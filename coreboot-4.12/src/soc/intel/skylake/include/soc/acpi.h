/* SPDX-License-Identifier: GPL-2.0-only */

#ifndef _SOC_ACPI_H_
#define _SOC_ACPI_H_

#include <acpi/acpi.h>
#include <soc/nvs.h>

/* P-state configuration */
#define PSS_MAX_ENTRIES			8
#define PSS_RATIO_STEP			2
#define PSS_LATENCY_TRANSITION		10
#define PSS_LATENCY_BUSMASTER		10

void acpi_fill_in_fadt(acpi_fadt_t *fadt);
unsigned long acpi_madt_irq_overrides(unsigned long current);
void southbridge_inject_dsdt(const struct device *device);
unsigned long southbridge_write_acpi_tables(const struct device *device,
	unsigned long current, struct acpi_rsdp *rsdp);
unsigned long northbridge_write_acpi_tables(const struct device *,
	unsigned long current, struct acpi_rsdp *);

#endif /* _SOC_ACPI_H_ */
