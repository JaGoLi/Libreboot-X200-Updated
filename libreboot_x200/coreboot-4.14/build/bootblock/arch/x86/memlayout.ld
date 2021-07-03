PHDRS
{
 to_load PT_LOAD;
}
ENTRY(_start)
SECTIONS
{
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
_car_mtrr_end = .;
_car_mtrr_start = _car_region_start;
_car_mtrr_size = _car_mtrr_end - _car_mtrr_start;
_car_mtrr_sz_log2 = 1 << LOG2CEIL(_car_mtrr_size);
_car_mtrr_mask = ~(MAX(4096, _car_mtrr_sz_log2) - 1);
_xip_program_sz_log2 = 1 << LOG2CEIL(_ebootblock - _bootblock);
_xip_mtrr_mask = ~(MAX(4096, _xip_program_sz_log2) - 1);
_rom_mtrr_mask = ~(((0x00400000 + ((0x00400000>>1)|(0x00400000>>2)|(0x00400000>>3)|(0x00400000>>4)|(0x00400000>>5)| (0x00400000>>6)|(0x00400000>>7)|(0x00400000>>8)|((1<<18)-1))) & ~((0x00400000>>1)|(0x00400000>>2)|(0x00400000>>3)|(0x00400000>>4)|(0x00400000>>5)| (0x00400000>>6)|(0x00400000>>7)|(0x00400000>>8)|((1<<18)-1))) - 1);
_rom_mtrr_base = _rom_mtrr_mask;
. = 0xffffff00;
.illegal_globals . : {
 *(EXCLUDE_FILE ("*/libagesa.*.a:" "*/romstage*/buildOpts.o" "*/romstage*/agesawrapper.o" "*/vendorcode/amd/agesa/*" "*/vendorcode/amd/cimx/*") .data)
 *(EXCLUDE_FILE ("*/libagesa.*.a:" "*/romstage*/buildOpts.o" "*/romstage*/agesawrapper.o" "*/vendorcode/amd/agesa/*" "*/vendorcode/amd/cimx/*") .data.*)
}
_bogus = ASSERT((0x8000 == 0) || (SIZEOF(.car.data) <= 0x8000), "Cache as RAM area is too full");
_bogus3 = ASSERT(0x2000 > 0x0, "BSP stack size not configured");
}
gdtptr_offset = gdtptr & 0xffff;
nullidt_offset = nullidt & 0xffff;
SECTIONS {
 . = BOOTBLOCK_TOP - PROGRAM_SZ;
 . = ALIGN(16);
 _bootblock = .;
 INCLUDE "bootblock/lib/program.ld"
 PROGRAM_SZ = SIZEOF(.text) + 512;
 . = MIN(_ID_SECTION, _FIT_POINTER) - EARLYASM_SZ;
 . = 0 ? ALIGN(4096) : ALIGN(16);
 BOOTBLOCK_TOP = .;
 .init (.) : {
  *(.init._start);
  *(.init);
  *(.init.*);
 }
 EARLYASM_SZ = SIZEOF(.init) + (0 ? 4096 : 16);
 . = _ID_SECTION;
 .id (.): {
  KEEP(*(.id));
 }
 _ID_SECTION_END = SIZEOF(.fit_pointer) && SIZEOF(.id) > 0x28 ? 0xffffff80 : _X86_RESET_VECTOR;
 _ID_SECTION = _ID_SECTION_END - SIZEOF(.id);
 . = _FIT_POINTER;
 .fit_pointer (.): {
  KEEP(*(.fit_pointer));
 }
 _FIT_POINTER = SIZEOF(.fit_pointer) ? 0xffffffc0 : _X86_RESET_VECTOR;
 . = 0xfffffff0;
 _X86_RESET_VECTOR = .;
 .reset . : {
  *(.reset);
  . = 15;
  BYTE(0x00);
 }
 _ebootblock = .;
}
_bogus1 = ASSERT(_bootblock & 0x80000000, "_bootblock too low, invalid ld script");
_bogus2 = ASSERT(_start16bit & 0x80000000, "_start16bit too low, invalid ld script");
_bogus3 = ASSERT(_start16bit >= 0xffff0000, "_start16bit too low. Please report.");
_bogus4 = ASSERT(_ebootblock - _bootblock <= 0x40000,
   "_bootblock too low, increase C_ENV_BOOTBLOCK_SIZE");
