/* SPDX-License-Identifier: GPL-2.0-only */

Name(\_S0, Package(){0x0,0x0,0x0,0x0})
#if !CONFIG(HAVE_ACPI_RESUME)
Name(\_S1, Package(){0x1,0x0,0x0,0x0})
#else
Name(\_S3, Package(){0x5,0x0,0x0,0x0})
#endif
#if !CONFIG(DISABLE_ACPI_HIBERNATE)
Name(\_S4, Package(){0x6,0x0,0x0,0x0})
#endif
Name(\_S5, Package(){0x7,0x0,0x0,0x0})