PHDRS
{
 to_load PT_LOAD;
}
ENTRY(_start)
SECTIONS
{
 _ = ASSERT(. <= 0x2000000, "romstage overlaps the previous region!"); . = 0x2000000; _romstage = ABSOLUTE(.); _eromstage = ABSOLUTE(_romstage + 1M); _romstage_size = ABSOLUTE(_eromstage - _romstage); _ = ASSERT(_eprogram - _program <= 1M, "Romstage exceeded its allotted size! (1M)"); INCLUDE "romstage/lib/program.ld"
. = 0xfefc0000;
.car.data . (NOLOAD) : {
 _car_region_start = . ;
 . += 0;
 _ = ASSERT(. <= ., "car_stack overlaps the previous region!"); . = .; _car_stack = ABSOLUTE(.); _ = ASSERT(. == ALIGN(4), "car_stack must be aligned to 4!"); _ = ASSERT(. <= . + 0x2000, "ecar_stack overlaps the previous region!"); . = . + 0x2000; _ecar_stack = ABSOLUTE(.); _car_stack_size = ABSOLUTE(_ecar_stack - _car_stack);
 _ = ASSERT(. <= ., "preram_cbmem_console overlaps the previous region!"); . = .; _preram_cbmem_console = ABSOLUTE(.); _ = ASSERT(. == ALIGN(4), "preram_cbmem_console must be aligned to 4!"); _ = ASSERT(. <= . + 0xc00, "epreram_cbmem_console overlaps the previous region!"); . = . + 0xc00; _epreram_cbmem_console = ABSOLUTE(.); _preram_cbmem_console_size = ABSOLUTE(_epreram_cbmem_console - _preram_cbmem_console);
 _ = ASSERT(. <= ., "timestamp overlaps the previous region!"); . = .; _timestamp = ABSOLUTE(.); _ = ASSERT(. == ALIGN(8), "timestamp must be aligned to 8!"); _ = ASSERT(. <= . + 0x200, "etimestamp overlaps the previous region!"); . = . + 0x200; _etimestamp = ABSOLUTE(.); _timestamp_size = ABSOLUTE(_etimestamp - _timestamp); _ = ASSERT(0x200 >= 212, "Timestamp region must fit timestamp_cache!");
 _ = ASSERT(. <= ., "cbfs_mcache overlaps the previous region!"); . = .; _cbfs_mcache = ABSOLUTE(.); _ = ASSERT(. == ALIGN(4), "cbfs_mcache must be aligned to 4!"); _ = ASSERT(. <= . + 0x2000, "ecbfs_mcache overlaps the previous region!"); . = . + 0x2000; _ecbfs_mcache = ABSOLUTE(.); _cbfs_mcache_size = ABSOLUTE(_ecbfs_mcache - _cbfs_mcache);
 _ = ASSERT(. <= ., "fmap_cache overlaps the previous region!"); . = .; _fmap_cache = ABSOLUTE(.); _ = ASSERT(. == ALIGN(4), "fmap_cache must be aligned to 4!"); _ = ASSERT(. <= . + 0xb6, "efmap_cache overlaps the previous region!"); . = . + 0xb6; _efmap_cache = ABSOLUTE(.); _fmap_cache_size = ABSOLUTE(_efmap_cache - _fmap_cache); _ = ASSERT(0xb6 >= 0xb6, "FMAP does not fit in FMAP_CACHE! (0xb6 < 0xb6)");
 _ = ASSERT(. <= ., "car_ehci_dbg_info overlaps the previous region!"); . = .; _car_ehci_dbg_info = ABSOLUTE(.); _ = ASSERT(. == ALIGN(1), "car_ehci_dbg_info must be aligned to 1!"); _ = ASSERT(. <= . + 80, "ecar_ehci_dbg_info overlaps the previous region!"); . = . + 80; _ecar_ehci_dbg_info = ABSOLUTE(.); _car_ehci_dbg_info_size = ABSOLUTE(_ecar_ehci_dbg_info - _car_ehci_dbg_info);
 . = ALIGN(8);
 _bss = .;
 *(.bss)
 *(.bss.*)
 *(.sbss)
 *(.sbss.*)
 . = ALIGN(8);
 _ebss = .;
 _bss_size = ABSOLUTE(_ebss - _bss);
 _car_unallocated_start = .;
 _car_region_end = . + 0x8000 - (. - _car_region_start)
     - 0;
}
. = _car_region_start;
.car.fspm_rc_heap . (NOLOAD) : {
. += 0;
}
. = _car_region_end;
.car.mrc_var . (NOLOAD) : {
 . += 0;
}
.car.fspt_reserved . (NOLOAD) : {
 . += 0;
}
. = 0xffffff00;
.illegal_globals . : {
 *(EXCLUDE_FILE ("*/libagesa.*.a:" "*/romstage*/buildOpts.o" "*/romstage*/agesawrapper.o" "*/vendorcode/amd/agesa/*" "*/vendorcode/amd/cimx/*") .data)
 *(EXCLUDE_FILE ("*/libagesa.*.a:" "*/romstage*/buildOpts.o" "*/romstage*/agesawrapper.o" "*/vendorcode/amd/agesa/*" "*/vendorcode/amd/cimx/*") .data.*)
}
_bogus = ASSERT((0x8000 == 0) || (SIZEOF(.car.data) <= 0x8000), "Cache as RAM area is too full");
_bogus3 = ASSERT(0x2000 > 0x0, "BSP stack size not configured");
}
