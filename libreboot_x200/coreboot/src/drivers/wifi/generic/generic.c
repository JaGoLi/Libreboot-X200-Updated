/* SPDX-License-Identifier: GPL-2.0-only */

#include <device/device.h>
#include <device/pci.h>
#include <device/pci_def.h>
#include <device/pci_ids.h>
#include <elog.h>
#include "chip.h"
#include "wifi_private.h"

static void wifi_pci_dev_init(struct device *dev)
{
	if (pci_dev_is_wake_source(dev))
		elog_add_event_wake(ELOG_WAKE_SOURCE_PME_WIFI, 0);
}

struct device_operations wifi_pcie_ops = {
	.read_resources		= pci_dev_read_resources,
	.set_resources		= pci_dev_set_resources,
	.enable_resources	= pci_dev_enable_resources,
	.init			= wifi_pci_dev_init,
	.ops_pci		= &pci_dev_ops_pci,
#if CONFIG(HAVE_ACPI_TABLES)
	.acpi_name		= wifi_pcie_acpi_name,
	.acpi_fill_ssdt		= wifi_pcie_fill_ssdt,
#endif
#if CONFIG(GENERATE_SMBIOS_TABLES)
	.get_smbios_data	= smbios_write_wifi_pcie,
#endif
};

struct device_operations wifi_cnvi_ops = {
	.read_resources		= noop_read_resources,
	.set_resources		= noop_set_resources,
#if CONFIG(HAVE_ACPI_TABLES)
	.acpi_fill_ssdt		= wifi_cnvi_fill_ssdt,
#endif
#if CONFIG(GENERATE_SMBIOS_TABLES)
	.get_smbios_data	= smbios_write_wifi_cnvi,
#endif
};

static void wifi_generic_enable(struct device *dev)
{
	struct drivers_wifi_generic_config *config = dev ? dev->chip_info : NULL;

	if (!config)
		return;

	if (dev->path.type == DEVICE_PATH_PCI)
		dev->ops = &wifi_pcie_ops;
	else
		dev->ops = &wifi_cnvi_ops;
}

struct chip_operations drivers_wifi_generic_ops = {
	CHIP_NAME("WIFI Device")
	.enable_dev = wifi_generic_enable
};

static const unsigned short intel_pci_device_ids[] = {
	PCI_DEVICE_ID_1000_SERIES_WIFI,
	PCI_DEVICE_ID_6005_SERIES_WIFI,
	PCI_DEVICE_ID_6005_I_SERIES_WIFI,
	PCI_DEVICE_ID_1030_SERIES_WIFI,
	PCI_DEVICE_ID_6030_I_SERIES_WIFI,
	PCI_DEVICE_ID_6030_SERIES_WIFI,
	PCI_DEVICE_ID_6150_SERIES_WIFI,
	PCI_DEVICE_ID_2030_SERIES_WIFI,
	PCI_DEVICE_ID_2000_SERIES_WIFI,
	PCI_DEVICE_ID_0135_SERIES_WIFI,
	PCI_DEVICE_ID_0105_SERIES_WIFI,
	PCI_DEVICE_ID_6035_SERIES_WIFI,
	PCI_DEVICE_ID_5300_SERIES_WIFI,
	PCI_DEVICE_ID_5100_SERIES_WIFI,
	PCI_DEVICE_ID_6000_SERIES_WIFI,
	PCI_DEVICE_ID_6000_I_SERIES_WIFI,
	PCI_DEVICE_ID_5350_SERIES_WIFI,
	PCI_DEVICE_ID_5150_SERIES_WIFI,
	/* Wilkins Peak 2 */
	PCI_DEVICE_ID_WP_7260_SERIES_1_WIFI,
	PCI_DEVICE_ID_WP_7260_SERIES_2_WIFI,
	/* Stone Peak 2 */
	PCI_DEVICE_ID_SP_7265_SERIES_1_WIFI,
	PCI_DEVICE_ID_SP_7265_SERIES_2_WIFI,
	/* Stone Field Peak */
	PCI_DEVICE_ID_SFP_8260_SERIES_1_WIFI,
	PCI_DEVICE_ID_SFP_8260_SERIES_2_WIFI,
	/* Windstorm Peak */
	PCI_DEVICE_ID_WSP_8275_SERIES_1_WIFI,
	/* Thunder Peak 2 */
	PCI_DEVICE_ID_TP_9260_SERIES_WIFI,
	/* Cyclone Peak */
	PCI_DEVICE_ID_CyP_6SERIES_WIFI,
	/* Typhoon Peak */
	PCI_DEVICE_ID_TyP_6SERIES_WIFI,
	/* Garfield Peak */
	PCI_DEVICE_ID_GrP_6SERIES_1_WIFI,
	PCI_DEVICE_ID_GrP_6SERIES_2_WIFI,
	0
};

/*
 * The PCI driver is retained for backward compatibility with boards that never utilized the
 * chip driver to support Intel WiFi device. For these devices, the PCI driver helps perform the
 * same operations as above (except exposing the wake property) by utilizing the same
 * `wifi_generic_ops`.
 */
static const struct pci_driver intel_wifi_pci_driver __pci_driver = {
	.ops		= &wifi_pcie_ops,
	.vendor		= PCI_VENDOR_ID_INTEL,
	.devices	= intel_pci_device_ids,
};
