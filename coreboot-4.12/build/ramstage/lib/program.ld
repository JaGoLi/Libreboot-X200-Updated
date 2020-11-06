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
 _pci_drivers = .;
 KEEP(*(.rodata.pci_driver));
 _epci_drivers = .;
 . = ALIGN(8);
 _cpu_drivers = .;
 KEEP(*(.rodata.cpu_driver));
 _ecpu_drivers = .;
 . = ALIGN(8);
 *(.rodata);
 *(.rodata.*);
 . = ALIGN(8);
 _etext = .;
} : to_load
.data . : {
 . = ALIGN(64);
 _data = .;
 *(.data);
 *(.data.*);
 *(.sdata);
 *(.sdata.*);
 . = ALIGN(8);
 _bs_init_begin = .;
 KEEP(*(.bs_init));
 LONG(0);
 LONG(0);
 _ebs_init_begin = .;
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
 . += (0 ? __heap_size : 0x4000);
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
