.text . : {
 _program = .;
 _text = .;
 *(.init._start);
 *(.init);
 *(.init.*);
 *(.text._start);
 *(.text.stage_entry);
 KEEP(*(.metadata_hash_anchor));
 *(.text);
 *(.text.*);
 . = ALIGN(8);
 _cbmem_init_hooks = .;
 KEEP(*(.rodata.cbmem_init_hooks));
 _ecbmem_init_hooks = .;
 _cbmem_init_hooks_size = ABSOLUTE(_ecbmem_init_hooks - _cbmem_init_hooks);
 . = ALIGN(8);
 _rsbe_init_begin = .;
 KEEP(*(.rsbe_init));
 _ersbe_init_begin = .;
 _rsbe_init_begin_size = ABSOLUTE(_ersbe_init_begin - _rsbe_init_begin);
 . = ALIGN(8);
 *(.rodata);
 *(.rodata.*);
 . = ALIGN(8);
 _etext = .;
 _text_size = ABSOLUTE(_etext - _text);
} : to_load
_eprogram = .;
_program_size = ABSOLUTE(_eprogram - _program);
zeroptr = 0;
/DISCARD/ : {
 *(.comment)
 *(.comment.*)
 *(.note)
 *(.note.*)
 *(.eh_frame);
}
