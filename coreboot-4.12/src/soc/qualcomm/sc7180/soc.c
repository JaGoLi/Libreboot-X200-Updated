/* SPDX-License-Identifier: GPL-2.0-only */

#include <symbols.h>
#include <device/device.h>
#include <soc/mmu.h>
#include <soc/mmu_common.h>
#include <soc/symbols.h>
#include <soc/aop.h>

static void soc_read_resources(struct device *dev)
{
	ram_resource(dev, 0, (uintptr_t)ddr_region->offset / KiB,
				ddr_region->size / KiB);
	reserved_ram_resource(dev, 1, (uintptr_t)_dram_aop / KiB,
				REGION_SIZE(dram_aop) / KiB);
	reserved_ram_resource(dev, 2, (uintptr_t)_dram_soc / KiB,
				REGION_SIZE(dram_soc) / KiB);
}

static void soc_init(struct device *dev)
{
	aop_fw_load_reset();
}

static struct device_operations soc_ops = {
	.read_resources = soc_read_resources,
	.init = soc_init,
};

static void enable_soc_dev(struct device *dev)
{
	dev->ops = &soc_ops;
}

struct chip_operations soc_qualcomm_sc7180_ops = {
	CHIP_NAME("SOC Qualcomm SC7180")
	.enable_dev = enable_soc_dev,
};
