/* A Bison parser, made by GNU Bison 3.7.6.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output, and Bison version.  */
#define YYBISON 30706

/* Bison version string.  */
#define YYBISON_VERSION "3.7.6"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* First part of user prologue.  */
#line 4 "bincfg.y"

#include <stdio.h>
#include <inttypes.h>
#include <stdlib.h>
#include <string.h>
#include "bincfg.h"
//#define YYDEBUG 1

static void check_pointer (void *ptr)
{
	if (ptr == NULL) {
		printf("Error: Out of memory\n");
		exit(1);
	}
}

static unsigned char* value_to_bits (unsigned int v, unsigned int w)
{
	unsigned int i;
	unsigned char* bitarr;

	if (w > MAX_WIDTH) w = MAX_WIDTH;
	bitarr = (unsigned char *) malloc (w * sizeof (unsigned char));
	check_pointer(bitarr);
	memset (bitarr, 0, w);

	for (i = 0; i < w; i++) {
		bitarr[i] = VALID_BIT | ((v & (1 << i)) >> i);
	}
	return bitarr;
}

/* Store each bit of a bitfield in a new byte sequentially 0x80 or 0x81 */
static void append_field_to_blob (unsigned char b[], unsigned int w)
{
	unsigned int i, j;
	binary->blb = (unsigned char *) realloc (binary->blb,
						 binary->bloblen + w);
	check_pointer(binary->blb);
	for (j = 0, i = binary->bloblen; i < binary->bloblen + w; i++, j++) {
		binary->blb[i] = VALID_BIT | (b[j] & 1);
		//fprintf (stderr, "blob[%d] = %d\n", i, binary->blb[i] & 1);
	}
	binary->bloblen += w;
}

static void set_bitfield(char *name, unsigned int value)
{
	unsigned long long i;
	struct field *bf = getsym (name);
	if (bf) {
		bf->value = value & 0xffffffff;
		i = (1 << bf->width) - 1;
		if (bf->width > 8 * sizeof (unsigned int)) {
			fprintf(stderr,
				"Overflow in bitfield, truncating bits to"
				" fit\n");
			bf->value = value & i;
		}
		//fprintf(stderr, "Setting `%s` = %d\n", bf->name, bf->value);
	} else {
		fprintf(stderr, "Can't find bitfield `%s` in spec\n", name);
	}
}

static void set_bitfield_array(char *name, unsigned int n, unsigned int value)
{
	unsigned int i;
	unsigned long len = strlen (name);
	char *namen = (char *) malloc ((len + 9) * sizeof (char));
	check_pointer(namen);
	for (i = 0; i < n; i++) {
		snprintf (namen, len + 8, "%s%x", name, i);
		set_bitfield (namen, value);
	}
	free(namen);
}

static void create_new_bitfield(char *name, unsigned int width)
{
	struct field *bf;

	if (!(bf = putsym (name, width))) return;
	//fprintf(stderr, "Added bitfield `%s` : %d\n", bf->name, width);
}

static void create_new_bitfields(char *name, unsigned int n, unsigned int width)
{
	unsigned int i;
	unsigned long len = strlen (name);
	char *namen = (char *) malloc ((len + 9) * sizeof (char));
	check_pointer(namen);
	for (i = 0; i < n; i++) {
		snprintf (namen, len + 8, "%s%x", name, i);
		create_new_bitfield (namen, width);
	}
	free(namen);
}

static struct field *putsym (char const *sym_name, unsigned int w)
{
	if (getsym(sym_name)) {
		fprintf(stderr, "Cannot add duplicate named bitfield `%s`\n",
			sym_name);
		return 0;
	}
	struct field *ptr = (struct field *) malloc (sizeof (struct field));
	check_pointer(ptr);
	ptr->name = (char *) malloc (strlen (sym_name) + 1);
	check_pointer(ptr->name);
	strcpy (ptr->name, sym_name);
	ptr->width = w;
	ptr->value = 0;
	ptr->next = (struct field *)0;
	if (sym_table_tail) {
		sym_table_tail->next = ptr;
	} else {
		sym_table = ptr;
	}
	sym_table_tail = ptr;
	return ptr;
}

static struct field *getsym (char const *sym_name)
{
	struct field *ptr;
	for (ptr = sym_table; ptr != (struct field *) 0;
			ptr = (struct field *)ptr->next) {
		if (strcmp (ptr->name, sym_name) == 0)
			return ptr;
	}
	return 0;
}

