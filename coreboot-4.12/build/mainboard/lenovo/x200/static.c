#include <device/device.h>
#include <device/pci.h>
#include "cpu/intel/model_1067x/chip.h"
#include "drivers/generic/ioapic/chip.h"
#include "ec/lenovo/h8/chip.h"
#include "ec/lenovo/pmh7/chip.h"
#include "northbridge/intel/gm45/chip.h"
#include "southbridge/intel/i82801ix/chip.h"

#if !DEVTREE_EARLY
__attribute__((weak)) struct chip_operations mainboard_ops = {};
__attribute__((weak)) struct chip_operations cpu_intel_model_1067x_ops = {};
__attribute__((weak)) struct chip_operations cpu_intel_socket_BGA956_ops = {};
__attribute__((weak)) struct chip_operations drivers_generic_ioapic_ops = {};
__attribute__((weak)) struct chip_operations drivers_i2c_at24rf08c_ops = {};
__attribute__((weak)) struct chip_operations ec_lenovo_h8_ops = {};
__attribute__((weak)) struct chip_operations ec_lenovo_pmh7_ops = {};
__attribute__((weak)) struct chip_operations northbridge_intel_gm45_ops = {};
__attribute__((weak)) struct chip_operations southbridge_intel_i82801ix_ops = {};
__attribute__((weak)) struct chip_operations superio_nsc_pc87382_ops = {};
#endif

#define STORAGE static __unused DEVTREE_CONST

STORAGE struct cpu_intel_model_1067x_config cpu_intel_model_1067x_info_1 = {
	.c5 = 1,
	.c6 = 1,
	.slfm = 1,
};

STORAGE struct drivers_generic_ioapic_config drivers_generic_ioapic_info_1 = {
	.base = (void *)0xfec00000,
	.enable_virtual_wire = 1,
	.have_isa_interrupts = 1,
	.irq_on_fsb = 1,
};

STORAGE struct ec_lenovo_h8_config ec_lenovo_h8_info_1 = {
	.bdc_gpio_lvl = 0,
	.bdc_gpio_num = 7,
	.beepmask0 = 0xfe,
	.beepmask1 = 0x96,
	.config0 = 0xa6,
	.config1 = 0x04,
	.config2 = 0xa0,
	.config3 = 0x01,
	.event2_enable = 0xff,
	.event3_enable = 0xff,
	.event4_enable = 0xf4,
	.event5_enable = 0x3c,
	.event6_enable = 0x80,
	.event7_enable = 0x01,
	.event8_enable = 0x01,
	.event9_enable = 0xff,
	.eventa_enable = 0xff,
	.eventb_enable = 0xff,
	.eventc_enable = 0xff,
	.eventd_enable = 0xff,
	.has_bdc_detection = 1,
	.has_power_management_beeps = 1,
	.has_uwb = 1,
};

STORAGE struct ec_lenovo_pmh7_config ec_lenovo_pmh7_info_1 = {
	.dock_event_enable = 0x01,
};

STORAGE struct ec_lenovo_pmh7_config ec_lenovo_pmh7_info_2 = {
	.backlight_enable = 0x01,
};

STORAGE struct northbridge_intel_gm45_config northbridge_intel_gm45_info_1 = {
	.gfx = GMA_STATIC_DISPLAYS(1),
	.gpu_panel_power_backlight_off_delay = 2500,
	.gpu_panel_power_backlight_on_delay = 2500,
	.gpu_panel_power_cycle_delay = 3,
	.gpu_panel_power_down_delay = 250,
	.gpu_panel_power_up_delay = 250,
	.pci_mmio_size = 2048,
};

STORAGE struct southbridge_intel_i82801ix_config southbridge_intel_i82801ix_info_1 = {
	.c4onc3_enable = 1,
	.c5_enable = 1,
	.c6_enable = 1,
	.gen1_dec = 0x007c1601,
	.gen2_dec = 0x000c15e1,
	.gen3_dec = 0x001c1681,
	.gpe0_en = 0x01000000,
	.gpi1_routing = 2,
	.gpi8_routing = 2,
	.pcie_hotplug_map = { 0, 0, 0, 1, 0, 0, 0, 0 },
	.pcie_power_limits = { { 10, 0 }, { 10, 0 }, { 10, 0 }, { 10, 0 }, { 0, 0 }, { 0, 0 } },
	.pcie_slot_implemented = 0xf,
	.pirqa_routing = 0x0b,
	.pirqb_routing = 0x0b,
	.pirqc_routing = 0x0b,
	.pirqd_routing = 0x0b,
	.pirqe_routing = 0x80,
	.pirqf_routing = 0x80,
	.pirqg_routing = 0x80,
	.pirqh_routing = 0x80,
	.sata_clock_request = 0,
	.sata_port_map = 0x03,
	.sata_traffic_monitor = 0,
	.throttle_duty = THTL_75_0,
};


