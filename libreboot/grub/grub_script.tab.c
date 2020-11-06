/* A Bison parser, made by GNU Bison 3.7.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
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
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

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

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.7.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 1

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1


/* Substitute the variable and function names.  */
#define yyparse         grub_script_yyparse
#define yylex           grub_script_yylex
#define yyerror         grub_script_yyerror
#define yydebug         grub_script_yydebug
#define yynerrs         grub_script_yynerrs

/* First part of user prologue.  */
#line 20 "./grub-core/script/parser.y"

#include <grub/script_sh.h>
#include <grub/mm.h>
#include <grub/misc.h>
#include <grub/i18n.h>

#define YYFREE          grub_free
#define YYMALLOC        grub_malloc
#define YYLTYPE_IS_TRIVIAL      0
#define YYENABLE_NLS    0

#include "grub_script.tab.h"

#pragma GCC diagnostic ignored "-Wmissing-declarations"


#line 93 "grub_script.tab.c"

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

#include "grub_script.tab.h"
/* Symbol kind.  */
enum yysymbol_kind_t
{
  YYSYMBOL_YYEMPTY = -2,
  YYSYMBOL_YYEOF = 0,                      /* "end-of-input"  */
  YYSYMBOL_YYerror = 1,                    /* error  */
  YYSYMBOL_YYUNDEF = 2,                    /* "invalid token"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_BAD = 3,      /* GRUB_PARSER_TOKEN_BAD  */
  YYSYMBOL_GRUB_PARSER_TOKEN_NEWLINE = 4,  /* "\n"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_AND = 5,      /* "&&"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_OR = 6,       /* "||"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_SEMI2 = 7,    /* ";;"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_PIPE = 8,     /* "|"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_AMP = 9,      /* "&"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_SEMI = 10,    /* ";"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_LBR = 11,     /* "{"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_RBR = 12,     /* "}"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_NOT = 13,     /* "!"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_LSQBR2 = 14,  /* "["  */
  YYSYMBOL_GRUB_PARSER_TOKEN_RSQBR2 = 15,  /* "]"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_LT = 16,      /* "<"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_GT = 17,      /* ">"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_CASE = 18,    /* "case"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_DO = 19,      /* "do"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_DONE = 20,    /* "done"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_ELIF = 21,    /* "elif"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_ELSE = 22,    /* "else"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_ESAC = 23,    /* "esac"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_FI = 24,      /* "fi"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_FOR = 25,     /* "for"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_IF = 26,      /* "if"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_IN = 27,      /* "in"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_SELECT = 28,  /* "select"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_THEN = 29,    /* "then"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_UNTIL = 30,   /* "until"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_WHILE = 31,   /* "while"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_FUNCTION = 32, /* "function"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_NAME = 33,    /* "name"  */
  YYSYMBOL_GRUB_PARSER_TOKEN_WORD = 34,    /* "word"  */
  YYSYMBOL_YYACCEPT = 35,                  /* $accept  */
  YYSYMBOL_script_init = 36,               /* script_init  */
  YYSYMBOL_37_1 = 37,                      /* $@1  */
  YYSYMBOL_script = 38,                    /* script  */
  YYSYMBOL_newlines0 = 39,                 /* newlines0  */
  YYSYMBOL_newlines1 = 40,                 /* newlines1  */
  YYSYMBOL_delimiter = 41,                 /* delimiter  */
  YYSYMBOL_delimiters0 = 42,               /* delimiters0  */
  YYSYMBOL_delimiters1 = 43,               /* delimiters1  */
  YYSYMBOL_word = 44,                      /* word  */
  YYSYMBOL_statement = 45,                 /* statement  */
  YYSYMBOL_argument = 46,                  /* argument  */
  YYSYMBOL_block = 47,                     /* block  */
  YYSYMBOL_48_2 = 48,                      /* @2  */
  YYSYMBOL_block0 = 49,                    /* block0  */
  YYSYMBOL_arguments0 = 50,                /* arguments0  */
  YYSYMBOL_arguments1 = 51,                /* arguments1  */
  YYSYMBOL_grubcmd = 52,                   /* grubcmd  */
  YYSYMBOL_command = 53,                   /* command  */
  YYSYMBOL_commands1 = 54,                 /* commands1  */
  YYSYMBOL_function = 55,                  /* function  */
  YYSYMBOL_56_3 = 56,                      /* @3  */
  YYSYMBOL_ifcmd = 57,                     /* ifcmd  */
  YYSYMBOL_58_4 = 58,                      /* $@4  */
  YYSYMBOL_ifclause = 59,                  /* ifclause  */
  YYSYMBOL_forcmd = 60,                    /* forcmd  */
  YYSYMBOL_61_5 = 61,                      /* $@5  */
  YYSYMBOL_whilecmd = 62,                  /* whilecmd  */
  YYSYMBOL_63_6 = 63,                      /* $@6  */
  YYSYMBOL_untilcmd = 64,                  /* untilcmd  */
  YYSYMBOL_65_7 = 65                       /* $@7  */
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
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
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
#define YYFINAL  3
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   216

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  35
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  31
/* YYNRULES -- Number of rules.  */
#define YYNRULES  63
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  105

/* YYMAXUTOK -- Last valid token kind.  */
#define YYMAXUTOK   289


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
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_int16 yyrline[] =
{
       0,   100,   100,   100,   103,   107,   111,   119,   119,   120,
     122,   123,   125,   125,   126,   127,   130,   131,   134,   135,
     138,   139,   140,   141,   142,   143,   144,   145,   146,   147,
     148,   149,   150,   151,   152,   153,   181,   180,   220,   221,
     224,   225,   227,   239,   256,   257,   258,   259,   260,   264,
     268,   275,   274,   302,   301,   311,   315,   319,   326,   325,
     337,   336,   348,   347
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
  "\"end-of-input\"", "error", "\"invalid token\"",
  "GRUB_PARSER_TOKEN_BAD", "\"\\n\"", "\"&&\"", "\"||\"", "\";;\"",
  "\"|\"", "\"&\"", "\";\"", "\"{\"", "\"}\"", "\"!\"", "\"[\"", "\"]\"",
  "\"<\"", "\">\"", "\"case\"", "\"do\"", "\"done\"", "\"elif\"",
  "\"else\"", "\"esac\"", "\"fi\"", "\"for\"", "\"if\"", "\"in\"",
  "\"select\"", "\"then\"", "\"until\"", "\"while\"", "\"function\"",
  "\"name\"", "\"word\"", "$accept", "script_init", "$@1", "script",
  "newlines0", "newlines1", "delimiter", "delimiters0", "delimiters1",
  "word", "statement", "argument", "block", "@2", "block0", "arguments0",
  "arguments1", "grubcmd", "command", "commands1", "function", "@3",
  "ifcmd", "$@4", "ifclause", "forcmd", "$@5", "whilecmd", "$@6",
  "untilcmd", "$@7", YY_NULLPTR
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
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289
};
#endif

#define YYPACT_NINF (-73)

#define yypact_value_is_default(Yyn) \
  ((Yyn) == YYPACT_NINF)

#define YYTABLE_NINF (-8)

#define yytable_value_is_error(Yyn) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int16 yypact[] =
{
     -73,     7,    42,   -73,   -73,   182,     9,   -73,   -19,   -73,
     -73,   -73,   -15,   -73,   -73,   172,     6,   -73,   -73,   -73,
     -73,   -73,   -73,   -73,   -73,   -73,   -73,   -73,   -73,   -73,
     -73,   -73,   -73,   -73,   -73,   -73,   -73,   -73,   -73,   -73,
     -73,   -73,   -73,   -73,   -73,   -73,   172,    -5,   -73,   -73,
     -73,   -73,    -8,   145,     6,    10,     6,     6,   -73,   -73,
     -73,   -73,   -73,     9,   172,   -73,   -73,    54,   -73,    67,
      77,    11,   -73,     6,   -73,   -73,   -73,   -73,   -73,   -73,
       6,    -2,     6,     6,     6,     6,    14,   155,   -73,    -1,
      95,   110,   120,   -73,     6,   -73,   -73,   -73,   -73,   -73,
     135,   -73,     6,   -73,   155
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_int8 yydefact[] =
{
       2,     0,     0,     1,     6,     3,     4,     8,     0,    53,
      62,    60,     0,    16,    17,    40,     0,    44,    18,    19,
      45,    46,    47,    48,     9,    58,     7,     7,     7,    51,
      20,    21,    22,    23,    24,    25,    26,    27,    28,    29,
      30,    31,    32,    33,    34,    35,    40,    38,    41,    11,
      10,     7,     0,     0,     0,     0,     0,     0,     7,    42,
      36,    39,    43,     5,    40,    49,    14,     0,    54,     0,
       0,     0,     7,     0,    15,     7,    50,     7,     7,     7,
      12,     0,     0,     0,     0,     0,     0,    13,     7,    55,
       0,     0,     0,    37,     0,     7,     7,    63,    61,    52,
       0,    57,     0,    59,    56
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -73,   -73,   -73,   -73,     2,   -73,    15,   -73,   -45,   -10,
     -73,   -73,   -73,   -73,   -73,   -37,   -73,   -73,     3,   -27,
     -73,   -73,   -73,   -73,   -72,   -73,   -73,   -73,   -73,   -73,
     -73
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int8 yydefgoto[] =
{
      -1,     1,     2,     5,    53,     7,    66,    86,    67,    15,
      16,    46,    61,    72,    62,    47,    48,    17,    76,    54,
      19,    58,    20,    26,    55,    21,    52,    22,    28,    23,
      27
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_int8 yytable[] =
{
      56,    57,    74,    74,     6,    45,    60,     3,    18,    59,
      49,    69,    70,    24,    25,    24,    50,    88,    29,    64,
      95,    96,    79,   101,     8,     9,    93,    73,    81,    10,
      11,    51,    13,    14,    68,    87,    45,    89,    90,    91,
      92,     0,    -7,     4,     0,    80,    -7,     0,    82,   100,
      83,    84,    85,    63,    45,     0,    65,   104,    74,     0,
      71,    94,     0,     0,     0,     0,     0,    -7,    -7,   102,
       0,    74,    -7,    -7,    -7,    -7,    -7,     0,     0,     8,
       9,    74,     0,    75,    10,    11,    77,    13,    14,     0,
       0,     0,     8,     9,     0,     0,    78,    10,    11,    74,
      13,    14,     8,     9,     0,     0,     0,    10,    11,     0,
      13,    14,     0,     0,    74,    97,     0,     0,     0,     0,
       8,     9,     0,     0,    74,    10,    11,     0,    13,    14,
      98,     0,    99,     0,     0,     8,     9,     0,     0,    74,
      10,    11,     0,    13,    14,     8,     9,     0,     0,    24,
      10,    11,     0,    13,    14,   103,     0,     0,     0,    74,
       8,     9,     0,     0,     0,    10,    11,     0,    13,    14,
       8,     9,     0,     0,     0,    10,    11,     0,    13,    14,
       8,     9,     0,     0,     0,    10,    11,     0,    13,    14,
      30,    31,    32,    33,    34,    35,    36,    37,    38,    39,
      40,    41,    42,    43,    44,    13,    14,     8,     9,     0,
       0,     0,    10,    11,    12,    13,    14
};

static const yytype_int8 yycheck[] =
{
      27,    28,     4,     4,     2,    15,    11,     0,     5,    46,
       4,    56,    57,     4,    33,     4,    10,    19,    33,    27,
      21,    22,    11,    95,    25,    26,    12,    64,    73,    30,
      31,    16,    33,    34,    24,    80,    46,    82,    83,    84,
      85,    -1,     0,     1,    -1,    72,     4,    -1,    75,    94,
      77,    78,    79,    51,    64,    -1,    53,   102,     4,    -1,
      58,    88,    -1,    -1,    -1,    -1,    -1,    25,    26,    96,
      -1,     4,    30,    31,    32,    33,    34,    -1,    -1,    25,
      26,     4,    -1,    29,    30,    31,    19,    33,    34,    -1,
      -1,    -1,    25,    26,    -1,    -1,    19,    30,    31,     4,
      33,    34,    25,    26,    -1,    -1,    -1,    30,    31,    -1,
      33,    34,    -1,    -1,     4,    20,    -1,    -1,    -1,    -1,
      25,    26,    -1,    -1,     4,    30,    31,    -1,    33,    34,
      20,    -1,    12,    -1,    -1,    25,    26,    -1,    -1,     4,
      30,    31,    -1,    33,    34,    25,    26,    -1,    -1,     4,
      30,    31,    -1,    33,    34,    20,    -1,    -1,    -1,     4,
      25,    26,    -1,    -1,    -1,    30,    31,    -1,    33,    34,
      25,    26,    -1,    -1,    -1,    30,    31,    -1,    33,    34,
      25,    26,    -1,    -1,    -1,    30,    31,    -1,    33,    34,
      18,    19,    20,    21,    22,    23,    24,    25,    26,    27,
      28,    29,    30,    31,    32,    33,    34,    25,    26,    -1,
      -1,    -1,    30,    31,    32,    33,    34
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_int8 yystos[] =
{
       0,    36,    37,     0,     1,    38,    39,    40,    25,    26,
      30,    31,    32,    33,    34,    44,    45,    52,    53,    55,
      57,    60,    62,    64,     4,    33,    58,    65,    63,    33,
      18,    19,    20,    21,    22,    23,    24,    25,    26,    27,
      28,    29,    30,    31,    32,    44,    46,    50,    51,     4,
      10,    41,    61,    39,    54,    59,    54,    54,    56,    50,
      11,    47,    49,    39,    27,    53,    41,    43,    24,    43,
      43,    39,    48,    50,     4,    29,    53,    19,    19,    11,
      54,    43,    54,    54,    54,    54,    42,    43,    19,    43,
      43,    43,    43,    12,    54,    21,    22,    20,    20,    12,
      43,    59,    54,    20,    43
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_int8 yyr1[] =
{
       0,    35,    37,    36,    38,    38,    38,    39,    39,    40,
      41,    41,    42,    42,    43,    43,    44,    44,    45,    45,
      46,    46,    46,    46,    46,    46,    46,    46,    46,    46,
      46,    46,    46,    46,    46,    46,    48,    47,    49,    49,
      50,    50,    51,    52,    53,    53,    53,    53,    53,    54,
      54,    56,    55,    58,    57,    59,    59,    59,    61,    60,
      63,    62,    65,    64
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_int8 yyr2[] =
{
       0,     2,     0,     2,     1,     4,     1,     0,     1,     2,
       1,     1,     0,     1,     1,     2,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     1,     1,     1,     1,
       1,     1,     1,     1,     1,     1,     0,     5,     0,     1,
       0,     1,     2,     3,     1,     1,     1,     1,     1,     2,
       3,     0,     8,     0,     4,     5,     8,     7,     0,    10,
       0,     8,     0,     8
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
        yyerror (state, YY_("syntax error: cannot back up")); \
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
                  Kind, Value, state); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*-----------------------------------.
| Print this symbol's value on YYO.  |
`-----------------------------------*/

static void
yy_symbol_value_print (FILE *yyo,
                       yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep, struct grub_parser_param *state)
{
  FILE *yyoutput = yyo;
  YYUSE (yyoutput);
  YYUSE (state);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yykind < YYNTOKENS)
    YYPRINT (yyo, yytoknum[yykind], *yyvaluep);
# endif
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}


/*---------------------------.
| Print this symbol on YYO.  |
`---------------------------*/

static void
yy_symbol_print (FILE *yyo,
                 yysymbol_kind_t yykind, YYSTYPE const * const yyvaluep, struct grub_parser_param *state)
{
  YYFPRINTF (yyo, "%s %s (",
             yykind < YYNTOKENS ? "token" : "nterm", yysymbol_name (yykind));

  yy_symbol_value_print (yyo, yykind, yyvaluep, state);
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
                 int yyrule, struct grub_parser_param *state)
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
                       &yyvsp[(yyi + 1) - (yynrhs)], state);
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule, state); \
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
            yysymbol_kind_t yykind, YYSTYPE *yyvaluep, struct grub_parser_param *state)
{
  YYUSE (yyvaluep);
  YYUSE (state);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yykind, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yykind);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}






/*----------.
| yyparse.  |
`----------*/

int
yyparse (struct grub_parser_param *state)
{
/* Lookahead token kind.  */
int yychar;


/* The semantic value of the lookahead symbol.  */
/* Default value used for initialization, for pacifying older GCCs
   or non-GCC compilers.  */
YY_INITIAL_VALUE (static YYSTYPE yyval_default;)
YYSTYPE yylval YY_INITIAL_VALUE (= yyval_default);

    /* Number of syntax errors so far.  */
    int yynerrs = 0;

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
      yychar = yylex (&yylval, state);
    }

  if (yychar <= GRUB_PARSER_TOKEN_EOF)
    {
      yychar = GRUB_PARSER_TOKEN_EOF;
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
  case 2: /* $@1: %empty  */
#line 100 "./grub-core/script/parser.y"
             { state->err = 0; }
#line 1246 "grub_script.tab.c"
    break;

  case 3: /* script_init: $@1 script  */
#line 100 "./grub-core/script/parser.y"
                                        { state->parsed = (yyvsp[0].cmd); state->err = 0; }
#line 1252 "grub_script.tab.c"
    break;

  case 4: /* script: newlines0  */
#line 104 "./grub-core/script/parser.y"
        {
          (yyval.cmd) = 0;
        }
#line 1260 "grub_script.tab.c"
    break;

  case 5: /* script: script statement delimiter newlines0  */
#line 108 "./grub-core/script/parser.y"
        {
          (yyval.cmd) = grub_script_append_cmd (state, (yyvsp[-3].cmd), (yyvsp[-2].cmd));
        }
#line 1268 "grub_script.tab.c"
    break;

  case 6: /* script: error  */
#line 112 "./grub-core/script/parser.y"
        {
          (yyval.cmd) = 0;
          yyerror (state, N_("Incorrect command"));
          yyerrok;
        }
#line 1278 "grub_script.tab.c"
    break;

  case 16: /* word: "name"  */
#line 130 "./grub-core/script/parser.y"
                             { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1284 "grub_script.tab.c"
    break;

  case 17: /* word: "word"  */
#line 131 "./grub-core/script/parser.y"
                             { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1290 "grub_script.tab.c"
    break;

  case 18: /* statement: command  */
#line 134 "./grub-core/script/parser.y"
                     { (yyval.cmd) = (yyvsp[0].cmd); }
#line 1296 "grub_script.tab.c"
    break;

  case 19: /* statement: function  */
#line 135 "./grub-core/script/parser.y"
                     { (yyval.cmd) = 0;  }
#line 1302 "grub_script.tab.c"
    break;

  case 20: /* argument: "case"  */
#line 138 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1308 "grub_script.tab.c"
    break;

  case 21: /* argument: "do"  */
#line 139 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1314 "grub_script.tab.c"
    break;

  case 22: /* argument: "done"  */
#line 140 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1320 "grub_script.tab.c"
    break;

  case 23: /* argument: "elif"  */
#line 141 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1326 "grub_script.tab.c"
    break;

  case 24: /* argument: "else"  */
#line 142 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1332 "grub_script.tab.c"
    break;

  case 25: /* argument: "esac"  */
#line 143 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1338 "grub_script.tab.c"
    break;

  case 26: /* argument: "fi"  */
#line 144 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1344 "grub_script.tab.c"
    break;

  case 27: /* argument: "for"  */
#line 145 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1350 "grub_script.tab.c"
    break;

  case 28: /* argument: "if"  */
#line 146 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1356 "grub_script.tab.c"
    break;

  case 29: /* argument: "in"  */
#line 147 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1362 "grub_script.tab.c"
    break;

  case 30: /* argument: "select"  */
#line 148 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1368 "grub_script.tab.c"
    break;

  case 31: /* argument: "then"  */
#line 149 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1374 "grub_script.tab.c"
    break;

  case 32: /* argument: "until"  */
#line 150 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1380 "grub_script.tab.c"
    break;

  case 33: /* argument: "while"  */
#line 151 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1386 "grub_script.tab.c"
    break;

  case 34: /* argument: "function"  */
#line 152 "./grub-core/script/parser.y"
                       { (yyval.arglist) = grub_script_add_arglist (state, 0, (yyvsp[0].arg)); }
#line 1392 "grub_script.tab.c"
    break;

  case 35: /* argument: word  */
#line 153 "./grub-core/script/parser.y"
                { (yyval.arglist) = (yyvsp[0].arglist); }
#line 1398 "grub_script.tab.c"
    break;

  case 36: /* @2: %empty  */
#line 181 "./grub-core/script/parser.y"
       {
         grub_script_lexer_ref (state->lexerstate);
         (yyval.offset) = grub_script_lexer_record_start (state);
	 (yyval.memory) = grub_script_mem_record (state);

	 /* save currently known scripts.  */
	 (yyval.scripts) = state->scripts;
	 state->scripts = 0;
       }
#line 1412 "grub_script.tab.c"
    break;

  case 37: /* block: "{" @2 commands1 delimiters0 "}"  */
#line 191 "./grub-core/script/parser.y"
       {
         char *p;
	 struct grub_script_mem *memory;
	 struct grub_script *s = (yyvsp[-3].scripts);

	 memory = grub_script_mem_record_stop (state, (yyvsp[-3].memory));
         if ((p = grub_script_lexer_record_stop (state, (yyvsp[-3].offset))))
	   *grub_strrchr (p, '}') = '\0';

	 (yyval.arg) = grub_script_arg_add (state, 0, GRUB_SCRIPT_ARG_TYPE_BLOCK, p);
	 if (! (yyval.arg) || ! ((yyval.arg)->script = grub_script_create ((yyvsp[-2].cmd), memory)))
	   grub_script_mem_free (memory);

	 else {
	   /* attach nested scripts to $$->script as children */
	   (yyval.arg)->script->children = state->scripts;

	   /* restore old scripts; append $$->script to siblings. */
	   state->scripts = (yyvsp[-3].scripts) ?: (yyval.arg)->script;
	   if (s) {
	     while (s->next_siblings)
	       s = s->next_siblings;
	     s->next_siblings = (yyval.arg)->script;
	   }
	 }

         grub_script_lexer_deref (state->lexerstate);
       }
#line 1445 "grub_script.tab.c"
    break;

  case 38: /* block0: %empty  */
#line 220 "./grub-core/script/parser.y"
                    { (yyval.arg) = 0; }
#line 1451 "grub_script.tab.c"
    break;

  case 39: /* block0: block  */
#line 221 "./grub-core/script/parser.y"
              { (yyval.arg) = (yyvsp[0].arg); }
#line 1457 "grub_script.tab.c"
    break;

  case 40: /* arguments0: %empty  */
#line 224 "./grub-core/script/parser.y"
                        { (yyval.arglist) = 0; }
#line 1463 "grub_script.tab.c"
    break;

  case 41: /* arguments0: arguments1  */
#line 225 "./grub-core/script/parser.y"
                        { (yyval.arglist) = (yyvsp[0].arglist); }
#line 1469 "grub_script.tab.c"
    break;

  case 42: /* arguments1: argument arguments0  */
#line 228 "./grub-core/script/parser.y"
            {
	      if ((yyvsp[-1].arglist) && (yyvsp[0].arglist))
		{
		  (yyvsp[-1].arglist)->next = (yyvsp[0].arglist);
		  (yyvsp[-1].arglist)->argcount += (yyvsp[0].arglist)->argcount;
		  (yyvsp[0].arglist)->argcount = 0;
		}
	      (yyval.arglist) = (yyvsp[-1].arglist);
            }
#line 1483 "grub_script.tab.c"
    break;

  case 43: /* grubcmd: word arguments0 block0  */
#line 240 "./grub-core/script/parser.y"
         {
	   struct grub_script_arglist *x = (yyvsp[-1].arglist);

	   if ((yyvsp[0].arg))
	     x = grub_script_add_arglist (state, (yyvsp[-1].arglist), (yyvsp[0].arg));

           if ((yyvsp[-2].arglist) && x) {
             (yyvsp[-2].arglist)->next = x;
             (yyvsp[-2].arglist)->argcount += x->argcount;
             x->argcount = 0;
           }
           (yyval.cmd) = grub_script_create_cmdline (state, (yyvsp[-2].arglist));
         }
#line 1501 "grub_script.tab.c"
    break;

  case 44: /* command: grubcmd  */
#line 256 "./grub-core/script/parser.y"
                  { (yyval.cmd) = (yyvsp[0].cmd); }
#line 1507 "grub_script.tab.c"
    break;

  case 45: /* command: ifcmd  */
#line 257 "./grub-core/script/parser.y"
                  { (yyval.cmd) = (yyvsp[0].cmd); }
#line 1513 "grub_script.tab.c"
    break;

  case 46: /* command: forcmd  */
#line 258 "./grub-core/script/parser.y"
                  { (yyval.cmd) = (yyvsp[0].cmd); }
#line 1519 "grub_script.tab.c"
    break;

  case 47: /* command: whilecmd  */
#line 259 "./grub-core/script/parser.y"
                  { (yyval.cmd) = (yyvsp[0].cmd); }
#line 1525 "grub_script.tab.c"
    break;

  case 48: /* command: untilcmd  */
#line 260 "./grub-core/script/parser.y"
                  { (yyval.cmd) = (yyvsp[0].cmd); }
#line 1531 "grub_script.tab.c"
    break;

  case 49: /* commands1: newlines0 command  */
#line 265 "./grub-core/script/parser.y"
           {
             (yyval.cmd) = grub_script_append_cmd (state, 0, (yyvsp[0].cmd));
           }
#line 1539 "grub_script.tab.c"
    break;

  case 50: /* commands1: commands1 delimiters1 command  */
#line 269 "./grub-core/script/parser.y"
           {
	     (yyval.cmd) = grub_script_append_cmd (state, (yyvsp[-2].cmd), (yyvsp[0].cmd));
           }
#line 1547 "grub_script.tab.c"
    break;

  case 51: /* @3: %empty  */
#line 275 "./grub-core/script/parser.y"
          {
            grub_script_lexer_ref (state->lexerstate);
            state->func_mem = grub_script_mem_record (state);

	    (yyval.scripts) = state->scripts;
	    state->scripts = 0;
          }
#line 1559 "grub_script.tab.c"
    break;

  case 52: /* function: "function" "name" @3 newlines0 "{" commands1 delimiters1 "}"  */
#line 283 "./grub-core/script/parser.y"
          {
            struct grub_script *script;
            state->func_mem = grub_script_mem_record_stop (state,
                                                           state->func_mem);
            script = grub_script_create ((yyvsp[-2].cmd), state->func_mem);
            if (! script)
	      grub_script_mem_free (state->func_mem);
	    else {
	      script->children = state->scripts;
	      if (!grub_script_function_create ((yyvsp[-6].arg), script))
		grub_script_free (script);
	    }

	    state->scripts = (yyvsp[-5].scripts);
            grub_script_lexer_deref (state->lexerstate);
          }
#line 1580 "grub_script.tab.c"
    break;

  case 53: /* $@4: %empty  */
#line 302 "./grub-core/script/parser.y"
        {
	  grub_script_lexer_ref (state->lexerstate);
	}
#line 1588 "grub_script.tab.c"
    break;

  case 54: /* ifcmd: "if" $@4 ifclause "fi"  */
#line 306 "./grub-core/script/parser.y"
        {
	  (yyval.cmd) = (yyvsp[-1].cmd);
	  grub_script_lexer_deref (state->lexerstate);
	}
#line 1597 "grub_script.tab.c"
    break;

  case 55: /* ifclause: commands1 delimiters1 "then" commands1 delimiters1  */
#line 312 "./grub-core/script/parser.y"
          {
	    (yyval.cmd) = grub_script_create_cmdif (state, (yyvsp[-4].cmd), (yyvsp[-1].cmd), 0);
	  }
#line 1605 "grub_script.tab.c"
    break;

  case 56: /* ifclause: commands1 delimiters1 "then" commands1 delimiters1 "else" commands1 delimiters1  */
#line 316 "./grub-core/script/parser.y"
          {
	    (yyval.cmd) = grub_script_create_cmdif (state, (yyvsp[-7].cmd), (yyvsp[-4].cmd), (yyvsp[-1].cmd));
	  }
#line 1613 "grub_script.tab.c"
    break;

  case 57: /* ifclause: commands1 delimiters1 "then" commands1 delimiters1 "elif" ifclause  */
#line 320 "./grub-core/script/parser.y"
          {
	    (yyval.cmd) = grub_script_create_cmdif (state, (yyvsp[-6].cmd), (yyvsp[-3].cmd), (yyvsp[0].cmd));
	  }
#line 1621 "grub_script.tab.c"
    break;

  case 58: /* $@5: %empty  */
#line 326 "./grub-core/script/parser.y"
        {
	  grub_script_lexer_ref (state->lexerstate);
        }
#line 1629 "grub_script.tab.c"
    break;

  case 59: /* forcmd: "for" "name" $@5 "in" arguments0 delimiters1 "do" commands1 delimiters1 "done"  */
#line 330 "./grub-core/script/parser.y"
        {
	  (yyval.cmd) = grub_script_create_cmdfor (state, (yyvsp[-8].arg), (yyvsp[-5].arglist), (yyvsp[-2].cmd));
	  grub_script_lexer_deref (state->lexerstate);
	}
#line 1638 "grub_script.tab.c"
    break;

  case 60: /* $@6: %empty  */
#line 337 "./grub-core/script/parser.y"
          {
	    grub_script_lexer_ref (state->lexerstate);
          }
#line 1646 "grub_script.tab.c"
    break;

  case 61: /* whilecmd: "while" $@6 commands1 delimiters1 "do" commands1 delimiters1 "done"  */
#line 341 "./grub-core/script/parser.y"
          {
	    (yyval.cmd) = grub_script_create_cmdwhile (state, (yyvsp[-5].cmd), (yyvsp[-2].cmd), 0);
	    grub_script_lexer_deref (state->lexerstate);
	  }
#line 1655 "grub_script.tab.c"
    break;

  case 62: /* $@7: %empty  */
#line 348 "./grub-core/script/parser.y"
          {
	    grub_script_lexer_ref (state->lexerstate);
          }
#line 1663 "grub_script.tab.c"
    break;

  case 63: /* untilcmd: "until" $@7 commands1 delimiters1 "do" commands1 delimiters1 "done"  */
#line 352 "./grub-core/script/parser.y"
          {
	    (yyval.cmd) = grub_script_create_cmdwhile (state, (yyvsp[-5].cmd), (yyvsp[-2].cmd), 1);
	    grub_script_lexer_deref (state->lexerstate);
	  }
#line 1672 "grub_script.tab.c"
    break;


#line 1676 "grub_script.tab.c"

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
      yyerror (state, YY_("syntax error"));
    }

  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= GRUB_PARSER_TOKEN_EOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == GRUB_PARSER_TOKEN_EOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval, state);
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
                  YY_ACCESSING_SYMBOL (yystate), yyvsp, state);
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
  yyerror (state, YY_("memory exhausted"));
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
                  yytoken, &yylval, state);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  YY_ACCESSING_SYMBOL (+*yyssp), yyvsp, state);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif

  return yyresult;
}