static void dump_all_values (void)
{
	struct field *ptr;
	for (ptr = sym_table; ptr != (struct field *) 0;
			ptr = (struct field *)ptr->next) {
		fprintf(stderr, "%s = %d (%d bits)\n",
				ptr->name,
				ptr->value,
				ptr->width);
	}
}

static void empty_field_table(void)
{
	struct field *ptr;
	struct field *ptrnext;

	for (ptr = sym_table; ptr != (struct field *) 0; ptr = ptrnext) {
		if (ptr) {
			ptrnext = ptr->next;
			free(ptr);
		} else {
			ptrnext = (struct field *) 0;
		}
	}
	sym_table = 0;
	sym_table_tail = 0;
}

static void create_binary_blob (void)
{
	if (binary && binary->blb) {
		free(binary->blb);
		free(binary);
	}
	binary = (struct blob *) malloc (sizeof (struct blob));
	check_pointer(binary);
	binary->blb = (unsigned char *) malloc (sizeof (unsigned char));
	check_pointer(binary->blb);
	binary->bloblen = 0;
	binary->blb[0] = VALID_BIT;
}

static void interpret_next_blob_value (struct field *f)
{
	unsigned int i;
	unsigned int v = 0;

	if (binary->bloblen >= binary->lenactualblob * 8) {
		f->value = 0;
		return;
	}

	for (i = 0; i < f->width; i++) {
		v |= (binary->blb[binary->bloblen++] & 1) << i;
	}

	f->value = v;
}

/* {}%BIN -> {} */
static void generate_setter_bitfields(FILE* fp, unsigned char *bin)
{
	unsigned int i;
	struct field *ptr;

	/* Convert bytes to bit array */
	for (i = 0; i < binary->lenactualblob; i++) {
		append_field_to_blob (value_to_bits(bin[i], 8), 8);
	}

	/* Reset blob position to zero */
	binary->bloblen = 0;

	fprintf (fp, "# AUTOGENERATED SETTER BY BINCFG\n{\n");

	/* Traverse spec and output bitfield setters based on blob values */
	for (ptr = sym_table; ptr != (struct field *) 0; ptr = ptr->next) {

		interpret_next_blob_value(ptr);
		fprintf (fp, "\t\"%s\" = 0x%x,\n", ptr->name, ptr->value);
	}
	fseek(fp, -2, SEEK_CUR);
	fprintf (fp, "\n}\n");
}

static void generate_binary_with_gbe_checksum(FILE* fp)
{
	unsigned int i;
	unsigned short checksum;

	/* traverse spec, push to blob and add up for checksum */
	struct field *ptr;
	unsigned int uptochksum = 0;
	for (ptr = sym_table; ptr != (struct field *) 0; ptr = ptr->next) {
		if (strcmp (ptr->name, "checksum_gbe") == 0) {
			/* Stop traversing because we hit checksum */
			ptr = ptr->next;
			break;
		}
		append_field_to_blob (
			value_to_bits(ptr->value, ptr->width),
			ptr->width);
		uptochksum += ptr->width;
	}

	/* deserialize bits of blob up to checksum */
	for (i = 0; i < uptochksum; i += 8) {
		unsigned char byte = (((binary->blb[i+0] & 1) << 0)
					| ((binary->blb[i+1] & 1) << 1)
					| ((binary->blb[i+2] & 1) << 2)
					| ((binary->blb[i+3] & 1) << 3)
					| ((binary->blb[i+4] & 1) << 4)
					| ((binary->blb[i+5] & 1) << 5)
					| ((binary->blb[i+6] & 1) << 6)
					| ((binary->blb[i+7] & 1) << 7)
		);
		fprintf(fp, "%c", byte);

		/* incremental 16 bit checksum */
		if ((i % 16) < 8) {
			binary->checksum += byte;
		} else {
			binary->checksum += byte << 8;
		}
	}

	checksum = (0xbaba - binary->checksum) & 0xffff;

	/* Now write checksum */
	set_bitfield ("checksum_gbe", checksum);

	fprintf(fp, "%c", checksum & 0xff);
	fprintf(fp, "%c", (checksum & 0xff00) >> 8);

	append_field_to_blob (value_to_bits(checksum, 16), 16);

	for (; ptr != (struct field *) 0; ptr = ptr->next) {
		append_field_to_blob (
			value_to_bits(ptr->value, ptr->width), ptr->width);
	}

	/* deserialize rest of blob past checksum */
	for (i = uptochksum + CHECKSUM_SIZE; i < binary->bloblen; i += 8) {
		unsigned char byte = (((binary->blb[i+0] & 1) << 0)
					| ((binary->blb[i+1] & 1) << 1)
					| ((binary->blb[i+2] & 1) << 2)
					| ((binary->blb[i+3] & 1) << 3)
					| ((binary->blb[i+4] & 1) << 4)
					| ((binary->blb[i+5] & 1) << 5)
					| ((binary->blb[i+6] & 1) << 6)
					| ((binary->blb[i+7] & 1) << 7)
		);
		fprintf(fp, "%c", byte);
	}
}