/* pass 0 */
STORAGE struct bus dev_root_links[];
STORAGE struct device _dev0;
STORAGE struct bus _dev0_links[];
STORAGE struct device _dev1;
STORAGE struct bus _dev1_links[];
STORAGE struct device _dev2;
STORAGE struct device _dev3;
STORAGE struct device _dev4;
STORAGE struct device _dev5;
STORAGE struct device _dev6;
STORAGE struct device _dev7;
STORAGE struct device _dev8;
STORAGE struct device _dev9;
STORAGE struct device _dev10;
STORAGE struct device _dev11;
STORAGE struct device _dev12;
STORAGE struct device _dev13;
STORAGE struct device _dev14;
STORAGE struct device _dev15;
STORAGE struct device _dev16;
STORAGE struct device _dev17;
STORAGE struct device _dev18;
STORAGE struct device _dev19;
STORAGE struct device _dev20;
STORAGE struct device _dev21;
STORAGE struct device _dev22;
STORAGE struct device _dev23;
STORAGE struct device _dev24;
STORAGE struct device _dev25;
STORAGE struct device _dev26;
STORAGE struct device _dev27;
STORAGE struct device _dev28;
STORAGE struct bus _dev28_links[];
STORAGE struct device _dev29;
STORAGE struct device _dev30;
STORAGE struct bus _dev30_links[];
STORAGE struct device _dev31;
STORAGE struct device _dev32;
STORAGE struct device _dev33;
STORAGE struct device _dev34;
STORAGE struct device _dev35;
STORAGE struct resource _dev35_res[];
STORAGE struct device _dev36;
STORAGE struct resource _dev36_res[];
STORAGE struct device _dev37;
STORAGE struct device _dev38;
STORAGE struct device _dev39;
STORAGE struct device _dev40;
STORAGE struct device _dev41;
STORAGE struct device _dev42;
STORAGE struct device _dev43;
STORAGE struct device _dev44;
STORAGE struct device _dev45;
STORAGE struct device _dev46;
STORAGE struct device _dev47;
DEVTREE_CONST struct device * DEVTREE_CONST last_dev = &_dev47;

/* pass 1 */
DEVTREE_CONST struct device dev_root = {
#if !DEVTREE_EARLY
	.ops = &default_dev_ops_root,
#endif
	.bus = &dev_root_links[0],
	.path = { .type = DEVICE_PATH_ROOT },
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = &dev_root_links[0],
	.sibling = NULL,
#if !DEVTREE_EARLY
	.chip_ops = &mainboard_ops,
	.name = mainboard_name,
#endif
	.next=&_dev0,
};
STORAGE struct bus dev_root_links[] = {
		[0] = {
			.link_num = 0,
			.dev = &dev_root,
			.children = &_dev0,
			.next = NULL,
		},
	};
