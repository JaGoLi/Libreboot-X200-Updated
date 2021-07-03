PHDRS
{
 to_load PT_LOAD;
}
ENTRY(_start)
SECTIONS
{
 _ = ASSERT(. <= 32M, "postcar overlaps the previous region!"); . = 32M; _postcar = ABSOLUTE(.); _epostcar = ABSOLUTE(_postcar + 1M); _postcar_size = ABSOLUTE(_epostcar - _postcar); _ = ASSERT(_eprogram - _program <= 1M, "Aftercar exceeded its allotted size! (1M)"); INCLUDE "postcar/lib/program.ld"
}
