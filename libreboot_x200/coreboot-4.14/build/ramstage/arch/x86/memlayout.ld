PHDRS
{
 to_load PT_LOAD;
}
ENTRY(_start)
SECTIONS
{
 _ = ASSERT(. <= 0xe00000, "ramstage overlaps the previous region!"); . = 0xe00000; _ramstage = ABSOLUTE(.); _eramstage = ABSOLUTE(_ramstage + 8M); _ramstage_size = ABSOLUTE(_eramstage - _ramstage); _ = ASSERT(_eprogram - _program <= 8M, "Ramstage exceeded its allotted size! (8M)"); INCLUDE "ramstage/lib/program.ld"
}