/* {}{} -> BIN */
static void generate_binary(FILE* fp)
{
	unsigned int i;
	struct field *ptr;

	if (binary->bloblen % 8) {
		fprintf (stderr,
			 "ERROR: Spec must be multiple of 8 bits wide\n");
		exit (1);
	}

	if (getsym ("checksum_gbe")) {
		generate_binary_with_gbe_checksum(fp);
		return;
	}

	/* traverse spec, push to blob */
	for (ptr = sym_table; ptr != (struct field *) 0; ptr = ptr->next) {
		append_field_to_blob (
			value_to_bits(ptr->value, ptr->width),
			ptr->width);
	}

	/* deserialize bits of blob */
	for (i = 0; i < binary->bloblen; i += 8) {
		unsigned char byte = (((binary->blb[i+0] & 1) << 0)
				| ((binary->blb[i+1] & 1) << 1)
				| ((binary->blb[i+2] & 1) << 2)
				| ((binary->blb[i+3] & 1) << 3)
				| ((binary->blb[i+4] & 1) << 4)
				| ((binary->blb[i+5] & 1) << 5)
				| ((binary->blb[i+6] & 1) << 6)
				| ((binary->blb[i+7] & 1) << 7)
		);
		fprintf(fp, "%c", byte);
	}
}


#line 403 "bincfg.tab.c"

# ifndef YY_CAST
#  ifdef __cplusplus
#   define YY_CAST(Type, Val) static_cast<Type> (Val)
#   define YY_REINTERPRET_CAST(Type, Val) reinterpret_cast<Type> (Val)
#  else
#   define YY_CAST(Type, Val) ((Type) (Val))
#   define YY_REINTERPRET_CAST(Type, Val) ((Type) (Val))
#  endif
# endif
# ifndef YY_NULLPTR
#  if defined __cplusplus
#   if 201103L <= __cplusplus
#    define YY_NULLPTR nullptr
#   else
#    define YY_NULLPTR 0
#   endif
#  else
#   define YY_NULLPTR ((void*)0)
#  endif
# endif

#include "bincfg.tab.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end of file"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_name = 3,                       /* name  */
  YYSYMBOL_val = 4,                        /* val  */
  YYSYMBOL_vals = 5,                       /* vals  */
  YYSYMBOL_hexbyte = 6,                    /* hexbyte  */
  YYSYMBOL_binblob = 7,                    /* binblob  */
  YYSYMBOL_eof = 8,                        /* eof  */
  YYSYMBOL_9_ = 9,                         /* '%'  */
  YYSYMBOL_10_ = 10,                       /* '{'  */
  YYSYMBOL_11_ = 11,                       /* '}'  */
  YYSYMBOL_12_ = 12,                       /* ','  */
  YYSYMBOL_13_ = 13,                       /* ':'  */
  YYSYMBOL_14_ = 14,                       /* '='  */
  YYSYMBOL_15_ = 15,                       /* '['  */
  YYSYMBOL_16_ = 16,                       /* ']'  */
  YYSYMBOL_YYACCEPT = 17,                  /* $accept  */
  YYSYMBOL_input = 18,                     /* input  */
  YYSYMBOL_blob = 19,                      /* blob  */
  YYSYMBOL_spec = 20,                      /* spec  */
  YYSYMBOL_specmembers = 21,               /* specmembers  */
  YYSYMBOL_specpair = 22,                  /* specpair  */
  YYSYMBOL_setter = 23,                    /* setter  */
  YYSYMBOL_valuemembers = 24,              /* valuemembers  */
  YYSYMBOL_setpair = 25                    /* setpair  */
};
typedef enum yysymbol_kind_t yysymbol_kind_t;




#ifdef short
# undef short
#endif

/* On compilers that do not define __PTRDIFF_MAX__ etc., make sure
   <limits.h> and (if available) <stdint.h> are included
   so that the code can choose integer types of a good width.  */

