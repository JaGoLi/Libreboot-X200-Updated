/*
  Copyright (C) 2014  Michał Masłowski  <mtjm@mtjm.eu>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

/* Try several backlight PWM frequencies and duty cycles to see which
   expose the noise on X60 with coreboot.
*/

#include <assert.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <pci/pci.h>

static struct pci_access *pacc;
static uint32_t *map;
static int fd;

#define REGISTER 0x61254

static void
init (void)
{
  fd = -1;
  /* Find the device. */
  struct pci_dev *dev;
  pacc = pci_alloc ();
  pacc->writeable = 1;
  pci_init (pacc);
  pci_scan_bus (pacc);
  for (dev = pacc->devices; dev != NULL; dev = dev->next)
    {
      pci_fill_info (dev, PCI_FILL_IDENT | PCI_FILL_BASES);
      if (dev->vendor_id != 0x8086 || dev->device_id != 0x27a2)
        continue;
      break;
    }
  if (dev == NULL)
    {
      fprintf (stderr, "Device not found.\n");
      goto fail;
    }
  /* Map a part of its MMIO. */
  fd = open ("/dev/mem", O_RDWR);
  if (fd == -1)
    {
      fprintf (stderr, "Cannot open memory.  Are you root?\n");
      goto fail;
    }
  map = mmap (NULL, 4096, PROT_READ | PROT_WRITE, MAP_SHARED, fd, dev->base_addr[0] + (REGISTER & (~4095)));
  if (map != MAP_FAILED)
    return;
  else
    perror ("mmap failed");
 fail:
  if (pacc != NULL)
    pci_cleanup (pacc);
  if (fd != -1)
    close (fd);
  exit (1);
}

static void
set_pwm (uint16_t freq, uint16_t duty)
{
  assert (duty <= freq);
  map[((REGISTER - 4) & 4095) >> 2] = 0x80000000;
  map[(REGISTER & 4095) >> 2] = ((freq | 1) << 16) | duty;
}

int
main (void)
{
  init ();
  int exponent = 8;
  int diff = 0;
  int divisor = 2;
  uint16_t freq = 0x61;
  uint16_t duties[] = {
#if 1
    // i945
    0xf,
    0x13,
    0x19,
    0x1f,
    0x23,
    0x29,
    0x2f,
    0x35,
    0x39,
    0x3f,
    0x45,
    0x4b,
    0x4f,
    0x55,
    0x5b,
    0x61
#else
    // gm45
    0x2,
    0x4,
    0x5,
    0x7,
    0x9,
    0xb,
    0xd,
    0x11,
    0x14,
    0x17,
    0x1c,
    0x20,
    0x27,
    0x31,
    0x41,
    0x61,
#endif
  };
#if 1
  for (unsigned int di = 0; di < sizeof (duties) / sizeof (duties[0]); di++)
    {
      uint16_t duty = duties[di];
#else
      for (uint16_t duty = 0; duty < 0x61; duty++)
        {
#endif
#if 0
        }
#endif
      uint16_t pwm_freq = (freq + diff) << exponent;
      pwm_freq += (pwm_freq >> divisor);
      //pwm_freq |= 0x33;
      uint16_t pwm_duty = (duty + diff) << exponent;
      pwm_duty += (pwm_duty >> divisor);
      //pwm_duty |= 0x32;
      set_pwm (pwm_freq, pwm_duty);
      sleep (1);
    }
  if (pacc != NULL)
    pci_cleanup (pacc);
  if (map != NULL)
    munmap (map, 4096);
  if (fd != -1)
    close (fd);
  return 0;
}
