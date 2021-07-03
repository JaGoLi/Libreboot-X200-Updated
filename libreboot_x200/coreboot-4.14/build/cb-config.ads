package CB.Config is

   --
   -- Automatically generated file; DO NOT EDIT.
   -- coreboot configuration
   --
   --
   -- General setup
   --
   COREBOOT_BUILD                                 : constant boolean := true;
   LOCALVERSION                                   : constant string  := "";
   CBFS_PREFIX                                    : constant string  := "fallback";
   COMPILER_GCC                                   : constant boolean := true;
   COMPILER_LLVM_CLANG                            : constant boolean := false;
   ANY_TOOLCHAIN                                  : constant boolean := false;
   CCACHE                                         : constant boolean := false;
   FMD_GENPARSER                                  : constant boolean := false;
   UTIL_GENPARSER                                 : constant boolean := false;
   USE_OPTION_TABLE                               : constant boolean := true;
   STATIC_OPTION_TABLE                            : constant boolean := false;
   COMPRESS_RAMSTAGE                              : constant boolean := true;
   INCLUDE_CONFIG_FILE                            : constant boolean := true;
   COLLECT_TIMESTAMPS                             : constant boolean := true;
   TIMESTAMPS_ON_CONSOLE                          : constant boolean := false;
   USE_BLOBS                                      : constant boolean := false;
   COVERAGE                                       : constant boolean := false;
   UBSAN                                          : constant boolean := false;
   HAVE_ASAN_IN_ROMSTAGE                          : constant boolean := false;
   ASAN_IN_ROMSTAGE                               : constant boolean := false;
   HAVE_ASAN_IN_RAMSTAGE                          : constant boolean := true;
   ASAN_IN_RAMSTAGE                               : constant boolean := false;
   ASAN                                           : constant boolean := false;
   NO_STAGE_CACHE                                 : constant boolean := false;
   TSEG_STAGE_CACHE                               : constant boolean := true;
   UPDATE_IMAGE                                   : constant boolean := false;
   BOOTSPLASH_IMAGE                               : constant boolean := false;
   FW_CONFIG                                      : constant boolean := false;
   --
   -- Mainboard
   --
   --
   -- Important: Run 'make distclean' before switching boards
   --
   VENDOR_51NB                                    : constant boolean := false;
   VENDOR_ACER                                    : constant boolean := false;
   VENDOR_ADLINK                                  : constant boolean := false;
   VENDOR_AMD                                     : constant boolean := false;
   VENDOR_AOPEN                                   : constant boolean := false;
   VENDOR_APPLE                                   : constant boolean := false;
   VENDOR_ASROCK                                  : constant boolean := false;
   VENDOR_ASUS                                    : constant boolean := false;
   VENDOR_BAP                                     : constant boolean := false;
   VENDOR_BIOSTAR                                 : constant boolean := false;
   VENDOR_BOSTENTECH                              : constant boolean := false;
   VENDOR_CAVIUM                                  : constant boolean := false;
   VENDOR_CLEVO                                   : constant boolean := false;
   VENDOR_COMPULAB                                : constant boolean := false;
   VENDOR_DELL                                    : constant boolean := false;
   VENDOR_ELMEX                                   : constant boolean := false;
   VENDOR_EMULATION                               : constant boolean := false;
   VENDOR_EXAMPLE                                 : constant boolean := false;
   VENDOR_FACEBOOK                                : constant boolean := false;
   VENDOR_FOXCONN                                 : constant boolean := false;
   VENDOR_GETAC                                   : constant boolean := false;
   VENDOR_GIGABYTE                                : constant boolean := false;
   VENDOR_GIZMOSPHERE                             : constant boolean := false;
   VENDOR_GOOGLE                                  : constant boolean := false;
   VENDOR_HP                                      : constant boolean := false;
   VENDOR_IBASE                                   : constant boolean := false;
   VENDOR_INTEL                                   : constant boolean := false;
   VENDOR_JETWAY                                  : constant boolean := false;
   VENDOR_KONTRON                                 : constant boolean := false;
   VENDOR_LENOVO                                  : constant boolean := true;
   VENDOR_LIBRETREND                              : constant boolean := false;
   VENDOR_LIPPERT                                 : constant boolean := false;
   VENDOR_MSI                                     : constant boolean := false;
   VENDOR_OCP                                     : constant boolean := false;
   VENDOR_OPENCELLULAR                            : constant boolean := false;
   VENDOR_PACKARDBELL                             : constant boolean := false;
   VENDOR_PCENGINES                               : constant boolean := false;
   VENDOR_PINE64                                  : constant boolean := false;
   VENDOR_PORTWELL                                : constant boolean := false;
   VENDOR_PRODRIVE                                : constant boolean := false;
   VENDOR_PROTECTLI                               : constant boolean := false;
   VENDOR_PURISM                                  : constant boolean := false;
   VENDOR_RAZER                                   : constant boolean := false;
   VENDOR_RODA                                    : constant boolean := false;
   VENDOR_SAMSUNG                                 : constant boolean := false;
   VENDOR_SAPPHIRE                                : constant boolean := false;
   VENDOR_SCALEWAY                                : constant boolean := false;
   VENDOR_SIEMENS                                 : constant boolean := false;
   VENDOR_SIFIVE                                  : constant boolean := false;
   VENDOR_SUPERMICRO                              : constant boolean := false;
   VENDOR_SYSTEM76                                : constant boolean := false;
   VENDOR_TI                                      : constant boolean := false;
   VENDOR_UP                                      : constant boolean := false;
   BOARD_SPECIFIC_OPTIONS                         : constant boolean := true;
   MAINBOARD_FAMILY                               : constant string  := "ThinkPad X200";
   MAINBOARD_PART_NUMBER                          : constant string  := "ThinkPad X200";
   MAINBOARD_VERSION                              : constant string  := "1.0";
   MAINBOARD_DIR                                  : constant string  := "lenovo/x200";
   VGA_BIOS_ID                                    : constant string  := "8086,2a42";
   DIMM_MAX                                       : constant         := 4;
   DIMM_SPD_SIZE                                  : constant         := 256;
   FMDFILE                                        : constant string  := "";
   NO_POST                                        : constant boolean := false;
   MAINBOARD_VENDOR                               : constant string  := "LENOVO";
   CBFS_SIZE                                      : constant         := 16#0020_0000#;
   ONBOARD_VGA_IS_PRIMARY                         : constant boolean := true;
   MAX_CPUS                                       : constant         := 2;
   VBOOT                                          : constant boolean := false;
   VBOOT_VBNV_OFFSET                              : constant         := 16#0082#;
   VARIANT_DIR                                    : constant string  := "x200";
   DEVICETREE                                     : constant string  := "devicetree.cb";
   VGA_BIOS                                       : constant boolean := false;
   MAINBOARD_SMBIOS_MANUFACTURER                  : constant string  := "LENOVO";
   PRERAM_CBMEM_CONSOLE_SIZE                      : constant         := 16#0c00#;
   POST_IO                                        : constant boolean := true;
   USBDEBUG_HCD_INDEX                             : constant         := 2;
   OVERRIDE_DEVICETREE                            : constant string  := "variants/$(CONFIG_VARIANT_DIR)/overridetree.cb";
   BOOT_DEVICE_SPI_FLASH_BUS                      : constant         := 0;
   CONSOLE_POST                                   : constant boolean := false;
   POST_DEVICE                                    : constant boolean := true;
   LINEAR_FRAMEBUFFER_MAX_WIDTH                   : constant         := 2560;
   LINEAR_FRAMEBUFFER_MAX_HEIGHT                  : constant         := 1600;
   MEMLAYOUT_LD_FILE                              : constant string  := "src/arch/x86/memlayout.ld";
   VBOOT_SLOTS_RW_A                               : constant boolean := true;
   DCACHE_RAM_BASE                                : constant         := 16#fefc_0000#;
   DCACHE_RAM_SIZE                                : constant         := 16#8000#;
   C_ENV_BOOTBLOCK_SIZE                           : constant         := 16#0004_0000#;
   DCACHE_BSP_STACK_SIZE                          : constant         := 16#2000#;
   MMCONF_BASE_ADDRESS                            : constant         := 16#f000_0000#;
   MMCONF_BUS_NUMBER                              : constant         := 64;
   MAX_ACPI_TABLE_SIZE_KB                         : constant         := 144;
   HAVE_INTEL_FIRMWARE                            : constant boolean := true;
   SPI_FLASH_INCLUDE_ALL_DRIVERS                  : constant boolean := true;
   SPI_FLASH_WINBOND                              : constant boolean := true;
   DRIVERS_INTEL_WIFI                             : constant boolean := false;
   IFD_BIN_PATH                                   : constant string  := "3rdparty/blobs/mainboard/$(MAINBOARDDIR)/descriptor.bin";
   GBE_BIN_PATH                                   : constant string  := "3rdparty/blobs/mainboard/$(MAINBOARDDIR)/gbe.bin";
   CONSOLE_CBMEM_BUFFER_SIZE                      : constant         := 16#0002_0000#;
   PCIEXP_HOTPLUG                                 : constant boolean := true;
   PCIEXP_HOTPLUG_BUSES                           : constant         := 8;
   PCIEXP_HOTPLUG_MEM                             : constant         := 16#0080_0000#;
   PCIEXP_HOTPLUG_PREFETCH_MEM                    : constant         := 16#1000_0000#;
   CBFS_MCACHE_SIZE                               : constant         := 16#2000#;
   MAINBOARD_SMBIOS_PRODUCT_NAME                  : constant string  := "ThinkPad X200";
   HAVE_IFD_BIN                                   : constant boolean := true;
   BOARD_LENOVO_G505S                             : constant boolean := false;
   BOARD_LENOVO_L520                              : constant boolean := false;
   BOARD_LENOVO_S230U                             : constant boolean := false;
   BOARD_LENOVO_T400                              : constant boolean := false;
   BOARD_LENOVO_T500                              : constant boolean := false;
   BOARD_LENOVO_R400                              : constant boolean := false;
   BOARD_LENOVO_R500                              : constant boolean := false;
   BOARD_LENOVO_W500                              : constant boolean := false;
   BOARD_LENOVO_T410                              : constant boolean := false;
   BOARD_LENOVO_T420                              : constant boolean := false;
   BOARD_LENOVO_T420S                             : constant boolean := false;
   BOARD_LENOVO_THINKPAD_T430                     : constant boolean := false;
   BOARD_LENOVO_T430S                             : constant boolean := false;
   BOARD_LENOVO_T431S                             : constant boolean := false;
   BOARD_LENOVO_THINKPAD_T440P                    : constant boolean := false;
   BOARD_LENOVO_T520                              : constant boolean := false;
   BOARD_LENOVO_W520                              : constant boolean := false;
   BOARD_LENOVO_T530                              : constant boolean := false;
   BOARD_LENOVO_W530                              : constant boolean := false;
   BOARD_LENOVO_T60                               : constant boolean := false;
   BOARD_LENOVO_Z61T                              : constant boolean := false;
   BOARD_LENOVO_R60                               : constant boolean := false;
   BOARD_LENOVO_THINKCENTRE_A58                   : constant boolean := false;
   BOARD_LENOVO_X131E                             : constant boolean := false;
   BOARD_LENOVO_X1_CARBON_GEN1                    : constant boolean := false;
   BOARD_LENOVO_X200                              : constant boolean := true;
   BOARD_LENOVO_X301                              : constant boolean := false;
   BOARD_LENOVO_X201                              : constant boolean := false;
   BOARD_LENOVO_X220                              : constant boolean := false;
   BOARD_LENOVO_X220I                             : constant boolean := false;
   BOARD_LENOVO_X1                                : constant boolean := false;
   BOARD_LENOVO_X230                              : constant boolean := false;
   BOARD_LENOVO_X230T                             : constant boolean := false;
   BOARD_LENOVO_X230S                             : constant boolean := false;
   BOARD_LENOVO_X60                               : constant boolean := false;
   PS2K_EISAID                                    : constant string  := "LEN0010";
   PS2M_EISAID                                    : constant string  := "IBM3780";
   THINKPADEC_HKEY_EISAID                         : constant string  := "IBM0068";
   DRIVER_LENOVO_SERIALS                          : constant boolean := true;
   BOARD_LENOVO_BASEBOARD_T520                    : constant boolean := false;
   BOARD_LENOVO_BASEBOARD_T530                    : constant boolean := false;
   PCIEXP_L1_SUB_STATE                            : constant boolean := true;
   PCIEXP_CLK_PM                                  : constant boolean := true;
   DRIVERS_UART_8250IO                            : constant boolean := false;
   HEAP_SIZE                                      : constant         := 16#4000#;
   BOARD_ROMSIZE_KB_8192                          : constant boolean := true;
   COREBOOT_ROMSIZE_KB_256                        : constant boolean := false;
   COREBOOT_ROMSIZE_KB_512                        : constant boolean := false;
   COREBOOT_ROMSIZE_KB_1024                       : constant boolean := false;
   COREBOOT_ROMSIZE_KB_2048                       : constant boolean := false;
   COREBOOT_ROMSIZE_KB_4096                       : constant boolean := true;
   COREBOOT_ROMSIZE_KB_5120                       : constant boolean := false;
   COREBOOT_ROMSIZE_KB_6144                       : constant boolean := false;
   COREBOOT_ROMSIZE_KB_8192                       : constant boolean := false;
   COREBOOT_ROMSIZE_KB_10240                      : constant boolean := false;
   COREBOOT_ROMSIZE_KB_12288                      : constant boolean := false;
   COREBOOT_ROMSIZE_KB_16384                      : constant boolean := false;
   COREBOOT_ROMSIZE_KB_32768                      : constant boolean := false;
   COREBOOT_ROMSIZE_KB_65536                      : constant boolean := false;
   COREBOOT_ROMSIZE_KB                            : constant         := 4096;
   ROM_SIZE                                       : constant         := 16#0040_0000#;
   HAVE_POWER_STATE_AFTER_FAILURE                 : constant boolean := true;
   HAVE_POWER_STATE_PREVIOUS_AFTER_FAILURE        : constant boolean := true;
   POWER_STATE_OFF_AFTER_FAILURE                  : constant boolean := true;
   POWER_STATE_ON_AFTER_FAILURE                   : constant boolean := false;
   POWER_STATE_PREVIOUS_AFTER_FAILURE             : constant boolean := false;
   MAINBOARD_POWER_FAILURE_STATE                  : constant         := 0;
   SYSTEM_TYPE_LAPTOP                             : constant boolean := true;
   SYSTEM_TYPE_TABLET                             : constant boolean := false;
   SYSTEM_TYPE_DETACHABLE                         : constant boolean := false;
   SYSTEM_TYPE_CONVERTIBLE                        : constant boolean := false;
   CBFS_AUTOGEN_ATTRIBUTES                        : constant boolean := false;
   --
   -- Chipset
   --
   --
   -- SoC
   --
   CHIPSET_DEVICETREE                             : constant string  := "";
   ROMSTAGE_ADDR                                  : constant         := 16#0200_0000#;
   VERSTAGE_ADDR                                  : constant         := 16#0200_0000#;
   RAMBASE                                        : constant         := 16#00e0_0000#;
   CPU_ADDR_BITS                                  : constant         := 36;
   SMM_RESERVED_SIZE                              : constant         := 16#0010_0000#;
   SMM_MODULE_STACK_SIZE                          : constant         := 16#0400#;
   CHECK_REV_IN_OPROM_NAME                        : constant boolean := false;
   ACPI_CPU_STRING                                : constant string  := "\\_SB.CP%02d";
   EHCI_BAR                                       : constant         := 16#fef0_0000#;
   SOC_CAVIUM_CN81XX                              : constant boolean := false;
   STACK_SIZE                                     : constant         := 16#1000#;
   SOC_CAVIUM_COMMON                              : constant boolean := false;
   VBT_DATA_SIZE_KB                               : constant         := 8;
   SOC_INTEL_GEMINILAKE                           : constant boolean := false;
   X86_TOP4G_BOOTMEDIA_MAP                        : constant boolean := true;
   INTEL_GMA_BCLV_OFFSET                          : constant         := 16#0006_1254#;
   INTEL_GMA_BCLV_WIDTH                           : constant         := 16;
   INTEL_GMA_BCLM_OFFSET                          : constant         := 16#0006_1256#;
   INTEL_GMA_BCLM_WIDTH                           : constant         := 16;
   PCIEXP_ASPM                                    : constant boolean := true;
   PCIEXP_COMMON_CLOCK                            : constant boolean := true;
   FIXED_MCHBAR_MMIO_BASE                         : constant         := 16#fed1_4000#;
   FIXED_DMIBAR_MMIO_BASE                         : constant         := 16#fed1_8000#;
   FIXED_EPBAR_MMIO_BASE                          : constant         := 16#fed1_9000#;
   UART_PCI_ADDR                                  : constant         := 16#0000#;
   AZALIA_MAX_CODECS                              : constant         := 3;
   SOC_MEDIATEK_MT8173                            : constant boolean := false;
   SOC_MEDIATEK_MT8183                            : constant boolean := false;
   SOC_MEDIATEK_MT8192                            : constant boolean := false;
   SOC_MEDIATEK_MT8195                            : constant boolean := false;
   SOC_NVIDIA_TEGRA124                            : constant boolean := false;
   SOC_NVIDIA_TEGRA210                            : constant boolean := false;
   SOC_QUALCOMM_COMMON                            : constant boolean := false;
   SOC_QC_IPQ40XX                                 : constant boolean := false;
   SOC_QC_IPQ806X                                 : constant boolean := false;
   SOC_QUALCOMM_QCS405                            : constant boolean := false;
   SOC_ROCKCHIP_RK3288                            : constant boolean := false;
   SOC_ROCKCHIP_RK3399                            : constant boolean := false;
   CPU_SAMSUNG_EXYNOS5250                         : constant boolean := false;
   CPU_SAMSUNG_EXYNOS5420                         : constant boolean := false;
   SOC_TI_AM335X                                  : constant boolean := false;
   SOC_UCB_RISCV                                  : constant boolean := false;
   --
   -- CPU
   --
   CPU_AMD_AGESA                                  : constant boolean := false;
   CPU_AMD_PI                                     : constant boolean := false;
   CPU_ARMLTD_CORTEX_A9                           : constant boolean := false;
   CPU_INTEL_MODEL_1067X                          : constant boolean := true;
   CPU_INTEL_SOCKET_BGA956                        : constant boolean := true;
   SSE2                                           : constant boolean := true;
   CPU_INTEL_FIRMWARE_INTERFACE_TABLE             : constant boolean := false;
   CPU_INTEL_TURBO_NOT_PACKAGE_SCOPED             : constant boolean := false;
   CPU_INTEL_COMMON                               : constant boolean := true;
   ENABLE_VMX                                     : constant boolean := false;
   SET_IA32_FC_LOCK_BIT                           : constant boolean := true;
   SET_MSR_AESNI_LOCK_BIT                         : constant boolean := true;
   CPU_INTEL_COMMON_TIMEBASE                      : constant boolean := true;
   CPU_INTEL_COMMON_SMM                           : constant boolean := true;
   MICROCODE_UPDATE_PRE_RAM                       : constant boolean := true;
   PARALLEL_CPU_INIT                              : constant boolean := false;
   PARALLEL_MP                                    : constant boolean := true;
   PARALLEL_MP_AP_WORK                            : constant boolean := false;
   UDELAY_LAPIC                                   : constant boolean := false;
   UDELAY_TSC                                     : constant boolean := true;
   TSC_MONOTONIC_TIMER                            : constant boolean := true;
   TSC_SYNC_LFENCE                                : constant boolean := false;
   TSC_SYNC_MFENCE                                : constant boolean := true;
   SETUP_XIP_CACHE                                : constant boolean := true;
   LOGICAL_CPUS                                   : constant boolean := true;
   HAVE_SMI_HANDLER                               : constant boolean := true;
   NO_SMM                                         : constant boolean := false;
   SMM_ASEG                                       : constant boolean := false;
   SMM_TSEG                                       : constant boolean := true;
   SMM_MODULE_HEAP_SIZE                           : constant         := 16#4000#;
   SMM_STUB_STACK_SIZE                            : constant         := 16#0400#;
   SMM_LAPIC_REMAP_MITIGATION                     : constant boolean := true;
   SERIALIZED_SMM_INITIALIZATION                  : constant boolean := false;
   X86_AMD_FIXED_MTRRS                            : constant boolean := false;
   X86_AMD_INIT_SIPI                              : constant boolean := false;
   SOC_SETS_MSRS                                  : constant boolean := false;
   RESERVE_MTRRS_FOR_OS                           : constant boolean := false;
   SMP                                            : constant boolean := true;
   MMX                                            : constant boolean := true;
   SSE                                            : constant boolean := true;
   SUPPORT_CPU_UCODE_IN_CBFS                      : constant boolean := true;
   USES_MICROCODE_HEADER_FILES                    : constant boolean := false;
   CPU_MICROCODE_CBFS_DEFAULT_BINS                : constant boolean := false;
   CPU_MICROCODE_CBFS_EXTERNAL_BINS               : constant boolean := false;
   CPU_MICROCODE_CBFS_EXTERNAL_HEADER             : constant boolean := false;
   CPU_MICROCODE_CBFS_NONE                        : constant boolean := true;
   --
   -- Northbridge
   --
   NORTHBRIDGE_AMD_AGESA                          : constant boolean := false;
   NORTHBRIDGE_AMD_PI                             : constant boolean := false;
   NORTHBRIDGE_SPECIFIC_OPTIONS                   : constant boolean := true;
   NORTHBRIDGE_INTEL_GM45                         : constant boolean := true;
   --
   -- Southbridge
   --
   AMD_SB_CIMX                                    : constant boolean := false;
   SOUTHBRIDGE_AMD_CIMX_SB800                     : constant boolean := false;
   HPET_MIN_TICKS                                 : constant         := 16#0080#;
   SOUTHBRIDGE_INTEL_I82801IX                     : constant boolean := true;
   INTEL_DESCRIPTOR_MODE_REQUIRED                 : constant boolean := false;
   SOUTHBRIDGE_INTEL_COMMON_RESET                 : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_RTC                   : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_PMCLIB                : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_PMBASE                : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_GPIO                  : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_ME                    : constant boolean := false;
   SOUTHBRIDGE_INTEL_COMMON_HPET                  : constant boolean := false;
   SOUTHBRIDGE_INTEL_COMMON_EARLY_SMBUS           : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_SMBUS                 : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_SPI                   : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_SPI_ICH7              : constant boolean := false;
   SOUTHBRIDGE_INTEL_COMMON_SPI_ICH9              : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_SPI_SILVERMONT        : constant boolean := false;
   SOUTHBRIDGE_INTEL_COMMON_PIRQ_ACPI_GEN         : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_RCBA_PIRQ             : constant boolean := true;
   HAVE_INTEL_CHIPSET_LOCKDOWN                    : constant boolean := false;
   SOUTHBRIDGE_INTEL_COMMON_SMM                   : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_USB_DEBUG             : constant boolean := true;
   INTEL_DESCRIPTOR_MODE_CAPABLE                  : constant boolean := true;
   VALIDATE_INTEL_DESCRIPTOR                      : constant boolean := true;
   SOUTHBRIDGE_INTEL_COMMON_WATCHDOG              : constant boolean := true;
   FIXED_RCBA_MMIO_BASE                           : constant         := 16#fed1_c000#;
   RCBA_LENGTH                                    : constant         := 16#4000#;
   FIXED_SMBUS_IO_BASE                            : constant         := 16#0400#;
   --
   -- Super I/O
   --
   SUPERIO_ASPEED_AST2400                         : constant boolean := false;
   SUPERIO_ASPEED_COMMON_PRE_RAM                  : constant boolean := false;
   SUPERIO_ASPEED_HAS_UART_DELAY_WORKAROUND       : constant boolean := false;
   SUPERIO_FINTEK_FAN_CONTROL                     : constant boolean := false;
   SUPERIO_NSC_PC87382                            : constant boolean := true;
   --
   -- Embedded Controllers
   --
   EC_ACPI                                        : constant boolean := true;
   EC_51NB_NPCE985LA0DX                           : constant boolean := false;
   EC_GOOGLE_CHROMEEC_SKUID                       : constant boolean := false;
   EC_GOOGLE_WILCO                                : constant boolean := false;
   EC_LENOVO_H8                                   : constant boolean := true;
   H8_BEEP_ON_DEATH                               : constant boolean := false;
   H8_FLASH_LEDS_ON_DEATH                         : constant boolean := true;
   H8_SUPPORT_BT_ON_WIFI                          : constant boolean := true;
   H8_HAS_BAT_TRESHOLDS_IMPL                      : constant boolean := true;
   H8_HAS_PRIMARY_FN_KEYS                         : constant boolean := false;
   EC_LENOVO_PMH7                                 : constant boolean := true;
   --
   -- Intel Firmware
   --
   HAVE_ME_BIN                                    : constant boolean := false;
   ME_REGION_ALLOW_CPU_READ_ACCESS                : constant boolean := false;
   MAINBOARD_USES_IFD_GBE_REGION                  : constant boolean := true;
   HAVE_GBE_BIN                                   : constant boolean := true;
   MAINBOARD_USES_IFD_EC_REGION                   : constant boolean := false;
   DO_NOT_TOUCH_DESCRIPTOR_REGION                 : constant boolean := false;
   LOCK_MANAGEMENT_ENGINE                         : constant boolean := false;
   UNLOCK_FLASH_REGIONS                           : constant boolean := true;
   CAVIUM_BDK                                     : constant boolean := false;
   MAINBOARD_HAS_CHROMEOS                         : constant boolean := false;
   GOOGLE_SMBIOS_MAINBOARD_VERSION                : constant boolean := false;
   UEFI_2_4_BINDING                               : constant boolean := false;
   UDK_2015_BINDING                               : constant boolean := false;
   UDK_2017_BINDING                               : constant boolean := false;
   UDK_202005_BINDING                             : constant boolean := false;
   USE_SIEMENS_HWILIB                             : constant boolean := false;
   ARM_LPAE                                       : constant boolean := false;
   ARCH_X86                                       : constant boolean := true;
   ARCH_BOOTBLOCK_X86_32                          : constant boolean := true;
   ARCH_VERSTAGE_X86_32                           : constant boolean := true;
   ARCH_ROMSTAGE_X86_32                           : constant boolean := true;
   ARCH_POSTCAR_X86_32                            : constant boolean := true;
   ARCH_RAMSTAGE_X86_32                           : constant boolean := true;
   ARCH_ALL_STAGES_X86_32                         : constant boolean := true;
   ARCH_POSTCAR_X86_64                            : constant boolean := false;
   USE_MARCH_586                                  : constant boolean := false;
   AP_IN_SIPI_WAIT                                : constant boolean := false;
   SIPI_VECTOR_IN_ROM                             : constant boolean := false;
   RAMTOP                                         : constant         := 16#0100_0000#;
   NUM_IPI_STARTS                                 : constant         := 2;
   PC80_SYSTEM                                    : constant boolean := true;
   BOOTBLOCK_DEBUG_SPINLOOP                       : constant boolean := false;
   HAVE_CMOS_DEFAULT                              : constant boolean := true;
   CMOS_DEFAULT_FILE                              : constant string  := "src/mainboard/$(MAINBOARDDIR)/cmos.default";
   IOAPIC_INTERRUPTS_ON_FSB                       : constant boolean := true;
   IOAPIC_INTERRUPTS_ON_APIC_SERIAL_BUS           : constant boolean := false;
   HPET_ADDRESS_OVERRIDE                          : constant boolean := false;
   HPET_ADDRESS                                   : constant         := 16#fed0_0000#;
   POSTCAR_STAGE                                  : constant boolean := true;
   VERSTAGE_DEBUG_SPINLOOP                        : constant boolean := false;
   ROMSTAGE_DEBUG_SPINLOOP                        : constant boolean := false;
   BOOTBLOCK_SIMPLE                               : constant boolean := true;
   BOOTBLOCK_NORMAL                               : constant boolean := false;
   COLLECT_TIMESTAMPS_NO_TSC                      : constant boolean := false;
   COLLECT_TIMESTAMPS_TSC                         : constant boolean := true;
   PAGING_IN_CACHE_AS_RAM                         : constant boolean := false;
   IDT_IN_EVERY_STAGE                             : constant boolean := false;
   HAVE_CF9_RESET                                 : constant boolean := true;
   PIRQ_ROUTE                                     : constant boolean := false;
   --
   -- Devices
   --
   HAVE_VGA_TEXT_FRAMEBUFFER                      : constant boolean := true;
   HAVE_LINEAR_FRAMEBUFFER                        : constant boolean := true;
   MAINBOARD_HAS_NATIVE_VGA_INIT                  : constant boolean := false;
   MAINBOARD_FORCE_NATIVE_VGA_INIT                : constant boolean := false;
   VGA_ROM_RUN_DEFAULT                            : constant boolean := false;
   MAINBOARD_HAS_LIBGFXINIT                       : constant boolean := true;
   MAINBOARD_USE_LIBGFXINIT                       : constant boolean := true;
   VGA_ROM_RUN                                    : constant boolean := false;
   NO_GFX_INIT                                    : constant boolean := false;
   MULTIPLE_VGA_ADAPTERS                          : constant boolean := false;
   --
   -- Display
   --
   VGA_TEXT_FRAMEBUFFER                           : constant boolean := false;
   GENERIC_LINEAR_FRAMEBUFFER                     : constant boolean := true;
   LINEAR_FRAMEBUFFER                             : constant boolean := true;
   BOOTSPLASH                                     : constant boolean := false;
   PCI                                            : constant boolean := true;
   NO_MMCONF_SUPPORT                              : constant boolean := false;
   MMCONF_SUPPORT                                 : constant boolean := true;
   PCIX_PLUGIN_SUPPORT                            : constant boolean := true;
   CARDBUS_PLUGIN_SUPPORT                         : constant boolean := true;
   AZALIA_PLUGIN_SUPPORT                          : constant boolean := true;
   AZALIA_LOCK_DOWN_R_WO_GCAP                     : constant boolean := false;
   PCIEXP_PLUGIN_SUPPORT                          : constant boolean := true;
   MMCONF_LENGTH                                  : constant         := 16#0400_0000#;
   PCI_ALLOW_BUS_MASTER                           : constant boolean := true;
   PCI_SET_BUS_MASTER_PCI_BRIDGES                 : constant boolean := true;
   PCI_ALLOW_BUS_MASTER_ANY_DEVICE                : constant boolean := true;
   PCIEXP_HOTPLUG_PREFETCH_MEM_ABOVE_4G           : constant boolean := true;
   PCIEXP_HOTPLUG_PREFETCH_MEM_BELOW_4G           : constant boolean := false;
   PCIEXP_HOTPLUG_IO                              : constant         := 16#2000#;
   EARLY_PCI_BRIDGE                               : constant boolean := false;
   SUBSYSTEM_VENDOR_ID                            : constant         := 16#0000#;
   SUBSYSTEM_DEVICE_ID                            : constant         := 16#0000#;
   INTEL_GMA_ADD_VBT                              : constant boolean := false;
   SOFTWARE_I2C                                   : constant boolean := false;
   RESOURCE_ALLOCATOR_V3                          : constant boolean := false;
   RESOURCE_ALLOCATOR_V4                          : constant boolean := true;
   XHCI_UTILS                                     : constant boolean := false;
   --
   -- Generic Drivers
   --
   DRIVERS_AS3722_RTC                             : constant boolean := false;
   CHROMEOS_CAMERA                                : constant boolean := false;
   CRB_TPM_BASE_ADDRESS                           : constant         := 16#fed4_0000#;
   MAINBOARD_HAS_CRB_TPM                          : constant boolean := false;
   ELOG                                           : constant boolean := false;
   GIC                                            : constant boolean := false;
   IPMI_KCS                                       : constant boolean := false;
   DRIVERS_LENOVO_WACOM                           : constant boolean := true;
   DIGITIZER_AUTODETECT                           : constant boolean := true;
   DIGITIZER_PRESENT                              : constant boolean := false;
   DIGITIZER_ABSENT                               : constant boolean := false;
   RT8168_GET_MAC_FROM_VPD                        : constant boolean := false;
   RT8168_SUPPORT_LEGACY_VPD_MAC                  : constant boolean := false;
   RT8168_SET_LED_MODE                            : constant boolean := false;
   SMMSTORE                                       : constant boolean := false;
   SMMSTORE_IN_CBFS                               : constant boolean := false;
   SPI_FLASH                                      : constant boolean := true;
   SPI_SDCARD                                     : constant boolean := false;
   BOOT_DEVICE_SPI_FLASH_RW_NOMMAP                : constant boolean := true;
   BOOT_DEVICE_SPI_FLASH_NO_EARLY_WRITES          : constant boolean := false;
   BOOT_DEVICE_SPI_FLASH_RW_NOMMAP_EARLY          : constant boolean := true;
   SPI_FLASH_DONT_INCLUDE_ALL_DRIVERS             : constant boolean := false;
   SPI_FLASH_NO_FAST_READ                         : constant boolean := false;
   SPI_FLASH_ADESTO                               : constant boolean := true;
   SPI_FLASH_AMIC                                 : constant boolean := true;
   SPI_FLASH_ATMEL                                : constant boolean := true;
   SPI_FLASH_EON                                  : constant boolean := true;
   SPI_FLASH_GIGADEVICE                           : constant boolean := true;
   SPI_FLASH_MACRONIX                             : constant boolean := true;
   SPI_FLASH_SPANSION                             : constant boolean := true;
   SPI_FLASH_SST                                  : constant boolean := true;
   SPI_FLASH_STMICRO                              : constant boolean := true;
   SPI_FLASH_HAS_VOLATILE_GROUP                   : constant boolean := false;
   HAVE_EM100PRO_SPI_CONSOLE_SUPPORT              : constant boolean := false;
   NO_UART_ON_SUPERIO                             : constant boolean := true;
   UART_OVERRIDE_INPUT_CLOCK_DIVIDER              : constant boolean := false;
   UART_OVERRIDE_REFCLK                           : constant boolean := false;
   DRIVERS_UART_8250MEM                           : constant boolean := false;
   DRIVERS_UART_8250MEM_32                        : constant boolean := false;
   HAVE_UART_SPECIAL                              : constant boolean := false;
   DRIVERS_UART_OXPCIE                            : constant boolean := false;
   DRIVERS_UART_PL011                             : constant boolean := false;
   UART_USE_REFCLK_AS_INPUT_CLOCK                 : constant boolean := false;
   HAVE_USBDEBUG                                  : constant boolean := true;
   HAVE_USBDEBUG_OPTIONS                          : constant boolean := true;
   USBDEBUG                                       : constant boolean := false;
   VPD                                            : constant boolean := false;
   DRIVERS_AMD_PI                                 : constant boolean := false;
   DRIVERS_GENERIC_CBFS_SERIAL                    : constant boolean := false;
   DRIVERS_GENERIC_IOAPIC                         : constant boolean := true;
   DRIVERS_GENESYSLOGIC_GL9755                    : constant boolean := false;
   DRIVERS_GFX_GENERIC                            : constant boolean := false;
   DRIVERS_I2C_GPIO_MUX                           : constant boolean := false;
   DRIVERS_I2C_MAX98373                           : constant boolean := false;
   DRIVERS_I2C_MAX98390                           : constant boolean := false;
   DRIVERS_I2C_MAX98927                           : constant boolean := false;
   DRIVERS_I2C_PCA9538                            : constant boolean := false;
   DRIVERS_I2C_PCF8523                            : constant boolean := false;
   DRIVERS_I2C_PTN3460                            : constant boolean := false;
   DRIVERS_I2C_RT1011                             : constant boolean := false;
   DRIVERS_I2C_RT5663                             : constant boolean := false;
   DRIVERS_I2C_RTD2132                            : constant boolean := false;
   DRIVERS_I2C_RX6110SA                           : constant boolean := false;
   DRIVERS_I2C_SX9310                             : constant boolean := false;
   DRIVERS_I2C_SX9324                             : constant boolean := false;
   DRIVERS_I2C_TAS5825M                           : constant boolean := false;
   MAINBOARD_HAS_I2C_TPM_ATMEL                    : constant boolean := false;
   MAINBOARD_HAS_I2C_TPM_CR50                     : constant boolean := false;
   MAINBOARD_HAS_I2C_TPM_GENERIC                  : constant boolean := false;
   DRIVER_I2C_TPM_ACPI                            : constant boolean := false;
   DRIVERS_INTEL_DPTF                             : constant boolean := false;
   PLATFORM_USES_FSP2_0                           : constant boolean := false;
   PLATFORM_USES_FSP2_1                           : constant boolean := false;
   PLATFORM_USES_FSP2_2                           : constant boolean := false;
   INTEL_DDI                                      : constant boolean := false;
   INTEL_EDID                                     : constant boolean := true;
   INTEL_INT15                                    : constant boolean := true;
   INTEL_GMA_ACPI                                 : constant boolean := true;
   INTEL_GMA_SSC_ALTERNATE_REF                    : constant boolean := true;
   INTEL_GMA_SWSMISCI                             : constant boolean := false;
   GFX_GMA_IGNORE_PRESENCE_STRAPS                 : constant boolean := false;
   GFX_GMA                                        : constant boolean := true;
   GFX_GMA_PANEL_1_ON_EDP                         : constant boolean := false;
   GFX_GMA_PANEL_1_ON_LVDS                        : constant boolean := true;
   GFX_GMA_DYN_CPU                                : constant boolean := true;
   GFX_GMA_GENERATION                             : constant string  := "G45";
   GFX_GMA_PCH                                    : constant string  := "No_PCH";
   GFX_GMA_PANEL_1_PORT                           : constant string  := "LVDS";
   GFX_GMA_PANEL_2_PORT                           : constant string  := "Disabled";
   GFX_GMA_ANALOG_I2C_PORT                        : constant string  := "PCH_DAC";
   DRIVER_INTEL_I210                              : constant boolean := false;
   DRIVERS_INTEL_ISH                              : constant boolean := false;
   DRIVERS_INTEL_MIPI_CAMERA                      : constant boolean := false;
   DRIVERS_INTEL_PMC                              : constant boolean := false;
   HAVE_INTEL_PTT                                 : constant boolean := false;
   IPMI_OCP                                       : constant boolean := false;
   DRIVERS_LENOVO_HYBRID_GRAPHICS                 : constant boolean := false;
   DRIVER_MAXIM_MAX77686                          : constant boolean := false;
   DRIVER_PARADE_PS8625                           : constant boolean := false;
   DRIVER_PARADE_PS8640                           : constant boolean := false;
   DRIVERS_PS2_KEYBOARD                           : constant boolean := true;
   DRIVERS_MC146818                               : constant boolean := true;
   MAINBOARD_HAS_LPC_TPM                          : constant boolean := false;
   VGA                                            : constant boolean := true;
   DRIVERS_RICOH_RCE822                           : constant boolean := false;
   DRIVER_SIEMENS_NC_FPGA                         : constant boolean := false;
   NC_FPGA_NOTIFY_CB_READY                        : constant boolean := false;
   DRIVERS_SIL_3114                               : constant boolean := false;
   MAINBOARD_HAS_SPI_TPM_CR50                     : constant boolean := false;
   MAINBOARD_HAS_SPI_TPM                          : constant boolean := false;
   DRIVERS_TI_SN65DSI86BRIDGE                     : constant boolean := false;
   DRIVER_TI_TPS65090                             : constant boolean := false;
   DRIVERS_TI_TPS65913_RTC                        : constant boolean := false;
   DRIVERS_USB_ACPI                               : constant boolean := false;
   DRIVERS_USB_PCI_XHCI                           : constant boolean := false;
   DRIVERS_WIFI_GENERIC                           : constant boolean := false;
   MP_SERVICES_PPI_V1                             : constant boolean := false;
   MP_SERVICES_PPI_V2                             : constant boolean := false;
   COMMONLIB_STORAGE                              : constant boolean := false;
   --
   -- Security
   --
   --
   -- Verified Boot (vboot)
   --
   --
   -- Trusted Platform Module
   --
   USER_NO_TPM                                    : constant boolean := true;
   --
   -- Memory initialization
   --
   PLATFORM_HAS_DRAM_CLEAR                        : constant boolean := true;
   SECURITY_CLEAR_DRAM_ON_REGULAR_BOOT            : constant boolean := false;
   BOOTMEDIA_LOCK_NONE                            : constant boolean := true;
   BOOTMEDIA_LOCK_CONTROLLER                      : constant boolean := false;
   BOOTMEDIA_LOCK_CHIP                            : constant boolean := false;
   ACPI_AMD_HARDWARE_SLEEP_VALUES                 : constant boolean := false;
   ACPI_HAVE_PCAT_8259                            : constant boolean := true;
   ACPI_INTEL_HARDWARE_SLEEP_VALUES               : constant boolean := true;
   ACPI_SOC_NVS                                   : constant boolean := true;
   ACPI_EINJ                                      : constant boolean := false;
   HAVE_ACPI_TABLES                               : constant boolean := true;
   BOOT_DEVICE_NOT_SPI_FLASH                      : constant boolean := false;
   BOOT_DEVICE_SPI_FLASH                          : constant boolean := true;
   BOOT_DEVICE_MEMORY_MAPPED                      : constant boolean := true;
   BOOT_DEVICE_SUPPORTS_WRITES                    : constant boolean := true;
   RTC                                            : constant boolean := false;
   --
   -- Console
   --
   BOOTBLOCK_CONSOLE                              : constant boolean := true;
   POSTCAR_CONSOLE                                : constant boolean := true;
   SQUELCH_EARLY_SMP                              : constant boolean := true;
   SPKMODEM                                       : constant boolean := false;
   CONSOLE_NE2K                                   : constant boolean := false;
   CONSOLE_CBMEM                                  : constant boolean := true;
   CONSOLE_CBMEM_DUMP_TO_UART                     : constant boolean := false;
   CONSOLE_SPI_FLASH                              : constant boolean := false;
   DEFAULT_CONSOLE_LOGLEVEL_8                     : constant boolean := true;
   DEFAULT_CONSOLE_LOGLEVEL_7                     : constant boolean := false;
   DEFAULT_CONSOLE_LOGLEVEL_6                     : constant boolean := false;
   DEFAULT_CONSOLE_LOGLEVEL_5                     : constant boolean := false;
   DEFAULT_CONSOLE_LOGLEVEL_4                     : constant boolean := false;
   DEFAULT_CONSOLE_LOGLEVEL_3                     : constant boolean := false;
   DEFAULT_CONSOLE_LOGLEVEL_2                     : constant boolean := false;
   DEFAULT_CONSOLE_LOGLEVEL_1                     : constant boolean := false;
   DEFAULT_CONSOLE_LOGLEVEL_0                     : constant boolean := false;
   DEFAULT_CONSOLE_LOGLEVEL                       : constant         := 8;
   CMOS_POST                                      : constant boolean := false;
   POST_DEVICE_NONE                               : constant boolean := true;
   POST_DEVICE_LPC                                : constant boolean := false;
   POST_DEVICE_PCI_PCIE                           : constant boolean := false;
   DEFAULT_POST_ON_LPC                            : constant boolean := false;
   POST_IO_PORT                                   : constant         := 16#0080#;
   NO_EARLY_BOOTBLOCK_POSTCODES                   : constant boolean := false;
   HWBASE_DEBUG_CB                                : constant boolean := true;
   HAVE_ACPI_RESUME                               : constant boolean := true;
   DISABLE_ACPI_HIBERNATE                         : constant boolean := false;
   RESUME_PATH_SAME_AS_BOOT                       : constant boolean := true;
   NO_MONOTONIC_TIMER                             : constant boolean := false;
   HAVE_MONOTONIC_TIMER                           : constant boolean := true;
   TIMER_QUEUE                                    : constant boolean := false;
   HAVE_OPTION_TABLE                              : constant boolean := true;
   PCI_IO_CFG_EXT                                 : constant boolean := false;
   IOAPIC                                         : constant boolean := true;
   USE_WATCHDOG_ON_BOOT                           : constant boolean := true;
   GFXUMA                                         : constant boolean := false;
   HAVE_MP_TABLE                                  : constant boolean := true;
   ACPI_NHLT                                      : constant boolean := false;
   --
   -- System tables
   --
   GENERATE_MP_TABLE                              : constant boolean := true;
   GENERATE_PIRQ_TABLE                            : constant boolean := false;
   GENERATE_SMBIOS_TABLES                         : constant boolean := true;
   SMBIOS_PROVIDED_BY_MOBO                        : constant boolean := true;
   MAINBOARD_SERIAL_NUMBER                        : constant string  := "123456789";
   --
   -- Payload
   --
   PAYLOAD_NONE                                   : constant boolean := false;
   PAYLOAD_ELF                                    : constant boolean := true;
   PAYLOAD_BOOTBOOT                               : constant boolean := false;
   PAYLOAD_FILO                                   : constant boolean := false;
   PAYLOAD_GRUB2                                  : constant boolean := false;
   PAYLOAD_LINUXBOOT                              : constant boolean := false;
   PAYLOAD_SEABIOS                                : constant boolean := false;
   PAYLOAD_UBOOT                                  : constant boolean := false;
   PAYLOAD_YABITS                                 : constant boolean := false;
   PAYLOAD_LINUX                                  : constant boolean := false;
   PAYLOAD_TIANOCORE                              : constant boolean := false;
   PAYLOAD_FILE                                   : constant string  := "payload.elf";
   PAYLOAD_OPTIONS                                : constant string  := "";
   PXE                                            : constant boolean := false;
   COMPRESSED_PAYLOAD_NONE                        : constant boolean := false;
   COMPRESSED_PAYLOAD_LZMA                        : constant boolean := true;
   COMPRESSED_PAYLOAD_LZ4                         : constant boolean := false;
   PAYLOAD_IS_FLAT_BINARY                         : constant boolean := false;
   COMPRESS_SECONDARY_PAYLOAD                     : constant boolean := true;
   --
   -- Secondary Payloads
   --
   COREINFO_SECONDARY_PAYLOAD                     : constant boolean := false;
   MEMTEST_SECONDARY_PAYLOAD                      : constant boolean := false;
   NVRAMCUI_SECONDARY_PAYLOAD                     : constant boolean := false;
   TINT_SECONDARY_PAYLOAD                         : constant boolean := false;
   --
   -- Debugging
   --
   --
   -- CPU Debug Settings
   --
   --
   -- BLOB Debug Settings
   --
   --
   -- General Debug Settings
   --
   FATAL_ASSERTS                                  : constant boolean := false;
   DEBUG_CBFS                                     : constant boolean := false;
   HAVE_DEBUG_RAM_SETUP                           : constant boolean := true;
   DEBUG_RAM_SETUP                                : constant boolean := false;
   HAVE_DEBUG_SMBUS                               : constant boolean := true;
   DEBUG_SMBUS                                    : constant boolean := false;
   DEBUG_SMI                                      : constant boolean := false;
   DEBUG_MALLOC                                   : constant boolean := false;
   DEBUG_RESOURCES                                : constant boolean := false;
   DEBUG_CONSOLE_INIT                             : constant boolean := false;
   DEBUG_SPI_FLASH                                : constant boolean := false;
   DEBUG_FUNC                                     : constant boolean := false;
   DEBUG_BOOT_STATE                               : constant boolean := false;
   DEBUG_ADA_CODE                                 : constant boolean := false;
   HAVE_EM100_SUPPORT                             : constant boolean := true;
   EM100                                          : constant boolean := false;
   RAMSTAGE_ADA                                   : constant boolean := true;
   RAMSTAGE_LIBHWBASE                             : constant boolean := true;
   SPD_CACHE_IN_FMAP                              : constant boolean := false;
   HWBASE_DYNAMIC_MMIO                            : constant boolean := true;
   HWBASE_DEFAULT_MMCONF                          : constant         := 16#f000_0000#;
   HWBASE_DIRECT_PCIDEV                           : constant boolean := true;
   WARNINGS_ARE_ERRORS                            : constant boolean := true;
   POWER_BUTTON_DEFAULT_ENABLE                    : constant boolean := false;
   POWER_BUTTON_DEFAULT_DISABLE                   : constant boolean := false;
   POWER_BUTTON_FORCE_ENABLE                      : constant boolean := false;
   POWER_BUTTON_FORCE_DISABLE                     : constant boolean := false;
   POWER_BUTTON_IS_OPTIONAL                       : constant boolean := false;
   REG_SCRIPT                                     : constant boolean := false;
   MAX_REBOOT_CNT                                 : constant         := 3;
   NO_XIP_EARLY_STAGES                            : constant boolean := false;
   EARLY_CBMEM_LIST                               : constant boolean := false;
   RELOCATABLE_MODULES                            : constant boolean := true;
   HAVE_BOOTBLOCK                                 : constant boolean := true;
   HAVE_ROMSTAGE                                  : constant boolean := true;
   HAVE_RAMSTAGE                                  : constant boolean := true;

end CB.Config;