#ifndef __PTRDIFF_MAX__
# include <limits.h> /* INFRINGES ON USER NAME SPACE */
# if defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stdint.h> /* INFRINGES ON USER NAME SPACE */
#  define YY_STDINT_H
# endif
#endif

/* Narrow types that promote to a signed type and that can represent a
   signed or unsigned integer of at least N bits.  In tables they can
   save space and decrease cache pressure.  Promoting to a signed type
   helps avoid bugs in integer arithmetic.  */

#ifdef __INT_LEAST8_MAX__
typedef __INT_LEAST8_TYPE__ yytype_int8;
#elif defined YY_STDINT_H
typedef int_least8_t yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef __INT_LEAST16_MAX__
typedef __INT_LEAST16_TYPE__ yytype_int16;
#elif defined YY_STDINT_H
typedef int_least16_t yytype_int16;
#else
typedef short yytype_int16;
#endif

/* Work around bug in HP-UX 11.23, which defines these macros
   incorrectly for preprocessor constants.  This workaround can likely
   be removed in 2023, as HPE has promised support for HP-UX 11.23
   (aka HP-UX 11i v2) only through the end of 2022; see Table 2 of
   <https://h20195.www2.hpe.com/V2/getpdf.aspx/4AA4-7673ENW.pdf>.  */
#ifdef __hpux
# undef UINT_LEAST8_MAX
# undef UINT_LEAST16_MAX
# define UINT_LEAST8_MAX 255
# define UINT_LEAST16_MAX 65535
#endif

#if defined __UINT_LEAST8_MAX__ && __UINT_LEAST8_MAX__ <= __INT_MAX__
typedef __UINT_LEAST8_TYPE__ yytype_uint8;
#elif (!defined __UINT_LEAST8_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST8_MAX <= INT_MAX)
typedef uint_least8_t yytype_uint8;
#elif !defined __UINT_LEAST8_MAX__ && UCHAR_MAX <= INT_MAX
typedef unsigned char yytype_uint8;
#else
typedef short yytype_uint8;
#endif

#if defined __UINT_LEAST16_MAX__ && __UINT_LEAST16_MAX__ <= __INT_MAX__
typedef __UINT_LEAST16_TYPE__ yytype_uint16;
#elif (!defined __UINT_LEAST16_MAX__ && defined YY_STDINT_H \
       && UINT_LEAST16_MAX <= INT_MAX)
typedef uint_least16_t yytype_uint16;
#elif !defined __UINT_LEAST16_MAX__ && USHRT_MAX <= INT_MAX
typedef unsigned short yytype_uint16;
#else
typedef int yytype_uint16;
#endif

#ifndef YYPTRDIFF_T
# if defined __PTRDIFF_TYPE__ && defined __PTRDIFF_MAX__
#  define YYPTRDIFF_T __PTRDIFF_TYPE__
#  define YYPTRDIFF_MAXIMUM __PTRDIFF_MAX__
# elif defined PTRDIFF_MAX
#  ifndef ptrdiff_t
#   include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  endif
#  define YYPTRDIFF_T ptrdiff_t
#  define YYPTRDIFF_MAXIMUM PTRDIFF_MAX
# else
#  define YYPTRDIFF_T long
#  define YYPTRDIFF_MAXIMUM LONG_MAX
# endif
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif defined __STDC_VERSION__ && 199901 <= __STDC_VERSION__
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned
# endif
#endif

#define YYSIZE_MAXIMUM                                  \
  YY_CAST (YYPTRDIFF_T,                                 \
           (YYPTRDIFF_MAXIMUM < YY_CAST (YYSIZE_T, -1)  \
            ? YYPTRDIFF_MAXIMUM                         \
            : YY_CAST (YYSIZE_T, -1)))

#define YYSIZEOF(X) YY_CAST (YYPTRDIFF_T, sizeof (X))


/* Stored state numbers (used for stacks). */
typedef yytype_int8 yy_state_t;

/* State numbers in computations.  */
typedef int yy_state_fast_t;

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif


#ifndef YY_ATTRIBUTE_PURE
# if defined __GNUC__ && 2 < __GNUC__ + (96 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_PURE __attribute__ ((__pure__))
# else
#  define YY_ATTRIBUTE_PURE
# endif
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# if defined __GNUC__ && 2 < __GNUC__ + (7 <= __GNUC_MINOR__)
#  define YY_ATTRIBUTE_UNUSED __attribute__ ((__unused__))
# else
#  define YY_ATTRIBUTE_UNUSED
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YY_USE(E) ((void) (E))
#else
# define YY_USE(E) /* empty */
#endif

