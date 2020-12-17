PHDRS
{
 to_load PT_LOAD;
}
ENTRY(_start)
SECTIONS
{
 _ = ASSERT(. <= 0xe00000, "ramstage overlaps the previous region!"); . = 0xe00000; _ramstage = .; _eramstage = _ramstage + 8M; _ = ASSERT(_eprogram - _program <= 8M, "Ramstage exceeded its allotted size! (8M)"); INCLUDE "ramstage/lib/program.ld"
}
