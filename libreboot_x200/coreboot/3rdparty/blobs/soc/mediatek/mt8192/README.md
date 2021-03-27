# Firmware list
- drame.elf
- dpm.dm
- dpm.pm
- spm_firmware.bin
- sspm.bin
- mcupm.bin

--------------------------------------------------------------------------------
# `dram.elf` Introduction

`dram.elf` is one ELF format file which is used for calibration.
The dram.elf is loaded at the first time bootup, it will do DRAM
full calibration, and save calibration parameters to NAND (or EMMC)
for faster bootup after the frist bootup.

## Who uses it
   - coreboot loads `dram.elf` at the first time bootup if no DRAM parameters exist.

## How to load `dram.elf`
   - coreboot locates `dram.elf` file, and locates the entry point "_start",
     then it passes DRAM struct "param", and call _start(&param) to execute `dram.elf`
     flow.

## Parameters
```
    struct dramc_param {
        struct dramc_param_header header; // see below
        void (*do_putc)(unsigned char c);
        struct dramc_data dramc_datas;    // see below
    };
```
   Below shows the internal structure of dramc_param:
```
    struct dramc_param_header {
        u32 checksum;   /* checksum of dramc_datas, update in the coreboot */
        u16 version;    /* DRAMC_PARAM_HEADER_VERSION, update in the coreboot */
        u16 size;       /* size of whole dramc_param, update in the coreboot */
        u16 status;     /* DRAMC_PARAM_STATUS_CODES, update in the dram blob */
        u16 flags;      /* DRAMC_PARAM_FLAGS, update in the dram blob */
    };

    struct dramc_data {
        struct ddr_base_info ddr_info;
        struct sdram_params freq_params[DRAM_DFS_SHU_MAX];
    };

    struct ddr_base_info {
        u16 config_dvfs;		/* DRAMC_PARAM_DVFS_FLAG */
        u16 ddr_type;			/* DRAMC_PARAM_DDR_TYPE */
        u16 ddr_geometry;		/* DRAMC_PARAM_GEOMETRY_TYPE */
        u16 voltage_type;		/* DRAM_PARAM_VOLTAGE_TYPE */
        u32 support_ranks;
        u64 rank_size[RANK_MAX];
        struct emi_mdl emi_config;
        dram_cbt_mode cbt_mode[RANK_MAX];
    };

    struct sdram_params {
        u32 rank_num;
        u16 num_dlycell_perT;
        u16 delay_cell_timex100;

    /* duty */
    s8 duty_clk_delay[CHANNEL_MAX][RANK_MAX];
    s8 duty_dqs_delay[CHANNEL_MAX][DQS_NUMBER_LP4];
    s8 duty_wck_delay[CHANNEL_MAX][DQS_NUMBER_LP4];
        .......
        .......
    };
```

## The output of `dram.elf`
   - `dram.elf` will set the suitable dramc settings, also save the DRAM parameters
     to NAND (or EMMC) on the specified section: "RW_DDR_TRAINING".

## Return Values
   - 0   : means successful.
   - < 0 : means failed.

--------------------------------------------------------------------------------
# DPM Introduction

DPM is hardware module which is used for DRAM Power Management, which
is used for DRAM low power.
For example: self refresh, disable PLL/DLL when not in used.

DPM includes two parts of images: data part (`dpm.dm`) and program part (`dpm.pm`).
They are loaded into DPM SRAM when system inits.

## Who uses it
   - coreboot will load dpm at ramstage. It will copy `dpm.dm` & `dpm.pm` to DPM SRAM.

## How to load DPM
   - Use CBFS to load `dpm.dm` and `dpm.pm`.
   - No need to pass other parameters to DPM.

## Return Values
   - 0  : means successful;
   - -1 : means failed;

## Version
  - No version yet.

--------------------------------------------------------------------------------
# SPM Introduction

SPM is able to turn off more power such as DRAM self-refresh mode and 26M clock off
when system is in suspend. Also, SPM helps support Vcore DVFS feature.

## Who uses it
   - Linux kernel system suspend and Vcore DVFS.

## How to load `spm_fimware.bin`
   - Use CBFS to load "spm_fimware.bin" to DRAM and SPM DMA loads it from dram to SPM SRAM.

## Return Values
   SPM driver in coreboot checks if pmem_words/dmem_words are 16-byte aligned in `spm_fimware.bin`
   - yes : SPM DMA can load `spm_fimware.bin` to SPM SRAM correctly.
   - no  : assert(0)

## Version
   Search "spmfw (version" will show log like below
   - spmfw (version pcm_suspend_v1.43_no_GPU_WAYEN)

--------------------------------------------------------------------------------
# SSPM Introduction

SSPM is "Secure System Power Manager" that provides power control in secure domain.
SSPM provides power related features, e.g. CPU DVFS, thermal control, to offload
application processor for security reason.

SSPM firmware is loaded into SSPM SRAM at system initialization.

## Who uses it
   - coreboot will load sspm.bin to SSPM SRAM at ramstage.

## How to load `sspm.bin`
   - Use CBFS to load `sspm.bin`.
   - No need to pass other parameters to SSPM.

## Return Value
  - No return value.

## Version
  - No version yet.

--------------------------------------------------------------------------------
# MCUPM Introduction

MCUPM is a hardware module which is used for MCUSYS Power Management,
for example: core/cluster on/off. MCUPM firmware (`mcupm.bin`) is loaded into
MCUPM SRAM at system initialization.

## Who uses it
   - coreboot will load MCUPM at ramstage. It will copy mcupm.bin to MCUPM SRAM.

## How to load `mcupm.bin`
   - Use CBFS to load `mcupm.bin`, then set normal boot flag and release software reset pin of MCUPM.

## Return Values
  - No return value.

## Version
  - Refer to MCUPM release note.