#if defined __GNUC__ && ! defined __ICC && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN                            \
    _Pragma ("GCC diagnostic push")                                     \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")              \
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END      \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif

#if defined __cplusplus && defined __GNUC__ && ! defined __ICC && 6 <= __GNUC__
# define YY_IGNORE_USELESS_CAST_BEGIN                          \
    _Pragma ("GCC diagnostic push")                            \
    _Pragma ("GCC diagnostic ignored \"-Wuseless-cast\"")
# define YY_IGNORE_USELESS_CAST_END            \
    _Pragma ("GCC diagnostic pop")
#endif
#ifndef YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_BEGIN
# define YY_IGNORE_USELESS_CAST_END
#endif


#define YY_ASSERT(E) ((void) (0 && (E)))

#if !defined yyoverflow

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* !defined yyoverflow */

#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yy_state_t yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (YYSIZEOF (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (YYSIZEOF (yy_state_t) + YYSIZEOF (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYPTRDIFF_T yynewbytes;                                         \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * YYSIZEOF (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / YYSIZEOF (*yyptr);                        \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, YY_CAST (YYSIZE_T, (Count)) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYPTRDIFF_T yyi;                      \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  2
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   32

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  17
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  9
/* YYNRULES -- Number of rules.  */
#define YYNRULES  17
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  39

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   263


/* YYTRANSLATE(TOKEN-NUM) -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, with out-of-bounds checking.  */
#define YYTRANSLATE(YYX)                                \
  (0 <= (YYX) && (YYX) <= YYMAXUTOK                     \
   ? YY_CAST (yysymbol_kind_t, yytranslate[YYX])        \
   : YYSYMBOL_YYUNDEF)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex.  */
static const yytype_int8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     9,     2,     2,
       2,     2,     2,     2,    12,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,    13,     2,
       2,    14,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,    15,     2,    16,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,    10,     2,    11,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   361,   361,   363,   364,   369,   374,   375,   380,   381,
     385,   386,   390,   391,   396,   397,   401,   402
};
#endif

/** Accessing symbol of state STATE.  */
#define YY_ACCESSING_SYMBOL(State) YY_CAST (yysymbol_kind_t, yystos[State])

#if YYDEBUG || 0
/* The user-facing name of the symbol whose (internal) number is
   YYSYMBOL.  No bounds checking.  */
static const char *yysymbol_name (yysymbol_kind_t yysymbol) YY_ATTRIBUTE_UNUSED;

/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "\"end of file\"", "error", "\"invalid token\"", "name", "val", "vals",
  "hexbyte", "binblob", "eof", "'%'", "'{'", "'}'", "','", "':'", "'='",
  "'['", "']'", "$accept", "input", "blob", "spec", "specmembers",
  "specpair", "setter", "valuemembers", "setpair", YY_NULLPTR
};

static const char *
yysymbol_name (yysymbol_kind_t yysymbol)
{
  return yytname[yysymbol];
}
#endif

#ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_int16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,    37,
     123,   125,    44,    58,    61,    91,    93
};
#endif

#define YYPACT_NINF (-11)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-1)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
     -11,     0,   -11,    -2,    -3,   -10,   -11,    -9,    -4,     3,
       1,   -11,     7,    12,    13,   -11,    15,   -11,    -1,   -11,
       8,     9,   -11,   -11,     4,   -11,    18,    19,   -11,    21,
      14,   -11,    10,   -11,    24,    11,   -11,    25,   -11
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       2,     0,     1,     0,     0,     0,     6,     0,     8,     0,
       0,     4,     0,     0,     0,     7,     0,     5,     0,    12,
       0,    14,     3,    10,     0,     9,     0,     0,    13,     0,
       0,    16,     0,    15,     0,     0,    11,     0,    17
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -11,   -11,   -11,   -11,    16,   -11,   -11,     2,   -11
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
       0,     1,    11,     4,     7,     8,    12,    20,    21
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
       2,     5,    15,    13,    18,    14,     9,    10,    16,     6,
       3,    17,    19,    26,    27,    22,    23,    24,     5,    28,
      30,    29,    31,    32,    18,    37,    35,    34,    36,    38,
       0,    33,    25
};

