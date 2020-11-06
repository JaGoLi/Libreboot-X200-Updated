.text . : {
 _program = .;
 _text = .;
 *(.rom.text);
 *(.rom.data);
 *(.text._start);
 *(.text.stage_entry);
 *(.text);
 *(.text.*);
 . = ALIGN(8);
 _cbmem_init_hooks = .;
 KEEP(*(.rodata.cbmem_init_hooks));
 _ecbmem_init_hooks = .;
 . = ALIGN(8);
 _rsbe_init_begin = .;
 KEEP(*(.rsbe_init));
 _ersbe_init_begin = .;
 . = ALIGN(8);
 *(.rodata);
 *(.rodata.*);
 . = ALIGN(8);
 _etext = .;
} : to_load
_eprogram = .;
zeroptr = 0;
/DISCARD/ : {
 *(.comment)
 *(.comment.*)
 *(.note)
 *(.note.*)
 *(.eh_frame);
}