STORAGE struct device _dev0 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &dev_root_links[0],
	.path = {.type=DEVICE_PATH_CPU_CLUSTER,{.cpu_cluster={ .cluster = 0x0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = &_dev0_links[0],
	.sibling = &_dev1,
#if !DEVTREE_EARLY
	.chip_ops = &northbridge_intel_gm45_ops,
#endif
	.chip_info = &northbridge_intel_gm45_info_1,
	.next=&_dev1,
};
STORAGE struct bus _dev0_links[] = {
		[0] = {
			.link_num = 0,
			.dev = &_dev0,
			.children = &_dev2,
			.next = NULL,
		},
	};
STORAGE struct device _dev1 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &dev_root_links[0],
	.path = {.type=DEVICE_PATH_DOMAIN,{.domain={ .domain = 0x0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = &_dev1_links[0],
	.sibling = NULL,
#if !DEVTREE_EARLY
	.chip_ops = &northbridge_intel_gm45_ops,
#endif
	.chip_info = &northbridge_intel_gm45_info_1,
	.next=&_dev2,
};
STORAGE struct bus _dev1_links[] = {
		[0] = {
			.link_num = 0,
			.dev = &_dev1,
			.children = &_dev4,
			.next = NULL,
		},
	};
STORAGE struct device _dev2 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev0_links[0],
	.path = {.type=DEVICE_PATH_APIC,{.apic={ .apic_id = 0x0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev3,
#if !DEVTREE_EARLY
	.chip_ops = &cpu_intel_socket_BGA956_ops,
#endif
	.next=&_dev3,
};
STORAGE struct device _dev3 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev0_links[0],
	.path = {.type=DEVICE_PATH_APIC,{.apic={ .apic_id = 0xacac }}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = NULL,
#if !DEVTREE_EARLY
	.chip_ops = &cpu_intel_model_1067x_ops,
#endif
	.chip_info = &cpu_intel_model_1067x_info_1,
	.next=&_dev4,
};
STORAGE struct device _dev4 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x0,0)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20e0,
	.link_list = NULL,
	.sibling = &_dev5,
#if !DEVTREE_EARLY
	.chip_ops = &northbridge_intel_gm45_ops,
#endif
	.chip_info = &northbridge_intel_gm45_info_1,
	.next=&_dev5,
};
STORAGE struct device _dev5 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x2,0)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20e4,
	.link_list = NULL,
	.sibling = &_dev6,
#if !DEVTREE_EARLY
	.pci_irq_info[0].ioapic_irq_pin = 16,
	.pci_irq_info[0].ioapic_dst_id = 2,
	.chip_ops = &northbridge_intel_gm45_ops,
#endif
	.chip_info = &northbridge_intel_gm45_info_1,
	.next=&_dev6,
};
STORAGE struct device _dev6 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x2,1)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20e4,
	.link_list = NULL,
	.sibling = &_dev7,
#if !DEVTREE_EARLY
	.chip_ops = &northbridge_intel_gm45_ops,
#endif
	.chip_info = &northbridge_intel_gm45_info_1,
	.next=&_dev7,
};
STORAGE struct device _dev7 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x3,0)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20e6,
	.link_list = NULL,
	.sibling = &_dev8,
#if !DEVTREE_EARLY
	.chip_ops = &northbridge_intel_gm45_ops,
#endif
	.chip_info = &northbridge_intel_gm45_info_1,
	.next=&_dev8,
};
STORAGE struct device _dev8 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x3,1)}}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev9,
#if !DEVTREE_EARLY
	.chip_ops = &northbridge_intel_gm45_ops,
#endif
	.chip_info = &northbridge_intel_gm45_info_1,
	.next=&_dev9,
};
STORAGE struct device _dev9 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x3,2)}}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev10,
#if !DEVTREE_EARLY
	.chip_ops = &northbridge_intel_gm45_ops,
#endif
	.chip_info = &northbridge_intel_gm45_info_1,
	.next=&_dev10,
};
STORAGE struct device _dev10 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x3,3)}}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev11,
#if !DEVTREE_EARLY
	.chip_ops = &northbridge_intel_gm45_ops,
#endif
	.chip_info = &northbridge_intel_gm45_info_1,
	.next=&_dev11,
};
STORAGE struct device _dev11 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x19,0)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev12,
#if !DEVTREE_EARLY
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev12,
};
STORAGE struct device _dev12 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1a,0)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f0,
	.link_list = NULL,
	.sibling = &_dev13,
#if !DEVTREE_EARLY
	.pci_irq_info[0].ioapic_irq_pin = 16,
	.pci_irq_info[0].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev13,
};
STORAGE struct device _dev13 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1a,1)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f0,
	.link_list = NULL,
	.sibling = &_dev14,
#if !DEVTREE_EARLY
	.pci_irq_info[1].ioapic_irq_pin = 17,
	.pci_irq_info[1].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev14,
};
STORAGE struct device _dev14 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1a,2)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f0,
	.link_list = NULL,
	.sibling = &_dev15,
#if !DEVTREE_EARLY
	.pci_irq_info[2].ioapic_irq_pin = 18,
	.pci_irq_info[2].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev15,
};
STORAGE struct device _dev15 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1a,7)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f1,
	.link_list = NULL,
	.sibling = &_dev16,
#if !DEVTREE_EARLY
	.pci_irq_info[2].ioapic_irq_pin = 18,
	.pci_irq_info[2].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev16,
};
STORAGE struct device _dev16 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1b,0)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f2,
	.link_list = NULL,
	.sibling = &_dev17,
