PHDRS
{
 to_load PT_LOAD;
}
ENTRY(_start)
SECTIONS
{
 _ = ASSERT(. <= 0x00000000, "rmodule overlaps the previous region!"); . = 0x00000000;
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
 _rsbe_init_begin = .;
 KEEP(*(.rsbe_init));
 _ersbe_init_begin = .;
 . = ALIGN(8);
 *(.rodata);
 *(.rodata.*);
 . = ALIGN(8);
 _etext = .;
} : to_load
.data . : {
 . = ALIGN(64);
 _data = .;
 _rmodule_params = .;
 KEEP(*(.module_parameters));
 _ermodule_params = .;
 *(.data);
 *(.data.*);
 *(.sdata);
 *(.sdata.*);
 . = ALIGN(8);
 _edata = .;
}
.bss . : {
 . = ALIGN(8);
 _bss = .;
 *(.bss)
 *(.bss.*)
 *(.sbss)
 *(.sbss.*)
 . = ALIGN(8);
 _ebss = .;
}
.heap . : {
 . = ALIGN(8);
 _heap = .;
 . += (1 ? __heap_size : 0x4000);
 . = ALIGN(8);
 _eheap = .;
}
_eprogram = .;
zeroptr = 0;
/DISCARD/ : {
 *(.comment)
 *(.comment.*)
 *(.note)
 *(.note.*)
 *(.eh_frame);
}
}
