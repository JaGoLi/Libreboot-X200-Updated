/* SPDX-License-Identifier: GPL-2.0-or-later */

#ifndef SOC_INTEL_COMMON_BLOCK_ACPI_H
#define SOC_INTEL_COMMON_BLOCK_ACPI_H

#include <acpi/acpi.h>
#include <device/device.h>
#include <intelblocks/cpulib.h>
#include <stdint.h>

/* Forward declare the power state struct here */
struct chipset_power_state;

/* Forward  declare the global nvs structure here */
struct global_nvs;

/* Return ACPI name for this device */
const char *soc_acpi_name(const struct device *dev);

/* Read the scis from soc specific register. Returns int scis value */
uint32_t soc_read_sci_irq_select(void);

/* Write the scis from soc specific register. */
void soc_write_sci_irq_select(uint32_t scis);

/* _CST MWAIT resource used by cstate_map. */
#define MWAIT_RES(state, sub_state)                         \
	{                                                   \
		.addrl = (((state) << 4) | (sub_state)),    \
		.space_id = ACPI_ADDRESS_SPACE_FIXED,       \
		.bit_width = ACPI_FFIXEDHW_VENDOR_INTEL,    \
		.bit_offset = ACPI_FFIXEDHW_CLASS_MWAIT,    \
		.access_size = ACPI_FFIXEDHW_FLAG_HW_COORD, \
	}

/*
 * get_cstate_map returns a table of processor specific acpi_cstate_t entries
 * and number of entries in the table
 */
acpi_cstate_t *soc_get_cstate_map(size_t *num_entries);

/*
 * get_tstate_map returns a table of processor specific acpi_tstate_t entries
 * and number of entries in the table
 */
acpi_tstate_t *soc_get_tss_table(int *entries);

/*
 * Chipset specific quirks for the wake enable bits.
 * Returns wake events for the soc.
 */
uint32_t acpi_fill_soc_wake(uint32_t generic_pm1_en,
			    const struct chipset_power_state *ps);

/* Chipset specific settings for filling up dmar table */
unsigned long sa_write_acpi_tables(const struct device *dev,
				   unsigned long current,
				   struct acpi_rsdp *rsdp);

/* Return the polarity flag for SCI IRQ */
int soc_madt_sci_irq_polarity(int sci);

/* Generate P-state tables */
void generate_p_state_entries(int core, int cores_per_package);

/* Generate T-state tables */
void generate_t_state_entries(int core, int cores_per_package);

/*
 * soc specific power states generation. We need this to be defined by soc
 * as the state generations varies in chipsets e.g. APL generates T and P
 * states while SKL generates  * P state only depending on a devicetree config
 */
void soc_power_states_generation(int core_id, int cores_per_package);

/*
 * Common function to calculate the power ratio for power state generation
 */
int common_calculate_power_ratio(int tdp, int p1_ratio, int ratio);

struct madt_ioapic_info {
	u8  id;
	u32 addr;
	u32 gsi_base;
};

/*
 * Returns a table of MADT ioapic_info entries and the number of entries
 * If the SOC doesn't implement this hook a default ioapic setting is used.
 */
const struct madt_ioapic_info *soc_get_ioapic_info(size_t *entries);

#endif				/* _SOC_INTEL_COMMON_BLOCK_ACPI_H_ */