static const yytype_int8 yycheck[] =
{
       0,     3,    11,    13,     3,    15,     9,    10,    12,    11,
      10,     8,    11,    14,    15,     8,     4,     4,     3,    11,
      16,    12,     4,     4,     3,    14,    16,    13,     4,     4,
      -1,    29,    16
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    18,     0,    10,    20,     3,    11,    21,    22,     9,
      10,    19,    23,    13,    15,    11,    12,     8,     3,    11,
      24,    25,     8,     4,     4,    21,    14,    15,    11,    12,
      16,     4,     4,    24,    13,    16,     4,    14,     4
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    17,    18,    18,    18,    19,    20,    20,    21,    21,
      22,    22,    23,    23,    24,    24,    25,    25
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     4,     3,     2,     2,     3,     1,     3,
       3,     6,     2,     3,     1,     3,     3,     6
};


enum { YYENOMEM = -2 };

#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                    \
  do                                                              \
    if (yychar == YYEMPTY)                                        \
      {                                                           \
        yychar = (Token);                                         \
        yylval = (Value);                                         \
        YYPOPSTACK (yylen);                                       \
        yystate = *yyssp;                                         \
        goto yybackup;                                            \
      }                                                           \
    else                                                          \
      {                                                           \
        yyerror (fp, YY_("syntax error: cannot back up")); \
        YYERROR;                                                  \
      }                                                           \
  while (0)

/* Backward compatibility with an undocumented macro.
   Use YYerror or YYUNDEF. */
#define YYERRCODE YYUNDEF


/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
# ifndef YY_LOCATION_PRINT
#  define YY_LOCATION_PRINT(File, Loc) ((void) 0)
# endif


# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Kind, Value, fp); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep, FILE* fp)
{
  FILE *yyoutput = yyo;
  YY_USE (yyoutput);
  YY_USE (fp);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yykind < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yykind], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep, FILE* fp)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep, fp);
  YYFPRINTF (yyo, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yy_state_t *yybottom, yy_state_t *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yy_state_t *yyssp, YYSTYPE *yyvsp,
                 int yyrule, FILE* fp)
{
  int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %d):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       YY_ACCESSING_SYMBOL (+yyssp[yyi + 1 - yynrhs]),
                       &yyvsp[(yyi + 1) - (yynrhs)], fp);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule, fp); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args) ((void) 0)
# define YY_SYMBOL_PRINT(Title, Kind, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif






/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg,
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep, FILE* fp)
{
  YY_USE (yyvaluep);
  YY_USE (fp);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YY_USE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/* Lookahead token kind.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;




/*----------.
| yyparse.  |
`----------*/

int
yyparse (FILE* fp)
{
    yy_state_fast_t yystate = 0;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus = 0;

    /* Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* Their size.  */
    YYPTRDIFF_T yystacksize = YYINITDEPTH;

    /* The state stack: array, bottom, top.  */
    yy_state_t yyssa[YYINITDEPTH];
    yy_state_t *yyss = yyssa;
    yy_state_t *yyssp = yyss;

    /* The semantic value stack: array, bottom, top.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs = yyvsa;
    YYSTYPE *yyvsp = yyvs;

  int yyn;
  /* The return value of yyparse.  */
  int yyresult;
  /* Lookahead symbol kind.  */
  yysymbol_kind_t yytoken = YYSYMBOL_YYEMPTY;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;



#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;


/*------------------------------------------------------------.
| yynewstate -- push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;


/*--------------------------------------------------------------------.
| yysetstate -- set current state (the top of the stack) to yystate.  |
`--------------------------------------------------------------------*/
yysetstate:
  YYDPRINTF ((stderr, "Entering state %d\n", yystate));
  YY_ASSERT (0 <= yystate && yystate < YYNSTATES);
  YY_IGNORE_USELESS_CAST_BEGIN
  *yyssp = YY_CAST (yy_state_t, yystate);
  YY_IGNORE_USELESS_CAST_END
  YY_STACK_PRINT (yyss, yyssp);

  if (yyss + yystacksize - 1 <= yyssp)
#if !defined yyoverflow && !defined YYSTACK_RELOCATE
    goto yyexhaustedlab;
#else
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYPTRDIFF_T yysize = yyssp - yyss + 1;

# if defined yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        yy_state_t *yyss1 = yyss;
        YYSTYPE *yyvs1 = yyvs;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * YYSIZEOF (*yyssp),
                    &yyvs1, yysize * YYSIZEOF (*yyvsp),
                    &yystacksize);
        yyss = yyss1;
        yyvs = yyvs1;
      }
