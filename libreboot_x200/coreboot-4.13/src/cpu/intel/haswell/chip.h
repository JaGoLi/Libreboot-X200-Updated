/* SPDX-License-Identifier: GPL-2.0-only */

/* Magic value used to locate this chip in the device tree */
#define SPEEDSTEP_APIC_MAGIC 0xACAC

struct cpu_intel_haswell_config {
	u8 disable_acpi;	/* Do not generate CPU ACPI tables */

	int c1_battery;		/* ACPI C1 on Battery Power */
	int c2_battery;		/* ACPI C2 on Battery Power */
	int c3_battery;		/* ACPI C3 on Battery Power */

	int c1_acpower;		/* ACPI C1 on AC Power */
	int c2_acpower;		/* ACPI C2 on AC Power */
	int c3_acpower;		/* ACPI C3 on AC Power */

	int tcc_offset;		/* TCC Activation Offset */
};
