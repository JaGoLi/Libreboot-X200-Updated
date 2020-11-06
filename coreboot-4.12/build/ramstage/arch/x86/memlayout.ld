PHDRS
{
 to_load PT_LOAD;
}
ENTRY(_start)
SECTIONS
{
 _ = ASSERT(. <= 0xe00000, "ramstage overlaps the previous region!"); . = 0xe00000; _ramstage = .; _eramstage = _ramstage + (1 ? 8M : 0x1000000 - 0xe00000); _ = ASSERT(_eprogram - _program <= (1 ? 8M : 0x1000000 - 0xe00000), "Ramstage exceeded its allotted size! ((1 ? 8M : 0x1000000 - 0xe00000))"); INCLUDE "ramstage/lib/program.ld"
}
