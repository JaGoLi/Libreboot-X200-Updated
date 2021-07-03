/* SPDX-License-Identifier: GPL-2.0-only */

#include <console/console.h>
#include <cpu/x86/mp.h>
#include <stdint.h>
#include <cpu/intel/smm_reloc.h>
#include <cpu/amd/amd64_save_state.h>
#include <mainboard/emulation/qemu-i440fx/fw_cfg.h>

static void get_smm_info(uintptr_t *perm_smbase, size_t *perm_smsize,
	      size_t *smm_save_state_size)
{
	printk(BIOS_DEBUG, "Setting up SMI for CPU\n");

	smm_subregion(SMM_SUBREGION_HANDLER, perm_smbase, perm_smsize);

	/* FIXME: on X86_64 the save state size is smaller than the size of the SMM stub */
	*smm_save_state_size = sizeof(amd64_smm_state_save_area_t);
	printk(BIOS_DEBUG, "Save state size: 0x%zx bytes\n", *smm_save_state_size);
}

/*
 * The relocation work is actually performed in SMM context, but the code
 * resides in the ramstage module. This occurs by trampolining from the default
 * SMRAM entry point to here.
 */
static void relocation_handler(int cpu, uintptr_t curr_smbase,
			       uintptr_t staggered_smbase)
{
	/* The em64t101 save state is sufficiently compatible with older
	   save states with regards of smbase, smm_revision. */
	amd64_smm_state_save_area_t *save_state;
	u32 smbase = staggered_smbase;

	save_state = (void *)(curr_smbase + SMM_DEFAULT_SIZE - sizeof(*save_state));
	save_state->smbase = smbase;

	printk(BIOS_DEBUG, "In relocation handler: cpu %d\n", cpu);
	printk(BIOS_DEBUG, "SMM revision: 0x%08x\n", save_state->smm_revision);
	printk(BIOS_DEBUG, "New SMBASE=0x%08x\n", smbase);
}

static void post_mp_init(void)
{
	/* Now that all APs have been relocated as well as the BSP let SMIs start flowing. */
	global_smi_enable();

	/* Lock down the SMRAM space. */
	smm_lock();
}

const struct mp_ops mp_ops_with_smm = {
	.get_cpu_count       = fw_cfg_max_cpus,
	.get_smm_info        = get_smm_info,
	.pre_mp_smm_init     = smm_southbridge_clear_state,
	.relocation_handler  = relocation_handler,
	.post_mp_init        = post_mp_init,
};