# else /* defined YYSTACK_RELOCATE */
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yy_state_t *yyss1 = yyss;
        union yyalloc *yyptr =
          YY_CAST (union yyalloc *,
                   YYSTACK_ALLOC (YY_CAST (YYSIZE_T, YYSTACK_BYTES (yystacksize))));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YY_IGNORE_USELESS_CAST_BEGIN
      YYDPRINTF ((stderr, "Stack size increased to %ld\n",
                  YY_CAST (long, yystacksize)));
      YY_IGNORE_USELESS_CAST_END

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }
#endif /* !defined yyoverflow && !defined YYSTACK_RELOCATE */

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;


/*-----------.
| yybackup.  |
`-----------*/
yybackup:
  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either empty, or end-of-input, or a valid lookahead.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token\n"));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = YYEOF;
      yytoken = YYSYMBOL_YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else if (yychar == YYerror)
    {
      /* The scanner already issued an error message, process directly
         to error recovery.  But do not keep the error token as
         lookahead, it is too special and may lead us to an endless
         loop in error recovery. */
      yychar = YYUNDEF;
      yytoken = YYSYMBOL_YYerror;
      goto yyerrlab1;
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);
  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  /* Discard the shifted token.  */
  yychar = YYEMPTY;
  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
  case 3: /* input: input spec setter eof  */
#line 363 "bincfg.y"
                                { empty_field_table(); YYACCEPT;}
#line 1432 "bincfg.tab.c"
    break;

  case 4: /* input: input spec blob  */
#line 364 "bincfg.y"
                                { fprintf (stderr, "Parsed all bytes\n");
				  empty_field_table(); YYACCEPT;}
#line 1439 "bincfg.tab.c"
    break;

  case 5: /* blob: '%' eof  */
#line 369 "bincfg.y"
                                { generate_setter_bitfields(fp,
				  binary->actualblob); }
#line 1446 "bincfg.tab.c"
    break;

  case 6: /* spec: '{' '}'  */
#line 374 "bincfg.y"
                        {	fprintf (stderr, "No spec\n"); }
#line 1452 "bincfg.tab.c"
    break;

  case 7: /* spec: '{' specmembers '}'  */
#line 375 "bincfg.y"
                        {	fprintf (stderr, "Parsed all spec\n");
				create_binary_blob(); }
#line 1459 "bincfg.tab.c"
    break;

  case 10: /* specpair: name ':' val  */
#line 385 "bincfg.y"
                        {	create_new_bitfield((yyvsp[-2].str), (yyvsp[0].u32)); }
#line 1465 "bincfg.tab.c"
    break;

  case 11: /* specpair: name '[' val ']' ':' val  */
#line 386 "bincfg.y"
                                { create_new_bitfields((yyvsp[-5].str), (yyvsp[-3].u32), (yyvsp[0].u32)); }
#line 1471 "bincfg.tab.c"
    break;

  case 12: /* setter: '{' '}'  */
#line 390 "bincfg.y"
                        {	fprintf (stderr, "No values\n"); }
#line 1477 "bincfg.tab.c"
    break;

  case 13: /* setter: '{' valuemembers '}'  */
#line 391 "bincfg.y"
                        {	fprintf (stderr, "Parsed all values\n");
				generate_binary(fp); }
#line 1484 "bincfg.tab.c"
    break;

  case 16: /* setpair: name '=' val  */
#line 401 "bincfg.y"
                        {	set_bitfield((yyvsp[-2].str), (yyvsp[0].u32)); }
#line 1490 "bincfg.tab.c"
    break;

  case 17: /* setpair: name '[' val ']' '=' val  */
#line 402 "bincfg.y"
                                { set_bitfield_array((yyvsp[-5].str), (yyvsp[-3].u32), (yyvsp[0].u32)); }
#line 1496 "bincfg.tab.c"
    break;