#if !DEVTREE_EARLY
	.pci_irq_info[0].ioapic_irq_pin = 16,
	.pci_irq_info[0].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev17,
};
STORAGE struct device _dev17 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1c,0)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f3,
	.link_list = NULL,
	.sibling = &_dev18,
#if !DEVTREE_EARLY
	.pci_irq_info[0].ioapic_irq_pin = 16,
	.pci_irq_info[0].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev18,
};
STORAGE struct device _dev18 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1c,1)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f3,
	.link_list = NULL,
	.sibling = &_dev19,
#if !DEVTREE_EARLY
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev19,
};
STORAGE struct device _dev19 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1c,2)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f3,
	.link_list = NULL,
	.sibling = &_dev20,
#if !DEVTREE_EARLY
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev20,
};
STORAGE struct device _dev20 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1c,3)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f3,
	.link_list = NULL,
	.sibling = &_dev21,
#if !DEVTREE_EARLY
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev21,
};
STORAGE struct device _dev21 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1c,4)}}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev22,
#if !DEVTREE_EARLY
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev22,
};
STORAGE struct device _dev22 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1c,5)}}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev23,
#if !DEVTREE_EARLY
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev23,
};
STORAGE struct device _dev23 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1d,0)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f0,
	.link_list = NULL,
	.sibling = &_dev24,
#if !DEVTREE_EARLY
	.pci_irq_info[0].ioapic_irq_pin = 16,
	.pci_irq_info[0].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev24,
};
STORAGE struct device _dev24 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1d,1)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f0,
	.link_list = NULL,
	.sibling = &_dev25,
#if !DEVTREE_EARLY
	.pci_irq_info[1].ioapic_irq_pin = 17,
	.pci_irq_info[1].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev25,
};
STORAGE struct device _dev25 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1d,2)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f0,
	.link_list = NULL,
	.sibling = &_dev26,
#if !DEVTREE_EARLY
	.pci_irq_info[2].ioapic_irq_pin = 18,
	.pci_irq_info[2].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev26,
};
STORAGE struct device _dev26 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1d,7)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f1,
	.link_list = NULL,
	.sibling = &_dev27,
#if !DEVTREE_EARLY
	.pci_irq_info[0].ioapic_irq_pin = 16,
	.pci_irq_info[0].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev27,
};
STORAGE struct device _dev27 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1e,0)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f4,
	.link_list = NULL,
	.sibling = &_dev28,
#if !DEVTREE_EARLY
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev28,
};
STORAGE struct device _dev28 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1f,0)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = &_dev28_links[0],
	.sibling = &_dev29,
#if !DEVTREE_EARLY
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev29,
};
STORAGE struct bus _dev28_links[] = {
		[0] = {
			.link_num = 0,
			.dev = &_dev28,
			.children = &_dev33,
			.next = NULL,
		},
	};
STORAGE struct device _dev29 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1f,2)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f8,
	.link_list = NULL,
	.sibling = &_dev30,
#if !DEVTREE_EARLY
	.pci_irq_info[1].ioapic_irq_pin = 17,
	.pci_irq_info[1].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev30,
};
STORAGE struct device _dev30 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1f,3)}}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.subsystem_vendor = 0x17aa,
	.subsystem_device = 0x20f9,
	.link_list = &_dev30_links[0],
	.sibling = &_dev31,
#if !DEVTREE_EARLY
	.pci_irq_info[2].ioapic_irq_pin = 18,
	.pci_irq_info[2].ioapic_dst_id = 2,
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev31,
};
STORAGE struct bus _dev30_links[] = {
		[0] = {
			.link_num = 0,
			.dev = &_dev30,
			.children = &_dev40,
			.next = NULL,
		},
	};
