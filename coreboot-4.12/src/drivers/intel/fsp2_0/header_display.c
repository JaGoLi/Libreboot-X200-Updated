/* SPDX-License-Identifier: GPL-2.0-or-later */

#include <console/console.h>
#include <fsp/util.h>

void fsp_print_header_info(const struct fsp_header *hdr)
{
	union {
		uint32_t val;
		struct {
			uint8_t bld_num;
			uint8_t revision;
			uint8_t minor;
			uint8_t major;
		} rev;
	} revision;

	revision.val = hdr->fsp_revision;

	printk(BIOS_SPEW, "Spec version: v%u.%u\n", (hdr->spec_version >> 4),
						     hdr->spec_version & 0xf);
	printk(BIOS_SPEW, "Revision: %u.%u.%u, Build Number %u\n",
							revision.rev.major,
							revision.rev.minor,
							revision.rev.revision,
							revision.rev.bld_num);
	printk(BIOS_SPEW, "Type: %s/%s\n",
			(hdr->component_attribute & 1) ? "release" : "debug",
			(hdr->component_attribute & 2) ? "test" : "official");
	printk(BIOS_SPEW, "image ID: %s, base 0x%lx + 0x%zx\n",
		hdr->image_id, hdr->image_base, hdr->image_size);
	printk(BIOS_SPEW, "\tConfig region        0x%zx + 0x%zx\n",
		hdr->cfg_region_offset, hdr->cfg_region_size);

	if ((hdr->component_attribute >> 12) == FSP_HDR_ATTRIB_FSPM) {
		printk(BIOS_SPEW, "\tMemory init offset   0x%zx\n",
						hdr->memory_init_entry_offset);
	}

	if ((hdr->component_attribute >> 12) == FSP_HDR_ATTRIB_FSPS) {
		printk(BIOS_SPEW, "\tSilicon init offset  0x%zx\n",
						hdr->silicon_init_entry_offset);
		printk(BIOS_SPEW, "\tNotify phase offset  0x%zx\n",
						hdr->notify_phase_entry_offset);
	}

}
