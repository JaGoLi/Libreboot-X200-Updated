/* compile: gcc -s -o bucts bucts.c -lpci  or:  make
 * run as root: ./bucts [0|1]
 */
/*
 * Copyright (C) 2011 Peter Stuge <peter@stuge.se>
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; version 2 of the License.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA
 */

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>
#include <stdint.h>
#include <string.h>
#include <errno.h>
#include <unistd.h>
#include <sys/mman.h>
#if defined(__GLIBC__)
#include <sys/io.h>
#endif
#include <pci/pci.h>

#if defined (__sun) && (defined(__i386) || defined(__amd64))
#define MEM_DEV "/dev/xsvc"
#else
#define MEM_DEV "/dev/mem"
#endif

static int fd_mem=-1;

static void *sys_physmap(unsigned long phys_addr, size_t len) {
  void *virt_addr = mmap(0, len, PROT_WRITE|PROT_READ, MAP_SHARED, fd_mem, (off_t)phys_addr);
  return MAP_FAILED == virt_addr ? NULL : virt_addr;
}

static void physunmap(void *virt_addr, size_t len) {
  if (!len) {
    printf("Not unmapping zero size at %p\n", virt_addr);
    return;
  }
  munmap(virt_addr, len);
}

static void *physmap(const char *descr, unsigned long phys_addr, size_t len) {
  void *virt_addr;

  if (!descr)
    descr = "memory";

  if (!len) {
    printf("Not mapping %s, zero size at 0x%08lx.\n", descr, phys_addr);
    return NULL;
  }

  if ((getpagesize() - 1) & len)
    fprintf(stderr, "Unaligned size 0x%lx for %s at 0x%08lx!\n", (unsigned long)len, descr, phys_addr);

  if ((getpagesize() - 1) & phys_addr)
    fprintf(stderr, "Unaligned address 0x%08lx for %s!\n", phys_addr, descr);

  virt_addr = sys_physmap(phys_addr, len);
  if (!virt_addr) {
    fprintf(stderr, "Error accessing 0x%lx bytes %s at 0x%08lx!\n", (unsigned long)len, descr, phys_addr);
    perror("mmap(" MEM_DEV ")");
    if (EINVAL == errno) {
      fprintf(stderr, "\n");
      fprintf(stderr, "In Linux this error can be caused by the CONFIG_NONPROMISC_DEVMEM (<2.6.27),\n");
      fprintf(stderr, "CONFIG_STRICT_DEVMEM (>=2.6.27) and CONFIG_X86_PAT kernel options.\n");
      fprintf(stderr, "Please check if either is enabled in your kernel before reporting a failure.\n");
      fprintf(stderr, "You can override CONFIG_X86_PAT at boot with the nopat kernel parameter but\n");
      fprintf(stderr, "disabling the other option unfortunately requires a kernel recompile. Sorry!\n");
    }
  }

  return virt_addr;
}

int bucts(struct pci_dev *sb, int8_t newts) {
  uint8_t buc, ts;
  uint32_t rcba_addr;
  volatile uint8_t *rcba;
  const char *str[2]={
    "128kb address range 0xFFFE0000-0xFFFFFFFF is untranslated",
    "64kb address ranges at 0xFFFE0000 and 0xFFFF0000 are swapped"
  };

  switch (sb->device_id) {
  case 0x27b9:
    rcba_addr = pci_read_long(sb, 0xf0) & ~1;
    break;
  default:
    fprintf(stderr, "Unsupported LPC bridge. Sorry.\n");
    return 1;
  }

  rcba = physmap("RCBA", rcba_addr, 0x4000);
  if (!rcba)
    return 1;

  buc = rcba[0x3414];
  ts = buc & 1;
  printf("Current BUC.TS=%d - %s\n", ts, str[ts]);

  if (0 == newts || 1 == newts) {
    if (ts == newts) {
      printf("Not writing BUC register since TS is already correct.\n");
      goto unmap;
    }
    buc &= ~1;
    buc |= newts;
    rcba[0x3414] = buc;
    buc = rcba[0x3414];
    ts = buc & 1;
    printf("Updated BUC.TS=%d - %s\n", ts, str[ts]);
  }

unmap:
  physunmap((void *)rcba, 0x4000);
  return 0;
}

int main(int argc, const char *argv[], const char *envp[]) {
  int ret;
  char *endp;
  int8_t newts = -1;
  struct pci_access *pacc;
  struct pci_dev *dev, *sb = NULL;
#if defined(__FreeBSD__)
  int io_fd;
#endif

  printf("bucts utility version '" VERSION "'\n");

#if defined(__FreeBSD__)
  if ((io_fd = open("/dev/io", O_RDWR)) < 0) {
    perror("open(/dev/io)");
#else
  if (iopl(3)) {
    perror("iopl");
#endif
    printf("You need to be root.\n");
    return 1;
  }

  if (-1 == (fd_mem = open(MEM_DEV, O_RDWR|O_SYNC))) {
    perror("Error: open(" MEM_DEV ")");
    return 1;
  }

  pacc=pci_alloc();
  pci_init(pacc);
  pci_scan_bus(pacc);
  for (dev=pacc->devices; dev && !sb; dev=dev->next) {
    pci_fill_info(dev, PCI_FILL_IDENT|PCI_FILL_CLASS);
    if (dev->vendor_id != 0x8086 || dev->device_class != 0x0601)
      continue;
    sb = dev;
  }
  if (!sb) {
    fprintf(stderr, "Error: LPC bridge not found!\n");
    return 1;
  }

  printf("Using LPC bridge %04x:%04x at %02x%02x:%02x.%02x\n", sb->vendor_id, sb->device_id, sb->domain, sb->bus, sb->dev, sb->func);

  if (argc > 1) {
    newts = strtoul(argv[1], &endp, 10);
    if (endp == argv[1]) {
      fprintf(stderr, "Invalid new TS value '%s', please specify 0 or 1.\n", argv[1]);
      newts = -1;
    }
  }

  ret = bucts(sb, newts);

  close(fd_mem);
  return ret;
}