STORAGE struct device _dev31 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1f,5)}}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev32,
#if !DEVTREE_EARLY
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev32,
};
STORAGE struct device _dev32 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev1_links[0],
	.path = {.type=DEVICE_PATH_PCI,{.pci={ .devfn = PCI_DEVFN(0x1f,6)}}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = NULL,
#if !DEVTREE_EARLY
	.chip_ops = &southbridge_intel_i82801ix_ops,
#endif
	.chip_info = &southbridge_intel_i82801ix_info_1,
	.next=&_dev33,
};
STORAGE struct device _dev33 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev28_links[0],
	.path = {.type=DEVICE_PATH_IOAPIC,{.ioapic={ .ioapic_id = 0x2 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev34,
#if !DEVTREE_EARLY
	.chip_ops = &drivers_generic_ioapic_ops,
#endif
	.chip_info = &drivers_generic_ioapic_info_1,
	.next=&_dev34,
};
STORAGE struct device _dev34 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev28_links[0],
	.path = {.type=DEVICE_PATH_PNP,{.pnp={ .port = 0xff, .device = 0x1 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev35,
#if !DEVTREE_EARLY
	.chip_ops = &ec_lenovo_pmh7_ops,
#endif
	.chip_info = &ec_lenovo_pmh7_info_2,
	.next=&_dev35,
};
STORAGE struct device _dev35 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev28_links[0],
	.path = {.type=DEVICE_PATH_PNP,{.pnp={ .port = 0xff, .device = 0x2 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.resource_list = &_dev35_res[0],
	.link_list = NULL,
	.sibling = &_dev36,
#if !DEVTREE_EARLY
	.chip_ops = &ec_lenovo_h8_ops,
#endif
	.chip_info = &ec_lenovo_h8_info_1,
	.next=&_dev36,
};
STORAGE struct resource _dev35_res[] = {
		{ .flags=IORESOURCE_FIXED | IORESOURCE_ASSIGNED | IORESOURCE_IO, .index=0x60, .base=0x62,.next=&_dev35_res[1]},
		{ .flags=IORESOURCE_FIXED | IORESOURCE_ASSIGNED | IORESOURCE_IO, .index=0x62, .base=0x66,.next=&_dev35_res[2]},
		{ .flags=IORESOURCE_FIXED | IORESOURCE_ASSIGNED | IORESOURCE_IO, .index=0x64, .base=0x1600,.next=&_dev35_res[3]},
		{ .flags=IORESOURCE_FIXED | IORESOURCE_ASSIGNED | IORESOURCE_IO, .index=0x66, .base=0x1604,.next=NULL },
	 };
STORAGE struct device _dev36 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev28_links[0],
	.path = {.type=DEVICE_PATH_PNP,{.pnp={ .port = 0x164e, .device = 0x3 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.resource_list = &_dev36_res[0],
	.link_list = NULL,
	.sibling = &_dev37,
#if !DEVTREE_EARLY
	.chip_ops = &superio_nsc_pc87382_ops,
#endif
	.next=&_dev37,
};
STORAGE struct resource _dev36_res[] = {
		{ .flags=IORESOURCE_FIXED | IORESOURCE_ASSIGNED | IORESOURCE_IO, .index=0x60, .base=0x200,.next=&_dev36_res[1]},
		{ .flags=IORESOURCE_FIXED | IORESOURCE_ASSIGNED | IORESOURCE_IRQ, .index=0x29, .base=0xb0,.next=&_dev36_res[2]},
		{ .flags=IORESOURCE_FIXED | IORESOURCE_ASSIGNED | IORESOURCE_IRQ, .index=0x70, .base=0x5,.next=&_dev36_res[3]},
		{ .flags=IORESOURCE_FIXED | IORESOURCE_ASSIGNED | IORESOURCE_IRQ, .index=0xf0, .base=0x82,.next=NULL },
	 };
STORAGE struct device _dev37 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev28_links[0],
	.path = {.type=DEVICE_PATH_PNP,{.pnp={ .port = 0x164e, .device = 0x2 }}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev38,
#if !DEVTREE_EARLY
	.chip_ops = &superio_nsc_pc87382_ops,
#endif
	.next=&_dev38,
};
STORAGE struct device _dev38 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev28_links[0],
	.path = {.type=DEVICE_PATH_PNP,{.pnp={ .port = 0x164e, .device = 0x7 }}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev39,
#if !DEVTREE_EARLY
	.chip_ops = &superio_nsc_pc87382_ops,
#endif
	.next=&_dev39,
};
STORAGE struct device _dev39 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev28_links[0],
	.path = {.type=DEVICE_PATH_PNP,{.pnp={ .port = 0x164e, .device = 0x19 }}},
	.enabled = 0,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = NULL,
#if !DEVTREE_EARLY
	.chip_ops = &superio_nsc_pc87382_ops,
#endif
	.next=&_dev40,
};
STORAGE struct device _dev40 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev30_links[0],
	.path = {.type=DEVICE_PATH_I2C,{.i2c={ .device = 0x54, .mode_10bit = 0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev41,
#if !DEVTREE_EARLY
	.chip_ops = &drivers_i2c_at24rf08c_ops,
#endif
	.next=&_dev41,
};
STORAGE struct device _dev41 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev30_links[0],
	.path = {.type=DEVICE_PATH_I2C,{.i2c={ .device = 0x55, .mode_10bit = 0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev42,
#if !DEVTREE_EARLY
	.chip_ops = &drivers_i2c_at24rf08c_ops,
#endif
	.next=&_dev42,
};
STORAGE struct device _dev42 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev30_links[0],
	.path = {.type=DEVICE_PATH_I2C,{.i2c={ .device = 0x56, .mode_10bit = 0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev43,
#if !DEVTREE_EARLY
	.chip_ops = &drivers_i2c_at24rf08c_ops,
#endif
	.next=&_dev43,
};
STORAGE struct device _dev43 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev30_links[0],
	.path = {.type=DEVICE_PATH_I2C,{.i2c={ .device = 0x57, .mode_10bit = 0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev44,
#if !DEVTREE_EARLY
	.chip_ops = &drivers_i2c_at24rf08c_ops,
#endif
	.next=&_dev44,
};
STORAGE struct device _dev44 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev30_links[0],
	.path = {.type=DEVICE_PATH_I2C,{.i2c={ .device = 0x5c, .mode_10bit = 0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev45,
#if !DEVTREE_EARLY
	.chip_ops = &drivers_i2c_at24rf08c_ops,
#endif
	.next=&_dev45,
};
STORAGE struct device _dev45 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev30_links[0],
	.path = {.type=DEVICE_PATH_I2C,{.i2c={ .device = 0x5d, .mode_10bit = 0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev46,
#if !DEVTREE_EARLY
	.chip_ops = &drivers_i2c_at24rf08c_ops,
#endif
	.next=&_dev46,
};
STORAGE struct device _dev46 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev30_links[0],
	.path = {.type=DEVICE_PATH_I2C,{.i2c={ .device = 0x5e, .mode_10bit = 0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = &_dev47,
#if !DEVTREE_EARLY
	.chip_ops = &drivers_i2c_at24rf08c_ops,
#endif
	.next=&_dev47,
};
STORAGE struct device _dev47 = {
#if !DEVTREE_EARLY
	.ops = NULL,
#endif
	.bus = &_dev30_links[0],
	.path = {.type=DEVICE_PATH_I2C,{.i2c={ .device = 0x5f, .mode_10bit = 0 }}},
	.enabled = 1,
	.hidden = 0,
	.mandatory = 0,
	.on_mainboard = 1,
	.link_list = NULL,
	.sibling = NULL,
#if !DEVTREE_EARLY
	.chip_ops = &drivers_i2c_at24rf08c_ops,
#endif
};

/* expose_device_names */
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_00_0 = &_dev4;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_02_0 = &_dev5;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_02_1 = &_dev6;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_03_0 = &_dev7;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_03_1 = &_dev8;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_03_2 = &_dev9;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_03_3 = &_dev10;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_19_0 = &_dev11;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1a_0 = &_dev12;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1a_1 = &_dev13;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1a_2 = &_dev14;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1a_7 = &_dev15;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1b_0 = &_dev16;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1c_0 = &_dev17;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1c_1 = &_dev18;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1c_2 = &_dev19;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1c_3 = &_dev20;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1c_4 = &_dev21;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1c_5 = &_dev22;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1d_0 = &_dev23;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1d_1 = &_dev24;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1d_2 = &_dev25;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1d_7 = &_dev26;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1e_0 = &_dev27;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1f_0 = &_dev28;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1f_2 = &_dev29;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1f_3 = &_dev30;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1f_5 = &_dev31;
DEVTREE_CONST struct device *DEVTREE_CONST __pci_0_1f_6 = &_dev32;
DEVTREE_CONST struct device *DEVTREE_CONST __pnp_00ff_01 = &_dev34;
DEVTREE_CONST struct device *DEVTREE_CONST __pnp_00ff_02 = &_dev35;
DEVTREE_CONST struct device *DEVTREE_CONST __pnp_164e_03 = &_dev36;
DEVTREE_CONST struct device *DEVTREE_CONST __pnp_164e_02 = &_dev37;
DEVTREE_CONST struct device *DEVTREE_CONST __pnp_164e_07 = &_dev38;
DEVTREE_CONST struct device *DEVTREE_CONST __pnp_164e_19 = &_dev39;