#line 1500 "bincfg.tab.c"

      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", YY_CAST (yysymbol_kind_t, yyr1[yyn]), &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */
  {
    const int yylhs = yyr1[yyn] - YYNTOKENS;
    const int yyi = yypgoto[yylhs] + *yyssp;
    yystate = (0 <= yyi && yyi <= YYLAST && yycheck[yyi] == *yyssp
               ? yytable[yyi]
               : yydefgoto[yylhs]);
  }

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYSYMBOL_YYEMPTY : YYTRANSLATE (yychar);
  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
      yyerror (fp, YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, fp);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:
  /* Pacify compilers when the user code never invokes YYERROR and the
     label yyerrorlab therefore never appears in user code.  */
  if (0)
    YYERROR;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  /* Pop stack until we find a state that shifts the error token.  */
  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYSYMBOL_YYerror;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYSYMBOL_YYerror)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  YY_ACCESSING_SYMBOL (yystate), yyvsp, fp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", YY_ACCESSING_SYMBOL (yyn), yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;


/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;


#if !defined yyoverflow
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (fp, YY_("memory exhausted"));
  yyresult = 2;
  goto yyreturn;
#endif


/*-------------------------------------------------------.
| yyreturn -- parsing is finished, clean up and return.  |
`-------------------------------------------------------*/
yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval, fp);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp, fp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

#line 405 "bincfg.y"


/* Called by yyparse on error.  */
static void yyerror (FILE* fp, char const *s)
{
	(void)fp;
	fprintf (stderr, "yyerror: %s\n", s);
}

/* Declarations */
void set_input_string(char* in);

/* This function parses a string */
static int parse_string(FILE* fp, unsigned char* in) {
	set_input_string ((char *)in);
	return yyparse (fp);
}

static unsigned int loadfile (FILE* fp, char *file, char *filetype,
	unsigned char **parsestring, unsigned int lenstr)
{
	unsigned int lenfile;

	if ((fp = fopen(file, "r")) == NULL) {
		printf("Error: Could not open %s file: %s\n",filetype,file);
		exit(1);
	}
	fseek(fp, 0, SEEK_END);
	lenfile = ftell(fp);
	fseek(fp, 0, SEEK_SET);

	if (lenstr == 0)
		*parsestring = (unsigned char *) malloc (lenfile + 2);
	else
		*parsestring = (unsigned char *) realloc (*parsestring,
						lenfile + lenstr);

	check_pointer(*parsestring);
	fread(*parsestring + lenstr, 1, lenfile, fp);
	fclose(fp);
	return lenfile;
}

int main (int argc, char *argv[])
{
	unsigned int lenspec;
	unsigned char *parsestring;
	int ret = 0;
	FILE* fp;

#if YYDEBUG == 1
	yydebug = 1;
#endif
	create_binary_blob();
	binary->lenactualblob = 0;

	if (argc == 4 && strcmp(argv[1], "-d") != 0) {
		/* Compile mode */

		/* Load Spec */
		lenspec = loadfile(fp, argv[1], "spec", &parsestring, 0);
		loadfile(fp, argv[2], "setter", &parsestring, lenspec);

		/* Open output and parse string - output to fp */
		if ((fp = fopen(argv[3], "wb")) == NULL) {
			printf("Error: Could not open output file: %s\n",
			       argv[3]);
			exit(1);
		}
		ret = parse_string(fp, parsestring);
		free(parsestring);
	} else if (argc == 5 && strcmp (argv[1], "-d") == 0) {
		/* Decompile mode */

		/* Load Spec */
		lenspec = loadfile(fp, argv[2], "spec", &parsestring, 0);

		parsestring[lenspec] = '%';
		parsestring[lenspec + 1] = '\0';

		/* Load Actual Binary */
		if ((fp = fopen(argv[3], "rb")) == NULL) {
			printf("Error: Could not open binary file: %s\n",
			       argv[3]);
			exit(1);
		}
		fseek(fp, 0, SEEK_END);
		binary->lenactualblob = ftell(fp);
		fseek(fp, 0, SEEK_SET);
		binary->actualblob = (unsigned char *)malloc(
			binary->lenactualblob);
		check_pointer(binary->actualblob);
		fread(binary->actualblob, 1, binary->lenactualblob, fp);
		fclose(fp);

		/* Open output and parse - output to fp */
		if ((fp = fopen(argv[4], "w")) == NULL) {
			printf("Error: Could not open output file: %s\n",
			       argv[4]);
			exit(1);
		}
		ret = parse_string(fp, parsestring);
		free(parsestring);
		free(binary->actualblob);
		fclose(fp);
	} else {
		printf("Usage: Compile mode\n\n");
		printf("       bincfg    spec  setter  binaryoutput\n");
		printf("                  (file) (file)     (file)\n");
		printf(" OR  : Decompile mode\n\n");
		printf("       bincfg -d spec  binary  setteroutput\n");
	}
	return ret;
}
