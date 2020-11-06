# 1 "util/grub-fstest.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "util/grub-fstest.c"
# 20 "util/grub-fstest.c"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 21 "util/grub-fstest.c" 2
# 1 "./include/grub/types.h" 1
# 22 "./include/grub/types.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/types.h" 2
# 76 "./include/grub/types.h"
typedef signed char grub_int8_t;
typedef short grub_int16_t;
typedef int grub_int32_t;

typedef long grub_int64_t;




typedef unsigned char grub_uint8_t;
typedef unsigned short grub_uint16_t;
typedef unsigned grub_uint32_t;



typedef unsigned long grub_uint64_t;
# 103 "./include/grub/types.h"
typedef grub_uint64_t grub_addr_t;
typedef grub_uint64_t grub_size_t;
typedef grub_int64_t grub_ssize_t;
# 154 "./include/grub/types.h"
typedef grub_uint64_t grub_properly_aligned_t;




typedef grub_uint64_t grub_off_t;


typedef grub_uint64_t grub_disk_addr_t;


static inline grub_uint16_t grub_swap_bytes16(grub_uint16_t _x)
{
   return (grub_uint16_t) ((_x << 8) | (_x >> 8));
}
# 186 "./include/grub/types.h"
static inline grub_uint32_t grub_swap_bytes32(grub_uint32_t x)
{
 return __builtin_bswap32(x);
}

static inline grub_uint64_t grub_swap_bytes64(grub_uint64_t x)
{
 return __builtin_bswap64(x);
}
# 260 "./include/grub/types.h"
struct grub_unaligned_uint16
{
  grub_uint16_t val;
} __attribute__ ((packed));
struct grub_unaligned_uint32
{
  grub_uint32_t val;
} __attribute__ ((packed));
struct grub_unaligned_uint64
{
  grub_uint64_t val;
} __attribute__ ((packed));

typedef struct grub_unaligned_uint16 grub_unaligned_uint16_t;
typedef struct grub_unaligned_uint32 grub_unaligned_uint32_t;
typedef struct grub_unaligned_uint64 grub_unaligned_uint64_t;

static inline grub_uint16_t grub_get_unaligned16 (const void *ptr)
{
  const struct grub_unaligned_uint16 *dd
    = (const struct grub_unaligned_uint16 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned16 (void *ptr, grub_uint16_t val)
{
  struct grub_unaligned_uint16 *dd = (struct grub_unaligned_uint16 *) ptr;
  dd->val = val;
}

static inline grub_uint32_t grub_get_unaligned32 (const void *ptr)
{
  const struct grub_unaligned_uint32 *dd
    = (const struct grub_unaligned_uint32 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned32 (void *ptr, grub_uint32_t val)
{
  struct grub_unaligned_uint32 *dd = (struct grub_unaligned_uint32 *) ptr;
  dd->val = val;
}

static inline grub_uint64_t grub_get_unaligned64 (const void *ptr)
{
  const struct grub_unaligned_uint64 *dd
    = (const struct grub_unaligned_uint64 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned64 (void *ptr, grub_uint64_t val)
{
  struct grub_unaligned_uint64_t
  {
    grub_uint64_t d;
  } __attribute__ ((packed));
  struct grub_unaligned_uint64_t *dd = (struct grub_unaligned_uint64_t *) ptr;
  dd->d = val;
}
# 22 "util/grub-fstest.c" 2
# 1 "./include/grub/emu/misc.h" 1
# 22 "./include/grub/emu/misc.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/emu/misc.h" 2
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 3 4

# 40 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 99 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 24 "./include/grub/emu/misc.h" 2

# 1 "/usr/include/stdio.h" 1 3 4
# 27 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/libc-header-start.h" 1 3 4
# 33 "/usr/include/bits/libc-header-start.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 465 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 452 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 453 "/usr/include/sys/cdefs.h" 2 3 4
# 1 "/usr/include/bits/long-double.h" 1 3 4
# 454 "/usr/include/sys/cdefs.h" 2 3 4
# 466 "/usr/include/features.h" 2 3 4
# 489 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4
# 10 "/usr/include/gnu/stubs.h" 3 4
# 1 "/usr/include/gnu/stubs-64.h" 1 3 4
# 11 "/usr/include/gnu/stubs.h" 2 3 4
# 490 "/usr/include/features.h" 2 3 4
# 34 "/usr/include/bits/libc-header-start.h" 2 3 4
# 28 "/usr/include/stdio.h" 2 3 4





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 209 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 34 "/usr/include/stdio.h" 2 3 4




# 1 "/usr/include/bits/types.h" 1 3 4
# 27 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 28 "/usr/include/bits/types.h" 2 3 4
# 1 "/usr/include/bits/timesize.h" 1 3 4
# 29 "/usr/include/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;






typedef __int8_t __int_least8_t;
typedef __uint8_t __uint_least8_t;
typedef __int16_t __int_least16_t;
typedef __uint16_t __uint_least16_t;
typedef __int32_t __int_least32_t;
typedef __uint32_t __uint_least32_t;
typedef __int64_t __int_least64_t;
typedef __uint64_t __uint_least64_t;



typedef long int __quad_t;
typedef unsigned long int __u_quad_t;







typedef long int __intmax_t;
typedef unsigned long int __uintmax_t;
# 141 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/typesizes.h" 1 3 4
# 142 "/usr/include/bits/types.h" 2 3 4
# 1 "/usr/include/bits/time64.h" 1 3 4
# 143 "/usr/include/bits/types.h" 2 3 4


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;
typedef long int __suseconds64_t;

typedef int __daddr_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;


typedef long int __fsword_t;

typedef long int __ssize_t;


typedef long int __syscall_slong_t;

typedef unsigned long int __syscall_ulong_t;



typedef __off64_t __loff_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;




typedef int __sig_atomic_t;
# 39 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/__fpos_t.h" 1 3 4




# 1 "/usr/include/bits/types/__mbstate_t.h" 1 3 4
# 13 "/usr/include/bits/types/__mbstate_t.h" 3 4
typedef struct
{
  int __count;
  union
  {
    unsigned int __wch;
    char __wchb[4];
  } __value;
} __mbstate_t;
# 6 "/usr/include/bits/types/__fpos_t.h" 2 3 4




typedef struct _G_fpos_t
{
  __off_t __pos;
  __mbstate_t __state;
} __fpos_t;
# 40 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/__fpos64_t.h" 1 3 4
# 10 "/usr/include/bits/types/__fpos64_t.h" 3 4
typedef struct _G_fpos64_t
{
  __off64_t __pos;
  __mbstate_t __state;
} __fpos64_t;
# 41 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/__FILE.h" 1 3 4



struct _IO_FILE;
typedef struct _IO_FILE __FILE;
# 42 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/FILE.h" 1 3 4



struct _IO_FILE;


typedef struct _IO_FILE FILE;
# 43 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/struct_FILE.h" 1 3 4
# 35 "/usr/include/bits/types/struct_FILE.h" 3 4
struct _IO_FILE;
struct _IO_marker;
struct _IO_codecvt;
struct _IO_wide_data;




typedef void _IO_lock_t;





struct _IO_FILE
{
  int _flags;


  char *_IO_read_ptr;
  char *_IO_read_end;
  char *_IO_read_base;
  char *_IO_write_base;
  char *_IO_write_ptr;
  char *_IO_write_end;
  char *_IO_buf_base;
  char *_IO_buf_end;


  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;
  int _flags2;
  __off_t _old_offset;


  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];

  _IO_lock_t *_lock;







  __off64_t _offset;

  struct _IO_codecvt *_codecvt;
  struct _IO_wide_data *_wide_data;
  struct _IO_FILE *_freeres_list;
  void *_freeres_buf;
  size_t __pad5;
  int _mode;

  char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];
};
# 44 "/usr/include/stdio.h" 2 3 4


# 1 "/usr/include/bits/types/cookie_io_functions_t.h" 1 3 4
# 27 "/usr/include/bits/types/cookie_io_functions_t.h" 3 4
typedef __ssize_t cookie_read_function_t (void *__cookie, char *__buf,
                                          size_t __nbytes);







typedef __ssize_t cookie_write_function_t (void *__cookie, const char *__buf,
                                           size_t __nbytes);







typedef int cookie_seek_function_t (void *__cookie, __off64_t *__pos, int __w);


typedef int cookie_close_function_t (void *__cookie);






typedef struct _IO_cookie_io_functions_t
{
  cookie_read_function_t *read;
  cookie_write_function_t *write;
  cookie_seek_function_t *seek;
  cookie_close_function_t *close;
} cookie_io_functions_t;
# 47 "/usr/include/stdio.h" 2 3 4
# 65 "/usr/include/stdio.h" 3 4
typedef __off64_t off_t;




typedef __off64_t off64_t;






typedef __ssize_t ssize_t;
# 86 "/usr/include/stdio.h" 3 4
typedef __fpos64_t fpos_t;


typedef __fpos64_t fpos64_t;
# 133 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 134 "/usr/include/stdio.h" 2 3 4



extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;






extern int remove (const char *__filename) __attribute__ ((__nothrow__ , __leaf__));

extern int rename (const char *__old, const char *__new) __attribute__ ((__nothrow__ , __leaf__));



extern int renameat (int __oldfd, const char *__old, int __newfd,
       const char *__new) __attribute__ ((__nothrow__ , __leaf__));
# 164 "/usr/include/stdio.h" 3 4
extern int renameat2 (int __oldfd, const char *__old, int __newfd,
        const char *__new, unsigned int __flags) __attribute__ ((__nothrow__ , __leaf__));
# 176 "/usr/include/stdio.h" 3 4
extern FILE *tmpfile (void) __asm__ ("" "tmpfile64") ;






extern FILE *tmpfile64 (void) ;



extern char *tmpnam (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;




extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;
# 204 "/usr/include/stdio.h" 3 4
extern char *tempnam (const char *__dir, const char *__pfx)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;







extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);
# 227 "/usr/include/stdio.h" 3 4
extern int fflush_unlocked (FILE *__stream);
# 237 "/usr/include/stdio.h" 3 4
extern int fcloseall (void);
# 257 "/usr/include/stdio.h" 3 4
extern FILE *fopen (const char *__restrict __filename, const char *__restrict __modes) __asm__ ("" "fopen64")

  ;
extern FILE *freopen (const char *__restrict __filename, const char *__restrict __modes, FILE *__restrict __stream) __asm__ ("" "freopen64")


  ;






extern FILE *fopen64 (const char *__restrict __filename,
        const char *__restrict __modes) ;
extern FILE *freopen64 (const char *__restrict __filename,
   const char *__restrict __modes,
   FILE *__restrict __stream) ;




extern FILE *fdopen (int __fd, const char *__modes) __attribute__ ((__nothrow__ , __leaf__)) ;





extern FILE *fopencookie (void *__restrict __magic_cookie,
     const char *__restrict __modes,
     cookie_io_functions_t __io_funcs) __attribute__ ((__nothrow__ , __leaf__)) ;




extern FILE *fmemopen (void *__s, size_t __len, const char *__modes)
  __attribute__ ((__nothrow__ , __leaf__)) ;




extern FILE *open_memstream (char **__bufloc, size_t *__sizeloc) __attribute__ ((__nothrow__ , __leaf__)) ;





extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));



extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
      int __modes, size_t __n) __attribute__ ((__nothrow__ , __leaf__));




extern void setbuffer (FILE *__restrict __stream, char *__restrict __buf,
         size_t __size) __attribute__ ((__nothrow__ , __leaf__));


extern void setlinebuf (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));







extern int fprintf (FILE *__restrict __stream,
      const char *__restrict __format, ...);




extern int printf (const char *__restrict __format, ...);

extern int sprintf (char *__restrict __s,
      const char *__restrict __format, ...) __attribute__ ((__nothrow__));





extern int vfprintf (FILE *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg);




extern int vprintf (const char *__restrict __format, __gnuc_va_list __arg);

extern int vsprintf (char *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg) __attribute__ ((__nothrow__));



extern int snprintf (char *__restrict __s, size_t __maxlen,
       const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 4)));

extern int vsnprintf (char *__restrict __s, size_t __maxlen,
        const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 0)));





extern int vasprintf (char **__restrict __ptr, const char *__restrict __f,
        __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 0))) ;
extern int __asprintf (char **__restrict __ptr,
         const char *__restrict __fmt, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3))) ;
extern int asprintf (char **__restrict __ptr,
       const char *__restrict __fmt, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3))) ;




extern int vdprintf (int __fd, const char *__restrict __fmt,
       __gnuc_va_list __arg)
     __attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));







extern int fscanf (FILE *__restrict __stream,
     const char *__restrict __format, ...) ;




extern int scanf (const char *__restrict __format, ...) ;

extern int sscanf (const char *__restrict __s,
     const char *__restrict __format, ...) __attribute__ ((__nothrow__ , __leaf__));





# 1 "/usr/include/bits/floatn.h" 1 3 4
# 119 "/usr/include/bits/floatn.h" 3 4
# 1 "/usr/include/bits/floatn-common.h" 1 3 4
# 24 "/usr/include/bits/floatn-common.h" 3 4
# 1 "/usr/include/bits/long-double.h" 1 3 4
# 25 "/usr/include/bits/floatn-common.h" 2 3 4
# 120 "/usr/include/bits/floatn.h" 2 3 4
# 407 "/usr/include/stdio.h" 2 3 4



extern int fscanf (FILE *__restrict __stream, const char *__restrict __format, ...) __asm__ ("" "__isoc99_fscanf")

                               ;
extern int scanf (const char *__restrict __format, ...) __asm__ ("" "__isoc99_scanf")
                              ;
extern int sscanf (const char *__restrict __s, const char *__restrict __format, ...) __asm__ ("" "__isoc99_sscanf") __attribute__ ((__nothrow__ , __leaf__))

                      ;
# 435 "/usr/include/stdio.h" 3 4
extern int vfscanf (FILE *__restrict __s, const char *__restrict __format,
      __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;





extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;


extern int vsscanf (const char *__restrict __s,
      const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format__ (__scanf__, 2, 0)));





extern int vfscanf (FILE *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vfscanf")



     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vscanf")

     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (const char *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vsscanf") __attribute__ ((__nothrow__ , __leaf__))



     __attribute__ ((__format__ (__scanf__, 2, 0)));
# 489 "/usr/include/stdio.h" 3 4
extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);






extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
# 514 "/usr/include/stdio.h" 3 4
extern int fgetc_unlocked (FILE *__stream);
# 525 "/usr/include/stdio.h" 3 4
extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);
# 541 "/usr/include/stdio.h" 3 4
extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);







extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     __attribute__ ((__access__ (__write_only__, 1, 2)));
# 591 "/usr/include/stdio.h" 3 4
extern char *fgets_unlocked (char *__restrict __s, int __n,
        FILE *__restrict __stream)
    __attribute__ ((__access__ (__write_only__, 1, 2)));
# 608 "/usr/include/stdio.h" 3 4
extern __ssize_t __getdelim (char **__restrict __lineptr,
                             size_t *__restrict __n, int __delimiter,
                             FILE *__restrict __stream) ;
extern __ssize_t getdelim (char **__restrict __lineptr,
                           size_t *__restrict __n, int __delimiter,
                           FILE *__restrict __stream) ;







extern __ssize_t getline (char **__restrict __lineptr,
                          size_t *__restrict __n,
                          FILE *__restrict __stream) ;







extern int fputs (const char *__restrict __s, FILE *__restrict __stream);





extern int puts (const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void *__restrict __ptr, size_t __size,
       size_t __n, FILE *__restrict __stream) ;




extern size_t fwrite (const void *__restrict __ptr, size_t __size,
        size_t __n, FILE *__restrict __s);
# 667 "/usr/include/stdio.h" 3 4
extern int fputs_unlocked (const char *__restrict __s,
      FILE *__restrict __stream);
# 678 "/usr/include/stdio.h" 3 4
extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream);







extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream) ;




extern void rewind (FILE *__stream);
# 720 "/usr/include/stdio.h" 3 4
extern int fseeko (FILE *__stream, __off64_t __off, int __whence) __asm__ ("" "fseeko64")

                  ;
extern __off64_t ftello (FILE *__stream) __asm__ ("" "ftello64");
# 744 "/usr/include/stdio.h" 3 4
extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos) __asm__ ("" "fgetpos64")
                                          ;
extern int fsetpos (FILE *__stream, const fpos_t *__pos) __asm__ ("" "fsetpos64")
                                                          ;







extern int fseeko64 (FILE *__stream, __off64_t __off, int __whence);
extern __off64_t ftello64 (FILE *__stream) ;
extern int fgetpos64 (FILE *__restrict __stream, fpos64_t *__restrict __pos);
extern int fsetpos64 (FILE *__stream, const fpos64_t *__pos);



extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));

extern int feof (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;

extern int ferror (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;



extern void clearerr_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
extern int feof_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern int ferror_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;







extern void perror (const char *__s);




extern int fileno (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
# 799 "/usr/include/stdio.h" 3 4
extern FILE *popen (const char *__command, const char *__modes) ;





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) __attribute__ ((__nothrow__ , __leaf__));





extern char *cuserid (char *__s);




struct obstack;


extern int obstack_printf (struct obstack *__restrict __obstack,
      const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3)));
extern int obstack_vprintf (struct obstack *__restrict __obstack,
       const char *__restrict __format,
       __gnuc_va_list __args)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 0)));







extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));



extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;


extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
# 857 "/usr/include/stdio.h" 3 4
extern int __uflow (FILE *);
extern int __overflow (FILE *, int);
# 874 "/usr/include/stdio.h" 3 4

# 26 "./include/grub/emu/misc.h" 2

# 1 "./include/grub/compiler.h" 1
# 28 "./include/grub/emu/misc.h" 2
# 1 "./include/grub/symbol.h" 1
# 22 "./include/grub/symbol.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/symbol.h" 2
# 29 "./include/grub/emu/misc.h" 2

# 1 "./include/grub/misc.h" 1
# 26 "./include/grub/misc.h"
# 1 "./include/grub/err.h" 1
# 28 "./include/grub/err.h"

# 28 "./include/grub/err.h"
typedef enum
  {
    GRUB_ERR_NONE = 0,
    GRUB_ERR_TEST_FAILURE,
    GRUB_ERR_BAD_MODULE,
    GRUB_ERR_OUT_OF_MEMORY,
    GRUB_ERR_BAD_FILE_TYPE,
    GRUB_ERR_FILE_NOT_FOUND,
    GRUB_ERR_FILE_READ_ERROR,
    GRUB_ERR_BAD_FILENAME,
    GRUB_ERR_UNKNOWN_FS,
    GRUB_ERR_BAD_FS,
    GRUB_ERR_BAD_NUMBER,
    GRUB_ERR_OUT_OF_RANGE,
    GRUB_ERR_UNKNOWN_DEVICE,
    GRUB_ERR_BAD_DEVICE,
    GRUB_ERR_READ_ERROR,
    GRUB_ERR_WRITE_ERROR,
    GRUB_ERR_UNKNOWN_COMMAND,
    GRUB_ERR_INVALID_COMMAND,
    GRUB_ERR_BAD_ARGUMENT,
    GRUB_ERR_BAD_PART_TABLE,
    GRUB_ERR_UNKNOWN_OS,
    GRUB_ERR_BAD_OS,
    GRUB_ERR_NO_KERNEL,
    GRUB_ERR_BAD_FONT,
    GRUB_ERR_NOT_IMPLEMENTED_YET,
    GRUB_ERR_SYMLINK_LOOP,
    GRUB_ERR_BAD_COMPRESSED_DATA,
    GRUB_ERR_MENU,
    GRUB_ERR_TIMEOUT,
    GRUB_ERR_IO,
    GRUB_ERR_ACCESS_DENIED,
    GRUB_ERR_EXTRACTOR,
    GRUB_ERR_NET_BAD_ADDRESS,
    GRUB_ERR_NET_ROUTE_LOOP,
    GRUB_ERR_NET_NO_ROUTE,
    GRUB_ERR_NET_NO_ANSWER,
    GRUB_ERR_NET_NO_CARD,
    GRUB_ERR_WAIT,
    GRUB_ERR_BUG,
    GRUB_ERR_NET_PORT_CLOSED,
    GRUB_ERR_NET_INVALID_RESPONSE,
    GRUB_ERR_NET_UNKNOWN_ERROR,
    GRUB_ERR_NET_PACKET_TOO_BIG,
    GRUB_ERR_NET_NO_DOMAIN,
    GRUB_ERR_EOF,
    GRUB_ERR_BAD_SIGNATURE
  }
grub_err_t;

struct grub_error_saved
{
  grub_err_t grub_errno;
  char errmsg[256];
};

extern grub_err_t grub_errno;
extern char grub_errmsg[256];

grub_err_t grub_error (grub_err_t n, const char *fmt, ...);
void grub_fatal (const char *fmt, ...) __attribute__ ((noreturn));
void grub_error_push (void);
int grub_error_pop (void);
void grub_print_error (void);
extern int grub_err_printed_errors;
int grub_err_printf (const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 1, 2)));
# 27 "./include/grub/misc.h" 2
# 1 "./include/grub/i18n.h" 1
# 22 "./include/grub/i18n.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/i18n.h" 2





extern const char *(*grub_gettext) (const char *s) __attribute__ ((format_arg (1)));



# 1 "/usr/include/locale.h" 1 3 4
# 28 "/usr/include/locale.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 29 "/usr/include/locale.h" 2 3 4
# 1 "/usr/include/bits/locale.h" 1 3 4
# 30 "/usr/include/locale.h" 2 3 4


# 51 "/usr/include/locale.h" 3 4

# 51 "/usr/include/locale.h" 3 4
struct lconv
{


  char *decimal_point;
  char *thousands_sep;





  char *grouping;





  char *int_curr_symbol;
  char *currency_symbol;
  char *mon_decimal_point;
  char *mon_thousands_sep;
  char *mon_grouping;
  char *positive_sign;
  char *negative_sign;
  char int_frac_digits;
  char frac_digits;

  char p_cs_precedes;

  char p_sep_by_space;

  char n_cs_precedes;

  char n_sep_by_space;






  char p_sign_posn;
  char n_sign_posn;


  char int_p_cs_precedes;

  char int_p_sep_by_space;

  char int_n_cs_precedes;

  char int_n_sep_by_space;






  char int_p_sign_posn;
  char int_n_sign_posn;
# 118 "/usr/include/locale.h" 3 4
};



extern char *setlocale (int __category, const char *__locale) __attribute__ ((__nothrow__ , __leaf__));


extern struct lconv *localeconv (void) __attribute__ ((__nothrow__ , __leaf__));
# 135 "/usr/include/locale.h" 3 4
# 1 "/usr/include/bits/types/locale_t.h" 1 3 4
# 22 "/usr/include/bits/types/locale_t.h" 3 4
# 1 "/usr/include/bits/types/__locale_t.h" 1 3 4
# 28 "/usr/include/bits/types/__locale_t.h" 3 4
struct __locale_struct
{

  struct __locale_data *__locales[13];


  const unsigned short int *__ctype_b;
  const int *__ctype_tolower;
  const int *__ctype_toupper;


  const char *__names[13];
};

typedef struct __locale_struct *__locale_t;
# 23 "/usr/include/bits/types/locale_t.h" 2 3 4

typedef __locale_t locale_t;
# 136 "/usr/include/locale.h" 2 3 4





extern locale_t newlocale (int __category_mask, const char *__locale,
      locale_t __base) __attribute__ ((__nothrow__ , __leaf__));
# 176 "/usr/include/locale.h" 3 4
extern locale_t duplocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));



extern void freelocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));






extern locale_t uselocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));








# 33 "./include/grub/i18n.h" 2
# 1 "/usr/include/libintl.h" 1 3 4
# 34 "/usr/include/libintl.h" 3 4





extern char *gettext (const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (1)));



extern char *dgettext (const char *__domainname, const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));
extern char *__dgettext (const char *__domainname, const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));



extern char *dcgettext (const char *__domainname,
   const char *__msgid, int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));
extern char *__dcgettext (const char *__domainname,
     const char *__msgid, int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));




extern char *ngettext (const char *__msgid1, const char *__msgid2,
         unsigned long int __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (1))) __attribute__ ((__format_arg__ (2)));



extern char *dngettext (const char *__domainname, const char *__msgid1,
   const char *__msgid2, unsigned long int __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2))) __attribute__ ((__format_arg__ (3)));



extern char *dcngettext (const char *__domainname, const char *__msgid1,
    const char *__msgid2, unsigned long int __n,
    int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2))) __attribute__ ((__format_arg__ (3)));





extern char *textdomain (const char *__domainname) __attribute__ ((__nothrow__ , __leaf__));



extern char *bindtextdomain (const char *__domainname,
        const char *__dirname) __attribute__ ((__nothrow__ , __leaf__));



extern char *bind_textdomain_codeset (const char *__domainname,
          const char *__codeset) __attribute__ ((__nothrow__ , __leaf__));
# 121 "/usr/include/libintl.h" 3 4

# 34 "./include/grub/i18n.h" 2
# 53 "./include/grub/i18n.h"

# 53 "./include/grub/i18n.h"
static inline const char * __attribute__ ((always_inline,format_arg (1)))
_ (const char *str)
{
  return gettext(str);
}
# 28 "./include/grub/misc.h" 2
# 40 "./include/grub/misc.h"
void *grub_memmove (void *dest, const void *src, grub_size_t n);
char *grub_strcpy (char *dest, const char *src);

static inline char *
grub_strncpy (char *dest, const char *src, int c)
{
  char *p = dest;

  while ((*p++ = *src++) != '\0' && --c)
    ;

  return dest;
}

static inline char *
grub_stpcpy (char *dest, const char *src)
{
  char *d = dest;
  const char *s = src;

  do
    *d++ = *s;
  while (*s++ != '\0');

  return d - 1;
}


static inline void *
grub_memcpy (void *dest, const void *src, grub_size_t n)
{
  return grub_memmove (dest, src, n);
}
# 82 "./include/grub/misc.h"
int grub_memcmp (const void *s1, const void *s2, grub_size_t n);
int grub_strcmp (const char *s1, const char *s2);
int grub_strncmp (const char *s1, const char *s2, grub_size_t n);

char *grub_strchr (const char *s, int c);
char *grub_strrchr (const char *s, int c);
int grub_strword (const char *s, const char *w);



static inline char *
grub_strstr (const char *haystack, const char *needle)
{





  if (*needle != '\0')
    {


      char b = *needle++;

      for (;; haystack++)
 {
   if (*haystack == '\0')

     return 0;
   if (*haystack == b)

     {
       const char *rhaystack = haystack + 1;
       const char *rneedle = needle;

       for (;; rhaystack++, rneedle++)
  {
    if (*rneedle == '\0')

      return (char *) haystack;
    if (*rhaystack == '\0')

      return 0;
    if (*rhaystack != *rneedle)

      break;
  }
     }
 }
    }
  else
    return (char *) haystack;
}

int grub_isspace (int c);

static inline int
grub_isprint (int c)
{
  return (c >= ' ' && c <= '~');
}

static inline int
grub_iscntrl (int c)
{
  return (c >= 0x00 && c <= 0x1F) || c == 0x7F;
}

static inline int
grub_isalpha (int c)
{
  return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

static inline int
grub_islower (int c)
{
  return (c >= 'a' && c <= 'z');
}

static inline int
grub_isupper (int c)
{
  return (c >= 'A' && c <= 'Z');
}

static inline int
grub_isgraph (int c)
{
  return (c >= '!' && c <= '~');
}

static inline int
grub_isdigit (int c)
{
  return (c >= '0' && c <= '9');
}

static inline int
grub_isxdigit (int c)
{
  return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F');
}

static inline int
grub_isalnum (int c)
{
  return grub_isalpha (c) || grub_isdigit (c);
}

static inline int
grub_tolower (int c)
{
  if (c >= 'A' && c <= 'Z')
    return c - 'A' + 'a';

  return c;
}

static inline int
grub_toupper (int c)
{
  if (c >= 'a' && c <= 'z')
    return c - 'a' + 'A';

  return c;
}

static inline int
grub_strcasecmp (const char *s1, const char *s2)
{
  while (*s1 && *s2)
    {
      if (grub_tolower ((grub_uint8_t) *s1)
   != grub_tolower ((grub_uint8_t) *s2))
 break;

      s1++;
      s2++;
    }

  return (int) grub_tolower ((grub_uint8_t) *s1)
    - (int) grub_tolower ((grub_uint8_t) *s2);
}

static inline int
grub_strncasecmp (const char *s1, const char *s2, grub_size_t n)
{
  if (n == 0)
    return 0;

  while (*s1 && *s2 && --n)
    {
      if (grub_tolower (*s1) != grub_tolower (*s2))
 break;

      s1++;
      s2++;
    }

  return (int) grub_tolower ((grub_uint8_t) *s1)
    - (int) grub_tolower ((grub_uint8_t) *s2);
}
# 264 "./include/grub/misc.h"
unsigned long grub_strtoul (const char * __restrict str, const char ** const __restrict end, int base);
unsigned long long grub_strtoull (const char * __restrict str, const char ** const __restrict end, int base);

static inline long
grub_strtol (const char * __restrict str, const char ** const __restrict end, int base)
{
  int negative = 0;
  unsigned long long magnitude;

  while (*str && grub_isspace (*str))
    str++;

  if (*str == '-')
    {
      negative = 1;
      str++;
    }

  magnitude = grub_strtoull (str, end, base);
  if (negative)
    {
      if (magnitude > (unsigned long) 9223372036854775807L + 1)
        {
          grub_error (GRUB_ERR_OUT_OF_RANGE, "overflow is detected");
          return (-9223372036854775807L - 1);
        }
      return -((long) magnitude);
    }
  else
    {
      if (magnitude > 9223372036854775807L)
        {
          grub_error (GRUB_ERR_OUT_OF_RANGE, "overflow is detected");
          return 9223372036854775807L;
        }
      return (long) magnitude;
    }
}

char *grub_strdup (const char *s) __attribute__ ((warn_unused_result));
char *grub_strndup (const char *s, grub_size_t n) __attribute__ ((warn_unused_result));
void *grub_memset (void *s, int c, grub_size_t n);
grub_size_t grub_strlen (const char *s) __attribute__ ((warn_unused_result));
int grub_printf (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));
int grub_printf_ (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));



static inline char *
grub_strchrsub (char *output, const char *input, char ch, const char *with)
{
  while (*input)
    {
      if (*input == ch)
 {
   grub_strcpy (output, with);
   output += grub_strlen (with);
   input++;
   continue;
 }
      *output++ = *input++;
    }
  *output = '\0';
  return output;
}

extern void (*grub_xputs) (const char *str);

static inline int
grub_puts (const char *s)
{
  const char nl[2] = "\n";
  grub_xputs (s);
  grub_xputs (nl);

  return 1;
}

int grub_puts_ (const char *s);
int grub_debug_enabled (const char *condition);
void grub_real_dprintf (const char *file,
                                     const int line,
                                     const char *condition,
                                     const char *fmt, ...) __attribute__ ((format (gnu_printf, 4, 5)));
int grub_vprintf (const char *fmt, va_list args);
int grub_snprintf (char *str, grub_size_t n, const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 3, 4)));
int grub_vsnprintf (char *str, grub_size_t n, const char *fmt,
     va_list args);
char *grub_xasprintf (const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 1, 2))) __attribute__ ((warn_unused_result));
char *grub_xvasprintf (const char *fmt, va_list args) __attribute__ ((warn_unused_result));
void grub_exit (void) __attribute__ ((noreturn));
grub_uint64_t grub_divmod64 (grub_uint64_t n,
       grub_uint64_t d,
       grub_uint64_t *r);
# 378 "./include/grub/misc.h"
grub_int64_t
grub_divmod64s (grub_int64_t n,
     grub_int64_t d,
     grub_int64_t *r);

grub_uint32_t
grub_divmod32 (grub_uint32_t n,
     grub_uint32_t d,
     grub_uint32_t *r);

grub_int32_t
grub_divmod32s (grub_int32_t n,
      grub_int32_t d,
      grub_int32_t *r);



static inline char *
grub_memchr (const void *p, int c, grub_size_t len)
{
  const char *s = (const char *) p;
  const char *e = s + len;

  for (; s < e; s++)
    if (*s == c)
      return (char *) s;

  return 0;
}


static inline unsigned int
grub_abs (int x)
{
  if (x < 0)
    return (unsigned int) (-x);
  else
    return (unsigned int) x;
}






void grub_reboot (void) __attribute__ ((noreturn));
# 437 "./include/grub/misc.h"
void grub_halt (void) __attribute__ ((noreturn));
# 447 "./include/grub/misc.h"
static inline void
grub_error_save (struct grub_error_saved *save)
{
  grub_memcpy (save->errmsg, grub_errmsg, sizeof (save->errmsg));
  save->grub_errno = grub_errno;
  grub_errno = GRUB_ERR_NONE;
}

static inline void
grub_error_load (const struct grub_error_saved *save)
{
  grub_memcpy (grub_errmsg, save->errmsg, sizeof (grub_errmsg));
  grub_errno = save->grub_errno;
}
# 31 "./include/grub/emu/misc.h" 2
# 1 "./include/grub/util/misc.h" 1
# 22 "./include/grub/util/misc.h"
# 1 "/usr/include/stdlib.h" 1 3 4
# 25 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/bits/libc-header-start.h" 1 3 4
# 26 "/usr/include/stdlib.h" 2 3 4





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 321 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 3 4

# 321 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 3 4
typedef int wchar_t;
# 32 "/usr/include/stdlib.h" 2 3 4







# 1 "/usr/include/bits/waitflags.h" 1 3 4
# 40 "/usr/include/stdlib.h" 2 3 4
# 1 "/usr/include/bits/waitstatus.h" 1 3 4
# 41 "/usr/include/stdlib.h" 2 3 4
# 58 "/usr/include/stdlib.h" 3 4
typedef struct
  {
    int quot;
    int rem;
  } div_t;



typedef struct
  {
    long int quot;
    long int rem;
  } ldiv_t;





__extension__ typedef struct
  {
    long long int quot;
    long long int rem;
  } lldiv_t;
# 97 "/usr/include/stdlib.h" 3 4
extern size_t __ctype_get_mb_cur_max (void) __attribute__ ((__nothrow__ , __leaf__)) ;



extern double atof (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern int atoi (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern long int atol (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;



__extension__ extern long long int atoll (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;



extern double strtod (const char *__restrict __nptr,
        char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern float strtof (const char *__restrict __nptr,
       char **__restrict __endptr) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

extern long double strtold (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 140 "/usr/include/stdlib.h" 3 4
extern _Float32 strtof32 (const char *__restrict __nptr,
     char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float64 strtof64 (const char *__restrict __nptr,
     char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float128 strtof128 (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float32x strtof32x (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float64x strtof64x (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 176 "/usr/include/stdlib.h" 3 4
extern long int strtol (const char *__restrict __nptr,
   char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

extern unsigned long int strtoul (const char *__restrict __nptr,
      char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



__extension__
extern long long int strtoq (const char *__restrict __nptr,
        char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

__extension__
extern unsigned long long int strtouq (const char *__restrict __nptr,
           char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




__extension__
extern long long int strtoll (const char *__restrict __nptr,
         char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

__extension__
extern unsigned long long int strtoull (const char *__restrict __nptr,
     char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int strfromd (char *__dest, size_t __size, const char *__format,
       double __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));

extern int strfromf (char *__dest, size_t __size, const char *__format,
       float __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));

extern int strfroml (char *__dest, size_t __size, const char *__format,
       long double __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));
# 232 "/usr/include/stdlib.h" 3 4
extern int strfromf32 (char *__dest, size_t __size, const char * __format,
         _Float32 __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf64 (char *__dest, size_t __size, const char * __format,
         _Float64 __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf128 (char *__dest, size_t __size, const char * __format,
   _Float128 __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf32x (char *__dest, size_t __size, const char * __format,
   _Float32x __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf64x (char *__dest, size_t __size, const char * __format,
   _Float64x __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));
# 274 "/usr/include/stdlib.h" 3 4
extern long int strtol_l (const char *__restrict __nptr,
     char **__restrict __endptr, int __base,
     locale_t __loc) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

extern unsigned long int strtoul_l (const char *__restrict __nptr,
        char **__restrict __endptr,
        int __base, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

__extension__
extern long long int strtoll_l (const char *__restrict __nptr,
    char **__restrict __endptr, int __base,
    locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

__extension__
extern unsigned long long int strtoull_l (const char *__restrict __nptr,
       char **__restrict __endptr,
       int __base, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

extern double strtod_l (const char *__restrict __nptr,
   char **__restrict __endptr, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));

extern float strtof_l (const char *__restrict __nptr,
         char **__restrict __endptr, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));

extern long double strtold_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));
# 316 "/usr/include/stdlib.h" 3 4
extern _Float32 strtof32_l (const char *__restrict __nptr,
       char **__restrict __endptr,
       locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float64 strtof64_l (const char *__restrict __nptr,
       char **__restrict __endptr,
       locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float128 strtof128_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float32x strtof32x_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float64x strtof64x_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));
# 385 "/usr/include/stdlib.h" 3 4
extern char *l64a (long int __n) __attribute__ ((__nothrow__ , __leaf__)) ;


extern long int a64l (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;




# 1 "/usr/include/sys/types.h" 1 3 4
# 27 "/usr/include/sys/types.h" 3 4






typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;


typedef __loff_t loff_t;






typedef __ino64_t ino_t;




typedef __ino64_t ino64_t;




typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;
# 97 "/usr/include/sys/types.h" 3 4
typedef __pid_t pid_t;





typedef __id_t id_t;
# 114 "/usr/include/sys/types.h" 3 4
typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;




# 1 "/usr/include/bits/types/clock_t.h" 1 3 4






typedef __clock_t clock_t;
# 127 "/usr/include/sys/types.h" 2 3 4

# 1 "/usr/include/bits/types/clockid_t.h" 1 3 4






typedef __clockid_t clockid_t;
# 129 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/bits/types/time_t.h" 1 3 4






typedef __time_t time_t;
# 130 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/bits/types/timer_t.h" 1 3 4






typedef __timer_t timer_t;
# 131 "/usr/include/sys/types.h" 2 3 4



typedef __useconds_t useconds_t;



typedef __suseconds_t suseconds_t;





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 145 "/usr/include/sys/types.h" 2 3 4



typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;




# 1 "/usr/include/bits/stdint-intn.h" 1 3 4
# 24 "/usr/include/bits/stdint-intn.h" 3 4
typedef __int8_t int8_t;
typedef __int16_t int16_t;
typedef __int32_t int32_t;
typedef __int64_t int64_t;
# 156 "/usr/include/sys/types.h" 2 3 4


typedef __uint8_t u_int8_t;
typedef __uint16_t u_int16_t;
typedef __uint32_t u_int32_t;
typedef __uint64_t u_int64_t;


typedef int register_t __attribute__ ((__mode__ (__word__)));
# 176 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 24 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 35 "/usr/include/bits/endian.h" 3 4
# 1 "/usr/include/bits/endianness.h" 1 3 4
# 36 "/usr/include/bits/endian.h" 2 3 4
# 25 "/usr/include/endian.h" 2 3 4
# 35 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/byteswap.h" 1 3 4
# 33 "/usr/include/bits/byteswap.h" 3 4
static __inline __uint16_t
__bswap_16 (__uint16_t __bsx)
{

  return __builtin_bswap16 (__bsx);



}






static __inline __uint32_t
__bswap_32 (__uint32_t __bsx)
{

  return __builtin_bswap32 (__bsx);



}
# 69 "/usr/include/bits/byteswap.h" 3 4
__extension__ static __inline __uint64_t
__bswap_64 (__uint64_t __bsx)
{

  return __builtin_bswap64 (__bsx);



}
# 36 "/usr/include/endian.h" 2 3 4
# 1 "/usr/include/bits/uintn-identity.h" 1 3 4
# 32 "/usr/include/bits/uintn-identity.h" 3 4
static __inline __uint16_t
__uint16_identity (__uint16_t __x)
{
  return __x;
}

static __inline __uint32_t
__uint32_identity (__uint32_t __x)
{
  return __x;
}

static __inline __uint64_t
__uint64_identity (__uint64_t __x)
{
  return __x;
}
# 37 "/usr/include/endian.h" 2 3 4
# 177 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/select.h" 1 3 4
# 30 "/usr/include/sys/select.h" 3 4
# 1 "/usr/include/bits/select.h" 1 3 4
# 31 "/usr/include/sys/select.h" 2 3 4


# 1 "/usr/include/bits/types/sigset_t.h" 1 3 4



# 1 "/usr/include/bits/types/__sigset_t.h" 1 3 4




typedef struct
{
  unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
} __sigset_t;
# 5 "/usr/include/bits/types/sigset_t.h" 2 3 4


typedef __sigset_t sigset_t;
# 34 "/usr/include/sys/select.h" 2 3 4



# 1 "/usr/include/bits/types/struct_timeval.h" 1 3 4







struct timeval
{
  __time_t tv_sec;
  __suseconds_t tv_usec;
};
# 38 "/usr/include/sys/select.h" 2 3 4

# 1 "/usr/include/bits/types/struct_timespec.h" 1 3 4
# 10 "/usr/include/bits/types/struct_timespec.h" 3 4
struct timespec
{
  __time_t tv_sec;



  __syscall_slong_t tv_nsec;
# 26 "/usr/include/bits/types/struct_timespec.h" 3 4
};
# 40 "/usr/include/sys/select.h" 2 3 4
# 49 "/usr/include/sys/select.h" 3 4
typedef long int __fd_mask;
# 59 "/usr/include/sys/select.h" 3 4
typedef struct
  {



    __fd_mask fds_bits[1024 / (8 * (int) sizeof (__fd_mask))];





  } fd_set;






typedef __fd_mask fd_mask;
# 91 "/usr/include/sys/select.h" 3 4

# 101 "/usr/include/sys/select.h" 3 4
extern int select (int __nfds, fd_set *__restrict __readfds,
     fd_set *__restrict __writefds,
     fd_set *__restrict __exceptfds,
     struct timeval *__restrict __timeout);
# 113 "/usr/include/sys/select.h" 3 4
extern int pselect (int __nfds, fd_set *__restrict __readfds,
      fd_set *__restrict __writefds,
      fd_set *__restrict __exceptfds,
      const struct timespec *__restrict __timeout,
      const __sigset_t *__restrict __sigmask);
# 126 "/usr/include/sys/select.h" 3 4

# 180 "/usr/include/sys/types.h" 2 3 4





typedef __blksize_t blksize_t;
# 205 "/usr/include/sys/types.h" 3 4
typedef __blkcnt64_t blkcnt_t;



typedef __fsblkcnt64_t fsblkcnt_t;



typedef __fsfilcnt64_t fsfilcnt_t;





typedef __blkcnt64_t blkcnt64_t;
typedef __fsblkcnt64_t fsblkcnt64_t;
typedef __fsfilcnt64_t fsfilcnt64_t;





# 1 "/usr/include/bits/pthreadtypes.h" 1 3 4
# 23 "/usr/include/bits/pthreadtypes.h" 3 4
# 1 "/usr/include/bits/thread-shared-types.h" 1 3 4
# 44 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/pthreadtypes-arch.h" 1 3 4
# 21 "/usr/include/bits/pthreadtypes-arch.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 22 "/usr/include/bits/pthreadtypes-arch.h" 2 3 4
# 45 "/usr/include/bits/thread-shared-types.h" 2 3 4




typedef struct __pthread_internal_list
{
  struct __pthread_internal_list *__prev;
  struct __pthread_internal_list *__next;
} __pthread_list_t;

typedef struct __pthread_internal_slist
{
  struct __pthread_internal_slist *__next;
} __pthread_slist_t;
# 74 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/struct_mutex.h" 1 3 4
# 22 "/usr/include/bits/struct_mutex.h" 3 4
struct __pthread_mutex_s
{
  int __lock;
  unsigned int __count;
  int __owner;

  unsigned int __nusers;



  int __kind;

  short __spins;
  short __elision;
  __pthread_list_t __list;
# 53 "/usr/include/bits/struct_mutex.h" 3 4
};
# 75 "/usr/include/bits/thread-shared-types.h" 2 3 4
# 87 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/struct_rwlock.h" 1 3 4
# 23 "/usr/include/bits/struct_rwlock.h" 3 4
struct __pthread_rwlock_arch_t
{
  unsigned int __readers;
  unsigned int __writers;
  unsigned int __wrphase_futex;
  unsigned int __writers_futex;
  unsigned int __pad3;
  unsigned int __pad4;

  int __cur_writer;
  int __shared;
  signed char __rwelision;




  unsigned char __pad1[7];


  unsigned long int __pad2;


  unsigned int __flags;
# 55 "/usr/include/bits/struct_rwlock.h" 3 4
};
# 88 "/usr/include/bits/thread-shared-types.h" 2 3 4




struct __pthread_cond_s
{
  __extension__ union
  {
    __extension__ unsigned long long int __wseq;
    struct
    {
      unsigned int __low;
      unsigned int __high;
    } __wseq32;
  };
  __extension__ union
  {
    __extension__ unsigned long long int __g1_start;
    struct
    {
      unsigned int __low;
      unsigned int __high;
    } __g1_start32;
  };
  unsigned int __g_refs[2] ;
  unsigned int __g_size[2];
  unsigned int __g1_orig_size;
  unsigned int __wrefs;
  unsigned int __g_signals[2];
};

typedef unsigned int __tss_t;
typedef unsigned long int __thrd_t;

typedef struct
{
  int __data ;
} __once_flag;
# 24 "/usr/include/bits/pthreadtypes.h" 2 3 4



typedef unsigned long int pthread_t;




typedef union
{
  char __size[4];
  int __align;
} pthread_mutexattr_t;




typedef union
{
  char __size[4];
  int __align;
} pthread_condattr_t;



typedef unsigned int pthread_key_t;



typedef int pthread_once_t;


union pthread_attr_t
{
  char __size[56];
  long int __align;
};

typedef union pthread_attr_t pthread_attr_t;




typedef union
{
  struct __pthread_mutex_s __data;
  char __size[40];
  long int __align;
} pthread_mutex_t;


typedef union
{
  struct __pthread_cond_s __data;
  char __size[48];
  __extension__ long long int __align;
} pthread_cond_t;





typedef union
{
  struct __pthread_rwlock_arch_t __data;
  char __size[56];
  long int __align;
} pthread_rwlock_t;

typedef union
{
  char __size[8];
  long int __align;
} pthread_rwlockattr_t;





typedef volatile int pthread_spinlock_t;




typedef union
{
  char __size[32];
  long int __align;
} pthread_barrier_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_barrierattr_t;
# 228 "/usr/include/sys/types.h" 2 3 4



# 395 "/usr/include/stdlib.h" 2 3 4






extern long int random (void) __attribute__ ((__nothrow__ , __leaf__));


extern void srandom (unsigned int __seed) __attribute__ ((__nothrow__ , __leaf__));





extern char *initstate (unsigned int __seed, char *__statebuf,
   size_t __statelen) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



extern char *setstate (char *__statebuf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







struct random_data
  {
    int32_t *fptr;
    int32_t *rptr;
    int32_t *state;
    int rand_type;
    int rand_deg;
    int rand_sep;
    int32_t *end_ptr;
  };

extern int random_r (struct random_data *__restrict __buf,
       int32_t *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern int srandom_r (unsigned int __seed, struct random_data *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

extern int initstate_r (unsigned int __seed, char *__restrict __statebuf,
   size_t __statelen,
   struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));

extern int setstate_r (char *__restrict __statebuf,
         struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern int rand (void) __attribute__ ((__nothrow__ , __leaf__));

extern void srand (unsigned int __seed) __attribute__ ((__nothrow__ , __leaf__));



extern int rand_r (unsigned int *__seed) __attribute__ ((__nothrow__ , __leaf__));







extern double drand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern double erand48 (unsigned short int __xsubi[3]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int lrand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern long int nrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int mrand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern long int jrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern void srand48 (long int __seedval) __attribute__ ((__nothrow__ , __leaf__));
extern unsigned short int *seed48 (unsigned short int __seed16v[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
extern void lcong48 (unsigned short int __param[7]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





struct drand48_data
  {
    unsigned short int __x[3];
    unsigned short int __old_x[3];
    unsigned short int __c;
    unsigned short int __init;
    __extension__ unsigned long long int __a;

  };


extern int drand48_r (struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int erand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int lrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int nrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int mrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int jrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int srand48_r (long int __seedval, struct drand48_data *__buffer)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

extern int seed48_r (unsigned short int __seed16v[3],
       struct drand48_data *__buffer) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern int lcong48_r (unsigned short int __param[7],
        struct drand48_data *__buffer)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern void *malloc (size_t __size) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__))
     __attribute__ ((__alloc_size__ (1))) ;

extern void *calloc (size_t __nmemb, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__alloc_size__ (1, 2))) ;






extern void *realloc (void *__ptr, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__warn_unused_result__)) __attribute__ ((__alloc_size__ (2)));







extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__warn_unused_result__))
     __attribute__ ((__alloc_size__ (2, 3)));



extern void free (void *__ptr) __attribute__ ((__nothrow__ , __leaf__));


# 1 "/usr/include/alloca.h" 1 3 4
# 24 "/usr/include/alloca.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 25 "/usr/include/alloca.h" 2 3 4







extern void *alloca (size_t __size) __attribute__ ((__nothrow__ , __leaf__));






# 569 "/usr/include/stdlib.h" 2 3 4





extern void *valloc (size_t __size) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__))
     __attribute__ ((__alloc_size__ (1))) ;




extern int posix_memalign (void **__memptr, size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;




extern void *aligned_alloc (size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__alloc_size__ (2))) ;



extern void abort (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));



extern int atexit (void (*__func) (void)) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







extern int at_quick_exit (void (*__func) (void)) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int on_exit (void (*__func) (int __status, void *__arg), void *__arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern void exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));





extern void quick_exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));





extern void _Exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));




extern char *getenv (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;




extern char *secure_getenv (const char *__name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;






extern int putenv (char *__string) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int setenv (const char *__name, const char *__value, int __replace)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));


extern int unsetenv (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int clearenv (void) __attribute__ ((__nothrow__ , __leaf__));
# 675 "/usr/include/stdlib.h" 3 4
extern char *mktemp (char *__template) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 691 "/usr/include/stdlib.h" 3 4
extern int mkstemp (char *__template) __asm__ ("" "mkstemp64")
     __attribute__ ((__nonnull__ (1))) ;





extern int mkstemp64 (char *__template) __attribute__ ((__nonnull__ (1))) ;
# 713 "/usr/include/stdlib.h" 3 4
extern int mkstemps (char *__template, int __suffixlen) __asm__ ("" "mkstemps64")
                     __attribute__ ((__nonnull__ (1))) ;





extern int mkstemps64 (char *__template, int __suffixlen)
     __attribute__ ((__nonnull__ (1))) ;
# 731 "/usr/include/stdlib.h" 3 4
extern char *mkdtemp (char *__template) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 745 "/usr/include/stdlib.h" 3 4
extern int mkostemp (char *__template, int __flags) __asm__ ("" "mkostemp64")
     __attribute__ ((__nonnull__ (1))) ;





extern int mkostemp64 (char *__template, int __flags) __attribute__ ((__nonnull__ (1))) ;
# 766 "/usr/include/stdlib.h" 3 4
extern int mkostemps (char *__template, int __suffixlen, int __flags) __asm__ ("" "mkostemps64")

     __attribute__ ((__nonnull__ (1))) ;





extern int mkostemps64 (char *__template, int __suffixlen, int __flags)
     __attribute__ ((__nonnull__ (1))) ;
# 784 "/usr/include/stdlib.h" 3 4
extern int system (const char *__command) ;





extern char *canonicalize_file_name (const char *__name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 800 "/usr/include/stdlib.h" 3 4
extern char *realpath (const char *__restrict __name,
         char *__restrict __resolved) __attribute__ ((__nothrow__ , __leaf__)) ;






typedef int (*__compar_fn_t) (const void *, const void *);


typedef __compar_fn_t comparison_fn_t;



typedef int (*__compar_d_fn_t) (const void *, const void *, void *);




extern void *bsearch (const void *__key, const void *__base,
        size_t __nmemb, size_t __size, __compar_fn_t __compar)
     __attribute__ ((__nonnull__ (1, 2, 5))) ;







extern void qsort (void *__base, size_t __nmemb, size_t __size,
     __compar_fn_t __compar) __attribute__ ((__nonnull__ (1, 4)));

extern void qsort_r (void *__base, size_t __nmemb, size_t __size,
       __compar_d_fn_t __compar, void *__arg)
  __attribute__ ((__nonnull__ (1, 4)));




extern int abs (int __x) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
extern long int labs (long int __x) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;


__extension__ extern long long int llabs (long long int __x)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;






extern div_t div (int __numer, int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
extern ldiv_t ldiv (long int __numer, long int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;


__extension__ extern lldiv_t lldiv (long long int __numer,
        long long int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
# 872 "/usr/include/stdlib.h" 3 4
extern char *ecvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *fcvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *gcvt (double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3))) ;




extern char *qecvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qfcvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qgcvt (long double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3))) ;




extern int ecvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int fcvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));

extern int qecvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int qfcvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));





extern int mblen (const char *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__));


extern int mbtowc (wchar_t *__restrict __pwc,
     const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__ , __leaf__));


extern int wctomb (char *__s, wchar_t __wchar) __attribute__ ((__nothrow__ , __leaf__));



extern size_t mbstowcs (wchar_t *__restrict __pwcs,
   const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__read_only__, 2)));

extern size_t wcstombs (char *__restrict __s,
   const wchar_t *__restrict __pwcs, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__))
  __attribute__ ((__access__ (__write_only__, 1, 3))) __attribute__ ((__access__ (__read_only__, 2)));






extern int rpmatch (const char *__response) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 958 "/usr/include/stdlib.h" 3 4
extern int getsubopt (char **__restrict __optionp,
        char *const *__restrict __tokens,
        char **__restrict __valuep)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2, 3))) ;







extern int posix_openpt (int __oflag) ;







extern int grantpt (int __fd) __attribute__ ((__nothrow__ , __leaf__));



extern int unlockpt (int __fd) __attribute__ ((__nothrow__ , __leaf__));




extern char *ptsname (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int ptsname_r (int __fd, char *__buf, size_t __buflen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 2, 3)));


extern int getpt (void);






extern int getloadavg (double __loadavg[], int __nelem)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 1014 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/bits/stdlib-float.h" 1 3 4
# 1015 "/usr/include/stdlib.h" 2 3 4
# 1026 "/usr/include/stdlib.h" 3 4

# 23 "./include/grub/util/misc.h" 2


# 1 "/usr/include/setjmp.h" 1 3 4
# 27 "/usr/include/setjmp.h" 3 4


# 1 "/usr/include/bits/setjmp.h" 1 3 4
# 26 "/usr/include/bits/setjmp.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 27 "/usr/include/bits/setjmp.h" 2 3 4




typedef long int __jmp_buf[8];
# 30 "/usr/include/setjmp.h" 2 3 4



struct __jmp_buf_tag
  {




    __jmp_buf __jmpbuf;
    int __mask_was_saved;
    __sigset_t __saved_mask;
  };


typedef struct __jmp_buf_tag jmp_buf[1];



extern int setjmp (jmp_buf __env) __attribute__ ((__nothrow__));




extern int __sigsetjmp (struct __jmp_buf_tag __env[1], int __savemask) __attribute__ ((__nothrow__));



extern int _setjmp (struct __jmp_buf_tag __env[1]) __attribute__ ((__nothrow__));
# 67 "/usr/include/setjmp.h" 3 4
extern void longjmp (struct __jmp_buf_tag __env[1], int __val)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));





extern void _longjmp (struct __jmp_buf_tag __env[1], int __val)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));







typedef struct __jmp_buf_tag sigjmp_buf[1];
# 93 "/usr/include/setjmp.h" 3 4
extern void siglongjmp (sigjmp_buf __env, int __val)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));
# 103 "/usr/include/setjmp.h" 3 4

# 26 "./include/grub/util/misc.h" 2
# 1 "/usr/include/unistd.h" 1 3 4
# 27 "/usr/include/unistd.h" 3 4

# 202 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/posix_opt.h" 1 3 4
# 203 "/usr/include/unistd.h" 2 3 4



# 1 "/usr/include/bits/environments.h" 1 3 4
# 22 "/usr/include/bits/environments.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 23 "/usr/include/bits/environments.h" 2 3 4
# 207 "/usr/include/unistd.h" 2 3 4
# 226 "/usr/include/unistd.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 227 "/usr/include/unistd.h" 2 3 4
# 267 "/usr/include/unistd.h" 3 4
typedef __intptr_t intptr_t;






typedef __socklen_t socklen_t;
# 287 "/usr/include/unistd.h" 3 4
extern int access (const char *__name, int __type) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int euidaccess (const char *__name, int __type)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int eaccess (const char *__name, int __type)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int faccessat (int __fd, const char *__file, int __type, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;
# 337 "/usr/include/unistd.h" 3 4
extern __off64_t lseek (int __fd, __off64_t __offset, int __whence) __asm__ ("" "lseek64") __attribute__ ((__nothrow__ , __leaf__))

             ;





extern __off64_t lseek64 (int __fd, __off64_t __offset, int __whence)
     __attribute__ ((__nothrow__ , __leaf__));






extern int close (int __fd);






extern ssize_t read (int __fd, void *__buf, size_t __nbytes)
    __attribute__ ((__access__ (__write_only__, 2, 3)));





extern ssize_t write (int __fd, const void *__buf, size_t __n)
    __attribute__ ((__access__ (__read_only__, 2, 3)));
# 393 "/usr/include/unistd.h" 3 4
extern ssize_t pread (int __fd, void *__buf, size_t __nbytes, __off64_t __offset) __asm__ ("" "pread64")


    __attribute__ ((__access__ (__write_only__, 2, 3)));
extern ssize_t pwrite (int __fd, const void *__buf, size_t __nbytes, __off64_t __offset) __asm__ ("" "pwrite64")


    __attribute__ ((__access__ (__read_only__, 2, 3)));
# 411 "/usr/include/unistd.h" 3 4
extern ssize_t pread64 (int __fd, void *__buf, size_t __nbytes,
   __off64_t __offset)
    __attribute__ ((__access__ (__write_only__, 2, 3)));


extern ssize_t pwrite64 (int __fd, const void *__buf, size_t __n,
    __off64_t __offset)
    __attribute__ ((__access__ (__read_only__, 2, 3)));







extern int pipe (int __pipedes[2]) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int pipe2 (int __pipedes[2], int __flags) __attribute__ ((__nothrow__ , __leaf__)) ;
# 441 "/usr/include/unistd.h" 3 4
extern unsigned int alarm (unsigned int __seconds) __attribute__ ((__nothrow__ , __leaf__));
# 453 "/usr/include/unistd.h" 3 4
extern unsigned int sleep (unsigned int __seconds);







extern __useconds_t ualarm (__useconds_t __value, __useconds_t __interval)
     __attribute__ ((__nothrow__ , __leaf__));






extern int usleep (__useconds_t __useconds);
# 478 "/usr/include/unistd.h" 3 4
extern int pause (void);



extern int chown (const char *__file, __uid_t __owner, __gid_t __group)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern int fchown (int __fd, __uid_t __owner, __gid_t __group) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int lchown (const char *__file, __uid_t __owner, __gid_t __group)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;






extern int fchownat (int __fd, const char *__file, __uid_t __owner,
       __gid_t __group, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;



extern int chdir (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern int fchdir (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;
# 520 "/usr/include/unistd.h" 3 4
extern char *getcwd (char *__buf, size_t __size) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 1, 2)));





extern char *get_current_dir_name (void) __attribute__ ((__nothrow__ , __leaf__));







extern char *getwd (char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__deprecated__))
    __attribute__ ((__access__ (__write_only__, 1)));




extern int dup (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;


extern int dup2 (int __fd, int __fd2) __attribute__ ((__nothrow__ , __leaf__));




extern int dup3 (int __fd, int __fd2, int __flags) __attribute__ ((__nothrow__ , __leaf__));



extern char **__environ;

extern char **environ;





extern int execve (const char *__path, char *const __argv[],
     char *const __envp[]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int fexecve (int __fd, char *const __argv[], char *const __envp[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));




extern int execv (const char *__path, char *const __argv[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execle (const char *__path, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execl (const char *__path, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execvp (const char *__file, char *const __argv[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int execlp (const char *__file, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int execvpe (const char *__file, char *const __argv[],
      char *const __envp[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern int nice (int __inc) __attribute__ ((__nothrow__ , __leaf__)) ;




extern void _exit (int __status) __attribute__ ((__noreturn__));





# 1 "/usr/include/bits/confname.h" 1 3 4
# 24 "/usr/include/bits/confname.h" 3 4
enum
  {
    _PC_LINK_MAX,

    _PC_MAX_CANON,

    _PC_MAX_INPUT,

    _PC_NAME_MAX,

    _PC_PATH_MAX,

    _PC_PIPE_BUF,

    _PC_CHOWN_RESTRICTED,

    _PC_NO_TRUNC,

    _PC_VDISABLE,

    _PC_SYNC_IO,

    _PC_ASYNC_IO,

    _PC_PRIO_IO,

    _PC_SOCK_MAXBUF,

    _PC_FILESIZEBITS,

    _PC_REC_INCR_XFER_SIZE,

    _PC_REC_MAX_XFER_SIZE,

    _PC_REC_MIN_XFER_SIZE,

    _PC_REC_XFER_ALIGN,

    _PC_ALLOC_SIZE_MIN,

    _PC_SYMLINK_MAX,

    _PC_2_SYMLINKS

  };


enum
  {
    _SC_ARG_MAX,

    _SC_CHILD_MAX,

    _SC_CLK_TCK,

    _SC_NGROUPS_MAX,

    _SC_OPEN_MAX,

    _SC_STREAM_MAX,

    _SC_TZNAME_MAX,

    _SC_JOB_CONTROL,

    _SC_SAVED_IDS,

    _SC_REALTIME_SIGNALS,

    _SC_PRIORITY_SCHEDULING,

    _SC_TIMERS,

    _SC_ASYNCHRONOUS_IO,

    _SC_PRIORITIZED_IO,

    _SC_SYNCHRONIZED_IO,

    _SC_FSYNC,

    _SC_MAPPED_FILES,

    _SC_MEMLOCK,

    _SC_MEMLOCK_RANGE,

    _SC_MEMORY_PROTECTION,

    _SC_MESSAGE_PASSING,

    _SC_SEMAPHORES,

    _SC_SHARED_MEMORY_OBJECTS,

    _SC_AIO_LISTIO_MAX,

    _SC_AIO_MAX,

    _SC_AIO_PRIO_DELTA_MAX,

    _SC_DELAYTIMER_MAX,

    _SC_MQ_OPEN_MAX,

    _SC_MQ_PRIO_MAX,

    _SC_VERSION,

    _SC_PAGESIZE,


    _SC_RTSIG_MAX,

    _SC_SEM_NSEMS_MAX,

    _SC_SEM_VALUE_MAX,

    _SC_SIGQUEUE_MAX,

    _SC_TIMER_MAX,




    _SC_BC_BASE_MAX,

    _SC_BC_DIM_MAX,

    _SC_BC_SCALE_MAX,

    _SC_BC_STRING_MAX,

    _SC_COLL_WEIGHTS_MAX,

    _SC_EQUIV_CLASS_MAX,

    _SC_EXPR_NEST_MAX,

    _SC_LINE_MAX,

    _SC_RE_DUP_MAX,

    _SC_CHARCLASS_NAME_MAX,


    _SC_2_VERSION,

    _SC_2_C_BIND,

    _SC_2_C_DEV,

    _SC_2_FORT_DEV,

    _SC_2_FORT_RUN,

    _SC_2_SW_DEV,

    _SC_2_LOCALEDEF,


    _SC_PII,

    _SC_PII_XTI,

    _SC_PII_SOCKET,

    _SC_PII_INTERNET,

    _SC_PII_OSI,

    _SC_POLL,

    _SC_SELECT,

    _SC_UIO_MAXIOV,

    _SC_IOV_MAX = _SC_UIO_MAXIOV,

    _SC_PII_INTERNET_STREAM,

    _SC_PII_INTERNET_DGRAM,

    _SC_PII_OSI_COTS,

    _SC_PII_OSI_CLTS,

    _SC_PII_OSI_M,

    _SC_T_IOV_MAX,



    _SC_THREADS,

    _SC_THREAD_SAFE_FUNCTIONS,

    _SC_GETGR_R_SIZE_MAX,

    _SC_GETPW_R_SIZE_MAX,

    _SC_LOGIN_NAME_MAX,

    _SC_TTY_NAME_MAX,

    _SC_THREAD_DESTRUCTOR_ITERATIONS,

    _SC_THREAD_KEYS_MAX,

    _SC_THREAD_STACK_MIN,

    _SC_THREAD_THREADS_MAX,

    _SC_THREAD_ATTR_STACKADDR,

    _SC_THREAD_ATTR_STACKSIZE,

    _SC_THREAD_PRIORITY_SCHEDULING,

    _SC_THREAD_PRIO_INHERIT,

    _SC_THREAD_PRIO_PROTECT,

    _SC_THREAD_PROCESS_SHARED,


    _SC_NPROCESSORS_CONF,

    _SC_NPROCESSORS_ONLN,

    _SC_PHYS_PAGES,

    _SC_AVPHYS_PAGES,

    _SC_ATEXIT_MAX,

    _SC_PASS_MAX,


    _SC_XOPEN_VERSION,

    _SC_XOPEN_XCU_VERSION,

    _SC_XOPEN_UNIX,

    _SC_XOPEN_CRYPT,

    _SC_XOPEN_ENH_I18N,

    _SC_XOPEN_SHM,


    _SC_2_CHAR_TERM,

    _SC_2_C_VERSION,

    _SC_2_UPE,


    _SC_XOPEN_XPG2,

    _SC_XOPEN_XPG3,

    _SC_XOPEN_XPG4,


    _SC_CHAR_BIT,

    _SC_CHAR_MAX,

    _SC_CHAR_MIN,

    _SC_INT_MAX,

    _SC_INT_MIN,

    _SC_LONG_BIT,

    _SC_WORD_BIT,

    _SC_MB_LEN_MAX,

    _SC_NZERO,

    _SC_SSIZE_MAX,

    _SC_SCHAR_MAX,

    _SC_SCHAR_MIN,

    _SC_SHRT_MAX,

    _SC_SHRT_MIN,

    _SC_UCHAR_MAX,

    _SC_UINT_MAX,

    _SC_ULONG_MAX,

    _SC_USHRT_MAX,


    _SC_NL_ARGMAX,

    _SC_NL_LANGMAX,

    _SC_NL_MSGMAX,

    _SC_NL_NMAX,

    _SC_NL_SETMAX,

    _SC_NL_TEXTMAX,


    _SC_XBS5_ILP32_OFF32,

    _SC_XBS5_ILP32_OFFBIG,

    _SC_XBS5_LP64_OFF64,

    _SC_XBS5_LPBIG_OFFBIG,


    _SC_XOPEN_LEGACY,

    _SC_XOPEN_REALTIME,

    _SC_XOPEN_REALTIME_THREADS,


    _SC_ADVISORY_INFO,

    _SC_BARRIERS,

    _SC_BASE,

    _SC_C_LANG_SUPPORT,

    _SC_C_LANG_SUPPORT_R,

    _SC_CLOCK_SELECTION,

    _SC_CPUTIME,

    _SC_THREAD_CPUTIME,

    _SC_DEVICE_IO,

    _SC_DEVICE_SPECIFIC,

    _SC_DEVICE_SPECIFIC_R,

    _SC_FD_MGMT,

    _SC_FIFO,

    _SC_PIPE,

    _SC_FILE_ATTRIBUTES,

    _SC_FILE_LOCKING,

    _SC_FILE_SYSTEM,

    _SC_MONOTONIC_CLOCK,

    _SC_MULTI_PROCESS,

    _SC_SINGLE_PROCESS,

    _SC_NETWORKING,

    _SC_READER_WRITER_LOCKS,

    _SC_SPIN_LOCKS,

    _SC_REGEXP,

    _SC_REGEX_VERSION,

    _SC_SHELL,

    _SC_SIGNALS,

    _SC_SPAWN,

    _SC_SPORADIC_SERVER,

    _SC_THREAD_SPORADIC_SERVER,

    _SC_SYSTEM_DATABASE,

    _SC_SYSTEM_DATABASE_R,

    _SC_TIMEOUTS,

    _SC_TYPED_MEMORY_OBJECTS,

    _SC_USER_GROUPS,

    _SC_USER_GROUPS_R,

    _SC_2_PBS,

    _SC_2_PBS_ACCOUNTING,

    _SC_2_PBS_LOCATE,

    _SC_2_PBS_MESSAGE,

    _SC_2_PBS_TRACK,

    _SC_SYMLOOP_MAX,

    _SC_STREAMS,

    _SC_2_PBS_CHECKPOINT,


    _SC_V6_ILP32_OFF32,

    _SC_V6_ILP32_OFFBIG,

    _SC_V6_LP64_OFF64,

    _SC_V6_LPBIG_OFFBIG,


    _SC_HOST_NAME_MAX,

    _SC_TRACE,

    _SC_TRACE_EVENT_FILTER,

    _SC_TRACE_INHERIT,

    _SC_TRACE_LOG,


    _SC_LEVEL1_ICACHE_SIZE,

    _SC_LEVEL1_ICACHE_ASSOC,

    _SC_LEVEL1_ICACHE_LINESIZE,

    _SC_LEVEL1_DCACHE_SIZE,

    _SC_LEVEL1_DCACHE_ASSOC,

    _SC_LEVEL1_DCACHE_LINESIZE,

    _SC_LEVEL2_CACHE_SIZE,

    _SC_LEVEL2_CACHE_ASSOC,

    _SC_LEVEL2_CACHE_LINESIZE,

    _SC_LEVEL3_CACHE_SIZE,

    _SC_LEVEL3_CACHE_ASSOC,

    _SC_LEVEL3_CACHE_LINESIZE,

    _SC_LEVEL4_CACHE_SIZE,

    _SC_LEVEL4_CACHE_ASSOC,

    _SC_LEVEL4_CACHE_LINESIZE,



    _SC_IPV6 = _SC_LEVEL1_ICACHE_SIZE + 50,

    _SC_RAW_SOCKETS,


    _SC_V7_ILP32_OFF32,

    _SC_V7_ILP32_OFFBIG,

    _SC_V7_LP64_OFF64,

    _SC_V7_LPBIG_OFFBIG,


    _SC_SS_REPL_MAX,


    _SC_TRACE_EVENT_NAME_MAX,

    _SC_TRACE_NAME_MAX,

    _SC_TRACE_SYS_MAX,

    _SC_TRACE_USER_EVENT_MAX,


    _SC_XOPEN_STREAMS,


    _SC_THREAD_ROBUST_PRIO_INHERIT,

    _SC_THREAD_ROBUST_PRIO_PROTECT

  };


enum
  {
    _CS_PATH,


    _CS_V6_WIDTH_RESTRICTED_ENVS,



    _CS_GNU_LIBC_VERSION,

    _CS_GNU_LIBPTHREAD_VERSION,


    _CS_V5_WIDTH_RESTRICTED_ENVS,



    _CS_V7_WIDTH_RESTRICTED_ENVS,



    _CS_LFS_CFLAGS = 1000,

    _CS_LFS_LDFLAGS,

    _CS_LFS_LIBS,

    _CS_LFS_LINTFLAGS,

    _CS_LFS64_CFLAGS,

    _CS_LFS64_LDFLAGS,

    _CS_LFS64_LIBS,

    _CS_LFS64_LINTFLAGS,


    _CS_XBS5_ILP32_OFF32_CFLAGS = 1100,

    _CS_XBS5_ILP32_OFF32_LDFLAGS,

    _CS_XBS5_ILP32_OFF32_LIBS,

    _CS_XBS5_ILP32_OFF32_LINTFLAGS,

    _CS_XBS5_ILP32_OFFBIG_CFLAGS,

    _CS_XBS5_ILP32_OFFBIG_LDFLAGS,

    _CS_XBS5_ILP32_OFFBIG_LIBS,

    _CS_XBS5_ILP32_OFFBIG_LINTFLAGS,

    _CS_XBS5_LP64_OFF64_CFLAGS,

    _CS_XBS5_LP64_OFF64_LDFLAGS,

    _CS_XBS5_LP64_OFF64_LIBS,

    _CS_XBS5_LP64_OFF64_LINTFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_CFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_LDFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_LIBS,

    _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS,


    _CS_POSIX_V6_ILP32_OFF32_CFLAGS,

    _CS_POSIX_V6_ILP32_OFF32_LDFLAGS,

    _CS_POSIX_V6_ILP32_OFF32_LIBS,

    _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_LIBS,

    _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS,

    _CS_POSIX_V6_LP64_OFF64_CFLAGS,

    _CS_POSIX_V6_LP64_OFF64_LDFLAGS,

    _CS_POSIX_V6_LP64_OFF64_LIBS,

    _CS_POSIX_V6_LP64_OFF64_LINTFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LIBS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS,


    _CS_POSIX_V7_ILP32_OFF32_CFLAGS,

    _CS_POSIX_V7_ILP32_OFF32_LDFLAGS,

    _CS_POSIX_V7_ILP32_OFF32_LIBS,

    _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_LIBS,

    _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS,

    _CS_POSIX_V7_LP64_OFF64_CFLAGS,

    _CS_POSIX_V7_LP64_OFF64_LDFLAGS,

    _CS_POSIX_V7_LP64_OFF64_LIBS,

    _CS_POSIX_V7_LP64_OFF64_LINTFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LIBS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS,


    _CS_V6_ENV,

    _CS_V7_ENV

  };
# 621 "/usr/include/unistd.h" 2 3 4


extern long int pathconf (const char *__path, int __name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int fpathconf (int __fd, int __name) __attribute__ ((__nothrow__ , __leaf__));


extern long int sysconf (int __name) __attribute__ ((__nothrow__ , __leaf__));



extern size_t confstr (int __name, char *__buf, size_t __len) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 2, 3)));




extern __pid_t getpid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t getppid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t getpgrp (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t __getpgid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));

extern __pid_t getpgid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));






extern int setpgid (__pid_t __pid, __pid_t __pgid) __attribute__ ((__nothrow__ , __leaf__));
# 672 "/usr/include/unistd.h" 3 4
extern int setpgrp (void) __attribute__ ((__nothrow__ , __leaf__));






extern __pid_t setsid (void) __attribute__ ((__nothrow__ , __leaf__));



extern __pid_t getsid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));



extern __uid_t getuid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __uid_t geteuid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __gid_t getgid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __gid_t getegid (void) __attribute__ ((__nothrow__ , __leaf__));




extern int getgroups (int __size, __gid_t __list[]) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 2, 1)));


extern int group_member (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__));






extern int setuid (__uid_t __uid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setreuid (__uid_t __ruid, __uid_t __euid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int seteuid (__uid_t __uid) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int setgid (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setregid (__gid_t __rgid, __gid_t __egid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setegid (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__)) ;





extern int getresuid (__uid_t *__ruid, __uid_t *__euid, __uid_t *__suid)
     __attribute__ ((__nothrow__ , __leaf__));



extern int getresgid (__gid_t *__rgid, __gid_t *__egid, __gid_t *__sgid)
     __attribute__ ((__nothrow__ , __leaf__));



extern int setresuid (__uid_t __ruid, __uid_t __euid, __uid_t __suid)
     __attribute__ ((__nothrow__ , __leaf__)) ;



extern int setresgid (__gid_t __rgid, __gid_t __egid, __gid_t __sgid)
     __attribute__ ((__nothrow__ , __leaf__)) ;






extern __pid_t fork (void) __attribute__ ((__nothrow__));







extern __pid_t vfork (void) __attribute__ ((__nothrow__ , __leaf__));





extern char *ttyname (int __fd) __attribute__ ((__nothrow__ , __leaf__));



extern int ttyname_r (int __fd, char *__buf, size_t __buflen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 2, 3)));



extern int isatty (int __fd) __attribute__ ((__nothrow__ , __leaf__));




extern int ttyslot (void) __attribute__ ((__nothrow__ , __leaf__));




extern int link (const char *__from, const char *__to)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) ;




extern int linkat (int __fromfd, const char *__from, int __tofd,
     const char *__to, int __flags)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4))) ;




extern int symlink (const char *__from, const char *__to)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) ;




extern ssize_t readlink (const char *__restrict __path,
    char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) __attribute__ ((__access__ (__write_only__, 2, 3)));





extern int symlinkat (const char *__from, int __tofd,
        const char *__to) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3))) ;


extern ssize_t readlinkat (int __fd, const char *__restrict __path,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3))) __attribute__ ((__access__ (__read_only__, 3, 4)));



extern int unlink (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int unlinkat (int __fd, const char *__name, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



extern int rmdir (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern __pid_t tcgetpgrp (int __fd) __attribute__ ((__nothrow__ , __leaf__));


extern int tcsetpgrp (int __fd, __pid_t __pgrp_id) __attribute__ ((__nothrow__ , __leaf__));






extern char *getlogin (void);







extern int getlogin_r (char *__name, size_t __name_len) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));




extern int setlogin (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







# 1 "/usr/include/bits/getopt_posix.h" 1 3 4
# 27 "/usr/include/bits/getopt_posix.h" 3 4
# 1 "/usr/include/bits/getopt_core.h" 1 3 4
# 28 "/usr/include/bits/getopt_core.h" 3 4








extern char *optarg;
# 50 "/usr/include/bits/getopt_core.h" 3 4
extern int optind;




extern int opterr;



extern int optopt;
# 91 "/usr/include/bits/getopt_core.h" 3 4
extern int getopt (int ___argc, char *const *___argv, const char *__shortopts)
       __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));


# 28 "/usr/include/bits/getopt_posix.h" 2 3 4


# 49 "/usr/include/bits/getopt_posix.h" 3 4

# 884 "/usr/include/unistd.h" 2 3 4







extern int gethostname (char *__name, size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));






extern int sethostname (const char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__read_only__, 1, 2)));



extern int sethostid (long int __id) __attribute__ ((__nothrow__ , __leaf__)) ;





extern int getdomainname (char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__write_only__, 1, 2)));
extern int setdomainname (const char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__read_only__, 1, 2)));




extern int vhangup (void) __attribute__ ((__nothrow__ , __leaf__));


extern int revoke (const char *__file) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;







extern int profil (unsigned short int *__sample_buffer, size_t __size,
     size_t __offset, unsigned int __scale)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int acct (const char *__name) __attribute__ ((__nothrow__ , __leaf__));



extern char *getusershell (void) __attribute__ ((__nothrow__ , __leaf__));
extern void endusershell (void) __attribute__ ((__nothrow__ , __leaf__));
extern void setusershell (void) __attribute__ ((__nothrow__ , __leaf__));





extern int daemon (int __nochdir, int __noclose) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int chroot (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern char *getpass (const char *__prompt) __attribute__ ((__nonnull__ (1)));







extern int fsync (int __fd);





extern int syncfs (int __fd) __attribute__ ((__nothrow__ , __leaf__));






extern long int gethostid (void);


extern void sync (void) __attribute__ ((__nothrow__ , __leaf__));





extern int getpagesize (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));




extern int getdtablesize (void) __attribute__ ((__nothrow__ , __leaf__));
# 1009 "/usr/include/unistd.h" 3 4
extern int truncate (const char *__file, __off64_t __length) __asm__ ("" "truncate64") __attribute__ ((__nothrow__ , __leaf__))

                  __attribute__ ((__nonnull__ (1))) ;





extern int truncate64 (const char *__file, __off64_t __length)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 1031 "/usr/include/unistd.h" 3 4
extern int ftruncate (int __fd, __off64_t __length) __asm__ ("" "ftruncate64") __attribute__ ((__nothrow__ , __leaf__))
                        ;





extern int ftruncate64 (int __fd, __off64_t __length) __attribute__ ((__nothrow__ , __leaf__)) ;
# 1049 "/usr/include/unistd.h" 3 4
extern int brk (void *__addr) __attribute__ ((__nothrow__ , __leaf__)) ;





extern void *sbrk (intptr_t __delta) __attribute__ ((__nothrow__ , __leaf__));
# 1070 "/usr/include/unistd.h" 3 4
extern long int syscall (long int __sysno, ...) __attribute__ ((__nothrow__ , __leaf__));
# 1096 "/usr/include/unistd.h" 3 4
extern int lockf (int __fd, int __cmd, __off64_t __len) __asm__ ("" "lockf64")
                       ;





extern int lockf64 (int __fd, int __cmd, __off64_t __len) ;
# 1121 "/usr/include/unistd.h" 3 4
ssize_t copy_file_range (int __infd, __off64_t *__pinoff,
    int __outfd, __off64_t *__poutoff,
    size_t __length, unsigned int __flags);





extern int fdatasync (int __fildes);
# 1138 "/usr/include/unistd.h" 3 4
extern char *crypt (const char *__key, const char *__salt)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));







extern void swab (const void *__restrict __from, void *__restrict __to,
    ssize_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)))
    __attribute__ ((__access__ (__read_only__, 1, 3)))
    __attribute__ ((__access__ (__write_only__, 2, 3)));
# 1177 "/usr/include/unistd.h" 3 4
int getentropy (void *__buffer, size_t __length)
    __attribute__ ((__access__ (__write_only__, 1, 2)));
# 1187 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/unistd_ext.h" 1 3 4
# 34 "/usr/include/bits/unistd_ext.h" 3 4
extern __pid_t gettid (void) __attribute__ ((__nothrow__ , __leaf__));
# 1188 "/usr/include/unistd.h" 2 3 4


# 27 "./include/grub/util/misc.h" 2

# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 29 "./include/grub/util/misc.h" 2


# 1 "./include/grub/emu/misc.h" 1
# 32 "./include/grub/util/misc.h" 2


# 33 "./include/grub/util/misc.h"
char *grub_util_get_path (const char *dir, const char *file);
size_t grub_util_get_image_size (const char *path);
char *grub_util_read_image (const char *path);
void grub_util_load_image (const char *path, char *buf);
void grub_util_write_image (const char *img, size_t size, FILE *out,
       const char *name);
void grub_util_write_image_at (const void *img, size_t size, off_t offset,
          FILE *out, const char *name);

char *make_system_path_relative_to_its_root (const char *path);

char *grub_canonicalize_file_name (const char *path);

void grub_util_init_nls (void);

void grub_util_host_init (int *argc, char ***argv);

int grub_qsort_strcmp (const void *, const void *);
# 32 "./include/grub/emu/misc.h" 2

extern int verbosity;
extern const char *program_name;

void grub_init_all (void);
void grub_fini_all (void);

void grub_find_zpool_from_dir (const char *dir,
          char **poolname, char **poolfs);

char *grub_make_system_path_relative_to_its_root (const char *path)
 __attribute__ ((warn_unused_result));
int
grub_util_device_is_mapped (const char *dev);




void * xcalloc (grub_size_t nmemb, grub_size_t size) __attribute__ ((warn_unused_result));
void * xmalloc (grub_size_t size) __attribute__ ((warn_unused_result));
void * xrealloc (void *ptr, grub_size_t size) __attribute__ ((warn_unused_result));
char * xstrdup (const char *str) __attribute__ ((warn_unused_result));
char * xasprintf (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2))) __attribute__ ((warn_unused_result));

void grub_util_warn (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));
void grub_util_info (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));
void grub_util_error (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2), noreturn));

grub_uint64_t grub_util_get_cpu_time_ms (void);


int grub_device_mapper_supported (void);





FILE *
grub_util_fopen (const char *path, const char *mode);


int grub_util_file_sync (FILE *f);
# 23 "util/grub-fstest.c" 2


# 1 "./include/grub/device.h" 1
# 26 "./include/grub/device.h"
struct grub_disk;
struct grub_net;

struct grub_device
{
  struct grub_disk *disk;
  struct grub_net *net;
};
typedef struct grub_device *grub_device_t;

typedef int (*grub_device_iterate_hook_t) (const char *name, void *data);

grub_device_t grub_device_open (const char *name);
grub_err_t grub_device_close (grub_device_t device);
int grub_device_iterate (grub_device_iterate_hook_t hook,
          void *hook_data);
# 26 "util/grub-fstest.c" 2
# 1 "./include/grub/disk.h" 1
# 22 "./include/grub/disk.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/disk.h" 2






# 1 "./include/grub/mm.h" 1
# 25 "./include/grub/mm.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 26 "./include/grub/mm.h" 2





void grub_mm_init_region (void *addr, grub_size_t size);
void *grub_calloc (grub_size_t nmemb, grub_size_t size);
void *grub_malloc (grub_size_t size);
void *grub_zalloc (grub_size_t size);
void grub_free (void *ptr);
void *grub_realloc (void *ptr, grub_size_t size);

void *grub_memalign (grub_size_t align, grub_size_t size);


void grub_mm_check_real (const char *file, int line);
# 30 "./include/grub/disk.h" 2



enum grub_disk_dev_id
  {
    GRUB_DISK_DEVICE_BIOSDISK_ID,
    GRUB_DISK_DEVICE_OFDISK_ID,
    GRUB_DISK_DEVICE_LOOPBACK_ID,
    GRUB_DISK_DEVICE_EFIDISK_ID,
    GRUB_DISK_DEVICE_DISKFILTER_ID,
    GRUB_DISK_DEVICE_HOST_ID,
    GRUB_DISK_DEVICE_ATA_ID,
    GRUB_DISK_DEVICE_MEMDISK_ID,
    GRUB_DISK_DEVICE_NAND_ID,
    GRUB_DISK_DEVICE_SCSI_ID,
    GRUB_DISK_DEVICE_CRYPTODISK_ID,
    GRUB_DISK_DEVICE_ARCDISK_ID,
    GRUB_DISK_DEVICE_HOSTDISK_ID,
    GRUB_DISK_DEVICE_PROCFS_ID,
    GRUB_DISK_DEVICE_CBFSDISK_ID,
    GRUB_DISK_DEVICE_UBOOTDISK_ID,
    GRUB_DISK_DEVICE_XEN,
    GRUB_DISK_DEVICE_OBDISK_ID,
  };

struct grub_disk;

struct grub_disk_memberlist;


typedef enum
  {
    GRUB_DISK_PULL_NONE,
    GRUB_DISK_PULL_REMOVABLE,
    GRUB_DISK_PULL_RESCAN,
    GRUB_DISK_PULL_MAX
  } grub_disk_pull_t;

typedef int (*grub_disk_dev_iterate_hook_t) (const char *name, void *data);


struct grub_disk_dev
{

  const char *name;


  enum grub_disk_dev_id id;


  int (*disk_iterate) (grub_disk_dev_iterate_hook_t hook, void *hook_data,
    grub_disk_pull_t pull);


  grub_err_t (*disk_open) (const char *name, struct grub_disk *disk);


  void (*disk_close) (struct grub_disk *disk);


  grub_err_t (*disk_read) (struct grub_disk *disk, grub_disk_addr_t sector,
        grub_size_t size, char *buf);


  grub_err_t (*disk_write) (struct grub_disk *disk, grub_disk_addr_t sector,
         grub_size_t size, const char *buf);


  struct grub_disk_memberlist *(*disk_memberlist) (struct grub_disk *disk);
  const char * (*disk_raidname) (struct grub_disk *disk);



  struct grub_disk_dev *next;
};
typedef struct grub_disk_dev *grub_disk_dev_t;

extern grub_disk_dev_t grub_disk_dev_list;

struct grub_partition;

typedef void (*grub_disk_read_hook_t) (grub_disk_addr_t sector,
           unsigned offset, unsigned length,
           void *data);


struct grub_disk
{

  const char *name;


  grub_disk_dev_t dev;


  grub_uint64_t total_sectors;


  unsigned int log_sector_size;


  unsigned int max_agglomerate;


  unsigned long id;


  struct grub_partition *partition;



  grub_disk_read_hook_t read_hook;


  void *read_hook_data;


  void *data;
};
typedef struct grub_disk *grub_disk_t;


struct grub_disk_memberlist
{
  grub_disk_t disk;
  struct grub_disk_memberlist *next;
};
typedef struct grub_disk_memberlist *grub_disk_memberlist_t;
# 178 "./include/grub/disk.h"
static inline grub_disk_addr_t
grub_disk_from_native_sector (grub_disk_t disk, grub_disk_addr_t sector)
{
  return sector << (disk->log_sector_size - 9);
}


void grub_disk_cache_invalidate_all (void);

void grub_disk_dev_register (grub_disk_dev_t dev);
void grub_disk_dev_unregister (grub_disk_dev_t dev);
static inline int
grub_disk_dev_iterate (grub_disk_dev_iterate_hook_t hook, void *hook_data)
{
  grub_disk_dev_t p;
  grub_disk_pull_t pull;

  for (pull = 0; pull < GRUB_DISK_PULL_MAX; pull++)
    for (p = grub_disk_dev_list; p; p = p->next)
      if (p->disk_iterate && (p->disk_iterate) (hook, hook_data, pull))
 return 1;

  return 0;
}

grub_disk_t grub_disk_open (const char *name);
void grub_disk_close (grub_disk_t disk);
grub_err_t grub_disk_read (grub_disk_t disk,
     grub_disk_addr_t sector,
     grub_off_t offset,
     grub_size_t size,
     void *buf);
grub_err_t grub_disk_write (grub_disk_t disk,
       grub_disk_addr_t sector,
       grub_off_t offset,
       grub_size_t size,
       const void *buf);
extern grub_err_t (*grub_disk_write_weak) (grub_disk_t disk,
             grub_disk_addr_t sector,
             grub_off_t offset,
             grub_size_t size,
             const void *buf);


grub_uint64_t grub_disk_get_size (grub_disk_t disk);






extern void (* grub_disk_firmware_fini) (void);
extern int grub_disk_firmware_is_tainted;

static inline void
grub_stop_disk_firmware (void)
{

  grub_disk_firmware_is_tainted = 1;
  if (grub_disk_firmware_fini)
    {
      grub_disk_firmware_fini ();
      grub_disk_firmware_fini = 
# 240 "./include/grub/disk.h" 3 4
                               ((void *)0)
# 240 "./include/grub/disk.h"
                                   ;
    }
}


struct grub_disk_cache
{
  enum grub_disk_dev_id dev_id;
  unsigned long disk_id;
  grub_disk_addr_t sector;
  char *data;
  int lock;
};

extern struct grub_disk_cache grub_disk_cache_table[1021];


void grub_lvm_init (void);
void grub_ldm_init (void);
void grub_mdraid09_init (void);
void grub_mdraid1x_init (void);
void grub_diskfilter_init (void);
void grub_lvm_fini (void);
void grub_ldm_fini (void);
void grub_mdraid09_fini (void);
void grub_mdraid1x_fini (void);
void grub_diskfilter_fini (void);
# 27 "util/grub-fstest.c" 2
# 1 "./include/grub/file.h" 1
# 25 "./include/grub/file.h"
# 1 "./include/grub/fs.h" 1
# 27 "./include/grub/fs.h"
# 1 "./include/grub/list.h" 1
# 27 "./include/grub/list.h"
struct grub_list
{
  struct grub_list *next;
  struct grub_list **prev;
};
typedef struct grub_list *grub_list_t;

void grub_list_push (grub_list_t *head, grub_list_t item);
void grub_list_remove (grub_list_t item);





static inline void *
grub_bad_type_cast_real (int line, const char *file)
     __attribute__ ((__error__ ("bad type cast between incompatible grub types")));

static inline void *
grub_bad_type_cast_real (int line, const char *file)
{
  grub_fatal ("error:%s:%u: bad type cast between incompatible grub types",
       file, line);
}
# 65 "./include/grub/list.h"
struct grub_named_list
{
  struct grub_named_list *next;
  struct grub_named_list **prev;
  char *name;
};
typedef struct grub_named_list *grub_named_list_t;

void * grub_named_list_find (grub_named_list_t head,
       const char *name);
# 28 "./include/grub/fs.h" 2


# 1 "./include/grub/partition.h" 1
# 22 "./include/grub/partition.h"
# 1 "./include/grub/dl.h" 1
# 27 "./include/grub/dl.h"
# 1 "./include/grub/elf.h" 1
# 28 "./include/grub/elf.h"
typedef grub_uint16_t Elf32_Half;
typedef grub_uint16_t Elf64_Half;


typedef grub_uint32_t Elf32_Word;
typedef grub_int32_t Elf32_Sword;
typedef grub_uint32_t Elf64_Word;
typedef grub_int32_t Elf64_Sword;


typedef grub_uint64_t Elf32_Xword;
typedef grub_int64_t Elf32_Sxword;
typedef grub_uint64_t Elf64_Xword;
typedef grub_int64_t Elf64_Sxword;


typedef grub_uint32_t Elf32_Addr;
typedef grub_uint64_t Elf64_Addr;


typedef grub_uint32_t Elf32_Off;
typedef grub_uint64_t Elf64_Off;


typedef grub_uint16_t Elf32_Section;
typedef grub_uint16_t Elf64_Section;


typedef Elf32_Half Elf32_Versym;
typedef Elf64_Half Elf64_Versym;






typedef struct
{
  unsigned char e_ident[(16)];
  Elf32_Half e_type;
  Elf32_Half e_machine;
  Elf32_Word e_version;
  Elf32_Addr e_entry;
  Elf32_Off e_phoff;
  Elf32_Off e_shoff;
  Elf32_Word e_flags;
  Elf32_Half e_ehsize;
  Elf32_Half e_phentsize;
  Elf32_Half e_phnum;
  Elf32_Half e_shentsize;
  Elf32_Half e_shnum;
  Elf32_Half e_shstrndx;
} Elf32_Ehdr;

typedef struct
{
  unsigned char e_ident[(16)];
  Elf64_Half e_type;
  Elf64_Half e_machine;
  Elf64_Word e_version;
  Elf64_Addr e_entry;
  Elf64_Off e_phoff;
  Elf64_Off e_shoff;
  Elf64_Word e_flags;
  Elf64_Half e_ehsize;
  Elf64_Half e_phentsize;
  Elf64_Half e_phnum;
  Elf64_Half e_shentsize;
  Elf64_Half e_shnum;
  Elf64_Half e_shstrndx;
} Elf64_Ehdr;
# 266 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word sh_name;
  Elf32_Word sh_type;
  Elf32_Word sh_flags;
  Elf32_Addr sh_addr;
  Elf32_Off sh_offset;
  Elf32_Word sh_size;
  Elf32_Word sh_link;
  Elf32_Word sh_info;
  Elf32_Word sh_addralign;
  Elf32_Word sh_entsize;
} Elf32_Shdr;

typedef struct
{
  Elf64_Word sh_name;
  Elf64_Word sh_type;
  Elf64_Xword sh_flags;
  Elf64_Addr sh_addr;
  Elf64_Off sh_offset;
  Elf64_Xword sh_size;
  Elf64_Word sh_link;
  Elf64_Word sh_info;
  Elf64_Xword sh_addralign;
  Elf64_Xword sh_entsize;
} Elf64_Shdr;
# 365 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word st_name;
  Elf32_Addr st_value;
  Elf32_Word st_size;
  unsigned char st_info;
  unsigned char st_other;
  Elf32_Section st_shndx;
} Elf32_Sym;

typedef struct
{
  Elf64_Word st_name;
  unsigned char st_info;
  unsigned char st_other;
  Elf64_Section st_shndx;
  Elf64_Addr st_value;
  Elf64_Xword st_size;
} Elf64_Sym;




typedef struct
{
  Elf32_Half si_boundto;
  Elf32_Half si_flags;
} Elf32_Syminfo;

typedef struct
{
  Elf64_Half si_boundto;
  Elf64_Half si_flags;
} Elf64_Syminfo;
# 479 "./include/grub/elf.h"
typedef struct
{
  Elf32_Addr r_offset;
  Elf32_Word r_info;
} Elf32_Rel;






typedef struct
{
  Elf64_Addr r_offset;
  Elf64_Xword r_info;
} Elf64_Rel;



typedef struct
{
  Elf32_Addr r_offset;
  Elf32_Word r_info;
  Elf32_Sword r_addend;
} Elf32_Rela;

typedef struct
{
  Elf64_Addr r_offset;
  Elf64_Xword r_info;
  Elf64_Sxword r_addend;
} Elf64_Rela;
# 524 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word p_type;
  Elf32_Off p_offset;
  Elf32_Addr p_vaddr;
  Elf32_Addr p_paddr;
  Elf32_Word p_filesz;
  Elf32_Word p_memsz;
  Elf32_Word p_flags;
  Elf32_Word p_align;
} Elf32_Phdr;

typedef struct
{
  Elf64_Word p_type;
  Elf64_Word p_flags;
  Elf64_Off p_offset;
  Elf64_Addr p_vaddr;
  Elf64_Addr p_paddr;
  Elf64_Xword p_filesz;
  Elf64_Xword p_memsz;
  Elf64_Xword p_align;
} Elf64_Phdr;
# 603 "./include/grub/elf.h"
typedef struct
{
  Elf32_Sword d_tag;
  union
    {
      Elf32_Word d_val;
      Elf32_Addr d_ptr;
    } d_un;
} Elf32_Dyn;

typedef struct
{
  Elf64_Sxword d_tag;
  union
    {
      Elf64_Xword d_val;
      Elf64_Addr d_ptr;
    } d_un;
} Elf64_Dyn;
# 767 "./include/grub/elf.h"
typedef struct
{
  Elf32_Half vd_version;
  Elf32_Half vd_flags;
  Elf32_Half vd_ndx;
  Elf32_Half vd_cnt;
  Elf32_Word vd_hash;
  Elf32_Word vd_aux;
  Elf32_Word vd_next;

} Elf32_Verdef;

typedef struct
{
  Elf64_Half vd_version;
  Elf64_Half vd_flags;
  Elf64_Half vd_ndx;
  Elf64_Half vd_cnt;
  Elf64_Word vd_hash;
  Elf64_Word vd_aux;
  Elf64_Word vd_next;

} Elf64_Verdef;
# 809 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word vda_name;
  Elf32_Word vda_next;

} Elf32_Verdaux;

typedef struct
{
  Elf64_Word vda_name;
  Elf64_Word vda_next;

} Elf64_Verdaux;




typedef struct
{
  Elf32_Half vn_version;
  Elf32_Half vn_cnt;
  Elf32_Word vn_file;

  Elf32_Word vn_aux;
  Elf32_Word vn_next;

} Elf32_Verneed;

typedef struct
{
  Elf64_Half vn_version;
  Elf64_Half vn_cnt;
  Elf64_Word vn_file;

  Elf64_Word vn_aux;
  Elf64_Word vn_next;

} Elf64_Verneed;
# 856 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word vna_hash;
  Elf32_Half vna_flags;
  Elf32_Half vna_other;
  Elf32_Word vna_name;
  Elf32_Word vna_next;

} Elf32_Vernaux;

typedef struct
{
  Elf64_Word vna_hash;
  Elf64_Half vna_flags;
  Elf64_Half vna_other;
  Elf64_Word vna_name;
  Elf64_Word vna_next;

} Elf64_Vernaux;
# 890 "./include/grub/elf.h"
typedef struct
{
  int a_type;
  union
    {
      long int a_val;
      void *a_ptr;
      void (*a_fcn) (void);
    } a_un;
} Elf32_auxv_t;

typedef struct
{
  long int a_type;
  union
    {
      long int a_val;
      void *a_ptr;
      void (*a_fcn) (void);
    } a_un;
} Elf64_auxv_t;
# 953 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word n_namesz;
  Elf32_Word n_descsz;
  Elf32_Word n_type;
} Elf32_Nhdr;

typedef struct
{
  Elf64_Word n_namesz;
  Elf64_Word n_descsz;
  Elf64_Word n_type;
} Elf64_Nhdr;
# 1000 "./include/grub/elf.h"
typedef struct
{
  Elf32_Xword m_value;
  Elf32_Word m_info;
  Elf32_Word m_poffset;
  Elf32_Half m_repeat;
  Elf32_Half m_stride;
} Elf32_Move;

typedef struct
{
  Elf64_Xword m_value;
  Elf64_Xword m_info;
  Elf64_Xword m_poffset;
  Elf64_Half m_repeat;
  Elf64_Half m_stride;
} Elf64_Move;
# 1365 "./include/grub/elf.h"
typedef union
{
  struct
    {
      Elf32_Word gt_current_g_value;
      Elf32_Word gt_unused;
    } gt_header;
  struct
    {
      Elf32_Word gt_g_value;
      Elf32_Word gt_bytes;
    } gt_entry;
} Elf32_gptab;



typedef struct
{
  Elf32_Word ri_gprmask;
  Elf32_Word ri_cprmask[4];
  Elf32_Sword ri_gp_value;
} Elf32_RegInfo;



typedef struct
{
  unsigned char kind;

  unsigned char size;
  Elf32_Section section;

  Elf32_Word info;
} Elf_Options;
# 1441 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word hwp_flags1;
  Elf32_Word hwp_flags2;
} Elf_Options_Hw;
# 1580 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word l_name;
  Elf32_Word l_time_stamp;
  Elf32_Word l_checksum;
  Elf32_Word l_version;
  Elf32_Word l_flags;
} Elf32_Lib;

typedef struct
{
  Elf64_Word l_name;
  Elf64_Word l_time_stamp;
  Elf64_Word l_checksum;
  Elf64_Word l_version;
  Elf64_Word l_flags;
} Elf64_Lib;
# 1611 "./include/grub/elf.h"
typedef Elf32_Addr Elf32_Conflict;
# 28 "./include/grub/dl.h" 2
# 155 "./include/grub/dl.h"
struct grub_dl_segment
{
  struct grub_dl_segment *next;
  void *addr;
  grub_size_t size;
  unsigned section;
};
typedef struct grub_dl_segment *grub_dl_segment_t;

struct grub_dl;

struct grub_dl_dep
{
  struct grub_dl_dep *next;
  struct grub_dl *mod;
};
typedef struct grub_dl_dep *grub_dl_dep_t;
# 199 "./include/grub/dl.h"
typedef struct grub_dl *grub_dl_t;

grub_dl_t grub_dl_load_file (const char *filename);
grub_dl_t grub_dl_load (const char *name);
grub_dl_t grub_dl_load_core (void *addr, grub_size_t size);
grub_dl_t grub_dl_load_core_noinit (void *addr, grub_size_t size);
int grub_dl_unload (grub_dl_t mod);
void grub_dl_unload_unneeded (void);
int grub_dl_ref (grub_dl_t mod);
int grub_dl_unref (grub_dl_t mod);
extern grub_dl_t grub_dl_head;
# 258 "./include/grub/dl.h"
grub_err_t grub_dl_register_symbol (const char *name, void *addr,
        int isfunc, grub_dl_t mod);

grub_err_t grub_arch_dl_check_header (void *ehdr);
# 276 "./include/grub/dl.h"
grub_err_t
grub_ia64_dl_get_tramp_got_size (const void *ehdr, grub_size_t *tramp,
     grub_size_t *got);
grub_err_t
grub_arm64_dl_get_tramp_got_size (const void *ehdr, grub_size_t *tramp,
      grub_size_t *got);
# 290 "./include/grub/dl.h"
grub_err_t
grub_arch_dl_get_tramp_got_size (const void *ehdr, grub_size_t *tramp,
     grub_size_t *got);
# 23 "./include/grub/partition.h" 2


struct grub_disk;

typedef struct grub_partition *grub_partition_t;


typedef enum
{
  GRUB_EMBED_PCBIOS
} grub_embed_type_t;


typedef int (*grub_partition_iterate_hook_t) (struct grub_disk *disk,
           const grub_partition_t partition,
           void *data);


struct grub_partition_map
{

  struct grub_partition_map *next;
  struct grub_partition_map **prev;


  const char *name;


  grub_err_t (*iterate) (struct grub_disk *disk,
    grub_partition_iterate_hook_t hook, void *hook_data);


  grub_err_t (*embed) (struct grub_disk *disk, unsigned int *nsectors,
         unsigned int max_nsectors,
         grub_embed_type_t embed_type,
         grub_disk_addr_t **sectors);

};
typedef struct grub_partition_map *grub_partition_map_t;


struct grub_partition
{

  int number;


  grub_disk_addr_t start;


  grub_uint64_t len;


  grub_disk_addr_t offset;


  int index;


  struct grub_partition *parent;


  grub_partition_map_t partmap;



  grub_uint8_t msdostype;
};

grub_partition_t grub_partition_probe (struct grub_disk *disk,
          const char *str);
int grub_partition_iterate (struct grub_disk *disk,
      grub_partition_iterate_hook_t hook,
      void *hook_data);
char *grub_partition_get_name (const grub_partition_t partition);


extern grub_partition_map_t grub_partition_map_list;


static inline void
grub_partition_map_register (grub_partition_map_t partmap)
{
  grub_list_push ((((char *) &(*&grub_partition_map_list)->next == (char *) &((grub_list_t) (*&grub_partition_map_list))->next) && ((char *) &(*&grub_partition_map_list)->prev == (char *) &((grub_list_t) (*&grub_partition_map_list))->prev) ? (grub_list_t *) (void *) &grub_partition_map_list : (grub_list_t *) grub_bad_type_cast_real(106, "util/grub-fstest.c")),
    (((char *) &(partmap)->next == (char *) &((grub_list_t) (partmap))->next) && ((char *) &(partmap)->prev == (char *) &((grub_list_t) (partmap))->prev) ? (grub_list_t) partmap : (grub_list_t) grub_bad_type_cast_real(107, "util/grub-fstest.c")));
}


static inline void
grub_partition_map_unregister (grub_partition_map_t partmap)
{
  grub_list_remove ((((char *) &(partmap)->next == (char *) &((grub_list_t) (partmap))->next) && ((char *) &(partmap)->prev == (char *) &((grub_list_t) (partmap))->prev) ? (grub_list_t) partmap : (grub_list_t) grub_bad_type_cast_real(114, "util/grub-fstest.c")));
}




static inline grub_disk_addr_t
grub_partition_get_start (const grub_partition_t p)
{
  grub_partition_t part;
  grub_uint64_t part_start = 0;

  for (part = p; part; part = part->parent)
    part_start += part->start;

  return part_start;
}

static inline grub_uint64_t
grub_partition_get_len (const grub_partition_t p)
{
  return p->len;
}
# 31 "./include/grub/fs.h" 2



struct grub_file;

struct grub_dirhook_info
{
  unsigned dir:1;
  unsigned mtimeset:1;
  unsigned case_insensitive:1;
  unsigned inodeset:1;
  grub_int32_t mtime;
  grub_uint64_t inode;
};

typedef int (*grub_fs_dir_hook_t) (const char *filename,
       const struct grub_dirhook_info *info,
       void *data);


struct grub_fs
{

  struct grub_fs *next;
  struct grub_fs **prev;


  const char *name;


  grub_err_t (*fs_dir) (grub_device_t device, const char *path,
       grub_fs_dir_hook_t hook, void *hook_data);


  grub_err_t (*fs_open) (struct grub_file *file, const char *name);


  grub_ssize_t (*fs_read) (struct grub_file *file, char *buf, grub_size_t len);


  grub_err_t (*fs_close) (struct grub_file *file);




  grub_err_t (*fs_label) (grub_device_t device, char **label);




  grub_err_t (*fs_uuid) (grub_device_t device, char **uuid);


  grub_err_t (*fs_mtime) (grub_device_t device, grub_int32_t *timebuf);



  grub_err_t (*fs_embed) (grub_device_t device, unsigned int *nsectors,
         unsigned int max_nsectors,
         grub_embed_type_t embed_type,
         grub_disk_addr_t **sectors);


  int reserved_first_sector;


  int blocklist_install;

};
typedef struct grub_fs *grub_fs_t;


extern struct grub_fs grub_fs_blocklist;





typedef int (*grub_fs_autoload_hook_t) (void);
extern grub_fs_autoload_hook_t grub_fs_autoload_hook;
extern grub_fs_t grub_fs_list;


static inline void
grub_fs_register (grub_fs_t fs)
{
  grub_list_push ((((char *) &(*&grub_fs_list)->next == (char *) &((grub_list_t) (*&grub_fs_list))->next) && ((char *) &(*&grub_fs_list)->prev == (char *) &((grub_list_t) (*&grub_fs_list))->prev) ? (grub_list_t *) (void *) &grub_fs_list : (grub_list_t *) grub_bad_type_cast_real(117, "util/grub-fstest.c")), (((char *) &(fs)->next == (char *) &((grub_list_t) (fs))->next) && ((char *) &(fs)->prev == (char *) &((grub_list_t) (fs))->prev) ? (grub_list_t) fs : (grub_list_t) grub_bad_type_cast_real(117, "util/grub-fstest.c")));
}


static inline void
grub_fs_unregister (grub_fs_t fs)
{
  grub_list_remove ((((char *) &(fs)->next == (char *) &((grub_list_t) (fs))->next) && ((char *) &(fs)->prev == (char *) &((grub_list_t) (fs))->prev) ? (grub_list_t) fs : (grub_list_t) grub_bad_type_cast_real(124, "util/grub-fstest.c")));
}



grub_fs_t grub_fs_probe (grub_device_t device);
# 26 "./include/grub/file.h" 2


enum grub_file_type
  {
    GRUB_FILE_TYPE_NONE = 0,

    GRUB_FILE_TYPE_GRUB_MODULE,

    GRUB_FILE_TYPE_LOOPBACK,

    GRUB_FILE_TYPE_LINUX_KERNEL,

    GRUB_FILE_TYPE_LINUX_INITRD,


    GRUB_FILE_TYPE_MULTIBOOT_KERNEL,

    GRUB_FILE_TYPE_MULTIBOOT_MODULE,


    GRUB_FILE_TYPE_XEN_HYPERVISOR,

    GRUB_FILE_TYPE_XEN_MODULE,

    GRUB_FILE_TYPE_BSD_KERNEL,
    GRUB_FILE_TYPE_FREEBSD_ENV,
    GRUB_FILE_TYPE_FREEBSD_MODULE,
    GRUB_FILE_TYPE_FREEBSD_MODULE_ELF,
    GRUB_FILE_TYPE_NETBSD_MODULE,
    GRUB_FILE_TYPE_OPENBSD_RAMDISK,

    GRUB_FILE_TYPE_XNU_INFO_PLIST,
    GRUB_FILE_TYPE_XNU_MKEXT,
    GRUB_FILE_TYPE_XNU_KEXT,
    GRUB_FILE_TYPE_XNU_KERNEL,
    GRUB_FILE_TYPE_XNU_RAMDISK,
    GRUB_FILE_TYPE_XNU_HIBERNATE_IMAGE,
    GRUB_FILE_XNU_DEVPROP,

    GRUB_FILE_TYPE_PLAN9_KERNEL,

    GRUB_FILE_TYPE_NTLDR,
    GRUB_FILE_TYPE_TRUECRYPT,
    GRUB_FILE_TYPE_FREEDOS,
    GRUB_FILE_TYPE_PXECHAINLOADER,
    GRUB_FILE_TYPE_PCCHAINLOADER,

    GRUB_FILE_TYPE_COREBOOT_CHAINLOADER,

    GRUB_FILE_TYPE_EFI_CHAINLOADED_IMAGE,


    GRUB_FILE_TYPE_SIGNATURE,

    GRUB_FILE_TYPE_PUBLIC_KEY,

    GRUB_FILE_TYPE_PUBLIC_KEY_TRUST,

    GRUB_FILE_TYPE_PRINT_BLOCKLIST,

    GRUB_FILE_TYPE_TESTLOAD,

    GRUB_FILE_TYPE_GET_SIZE,

    GRUB_FILE_TYPE_FONT,

    GRUB_FILE_TYPE_ZFS_ENCRYPTION_KEY,

    GRUB_FILE_TYPE_FSTEST,

    GRUB_FILE_TYPE_MOUNT,

    GRUB_FILE_TYPE_FILE_ID,

    GRUB_FILE_TYPE_ACPI_TABLE,

    GRUB_FILE_TYPE_DEVICE_TREE_IMAGE,

    GRUB_FILE_TYPE_CAT,
    GRUB_FILE_TYPE_HEXCAT,

    GRUB_FILE_TYPE_CMP,

    GRUB_FILE_TYPE_HASHLIST,

    GRUB_FILE_TYPE_TO_HASH,

    GRUB_FILE_TYPE_KEYBOARD_LAYOUT,

    GRUB_FILE_TYPE_PIXMAP,

    GRUB_FILE_TYPE_GRUB_MODULE_LIST,

    GRUB_FILE_TYPE_CONFIG,
    GRUB_FILE_TYPE_THEME,
    GRUB_FILE_TYPE_GETTEXT_CATALOG,
    GRUB_FILE_TYPE_FS_SEARCH,
    GRUB_FILE_TYPE_AUDIO,
    GRUB_FILE_TYPE_VBE_DUMP,

    GRUB_FILE_TYPE_LOADENV,
    GRUB_FILE_TYPE_SAVEENV,

    GRUB_FILE_TYPE_VERIFY_SIGNATURE,

    GRUB_FILE_TYPE_MASK = 0xffff,


    GRUB_FILE_TYPE_SKIP_SIGNATURE = 0x10000,
    GRUB_FILE_TYPE_NO_DECOMPRESS = 0x20000
  };


struct grub_file
{

  char *name;


  grub_device_t device;


  grub_fs_t fs;


  grub_off_t offset;
  grub_off_t progress_offset;


  grub_uint64_t last_progress_time;
  grub_off_t last_progress_offset;
  grub_uint64_t estimated_speed;


  grub_off_t size;


  int not_easily_seekable;


  void *data;


  grub_disk_read_hook_t read_hook;


  void *read_hook_data;
};
typedef struct grub_file *grub_file_t;

extern grub_disk_read_hook_t grub_file_progress_hook;


typedef enum grub_file_filter_id
  {
    GRUB_FILE_FILTER_VERIFY,
    GRUB_FILE_FILTER_GZIO,
    GRUB_FILE_FILTER_XZIO,
    GRUB_FILE_FILTER_LZOPIO,
    GRUB_FILE_FILTER_MAX,
    GRUB_FILE_FILTER_COMPRESSION_FIRST = GRUB_FILE_FILTER_GZIO,
    GRUB_FILE_FILTER_COMPRESSION_LAST = GRUB_FILE_FILTER_LZOPIO,
  } grub_file_filter_id_t;

typedef grub_file_t (*grub_file_filter_t) (grub_file_t in, enum grub_file_type type);

extern grub_file_filter_t grub_file_filters[GRUB_FILE_FILTER_MAX];

static inline void
grub_file_filter_register (grub_file_filter_id_t id, grub_file_filter_t filter)
{
  grub_file_filters[id] = filter;
}

static inline void
grub_file_filter_unregister (grub_file_filter_id_t id)
{
  grub_file_filters[id] = 0;
}


char *grub_file_get_device_name (const char *name);

grub_file_t grub_file_open (const char *name, enum grub_file_type type);
grub_ssize_t grub_file_read (grub_file_t file, void *buf,
       grub_size_t len);
grub_off_t grub_file_seek (grub_file_t file, grub_off_t offset);
grub_err_t grub_file_close (grub_file_t file);




static inline grub_off_t
grub_file_size (const grub_file_t file)
{
  return file->size;
}

static inline grub_off_t
grub_file_tell (const grub_file_t file)
{
  return file->offset;
}

static inline int
grub_file_seekable (const grub_file_t file)
{
  return !file->not_easily_seekable;
}

grub_file_t
grub_file_offset_open (grub_file_t parent, enum grub_file_type type,
         grub_off_t start, grub_off_t size);
void
grub_file_offset_close (grub_file_t file);
# 28 "util/grub-fstest.c" 2

# 1 "./include/grub/env.h" 1
# 25 "./include/grub/env.h"
# 1 "./include/grub/menu.h" 1
# 23 "./include/grub/menu.h"
struct grub_menu_entry_class
{
  char *name;
  struct grub_menu_entry_class *next;
};


struct grub_menu_entry
{

  const char *title;


  const char *id;


  int restricted;


  const char *users;





  struct grub_menu_entry_class *classes;


  const char *sourcecode;


  int argc;
  char **args;

  int hotkey;

  int submenu;


  struct grub_menu_entry *next;
};
typedef struct grub_menu_entry *grub_menu_entry_t;


struct grub_menu
{

  int size;


  grub_menu_entry_t entry_list;
};
typedef struct grub_menu *grub_menu_t;



typedef struct grub_menu_execute_callback
{

  void (*notify_booting) (grub_menu_entry_t entry, void *userdata);






  void (*notify_fallback) (grub_menu_entry_t entry, void *userdata);



  void (*notify_failure) (void *userdata);
}
*grub_menu_execute_callback_t;

grub_menu_entry_t grub_menu_get_entry (grub_menu_t menu, int no);
int grub_menu_get_timeout (void);
void grub_menu_set_timeout (int timeout);
void grub_menu_entry_run (grub_menu_entry_t entry);
int grub_menu_get_default_entry_index (grub_menu_t menu);

void grub_menu_init (void);
void grub_menu_fini (void);
# 26 "./include/grub/env.h" 2

struct grub_env_var;

typedef const char *(*grub_env_read_hook_t) (struct grub_env_var *var,
          const char *val);
typedef char *(*grub_env_write_hook_t) (struct grub_env_var *var,
     const char *val);

struct grub_env_var
{
  char *name;
  char *value;
  grub_env_read_hook_t read_hook;
  grub_env_write_hook_t write_hook;
  struct grub_env_var *next;
  struct grub_env_var **prevp;
  struct grub_env_var *sorted_next;
  int global;
};

grub_err_t grub_env_set (const char *name, const char *val);
const char *grub_env_get (const char *name);
void grub_env_unset (const char *name);
struct grub_env_var *grub_env_update_get_sorted (void);



grub_err_t grub_register_variable_hook (const char *name,
           grub_env_read_hook_t read_hook,
           grub_env_write_hook_t write_hook);

grub_err_t grub_env_context_open (void);
grub_err_t grub_env_context_close (void);
grub_err_t grub_env_export (const char *name);

void grub_env_unset_menu (void);
grub_menu_t grub_env_get_menu (void);
void grub_env_set_menu (grub_menu_t nmenu);

grub_err_t
grub_env_extractor_open (int source);

grub_err_t
grub_env_extractor_close (int source);
# 30 "util/grub-fstest.c" 2
# 1 "./include/grub/term.h" 1
# 72 "./include/grub/term.h"
# 1 "./include/grub/unicode.h" 1
# 26 "./include/grub/unicode.h"
struct grub_unicode_bidi_pair
{
  grub_uint32_t key;
  grub_uint32_t replace;
};

struct grub_unicode_compact_range
{
  unsigned start:21;
  unsigned len:9;
  unsigned bidi_type:5;
  unsigned comb_type:8;
  unsigned bidi_mirror:1;
  unsigned join_type:3;
} __attribute__ ((packed));



struct grub_unicode_arabic_shape
{
  grub_uint32_t code;
  grub_uint32_t isolated;
  grub_uint32_t right_linked;
  grub_uint32_t both_linked;
  grub_uint32_t left_linked;
};

extern struct grub_unicode_arabic_shape grub_unicode_arabic_shapes[];

enum grub_bidi_type
  {
    GRUB_BIDI_TYPE_L = 0,
    GRUB_BIDI_TYPE_LRE,
    GRUB_BIDI_TYPE_LRO,
    GRUB_BIDI_TYPE_R,
    GRUB_BIDI_TYPE_AL,
    GRUB_BIDI_TYPE_RLE,
    GRUB_BIDI_TYPE_RLO,
    GRUB_BIDI_TYPE_PDF,
    GRUB_BIDI_TYPE_EN,
    GRUB_BIDI_TYPE_ES,
    GRUB_BIDI_TYPE_ET,
    GRUB_BIDI_TYPE_AN,
    GRUB_BIDI_TYPE_CS,
    GRUB_BIDI_TYPE_NSM,
    GRUB_BIDI_TYPE_BN,
    GRUB_BIDI_TYPE_B,
    GRUB_BIDI_TYPE_S,
    GRUB_BIDI_TYPE_WS,
    GRUB_BIDI_TYPE_ON
  };

enum grub_join_type
  {
    GRUB_JOIN_TYPE_NONJOINING = 0,
    GRUB_JOIN_TYPE_LEFT = 1,
    GRUB_JOIN_TYPE_RIGHT = 2,
    GRUB_JOIN_TYPE_DUAL = 3,
    GRUB_JOIN_TYPE_CAUSING = 4,
    GRUB_JOIN_TYPE_TRANSPARENT = 5
  };

enum grub_comb_type
  {
    GRUB_UNICODE_COMB_NONE = 0,
    GRUB_UNICODE_COMB_OVERLAY = 1,
    GRUB_UNICODE_COMB_HEBREW_SHEVA = 10,
    GRUB_UNICODE_COMB_HEBREW_HATAF_SEGOL = 11,
    GRUB_UNICODE_COMB_HEBREW_HATAF_PATAH = 12,
    GRUB_UNICODE_COMB_HEBREW_HATAF_QAMATS = 13,
    GRUB_UNICODE_COMB_HEBREW_HIRIQ = 14,
    GRUB_UNICODE_COMB_HEBREW_TSERE = 15,
    GRUB_UNICODE_COMB_HEBREW_SEGOL = 16,
    GRUB_UNICODE_COMB_HEBREW_PATAH = 17,
    GRUB_UNICODE_COMB_HEBREW_QAMATS = 18,
    GRUB_UNICODE_COMB_HEBREW_HOLAM = 19,
    GRUB_UNICODE_COMB_HEBREW_QUBUTS = 20,
    GRUB_UNICODE_COMB_HEBREW_DAGESH = 21,
    GRUB_UNICODE_COMB_HEBREW_METEG = 22,
    GRUB_UNICODE_COMB_HEBREW_RAFE = 23,
    GRUB_UNICODE_COMB_HEBREW_SHIN_DOT = 24,
    GRUB_UNICODE_COMB_HEBREW_SIN_DOT = 25,
    GRUB_UNICODE_COMB_HEBREW_VARIKA = 26,
    GRUB_UNICODE_COMB_ARABIC_FATHATAN = 27,
    GRUB_UNICODE_COMB_ARABIC_DAMMATAN = 28,
    GRUB_UNICODE_COMB_ARABIC_KASRATAN = 29,
    GRUB_UNICODE_COMB_ARABIC_FATHAH = 30,
    GRUB_UNICODE_COMB_ARABIC_DAMMAH = 31,
    GRUB_UNICODE_COMB_ARABIC_KASRA = 32,
    GRUB_UNICODE_COMB_ARABIC_SHADDA = 33,
    GRUB_UNICODE_COMB_ARABIC_SUKUN = 34,
    GRUB_UNICODE_COMB_ARABIC_SUPERSCRIPT_ALIF = 35,
    GRUB_UNICODE_COMB_SYRIAC_SUPERSCRIPT_ALAPH = 36,
    GRUB_UNICODE_STACK_ATTACHED_BELOW = 202,
    GRUB_UNICODE_STACK_ATTACHED_ABOVE = 214,
    GRUB_UNICODE_COMB_ATTACHED_ABOVE_RIGHT = 216,
    GRUB_UNICODE_STACK_BELOW = 220,
    GRUB_UNICODE_COMB_BELOW_RIGHT = 222,
    GRUB_UNICODE_COMB_ABOVE_LEFT = 228,
    GRUB_UNICODE_STACK_ABOVE = 230,
    GRUB_UNICODE_COMB_ABOVE_RIGHT = 232,
    GRUB_UNICODE_COMB_YPOGEGRAMMENI = 240,


    GRUB_UNICODE_COMB_ME = 253,
    GRUB_UNICODE_COMB_MC = 254,
    GRUB_UNICODE_COMB_MN = 255,
  };

struct grub_unicode_combining
{
  grub_uint32_t code:21;
  enum grub_comb_type type:8;
};

struct grub_unicode_glyph
{
  grub_uint32_t base:23;
  grub_uint16_t variant:9;

  grub_uint8_t attributes:5;
  grub_uint8_t bidi_level:6;
  enum grub_bidi_type bidi_type:5;

  unsigned ncomb:8;


  int estimated_width:8;

  grub_size_t orig_pos;
  union
  {
    struct grub_unicode_combining combining_inline[sizeof (void *)
         / sizeof (struct grub_unicode_combining)];
    struct grub_unicode_combining *combining_ptr;
  };
};
# 181 "./include/grub/unicode.h"
enum
  {
    GRUB_UNICODE_DOTLESS_LOWERCASE_I = 0x0131,
    GRUB_UNICODE_DOTLESS_LOWERCASE_J = 0x0237,
    GRUB_UNICODE_COMBINING_GRAPHEME_JOINER = 0x034f,
    GRUB_UNICODE_HEBREW_WAW = 0x05d5,
    GRUB_UNICODE_ARABIC_START = 0x0600,
    GRUB_UNICODE_ARABIC_END = 0x0700,
    GRUB_UNICODE_THAANA_ABAFILI = 0x07a6,
    GRUB_UNICODE_THAANA_AABAAFILI = 0x07a7,
    GRUB_UNICODE_THAANA_IBIFILI = 0x07a8,
    GRUB_UNICODE_THAANA_EEBEEFILI = 0x07a9,
    GRUB_UNICODE_THAANA_UBUFILI = 0x07aa,
    GRUB_UNICODE_THAANA_OOBOOFILI = 0x07ab,
    GRUB_UNICODE_THAANA_EBEFILI = 0x07ac,
    GRUB_UNICODE_THAANA_EYBEYFILI = 0x07ad,
    GRUB_UNICODE_THAANA_OBOFILI = 0x07ae,
    GRUB_UNICODE_THAANA_OABOAFILI = 0x07af,
    GRUB_UNICODE_THAANA_SUKUN = 0x07b0,
    GRUB_UNICODE_ZWNJ = 0x200c,
    GRUB_UNICODE_ZWJ = 0x200d,
    GRUB_UNICODE_LRM = 0x200e,
    GRUB_UNICODE_RLM = 0x200f,
    GRUB_UNICODE_LRE = 0x202a,
    GRUB_UNICODE_RLE = 0x202b,
    GRUB_UNICODE_PDF = 0x202c,
    GRUB_UNICODE_LRO = 0x202d,
    GRUB_UNICODE_RLO = 0x202e,
    GRUB_UNICODE_LEFTARROW = 0x2190,
    GRUB_UNICODE_UPARROW = 0x2191,
    GRUB_UNICODE_RIGHTARROW = 0x2192,
    GRUB_UNICODE_DOWNARROW = 0x2193,
    GRUB_UNICODE_UPDOWNARROW = 0x2195,
    GRUB_UNICODE_LIGHT_HLINE = 0x2500,
    GRUB_UNICODE_HLINE = 0x2501,
    GRUB_UNICODE_LIGHT_VLINE = 0x2502,
    GRUB_UNICODE_VLINE = 0x2503,
    GRUB_UNICODE_LIGHT_CORNER_UL = 0x250c,
    GRUB_UNICODE_CORNER_UL = 0x250f,
    GRUB_UNICODE_LIGHT_CORNER_UR = 0x2510,
    GRUB_UNICODE_CORNER_UR = 0x2513,
    GRUB_UNICODE_LIGHT_CORNER_LL = 0x2514,
    GRUB_UNICODE_CORNER_LL = 0x2517,
    GRUB_UNICODE_LIGHT_CORNER_LR = 0x2518,
    GRUB_UNICODE_CORNER_LR = 0x251b,
    GRUB_UNICODE_BLACK_UP_TRIANGLE = 0x25b2,
    GRUB_UNICODE_BLACK_RIGHT_TRIANGLE = 0x25ba,
    GRUB_UNICODE_BLACK_DOWN_TRIANGLE = 0x25bc,
    GRUB_UNICODE_BLACK_LEFT_TRIANGLE = 0x25c4,
    GRUB_UNICODE_VARIATION_SELECTOR_1 = 0xfe00,
    GRUB_UNICODE_VARIATION_SELECTOR_16 = 0xfe0f,
    GRUB_UNICODE_TAG_START = 0xe0000,
    GRUB_UNICODE_TAG_END = 0xe007f,
    GRUB_UNICODE_VARIATION_SELECTOR_17 = 0xe0100,
    GRUB_UNICODE_VARIATION_SELECTOR_256 = 0xe01ef,
    GRUB_UNICODE_LAST_VALID = 0x10ffff
  };

extern struct grub_unicode_compact_range grub_unicode_compact[];
extern struct grub_unicode_bidi_pair grub_unicode_bidi_pairs[];





struct grub_term_pos
{
  unsigned valid:1;
  unsigned x:15, y:16;
};

grub_ssize_t
grub_bidi_logical_to_visual (const grub_uint32_t *logical,
        grub_size_t logical_len,
        struct grub_unicode_glyph **visual_out,
        grub_size_t (*getcharwidth) (const struct grub_unicode_glyph *visual, void *getcharwidth_arg),
        void *getcharwidth_arg,
        grub_size_t max_width,
        grub_size_t start_width, grub_uint32_t codechar,
        struct grub_term_pos *pos,
        int primitive_wrap);

enum grub_comb_type
grub_unicode_get_comb_type (grub_uint32_t c);
grub_size_t
grub_unicode_aglomerate_comb (const grub_uint32_t *in, grub_size_t inlen,
         struct grub_unicode_glyph *out);

static inline const struct grub_unicode_combining *
grub_unicode_get_comb (const struct grub_unicode_glyph *in)
{
  if (in->ncomb == 0)
    return 
# 273 "./include/grub/unicode.h" 3 4
          ((void *)0)
# 273 "./include/grub/unicode.h"
              ;
  if (in->ncomb > (sizeof (in->combining_inline) / sizeof (in->combining_inline[0])))
    return in->combining_ptr;
  return in->combining_inline;
}

static inline void
grub_unicode_destroy_glyph (struct grub_unicode_glyph *glyph)
{
  if (glyph->ncomb > (sizeof (glyph->combining_inline) / sizeof (glyph->combining_inline[0])))
    grub_free (glyph->combining_ptr);
  glyph->ncomb = 0;
}

static inline struct grub_unicode_glyph *
grub_unicode_glyph_dup (const struct grub_unicode_glyph *in)
{
  struct grub_unicode_glyph *out = grub_malloc (sizeof (*out));
  if (!out)
    return 
# 292 "./include/grub/unicode.h" 3 4
          ((void *)0)
# 292 "./include/grub/unicode.h"
              ;
  grub_memcpy (out, in, sizeof (*in));
  if (in->ncomb > (sizeof (out->combining_inline) / sizeof (out->combining_inline[0])))
    {
      out->combining_ptr = grub_calloc (in->ncomb, sizeof (out->combining_ptr[0]));
      if (!out->combining_ptr)
 {
   grub_free (out);
   return 
# 300 "./include/grub/unicode.h" 3 4
         ((void *)0)
# 300 "./include/grub/unicode.h"
             ;
 }
      grub_memcpy (out->combining_ptr, in->combining_ptr,
     in->ncomb * sizeof (out->combining_ptr[0]));
    }
  else
    grub_memcpy (&out->combining_inline, &in->combining_inline,
   sizeof (out->combining_inline));
  return out;
}

static inline void
grub_unicode_set_glyph (struct grub_unicode_glyph *out,
   const struct grub_unicode_glyph *in)
{
  grub_memcpy (out, in, sizeof (*in));
  if (in->ncomb > (sizeof (out->combining_inline) / sizeof (out->combining_inline[0])))
    {
      out->combining_ptr = grub_calloc (in->ncomb, sizeof (out->combining_ptr[0]));
      if (!out->combining_ptr)
 return;
      grub_memcpy (out->combining_ptr, in->combining_ptr,
     in->ncomb * sizeof (out->combining_ptr[0]));
    }
  else
    grub_memcpy (&out->combining_inline, &in->combining_inline,
   sizeof (out->combining_inline));
}

static inline struct grub_unicode_glyph *
grub_unicode_glyph_from_code (grub_uint32_t code)
{
  struct grub_unicode_glyph *ret;
  ret = grub_zalloc (sizeof (*ret));
  if (!ret)
    return 
# 335 "./include/grub/unicode.h" 3 4
          ((void *)0)
# 335 "./include/grub/unicode.h"
              ;

  ret->base = code;

  return ret;
}

static inline void
grub_unicode_set_glyph_from_code (struct grub_unicode_glyph *glyph,
      grub_uint32_t code)
{
  grub_memset (glyph, 0, sizeof (*glyph));

  glyph->base = code;
}

grub_uint32_t
grub_unicode_mirror_code (grub_uint32_t in);
grub_uint32_t
grub_unicode_shape_code (grub_uint32_t in, grub_uint8_t attr);

const grub_uint32_t *
grub_unicode_get_comb_end (const grub_uint32_t *end,
      const grub_uint32_t *cur);
# 73 "./include/grub/term.h" 2



typedef enum
  {

    GRUB_TERM_COLOR_UNDEFINED = -1,


    GRUB_TERM_COLOR_STANDARD = 0,

    GRUB_TERM_COLOR_NORMAL,

    GRUB_TERM_COLOR_HIGHLIGHT
  }
grub_term_color_state;
# 140 "./include/grub/term.h"
struct grub_term_input
{

  struct grub_term_input *next;
  struct grub_term_input **prev;


  const char *name;


  grub_err_t (*init) (struct grub_term_input *term);


  grub_err_t (*fini) (struct grub_term_input *term);


  int (*getkey) (struct grub_term_input *term);


  int (*getkeystatus) (struct grub_term_input *term);

  void *data;
};
typedef struct grub_term_input *grub_term_input_t;


struct grub_term_coordinate
{
  grub_uint16_t x;
  grub_uint16_t y;
};

struct grub_term_output
{

  struct grub_term_output *next;
  struct grub_term_output **prev;


  const char *name;


  grub_err_t (*init) (struct grub_term_output *term);


  grub_err_t (*fini) (struct grub_term_output *term);


  void (*putchar) (struct grub_term_output *term,
     const struct grub_unicode_glyph *c);



  grub_size_t (*getcharwidth) (struct grub_term_output *term,
          const struct grub_unicode_glyph *c);


  struct grub_term_coordinate (*getwh) (struct grub_term_output *term);


  struct grub_term_coordinate (*getxy) (struct grub_term_output *term);


  void (*gotoxy) (struct grub_term_output *term,
    struct grub_term_coordinate pos);


  void (*cls) (struct grub_term_output *term);


  void (*setcolorstate) (struct grub_term_output *term,
    grub_term_color_state state);


  void (*setcursor) (struct grub_term_output *term, int on);


  void (*refresh) (struct grub_term_output *term);


  grub_err_t (*fullscreen) (void);


  grub_uint32_t flags;


  grub_uint32_t progress_update_divisor;
  grub_uint32_t progress_update_counter;

  void *data;
};
typedef struct grub_term_output *grub_term_output_t;






extern grub_uint8_t grub_term_normal_color;
extern grub_uint8_t grub_term_highlight_color;

extern struct grub_term_output *grub_term_outputs_disabled;
extern struct grub_term_input *grub_term_inputs_disabled;
extern struct grub_term_output *grub_term_outputs;
extern struct grub_term_input *grub_term_inputs;

static inline void
grub_term_register_input (const char *name __attribute__ ((unused)),
     grub_term_input_t term)
{
  if (grub_term_inputs)
    grub_list_push ((((char *) &(*&grub_term_inputs_disabled)->next == (char *) &((grub_list_t) (*&grub_term_inputs_disabled))->next) && ((char *) &(*&grub_term_inputs_disabled)->prev == (char *) &((grub_list_t) (*&grub_term_inputs_disabled))->prev) ? (grub_list_t *) (void *) &grub_term_inputs_disabled : (grub_list_t *) grub_bad_type_cast_real(251, "util/grub-fstest.c")),
      (((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(252, "util/grub-fstest.c")));
  else
    {

      if (! term->init || term->init (term) == GRUB_ERR_NONE)
 grub_list_push ((((char *) &(*&grub_term_inputs)->next == (char *) &((grub_list_t) (*&grub_term_inputs))->next) && ((char *) &(*&grub_term_inputs)->prev == (char *) &((grub_list_t) (*&grub_term_inputs))->prev) ? (grub_list_t *) (void *) &grub_term_inputs : (grub_list_t *) grub_bad_type_cast_real(257, "util/grub-fstest.c")), (((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(257, "util/grub-fstest.c")));
    }
}

static inline void
grub_term_register_input_inactive (const char *name __attribute__ ((unused)),
       grub_term_input_t term)
{
  grub_list_push ((((char *) &(*&grub_term_inputs_disabled)->next == (char *) &((grub_list_t) (*&grub_term_inputs_disabled))->next) && ((char *) &(*&grub_term_inputs_disabled)->prev == (char *) &((grub_list_t) (*&grub_term_inputs_disabled))->prev) ? (grub_list_t *) (void *) &grub_term_inputs_disabled : (grub_list_t *) grub_bad_type_cast_real(265, "util/grub-fstest.c")),
    (((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(266, "util/grub-fstest.c")));
}

static inline void
grub_term_register_input_active (const char *name __attribute__ ((unused)),
     grub_term_input_t term)
{
  if (! term->init || term->init (term) == GRUB_ERR_NONE)
    grub_list_push ((((char *) &(*&grub_term_inputs)->next == (char *) &((grub_list_t) (*&grub_term_inputs))->next) && ((char *) &(*&grub_term_inputs)->prev == (char *) &((grub_list_t) (*&grub_term_inputs))->prev) ? (grub_list_t *) (void *) &grub_term_inputs : (grub_list_t *) grub_bad_type_cast_real(274, "util/grub-fstest.c")), (((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(274, "util/grub-fstest.c")));
}

static inline void
grub_term_register_output (const char *name __attribute__ ((unused)),
      grub_term_output_t term)
{
  if (grub_term_outputs)
    grub_list_push ((((char *) &(*&grub_term_outputs_disabled)->next == (char *) &((grub_list_t) (*&grub_term_outputs_disabled))->next) && ((char *) &(*&grub_term_outputs_disabled)->prev == (char *) &((grub_list_t) (*&grub_term_outputs_disabled))->prev) ? (grub_list_t *) (void *) &grub_term_outputs_disabled : (grub_list_t *) grub_bad_type_cast_real(282, "util/grub-fstest.c")),
      (((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(283, "util/grub-fstest.c")));
  else
    {

      if (! term->init || term->init (term) == GRUB_ERR_NONE)
 grub_list_push ((((char *) &(*&grub_term_outputs)->next == (char *) &((grub_list_t) (*&grub_term_outputs))->next) && ((char *) &(*&grub_term_outputs)->prev == (char *) &((grub_list_t) (*&grub_term_outputs))->prev) ? (grub_list_t *) (void *) &grub_term_outputs : (grub_list_t *) grub_bad_type_cast_real(288, "util/grub-fstest.c")),
   (((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(289, "util/grub-fstest.c")));
    }
}

static inline void
grub_term_register_output_inactive (const char *name __attribute__ ((unused)),
        grub_term_output_t term)
{
  grub_list_push ((((char *) &(*&grub_term_outputs_disabled)->next == (char *) &((grub_list_t) (*&grub_term_outputs_disabled))->next) && ((char *) &(*&grub_term_outputs_disabled)->prev == (char *) &((grub_list_t) (*&grub_term_outputs_disabled))->prev) ? (grub_list_t *) (void *) &grub_term_outputs_disabled : (grub_list_t *) grub_bad_type_cast_real(297, "util/grub-fstest.c")),
    (((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(298, "util/grub-fstest.c")));
}

static inline void
grub_term_register_output_active (const char *name __attribute__ ((unused)),
      grub_term_output_t term)
{
  if (! term->init || term->init (term) == GRUB_ERR_NONE)
    grub_list_push ((((char *) &(*&grub_term_outputs)->next == (char *) &((grub_list_t) (*&grub_term_outputs))->next) && ((char *) &(*&grub_term_outputs)->prev == (char *) &((grub_list_t) (*&grub_term_outputs))->prev) ? (grub_list_t *) (void *) &grub_term_outputs : (grub_list_t *) grub_bad_type_cast_real(306, "util/grub-fstest.c")),
      (((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(307, "util/grub-fstest.c")));
}

static inline void
grub_term_unregister_input (grub_term_input_t term)
{
  grub_list_remove ((((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(313, "util/grub-fstest.c")));
  grub_list_remove ((((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(314, "util/grub-fstest.c")));
}

static inline void
grub_term_unregister_output (grub_term_output_t term)
{
  grub_list_remove ((((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(320, "util/grub-fstest.c")));
  grub_list_remove ((((char *) &(term)->next == (char *) &((grub_list_t) (term))->next) && ((char *) &(term)->prev == (char *) &((grub_list_t) (term))->prev) ? (grub_list_t) term : (grub_list_t) grub_bad_type_cast_real(321, "util/grub-fstest.c")));
}






void grub_putcode (grub_uint32_t code, struct grub_term_output *term);
int grub_getkey (void);
int grub_getkey_noblock (void);
int grub_getkeystatus (void);
int grub_key_is_interrupt (int key);
void grub_cls (void);
void grub_refresh (void);
void grub_puts_terminal (const char *str, struct grub_term_output *term);
struct grub_term_coordinate *grub_term_save_pos (void);
void grub_term_restore_pos (struct grub_term_coordinate *pos);

static inline unsigned grub_term_width (struct grub_term_output *term)
{
  return term->getwh(term).x ? : 80;
}

static inline unsigned grub_term_height (struct grub_term_output *term)
{
  return term->getwh(term).y ? : 24;
}

static inline struct grub_term_coordinate
grub_term_getxy (struct grub_term_output *term)
{
  return term->getxy (term);
}

static inline void
grub_term_refresh (struct grub_term_output *term)
{
  if (term->refresh)
    term->refresh (term);
}

static inline void
grub_term_gotoxy (struct grub_term_output *term, struct grub_term_coordinate pos)
{
  term->gotoxy (term, pos);
}

static inline void
grub_term_setcolorstate (struct grub_term_output *term,
    grub_term_color_state state)
{
  if (term->setcolorstate)
    term->setcolorstate (term, state);
}

static inline void
grub_setcolorstate (grub_term_color_state state)
{
  struct grub_term_output *term;

  for (((term)) = ((grub_term_outputs)); ((term)); ((term)) = ((term))->next)
    grub_term_setcolorstate (term, state);
}


static inline void
grub_term_setcursor (struct grub_term_output *term, int on)
{
  if (term->setcursor)
    term->setcursor (term, on);
}

static inline void
grub_term_cls (struct grub_term_output *term)
{
  if (term->cls)
    (term->cls) (term);
  else
    {
      grub_putcode ('\n', term);
      grub_term_refresh (term);
    }
}
# 413 "./include/grub/term.h"
static inline grub_size_t
grub_unicode_estimate_width (const struct grub_unicode_glyph *c __attribute__ ((unused)))
{
  if (grub_unicode_get_comb_type (c->base))
    return 0;
  return 1;
}





static inline grub_size_t
grub_term_getcharwidth (struct grub_term_output *term,
   const struct grub_unicode_glyph *c)
{
  if (c->base == '\t')
    return 8;

  if (term->getcharwidth)
    return term->getcharwidth (term, c);
  else if (((term->flags & (7 << 3))
     == (2 << 3))
    || ((term->flags & (7 << 3))
        == (3 << 3))
    || ((term->flags & (7 << 3))
        == (4 << 3)))
    return grub_unicode_estimate_width (c);
  else
    return 1;
}

struct grub_term_autoload
{
  struct grub_term_autoload *next;
  char *name;
  char *modname;
};

extern struct grub_term_autoload *grub_term_input_autoload;
extern struct grub_term_autoload *grub_term_output_autoload;

static inline void
grub_print_spaces (struct grub_term_output *term, int number_spaces)
{
  while (--number_spaces >= 0)
    grub_putcode (' ', term);
}

extern void (*grub_term_poll_usb) (int wait_for_completion);
# 31 "util/grub-fstest.c" 2

# 1 "./include/grub/lib/hexdump.h" 1
# 23 "./include/grub/lib/hexdump.h"
void hexdump (unsigned long bse,char* buf,int len);
# 33 "util/grub-fstest.c" 2
# 1 "./include/grub/crypto.h" 1
# 31 "./include/grub/crypto.h"
typedef enum
  {
    GPG_ERR_NO_ERROR,
    GPG_ERR_BAD_MPI,
    GPG_ERR_BAD_SECKEY,
    GPG_ERR_BAD_SIGNATURE,
    GPG_ERR_CIPHER_ALGO,
    GPG_ERR_CONFLICT,
    GPG_ERR_DECRYPT_FAILED,
    GPG_ERR_DIGEST_ALGO,
    GPG_ERR_GENERAL,
    GPG_ERR_INTERNAL,
    GPG_ERR_INV_ARG,
    GPG_ERR_INV_CIPHER_MODE,
    GPG_ERR_INV_FLAG,
    GPG_ERR_INV_KEYLEN,
    GPG_ERR_INV_OBJ,
    GPG_ERR_INV_OP,
    GPG_ERR_INV_SEXP,
    GPG_ERR_INV_VALUE,
    GPG_ERR_MISSING_VALUE,
    GPG_ERR_NO_ENCRYPTION_SCHEME,
    GPG_ERR_NO_OBJ,
    GPG_ERR_NO_PRIME,
    GPG_ERR_NO_SIGNATURE_SCHEME,
    GPG_ERR_NOT_FOUND,
    GPG_ERR_NOT_IMPLEMENTED,
    GPG_ERR_NOT_SUPPORTED,
    GPG_ERR_PUBKEY_ALGO,
    GPG_ERR_SELFTEST_FAILED,
    GPG_ERR_TOO_SHORT,
    GPG_ERR_UNSUPPORTED,
    GPG_ERR_WEAK_KEY,
    GPG_ERR_WRONG_KEY_USAGE,
    GPG_ERR_WRONG_PUBKEY_ALGO,
    GPG_ERR_OUT_OF_MEMORY,
    GPG_ERR_TOO_LARGE,
    GPG_ERR_ENOMEM
  } gpg_err_code_t;
typedef gpg_err_code_t gpg_error_t;
typedef gpg_error_t gcry_error_t;
typedef gpg_err_code_t gcry_err_code_t;
# 93 "./include/grub/crypto.h"
typedef gcry_err_code_t (*gcry_cipher_setkey_t) (void *c,
       const unsigned char *key,
       unsigned keylen);


typedef void (*gcry_cipher_encrypt_t) (void *c,
           unsigned char *outbuf,
           const unsigned char *inbuf);


typedef void (*gcry_cipher_decrypt_t) (void *c,
           unsigned char *outbuf,
           const unsigned char *inbuf);


typedef void (*gcry_cipher_stencrypt_t) (void *c,
      unsigned char *outbuf,
      const unsigned char *inbuf,
      unsigned int n);


typedef void (*gcry_cipher_stdecrypt_t) (void *c,
      unsigned char *outbuf,
      const unsigned char *inbuf,
      unsigned int n);

typedef struct gcry_cipher_oid_spec
{
  const char *oid;
  int mode;
} gcry_cipher_oid_spec_t;


typedef struct gcry_cipher_spec
{
  const char *name;
  const char **aliases;
  gcry_cipher_oid_spec_t *oids;
  grub_size_t blocksize;
  grub_size_t keylen;
  grub_size_t contextsize;
  gcry_cipher_setkey_t setkey;
  gcry_cipher_encrypt_t encrypt;
  gcry_cipher_decrypt_t decrypt;
  gcry_cipher_stencrypt_t stencrypt;
  gcry_cipher_stdecrypt_t stdecrypt;

  const char *modname;

  struct gcry_cipher_spec *next;
} gcry_cipher_spec_t;


typedef void (*gcry_md_init_t) (void *c);


typedef void (*gcry_md_write_t) (void *c, const void *buf, grub_size_t nbytes);


typedef void (*gcry_md_final_t) (void *c);


typedef unsigned char *(*gcry_md_read_t) (void *c);

typedef struct gcry_md_oid_spec
{
  const char *oidstring;
} gcry_md_oid_spec_t;


typedef struct gcry_md_spec
{
  const char *name;
  unsigned char *asnoid;
  int asnlen;
  gcry_md_oid_spec_t *oids;
  grub_size_t mdlen;
  gcry_md_init_t init;
  gcry_md_write_t write;
  gcry_md_final_t final;
  gcry_md_read_t read;
  grub_size_t contextsize;

  grub_size_t blocksize;

  const char *modname;

  struct gcry_md_spec *next;
} gcry_md_spec_t;

struct gcry_mpi;
typedef struct gcry_mpi *gcry_mpi_t;


typedef gcry_err_code_t (*gcry_pk_generate_t) (int algo,
            unsigned int nbits,
            unsigned long use_e,
            gcry_mpi_t *skey,
            gcry_mpi_t **retfactors);


typedef gcry_err_code_t (*gcry_pk_check_secret_key_t) (int algo,
             gcry_mpi_t *skey);


typedef gcry_err_code_t (*gcry_pk_encrypt_t) (int algo,
           gcry_mpi_t *resarr,
           gcry_mpi_t data,
           gcry_mpi_t *pkey,
           int flags);


typedef gcry_err_code_t (*gcry_pk_decrypt_t) (int algo,
           gcry_mpi_t *result,
           gcry_mpi_t *data,
           gcry_mpi_t *skey,
           int flags);


typedef gcry_err_code_t (*gcry_pk_sign_t) (int algo,
        gcry_mpi_t *resarr,
        gcry_mpi_t data,
        gcry_mpi_t *skey);


typedef gcry_err_code_t (*gcry_pk_verify_t) (int algo,
          gcry_mpi_t hash,
          gcry_mpi_t *data,
          gcry_mpi_t *pkey,
          int (*cmp) (void *, gcry_mpi_t),
          void *opaquev);


typedef unsigned (*gcry_pk_get_nbits_t) (int algo, gcry_mpi_t *pkey);


typedef struct gcry_pk_spec
{
  const char *name;
  const char **aliases;
  const char *elements_pkey;
  const char *elements_skey;
  const char *elements_enc;
  const char *elements_sig;
  const char *elements_grip;
  int use;
  gcry_pk_generate_t generate;
  gcry_pk_check_secret_key_t check_secret_key;
  gcry_pk_encrypt_t encrypt;
  gcry_pk_decrypt_t decrypt;
  gcry_pk_sign_t sign;
  gcry_pk_verify_t verify;
  gcry_pk_get_nbits_t get_nbits;

  const char *modname;

} gcry_pk_spec_t;

struct grub_crypto_cipher_handle
{
  const struct gcry_cipher_spec *cipher;
  char ctx[0];
};

typedef struct grub_crypto_cipher_handle *grub_crypto_cipher_handle_t;

struct grub_crypto_hmac_handle;

const gcry_cipher_spec_t *
grub_crypto_lookup_cipher_by_name (const char *name);

grub_crypto_cipher_handle_t
grub_crypto_cipher_open (const struct gcry_cipher_spec *cipher);

gcry_err_code_t
grub_crypto_cipher_set_key (grub_crypto_cipher_handle_t cipher,
       const unsigned char *key,
       unsigned keylen);

static inline void
grub_crypto_cipher_close (grub_crypto_cipher_handle_t cipher)
{
  grub_free (cipher);
}

static inline void
grub_crypto_xor (void *out, const void *in1, const void *in2, grub_size_t size)
{
  const grub_uint8_t *in1ptr = in1, *in2ptr = in2;
  grub_uint8_t *outptr = out;
  while (size && (((grub_addr_t) in1ptr & (sizeof (grub_uint64_t) - 1))
    || ((grub_addr_t) in2ptr & (sizeof (grub_uint64_t) - 1))
    || ((grub_addr_t) outptr & (sizeof (grub_uint64_t) - 1))))
    {
      *outptr = *in1ptr ^ *in2ptr;
      in1ptr++;
      in2ptr++;
      outptr++;
      size--;
    }
  while (size >= sizeof (grub_uint64_t))
    {

      *(grub_uint64_t *) (void *) outptr
 = (*(const grub_uint64_t *) (const void *) in1ptr
    ^ *(const grub_uint64_t *) (const void *) in2ptr);
      in1ptr += sizeof (grub_uint64_t);
      in2ptr += sizeof (grub_uint64_t);
      outptr += sizeof (grub_uint64_t);
      size -= sizeof (grub_uint64_t);
    }
  while (size)
    {
      *outptr = *in1ptr ^ *in2ptr;
      in1ptr++;
      in2ptr++;
      outptr++;
      size--;
    }
}

gcry_err_code_t
grub_crypto_ecb_decrypt (grub_crypto_cipher_handle_t cipher,
    void *out, const void *in, grub_size_t size);

gcry_err_code_t
grub_crypto_ecb_encrypt (grub_crypto_cipher_handle_t cipher,
    void *out, const void *in, grub_size_t size);
gcry_err_code_t
grub_crypto_cbc_encrypt (grub_crypto_cipher_handle_t cipher,
    void *out, const void *in, grub_size_t size,
    void *iv_in);
gcry_err_code_t
grub_crypto_cbc_decrypt (grub_crypto_cipher_handle_t cipher,
    void *out, const void *in, grub_size_t size,
    void *iv);
void
grub_cipher_register (gcry_cipher_spec_t *cipher);
void
grub_cipher_unregister (gcry_cipher_spec_t *cipher);
void
grub_md_register (gcry_md_spec_t *digest);
void
grub_md_unregister (gcry_md_spec_t *cipher);

extern struct gcry_pk_spec *grub_crypto_pk_dsa;
extern struct gcry_pk_spec *grub_crypto_pk_ecdsa;
extern struct gcry_pk_spec *grub_crypto_pk_ecdh;
extern struct gcry_pk_spec *grub_crypto_pk_rsa;

void
grub_crypto_hash (const gcry_md_spec_t *hash, void *out, const void *in,
    grub_size_t inlen);
const gcry_md_spec_t *
grub_crypto_lookup_md_by_name (const char *name);

grub_err_t
grub_crypto_gcry_error (gcry_err_code_t in);

void grub_burn_stack (grub_size_t size);

struct grub_crypto_hmac_handle *
grub_crypto_hmac_init (const struct gcry_md_spec *md,
         const void *key, grub_size_t keylen);
void
grub_crypto_hmac_write (struct grub_crypto_hmac_handle *hnd,
   const void *data,
   grub_size_t datalen);
gcry_err_code_t
grub_crypto_hmac_fini (struct grub_crypto_hmac_handle *hnd, void *out);

gcry_err_code_t
grub_crypto_hmac_buffer (const struct gcry_md_spec *md,
    const void *key, grub_size_t keylen,
    const void *data, grub_size_t datalen, void *out);

extern gcry_md_spec_t _gcry_digest_spec_md5;
extern gcry_md_spec_t _gcry_digest_spec_sha1;
extern gcry_md_spec_t _gcry_digest_spec_sha256;
extern gcry_md_spec_t _gcry_digest_spec_sha512;
extern gcry_md_spec_t _gcry_digest_spec_crc32;
extern gcry_cipher_spec_t _gcry_cipher_spec_aes;
# 388 "./include/grub/crypto.h"
gcry_err_code_t
grub_crypto_pbkdf2 (const struct gcry_md_spec *md,
      const grub_uint8_t *P, grub_size_t Plen,
      const grub_uint8_t *S, grub_size_t Slen,
      unsigned int c,
      grub_uint8_t *DK, grub_size_t dkLen);

int
grub_crypto_memcmp (const void *a, const void *b, grub_size_t n);

int
grub_password_get (char buf[], unsigned buf_size);




extern void (*grub_crypto_autoload_hook) (const char *name);

void _gcry_assert_failed (const char *expr, const char *file, int line,
                          const char *func) __attribute__ ((noreturn));

void _gcry_burn_stack (int bytes);
void _gcry_log_error( const char *fmt, ... ) __attribute__ ((format (__printf__, 1, 2)));



void grub_gcry_init_all (void);
void grub_gcry_fini_all (void);

int
grub_get_random (void *out, grub_size_t len);
# 34 "util/grub-fstest.c" 2
# 1 "./include/grub/command.h" 1
# 27 "./include/grub/command.h"
typedef enum grub_command_flags
  {

    GRUB_COMMAND_FLAG_EXTCMD = 0x10,

    GRUB_COMMAND_FLAG_DYNCMD = 0x20,

    GRUB_COMMAND_FLAG_BLOCKS = 0x40,

    GRUB_COMMAND_ACCEPT_DASH = 0x80,

    GRUB_COMMAND_OPTIONS_AT_START = 0x100,

    GRUB_COMMAND_FLAG_EXTRACTOR = 0x200
  } grub_command_flags_t;

struct grub_command;

typedef grub_err_t (*grub_command_func_t) (struct grub_command *cmd,
        int argc, char **argv);





struct grub_command
{

  struct grub_command *next;
  struct grub_command **prev;


  const char *name;


  int prio;


  grub_command_func_t func;


  grub_command_flags_t flags;


  const char *summary;


  const char *description;


  void *data;
};
typedef struct grub_command *grub_command_t;

extern grub_command_t grub_command_list;

grub_command_t
grub_register_command_prio (const char *name,
      grub_command_func_t func,
      const char *summary,
      const char *description,
      int prio);
void grub_unregister_command (grub_command_t cmd);

static inline grub_command_t
grub_register_command (const char *name,
         grub_command_func_t func,
         const char *summary,
         const char *description)
{
  return grub_register_command_prio (name, func, summary, description, 0);
}

static inline grub_command_t
grub_register_command_p1 (const char *name,
     grub_command_func_t func,
     const char *summary,
     const char *description)
{
  return grub_register_command_prio (name, func, summary, description, 1);
}

static inline grub_command_t
grub_command_find (const char *name)
{
  return grub_named_list_find (((((char *) &(grub_command_list)->next == (char *) &((grub_named_list_t) (grub_command_list))->next) && ((char *) &(grub_command_list)->prev == (char *) &((grub_named_list_t) (grub_command_list))->prev) && ((char *) &(grub_command_list)->name == (char *) &((grub_named_list_t) (grub_command_list))->name))? (grub_named_list_t) grub_command_list : (grub_named_list_t) grub_bad_type_cast_real(112, "util/grub-fstest.c")), name);
}

static inline grub_err_t
grub_command_execute (const char *name, int argc, char **argv)
{
  grub_command_t cmd;

  cmd = grub_command_find (name);
  return (cmd) ? cmd->func (cmd, argc, argv) : GRUB_ERR_FILE_NOT_FOUND;
}




void grub_register_core_commands (void);
# 35 "util/grub-fstest.c" 2

# 1 "./include/grub/zfs/zfs.h" 1
# 29 "./include/grub/zfs/zfs.h"
typedef enum grub_zfs_endian
  {
    GRUB_ZFS_UNKNOWN_ENDIAN = -2,
    GRUB_ZFS_LITTLE_ENDIAN = -1,
    GRUB_ZFS_BIG_ENDIAN = 0
  } grub_zfs_endian_t;
# 111 "./include/grub/zfs/zfs.h"
typedef enum pool_state {
 POOL_STATE_ACTIVE = 0,
 POOL_STATE_EXPORTED,
 POOL_STATE_DESTROYED,
 POOL_STATE_SPARE,
 POOL_STATE_L2CACHE,
 POOL_STATE_UNINITIALIZED,
 POOL_STATE_UNAVAIL,
 POOL_STATE_POTENTIALLY_ACTIVE
} pool_state_t;

struct grub_zfs_data;

grub_err_t grub_zfs_fetch_nvlist (grub_device_t dev, char **nvlist);
grub_err_t grub_zfs_getmdnobj (grub_device_t dev, const char *fsfilename,
          grub_uint64_t *mdnobj);

char *grub_zfs_nvlist_lookup_string (const char *nvlist, const char *name);
char *grub_zfs_nvlist_lookup_nvlist (const char *nvlist, const char *name);
int grub_zfs_nvlist_lookup_uint64 (const char *nvlist, const char *name,
       grub_uint64_t *out);
char *grub_zfs_nvlist_lookup_nvlist_array (const char *nvlist,
        const char *name,
        grub_size_t array_index);
int grub_zfs_nvlist_lookup_nvlist_array_get_nelm (const char *nvlist,
        const char *name);
grub_err_t
grub_zfs_add_key (grub_uint8_t *key_in,
    grub_size_t keylen,
    int passphrase);

extern grub_err_t (*grub_zfs_decrypt) (grub_crypto_cipher_handle_t cipher,
           grub_uint64_t algo,
           void *nonce,
           char *buf, grub_size_t size,
           const grub_uint32_t *expected_mac,
           grub_zfs_endian_t endian);

struct grub_zfs_key;

extern grub_crypto_cipher_handle_t (*grub_zfs_load_key) (const struct grub_zfs_key *key,
        grub_size_t keysize,
        grub_uint64_t salt,
        grub_uint64_t algo);
# 37 "util/grub-fstest.c" 2
# 1 "./include/grub/emu/hostfile.h" 1
# 25 "./include/grub/emu/hostfile.h"
# 1 "./include/grub/osdep/hostfile.h" 1





# 1 "./include/grub/osdep/hostfile_unix.h" 1
# 22 "./include/grub/osdep/hostfile_unix.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/osdep/hostfile_unix.h" 2






# 1 "/usr/include/sys/stat.h" 1 3 4
# 99 "/usr/include/sys/stat.h" 3 4


# 1 "/usr/include/bits/stat.h" 1 3 4
# 46 "/usr/include/bits/stat.h" 3 4

# 46 "/usr/include/bits/stat.h" 3 4
struct stat
  {
    __dev_t st_dev;




    __ino_t st_ino;







    __nlink_t st_nlink;
    __mode_t st_mode;

    __uid_t st_uid;
    __gid_t st_gid;

    int __pad0;

    __dev_t st_rdev;




    __off_t st_size;



    __blksize_t st_blksize;

    __blkcnt_t st_blocks;
# 91 "/usr/include/bits/stat.h" 3 4
    struct timespec st_atim;
    struct timespec st_mtim;
    struct timespec st_ctim;
# 106 "/usr/include/bits/stat.h" 3 4
    __syscall_slong_t __glibc_reserved[3];
# 115 "/usr/include/bits/stat.h" 3 4
  };



struct stat64
  {
    __dev_t st_dev;

    __ino64_t st_ino;
    __nlink_t st_nlink;
    __mode_t st_mode;






    __uid_t st_uid;
    __gid_t st_gid;

    int __pad0;
    __dev_t st_rdev;
    __off_t st_size;





    __blksize_t st_blksize;
    __blkcnt64_t st_blocks;







    struct timespec st_atim;
    struct timespec st_mtim;
    struct timespec st_ctim;
# 164 "/usr/include/bits/stat.h" 3 4
    __syscall_slong_t __glibc_reserved[3];



  };
# 102 "/usr/include/sys/stat.h" 2 3 4
# 213 "/usr/include/sys/stat.h" 3 4
extern int stat (const char *__restrict __file, struct stat *__restrict __buf) __asm__ ("" "stat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (1, 2)));
extern int fstat (int __fd, struct stat *__buf) __asm__ ("" "fstat64") __attribute__ ((__nothrow__ , __leaf__))
     __attribute__ ((__nonnull__ (2)));






extern int stat64 (const char *__restrict __file,
     struct stat64 *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int fstat64 (int __fd, struct stat64 *__buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));
# 239 "/usr/include/sys/stat.h" 3 4
extern int fstatat (int __fd, const char *__restrict __file, struct stat *__restrict __buf, int __flag) __asm__ ("" "fstatat64") __attribute__ ((__nothrow__ , __leaf__))


                 __attribute__ ((__nonnull__ (2, 3)));






extern int fstatat64 (int __fd, const char *__restrict __file,
        struct stat64 *__restrict __buf, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
# 263 "/usr/include/sys/stat.h" 3 4
extern int lstat (const char *__restrict __file, struct stat *__restrict __buf) __asm__ ("" "lstat64") __attribute__ ((__nothrow__ , __leaf__))


     __attribute__ ((__nonnull__ (1, 2)));





extern int lstat64 (const char *__restrict __file,
      struct stat64 *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern int chmod (const char *__file, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int lchmod (const char *__file, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int fchmod (int __fd, __mode_t __mode) __attribute__ ((__nothrow__ , __leaf__));





extern int fchmodat (int __fd, const char *__file, __mode_t __mode,
       int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;






extern __mode_t umask (__mode_t __mask) __attribute__ ((__nothrow__ , __leaf__));




extern __mode_t getumask (void) __attribute__ ((__nothrow__ , __leaf__));



extern int mkdir (const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mkdirat (int __fd, const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));






extern int mknod (const char *__path, __mode_t __mode, __dev_t __dev)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mknodat (int __fd, const char *__path, __mode_t __mode,
      __dev_t __dev) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));





extern int mkfifo (const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mkfifoat (int __fd, const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));





extern int utimensat (int __fd, const char *__path,
        const struct timespec __times[2],
        int __flags)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));




extern int futimens (int __fd, const struct timespec __times[2]) __attribute__ ((__nothrow__ , __leaf__));
# 406 "/usr/include/sys/stat.h" 3 4
extern int __fxstat (int __ver, int __fildes, struct stat *__stat_buf) __asm__ ("" "__fxstat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (3)));
extern int __xstat (int __ver, const char *__filename, struct stat *__stat_buf) __asm__ ("" "__xstat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (2, 3)));
extern int __lxstat (int __ver, const char *__filename, struct stat *__stat_buf) __asm__ ("" "__lxstat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (2, 3)));
extern int __fxstatat (int __ver, int __fildes, const char *__filename, struct stat *__stat_buf, int __flag) __asm__ ("" "__fxstatat64") __attribute__ ((__nothrow__ , __leaf__))


                    __attribute__ ((__nonnull__ (3, 4)));
# 428 "/usr/include/sys/stat.h" 3 4
extern int __fxstat64 (int __ver, int __fildes, struct stat64 *__stat_buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));
extern int __xstat64 (int __ver, const char *__filename,
        struct stat64 *__stat_buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
extern int __lxstat64 (int __ver, const char *__filename,
         struct stat64 *__stat_buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
extern int __fxstatat64 (int __ver, int __fildes, const char *__filename,
    struct stat64 *__stat_buf, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4)));

extern int __xmknod (int __ver, const char *__path, __mode_t __mode,
       __dev_t *__dev) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));

extern int __xmknodat (int __ver, int __fd, const char *__path,
         __mode_t __mode, __dev_t *__dev)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 5)));


# 1 "/usr/include/bits/statx.h" 1 3 4
# 31 "/usr/include/bits/statx.h" 3 4
# 1 "/usr/include/linux/stat.h" 1 3 4




# 1 "/usr/include/linux/types.h" 1 3 4




# 1 "/usr/include/asm/types.h" 1 3 4
# 1 "/usr/include/asm-generic/types.h" 1 3 4






# 1 "/usr/include/asm-generic/int-ll64.h" 1 3 4
# 12 "/usr/include/asm-generic/int-ll64.h" 3 4
# 1 "/usr/include/asm/bitsperlong.h" 1 3 4
# 11 "/usr/include/asm/bitsperlong.h" 3 4
# 1 "/usr/include/asm-generic/bitsperlong.h" 1 3 4
# 12 "/usr/include/asm/bitsperlong.h" 2 3 4
# 13 "/usr/include/asm-generic/int-ll64.h" 2 3 4







typedef __signed__ char __s8;
typedef unsigned char __u8;

typedef __signed__ short __s16;
typedef unsigned short __u16;

typedef __signed__ int __s32;
typedef unsigned int __u32;


__extension__ typedef __signed__ long long __s64;
__extension__ typedef unsigned long long __u64;
# 8 "/usr/include/asm-generic/types.h" 2 3 4
# 2 "/usr/include/asm/types.h" 2 3 4
# 6 "/usr/include/linux/types.h" 2 3 4



# 1 "/usr/include/linux/posix_types.h" 1 3 4




# 1 "/usr/include/linux/stddef.h" 1 3 4
# 6 "/usr/include/linux/posix_types.h" 2 3 4
# 25 "/usr/include/linux/posix_types.h" 3 4
typedef struct {
 unsigned long fds_bits[1024 / (8 * sizeof(long))];
} __kernel_fd_set;


typedef void (*__kernel_sighandler_t)(int);


typedef int __kernel_key_t;
typedef int __kernel_mqd_t;

# 1 "/usr/include/asm/posix_types.h" 1 3 4






# 1 "/usr/include/asm/posix_types_64.h" 1 3 4
# 11 "/usr/include/asm/posix_types_64.h" 3 4
typedef unsigned short __kernel_old_uid_t;
typedef unsigned short __kernel_old_gid_t;


typedef unsigned long __kernel_old_dev_t;


# 1 "/usr/include/asm-generic/posix_types.h" 1 3 4
# 15 "/usr/include/asm-generic/posix_types.h" 3 4
typedef long __kernel_long_t;
typedef unsigned long __kernel_ulong_t;



typedef __kernel_ulong_t __kernel_ino_t;



typedef unsigned int __kernel_mode_t;



typedef int __kernel_pid_t;



typedef int __kernel_ipc_pid_t;



typedef unsigned int __kernel_uid_t;
typedef unsigned int __kernel_gid_t;



typedef __kernel_long_t __kernel_suseconds_t;



typedef int __kernel_daddr_t;



typedef unsigned int __kernel_uid32_t;
typedef unsigned int __kernel_gid32_t;
# 72 "/usr/include/asm-generic/posix_types.h" 3 4
typedef __kernel_ulong_t __kernel_size_t;
typedef __kernel_long_t __kernel_ssize_t;
typedef __kernel_long_t __kernel_ptrdiff_t;




typedef struct {
 int val[2];
} __kernel_fsid_t;





typedef __kernel_long_t __kernel_off_t;
typedef long long __kernel_loff_t;
typedef __kernel_long_t __kernel_old_time_t;
typedef __kernel_long_t __kernel_time_t;
typedef long long __kernel_time64_t;
typedef __kernel_long_t __kernel_clock_t;
typedef int __kernel_timer_t;
typedef int __kernel_clockid_t;
typedef char * __kernel_caddr_t;
typedef unsigned short __kernel_uid16_t;
typedef unsigned short __kernel_gid16_t;
# 19 "/usr/include/asm/posix_types_64.h" 2 3 4
# 8 "/usr/include/asm/posix_types.h" 2 3 4
# 37 "/usr/include/linux/posix_types.h" 2 3 4
# 10 "/usr/include/linux/types.h" 2 3 4
# 24 "/usr/include/linux/types.h" 3 4
typedef __u16 __le16;
typedef __u16 __be16;
typedef __u32 __le32;
typedef __u32 __be32;
typedef __u64 __le64;
typedef __u64 __be64;

typedef __u16 __sum16;
typedef __u32 __wsum;
# 47 "/usr/include/linux/types.h" 3 4
typedef unsigned __poll_t;
# 6 "/usr/include/linux/stat.h" 2 3 4
# 56 "/usr/include/linux/stat.h" 3 4
struct statx_timestamp {
 __s64 tv_sec;
 __u32 tv_nsec;
 __s32 __reserved;
};
# 99 "/usr/include/linux/stat.h" 3 4
struct statx {

 __u32 stx_mask;
 __u32 stx_blksize;
 __u64 stx_attributes;

 __u32 stx_nlink;
 __u32 stx_uid;
 __u32 stx_gid;
 __u16 stx_mode;
 __u16 __spare0[1];

 __u64 stx_ino;
 __u64 stx_size;
 __u64 stx_blocks;
 __u64 stx_attributes_mask;

 struct statx_timestamp stx_atime;
 struct statx_timestamp stx_btime;
 struct statx_timestamp stx_ctime;
 struct statx_timestamp stx_mtime;

 __u32 stx_rdev_major;
 __u32 stx_rdev_minor;
 __u32 stx_dev_major;
 __u32 stx_dev_minor;

 __u64 stx_mnt_id;
 __u64 __spare2;

 __u64 __spare3[12];

};
# 32 "/usr/include/bits/statx.h" 2 3 4







# 1 "/usr/include/bits/statx-generic.h" 1 3 4
# 25 "/usr/include/bits/statx-generic.h" 3 4
# 1 "/usr/include/bits/types/struct_statx_timestamp.h" 1 3 4
# 26 "/usr/include/bits/statx-generic.h" 2 3 4
# 1 "/usr/include/bits/types/struct_statx.h" 1 3 4
# 27 "/usr/include/bits/statx-generic.h" 2 3 4
# 54 "/usr/include/bits/statx-generic.h" 3 4



int statx (int __dirfd, const char *__restrict __path, int __flags,
           unsigned int __mask, struct statx *__restrict __buf)
  __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 5)));


# 40 "/usr/include/bits/statx.h" 2 3 4
# 447 "/usr/include/sys/stat.h" 2 3 4
# 534 "/usr/include/sys/stat.h" 3 4

# 30 "./include/grub/osdep/hostfile_unix.h" 2
# 1 "/usr/include/fcntl.h" 1 3 4
# 28 "/usr/include/fcntl.h" 3 4







# 1 "/usr/include/bits/fcntl.h" 1 3 4
# 35 "/usr/include/bits/fcntl.h" 3 4
struct flock
  {
    short int l_type;
    short int l_whence;




    __off64_t l_start;
    __off64_t l_len;

    __pid_t l_pid;
  };


struct flock64
  {
    short int l_type;
    short int l_whence;
    __off64_t l_start;
    __off64_t l_len;
    __pid_t l_pid;
  };



# 1 "/usr/include/bits/fcntl-linux.h" 1 3 4
# 38 "/usr/include/bits/fcntl-linux.h" 3 4
# 1 "/usr/include/bits/types/struct_iovec.h" 1 3 4
# 23 "/usr/include/bits/types/struct_iovec.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 24 "/usr/include/bits/types/struct_iovec.h" 2 3 4


struct iovec
  {
    void *iov_base;
    size_t iov_len;
  };
# 39 "/usr/include/bits/fcntl-linux.h" 2 3 4
# 265 "/usr/include/bits/fcntl-linux.h" 3 4
enum __pid_type
  {
    F_OWNER_TID = 0,
    F_OWNER_PID,
    F_OWNER_PGRP,
    F_OWNER_GID = F_OWNER_PGRP
  };


struct f_owner_ex
  {
    enum __pid_type type;
    __pid_t pid;
  };
# 354 "/usr/include/bits/fcntl-linux.h" 3 4
# 1 "/usr/include/linux/falloc.h" 1 3 4
# 355 "/usr/include/bits/fcntl-linux.h" 2 3 4



struct file_handle
{
  unsigned int handle_bytes;
  int handle_type;

  unsigned char f_handle[0];
};










extern __ssize_t readahead (int __fd, __off64_t __offset, size_t __count)
    __attribute__ ((__nothrow__ , __leaf__));






extern int sync_file_range (int __fd, __off64_t __offset, __off64_t __count,
       unsigned int __flags);






extern __ssize_t vmsplice (int __fdout, const struct iovec *__iov,
      size_t __count, unsigned int __flags);





extern __ssize_t splice (int __fdin, __off64_t *__offin, int __fdout,
    __off64_t *__offout, size_t __len,
    unsigned int __flags);





extern __ssize_t tee (int __fdin, int __fdout, size_t __len,
        unsigned int __flags);
# 417 "/usr/include/bits/fcntl-linux.h" 3 4
extern int fallocate (int __fd, int __mode, __off64_t __offset, __off64_t __len) __asm__ ("" "fallocate64")

                     ;





extern int fallocate64 (int __fd, int __mode, __off64_t __offset,
   __off64_t __len);




extern int name_to_handle_at (int __dfd, const char *__name,
         struct file_handle *__handle, int *__mnt_id,
         int __flags) __attribute__ ((__nothrow__ , __leaf__));





extern int open_by_handle_at (int __mountdirfd, struct file_handle *__handle,
         int __flags);




# 62 "/usr/include/bits/fcntl.h" 2 3 4
# 36 "/usr/include/fcntl.h" 2 3 4
# 78 "/usr/include/fcntl.h" 3 4
# 1 "/usr/include/bits/stat.h" 1 3 4
# 79 "/usr/include/fcntl.h" 2 3 4
# 179 "/usr/include/fcntl.h" 3 4
extern int fcntl (int __fd, int __cmd, ...) __asm__ ("" "fcntl64");





extern int fcntl64 (int __fd, int __cmd, ...);
# 199 "/usr/include/fcntl.h" 3 4
extern int open (const char *__file, int __oflag, ...) __asm__ ("" "open64")
     __attribute__ ((__nonnull__ (1)));





extern int open64 (const char *__file, int __oflag, ...) __attribute__ ((__nonnull__ (1)));
# 224 "/usr/include/fcntl.h" 3 4
extern int openat (int __fd, const char *__file, int __oflag, ...) __asm__ ("" "openat64")
                    __attribute__ ((__nonnull__ (2)));





extern int openat64 (int __fd, const char *__file, int __oflag, ...)
     __attribute__ ((__nonnull__ (2)));
# 245 "/usr/include/fcntl.h" 3 4
extern int creat (const char *__file, mode_t __mode) __asm__ ("" "creat64")
                  __attribute__ ((__nonnull__ (1)));





extern int creat64 (const char *__file, mode_t __mode) __attribute__ ((__nonnull__ (1)));
# 292 "/usr/include/fcntl.h" 3 4
extern int posix_fadvise (int __fd, __off64_t __offset, __off64_t __len, int __advise) __asm__ ("" "posix_fadvise64") __attribute__ ((__nothrow__ , __leaf__))

                      ;





extern int posix_fadvise64 (int __fd, off64_t __offset, off64_t __len,
       int __advise) __attribute__ ((__nothrow__ , __leaf__));
# 313 "/usr/include/fcntl.h" 3 4
extern int posix_fallocate (int __fd, __off64_t __offset, __off64_t __len) __asm__ ("" "posix_fallocate64")

                           ;





extern int posix_fallocate64 (int __fd, off64_t __offset, off64_t __len);
# 332 "/usr/include/fcntl.h" 3 4

# 31 "./include/grub/osdep/hostfile_unix.h" 2
# 1 "/usr/include/dirent.h" 1 3 4
# 27 "/usr/include/dirent.h" 3 4

# 61 "/usr/include/dirent.h" 3 4
# 1 "/usr/include/bits/dirent.h" 1 3 4
# 22 "/usr/include/bits/dirent.h" 3 4
struct dirent
  {




    __ino64_t d_ino;
    __off64_t d_off;

    unsigned short int d_reclen;
    unsigned char d_type;
    char d_name[256];
  };


struct dirent64
  {
    __ino64_t d_ino;
    __off64_t d_off;
    unsigned short int d_reclen;
    unsigned char d_type;
    char d_name[256];
  };
# 62 "/usr/include/dirent.h" 2 3 4
# 97 "/usr/include/dirent.h" 3 4
enum
  {
    DT_UNKNOWN = 0,

    DT_FIFO = 1,

    DT_CHR = 2,

    DT_DIR = 4,

    DT_BLK = 6,

    DT_REG = 8,

    DT_LNK = 10,

    DT_SOCK = 12,

    DT_WHT = 14

  };
# 127 "/usr/include/dirent.h" 3 4
typedef struct __dirstream DIR;






extern DIR *opendir (const char *__name) __attribute__ ((__nonnull__ (1)));






extern DIR *fdopendir (int __fd);







extern int closedir (DIR *__dirp) __attribute__ ((__nonnull__ (1)));
# 165 "/usr/include/dirent.h" 3 4
extern struct dirent *readdir (DIR *__dirp) __asm__ ("" "readdir64")
     __attribute__ ((__nonnull__ (1)));






extern struct dirent64 *readdir64 (DIR *__dirp) __attribute__ ((__nonnull__ (1)));
# 189 "/usr/include/dirent.h" 3 4
extern int readdir_r (DIR *__restrict __dirp, struct dirent *__restrict __entry, struct dirent **__restrict __result) __asm__ ("" "readdir64_r")




  __attribute__ ((__nonnull__ (1, 2, 3))) __attribute__ ((__deprecated__));






extern int readdir64_r (DIR *__restrict __dirp,
   struct dirent64 *__restrict __entry,
   struct dirent64 **__restrict __result)
  __attribute__ ((__nonnull__ (1, 2, 3))) __attribute__ ((__deprecated__));




extern void rewinddir (DIR *__dirp) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern void seekdir (DIR *__dirp, long int __pos) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int telldir (DIR *__dirp) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int dirfd (DIR *__dirp) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 233 "/usr/include/dirent.h" 3 4
# 1 "/usr/include/bits/posix1_lim.h" 1 3 4
# 27 "/usr/include/bits/posix1_lim.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 28 "/usr/include/bits/posix1_lim.h" 2 3 4
# 161 "/usr/include/bits/posix1_lim.h" 3 4
# 1 "/usr/include/bits/local_lim.h" 1 3 4
# 38 "/usr/include/bits/local_lim.h" 3 4
# 1 "/usr/include/linux/limits.h" 1 3 4
# 39 "/usr/include/bits/local_lim.h" 2 3 4
# 162 "/usr/include/bits/posix1_lim.h" 2 3 4
# 234 "/usr/include/dirent.h" 2 3 4
# 245 "/usr/include/dirent.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 246 "/usr/include/dirent.h" 2 3 4
# 263 "/usr/include/dirent.h" 3 4
extern int scandir (const char *__restrict __dir, struct dirent ***__restrict __namelist, int (*__selector) (const struct dirent *), int (*__cmp) (const struct dirent **, const struct dirent **)) __asm__ ("" "scandir64")





                    __attribute__ ((__nonnull__ (1, 2)));
# 278 "/usr/include/dirent.h" 3 4
extern int scandir64 (const char *__restrict __dir,
        struct dirent64 ***__restrict __namelist,
        int (*__selector) (const struct dirent64 *),
        int (*__cmp) (const struct dirent64 **,
        const struct dirent64 **))
     __attribute__ ((__nonnull__ (1, 2)));
# 301 "/usr/include/dirent.h" 3 4
extern int scandirat (int __dfd, const char *__restrict __dir, struct dirent ***__restrict __namelist, int (*__selector) (const struct dirent *), int (*__cmp) (const struct dirent **, const struct dirent **)) __asm__ ("" "scandirat64")





                      __attribute__ ((__nonnull__ (2, 3)));







extern int scandirat64 (int __dfd, const char *__restrict __dir,
   struct dirent64 ***__restrict __namelist,
   int (*__selector) (const struct dirent64 *),
   int (*__cmp) (const struct dirent64 **,
          const struct dirent64 **))
     __attribute__ ((__nonnull__ (2, 3)));
# 330 "/usr/include/dirent.h" 3 4
extern int alphasort (const struct dirent **__e1, const struct dirent **__e2) __asm__ ("" "alphasort64") __attribute__ ((__nothrow__ , __leaf__))


                   __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));






extern int alphasort64 (const struct dirent64 **__e1,
   const struct dirent64 **__e2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 359 "/usr/include/dirent.h" 3 4
extern __ssize_t getdirentries (int __fd, char *__restrict __buf, size_t __nbytes, __off64_t *__restrict __basep) __asm__ ("" "getdirentries64") __attribute__ ((__nothrow__ , __leaf__))



                      __attribute__ ((__nonnull__ (2, 4)));






extern __ssize_t getdirentries64 (int __fd, char *__restrict __buf,
      size_t __nbytes,
      __off64_t *__restrict __basep)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));
# 385 "/usr/include/dirent.h" 3 4
extern int versionsort (const struct dirent **__e1, const struct dirent **__e2) __asm__ ("" "versionsort64") __attribute__ ((__nothrow__ , __leaf__))



     __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));






extern int versionsort64 (const struct dirent64 **__e1,
     const struct dirent64 **__e2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));





# 1 "/usr/include/bits/dirent_ext.h" 1 3 4
# 23 "/usr/include/bits/dirent_ext.h" 3 4






extern __ssize_t getdents64 (int __fd, void *__buffer, size_t __length)
  __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



# 405 "/usr/include/dirent.h" 2 3 4
# 32 "./include/grub/osdep/hostfile_unix.h" 2




# 35 "./include/grub/osdep/hostfile_unix.h"
typedef struct dirent *grub_util_fd_dirent_t;
typedef DIR *grub_util_fd_dir_t;

static inline grub_util_fd_dir_t
grub_util_fd_opendir (const char *name)
{
  return opendir (name);
}

static inline void
grub_util_fd_closedir (grub_util_fd_dir_t dirp)
{
  closedir (dirp);
}

static inline grub_util_fd_dirent_t
grub_util_fd_readdir (grub_util_fd_dir_t dirp)
{
  return readdir (dirp);
}

static inline int
grub_util_unlink (const char *pathname)
{
  return unlink (pathname);
}

static inline int
grub_util_rmdir (const char *pathname)
{
  return rmdir (pathname);
}

static inline int
grub_util_rename (const char *from, const char *to)
{
  return rename (from, to);
}

static inline ssize_t
grub_util_readlink (const char *name, char *buf, size_t bufsize)
{
  return readlink(name, buf, bufsize);
}
# 89 "./include/grub/osdep/hostfile_unix.h"
enum grub_util_fd_open_flags_t
  {
    GRUB_UTIL_FD_O_RDONLY = 
# 91 "./include/grub/osdep/hostfile_unix.h" 3 4
                           00
# 91 "./include/grub/osdep/hostfile_unix.h"
                                   ,
    GRUB_UTIL_FD_O_WRONLY = 
# 92 "./include/grub/osdep/hostfile_unix.h" 3 4
                           01
# 92 "./include/grub/osdep/hostfile_unix.h"
                                   ,
    GRUB_UTIL_FD_O_RDWR = 
# 93 "./include/grub/osdep/hostfile_unix.h" 3 4
                         02
# 93 "./include/grub/osdep/hostfile_unix.h"
                               ,
    GRUB_UTIL_FD_O_CREATTRUNC = 
# 94 "./include/grub/osdep/hostfile_unix.h" 3 4
                               0100 
# 94 "./include/grub/osdep/hostfile_unix.h"
                                       | 
# 94 "./include/grub/osdep/hostfile_unix.h" 3 4
                                         01000
# 94 "./include/grub/osdep/hostfile_unix.h"
                                                ,
    GRUB_UTIL_FD_O_SYNC = (0

      | 
# 97 "./include/grub/osdep/hostfile_unix.h" 3 4
       04010000


      
# 100 "./include/grub/osdep/hostfile_unix.h"
     | 
# 100 "./include/grub/osdep/hostfile_unix.h" 3 4
       04010000

      
# 102 "./include/grub/osdep/hostfile_unix.h"
     )
  };



typedef int grub_util_fd_t;
# 7 "./include/grub/osdep/hostfile.h" 2
# 26 "./include/grub/emu/hostfile.h" 2

int
grub_util_is_directory (const char *path);
int
grub_util_is_special_file (const char *path);
int
grub_util_is_regular (const char *path);

char *
grub_util_path_concat (size_t n, ...);
char *
grub_util_path_concat_ext (size_t n, ...);

int
grub_util_fd_seek (grub_util_fd_t fd, grub_uint64_t off);
ssize_t
grub_util_fd_read (grub_util_fd_t fd, char *buf, size_t len);
ssize_t
grub_util_fd_write (grub_util_fd_t fd, const char *buf, size_t len);

grub_util_fd_t
grub_util_fd_open (const char *os_dev, int flags);
const char *
grub_util_fd_strerror (void);
int
grub_util_fd_sync (grub_util_fd_t fd);
void
grub_util_disable_fd_syncs (void);
int
grub_util_fd_close (grub_util_fd_t fd);

grub_uint64_t
grub_util_get_fd_size (grub_util_fd_t fd, const char *name, unsigned *log_secsize);
char *
grub_util_make_temporary_file (void);
char *
grub_util_make_temporary_dir (void);
void
grub_util_unlink_recursive (const char *name);
grub_uint32_t
grub_util_get_mtime (const char *name);
# 38 "util/grub-fstest.c" 2


# 1 "/usr/include/errno.h" 1 3 4
# 28 "/usr/include/errno.h" 3 4
# 1 "/usr/include/bits/errno.h" 1 3 4
# 26 "/usr/include/bits/errno.h" 3 4
# 1 "/usr/include/linux/errno.h" 1 3 4
# 1 "/usr/include/asm/errno.h" 1 3 4
# 1 "/usr/include/asm-generic/errno.h" 1 3 4




# 1 "/usr/include/asm-generic/errno-base.h" 1 3 4
# 6 "/usr/include/asm-generic/errno.h" 2 3 4
# 2 "/usr/include/asm/errno.h" 2 3 4
# 2 "/usr/include/linux/errno.h" 2 3 4
# 27 "/usr/include/bits/errno.h" 2 3 4
# 29 "/usr/include/errno.h" 2 3 4









# 37 "/usr/include/errno.h" 3 4
extern int *__errno_location (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));







extern char *program_invocation_name;
extern char *program_invocation_short_name;

# 1 "/usr/include/bits/types/error_t.h" 1 3 4
# 22 "/usr/include/bits/types/error_t.h" 3 4
typedef int error_t;
# 49 "/usr/include/errno.h" 2 3 4




# 41 "util/grub-fstest.c" 2
# 1 "/usr/include/string.h" 1 3 4
# 26 "/usr/include/string.h" 3 4
# 1 "/usr/include/bits/libc-header-start.h" 1 3 4
# 27 "/usr/include/string.h" 2 3 4






# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 34 "/usr/include/string.h" 2 3 4
# 43 "/usr/include/string.h" 3 4
extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
       size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern void *memmove (void *__dest, const void *__src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern void *memccpy (void *__restrict __dest, const void *__restrict __src,
        int __c, size_t __n)
    __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) __attribute__ ((__access__ (__write_only__, 1, 4)));




extern void *memset (void *__s, int __c, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int memcmp (const void *__s1, const void *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 91 "/usr/include/string.h" 3 4
extern void *memchr (const void *__s, int __c, size_t __n)
      __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 104 "/usr/include/string.h" 3 4
extern void *rawmemchr (const void *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 117 "/usr/include/string.h" 3 4
extern void *memrchr (const void *__s, int __c, size_t __n)
      __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)))
      __attribute__ ((__access__ (__read_only__, 1, 3)));





extern char *strcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern char *strncpy (char *__restrict __dest,
        const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern char *strcat (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern char *strncat (char *__restrict __dest, const char *__restrict __src,
        size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strcmp (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));

extern int strncmp (const char *__s1, const char *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strcoll (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));

extern size_t strxfrm (char *__restrict __dest,
         const char *__restrict __src, size_t __n)
    __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 1, 3)));






extern int strcoll_l (const char *__s1, const char *__s2, locale_t __l)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 3)));


extern size_t strxfrm_l (char *__dest, const char *__src, size_t __n,
    locale_t __l) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)))
     __attribute__ ((__access__ (__write_only__, 1, 3)));





extern char *strdup (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));






extern char *strndup (const char *__string, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));
# 230 "/usr/include/string.h" 3 4
extern char *strchr (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 257 "/usr/include/string.h" 3 4
extern char *strrchr (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 270 "/usr/include/string.h" 3 4
extern char *strchrnul (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));





extern size_t strcspn (const char *__s, const char *__reject)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern size_t strspn (const char *__s, const char *__accept)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 307 "/usr/include/string.h" 3 4
extern char *strpbrk (const char *__s, const char *__accept)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 334 "/usr/include/string.h" 3 4
extern char *strstr (const char *__haystack, const char *__needle)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));




extern char *strtok (char *__restrict __s, const char *__restrict __delim)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



extern char *__strtok_r (char *__restrict __s,
    const char *__restrict __delim,
    char **__restrict __save_ptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));

extern char *strtok_r (char *__restrict __s, const char *__restrict __delim,
         char **__restrict __save_ptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
# 364 "/usr/include/string.h" 3 4
extern char *strcasestr (const char *__haystack, const char *__needle)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));







extern void *memmem (const void *__haystack, size_t __haystacklen,
       const void *__needle, size_t __needlelen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 3)))
    __attribute__ ((__access__ (__read_only__, 1, 2)))
    __attribute__ ((__access__ (__read_only__, 3, 4)));



extern void *__mempcpy (void *__restrict __dest,
   const void *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern void *mempcpy (void *__restrict __dest,
        const void *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern size_t strlen (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));




extern size_t strnlen (const char *__string, size_t __maxlen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));




extern char *strerror (int __errnum) __attribute__ ((__nothrow__ , __leaf__));
# 428 "/usr/include/string.h" 3 4
extern char *strerror_r (int __errnum, char *__buf, size_t __buflen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 2, 3)));




extern const char *strerrordesc_np (int __err) __attribute__ ((__nothrow__ , __leaf__));

extern const char *strerrorname_np (int __err) __attribute__ ((__nothrow__ , __leaf__));





extern char *strerror_l (int __errnum, locale_t __l) __attribute__ ((__nothrow__ , __leaf__));



# 1 "/usr/include/strings.h" 1 3 4
# 23 "/usr/include/strings.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 24 "/usr/include/strings.h" 2 3 4










extern int bcmp (const void *__s1, const void *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern void bcopy (const void *__src, void *__dest, size_t __n)
  __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern void bzero (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 68 "/usr/include/strings.h" 3 4
extern char *index (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 96 "/usr/include/strings.h" 3 4
extern char *rindex (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));






extern int ffs (int __i) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));





extern int ffsl (long int __l) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
__extension__ extern int ffsll (long long int __ll)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));



extern int strcasecmp (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strncasecmp (const char *__s1, const char *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));






extern int strcasecmp_l (const char *__s1, const char *__s2, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 3)));



extern int strncasecmp_l (const char *__s1, const char *__s2,
     size_t __n, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 4)));



# 447 "/usr/include/string.h" 2 3 4



extern void explicit_bzero (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));



extern char *strsep (char **__restrict __stringp,
       const char *__restrict __delim)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern char *strsignal (int __sig) __attribute__ ((__nothrow__ , __leaf__));



extern const char *sigabbrev_np (int __sig) __attribute__ ((__nothrow__ , __leaf__));


extern const char *sigdescr_np (int __sig) __attribute__ ((__nothrow__ , __leaf__));



extern char *__stpcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern char *__stpncpy (char *__restrict __dest,
   const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpncpy (char *__restrict __dest,
        const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int strverscmp (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern char *strfry (char *__string) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern void *memfrob (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));
# 511 "/usr/include/string.h" 3 4
extern char *basename (const char *__filename) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 523 "/usr/include/string.h" 3 4

# 42 "util/grub-fstest.c" 2

# 1 "./grub-core/lib/gnulib/progname.h" 1
# 32 "./grub-core/lib/gnulib/progname.h"

# 32 "./grub-core/lib/gnulib/progname.h"
extern const char *program_name;




extern void set_program_name (const char *argv0);
# 44 "util/grub-fstest.c" 2
#pragma GCC diagnostic ignored "-Wmissing-prototypes"
#pragma GCC diagnostic ignored "-Wmissing-declarations"
# 1 "./grub-core/lib/gnulib/argp.h" 1
# 23 "./grub-core/lib/gnulib/argp.h"
# 1 "/usr/include/ctype.h" 1 3 4
# 28 "/usr/include/ctype.h" 3 4

# 46 "/usr/include/ctype.h" 3 4

# 46 "/usr/include/ctype.h" 3 4
enum
{
  _ISupper = ((0) < 8 ? ((1 << (0)) << 8) : ((1 << (0)) >> 8)),
  _ISlower = ((1) < 8 ? ((1 << (1)) << 8) : ((1 << (1)) >> 8)),
  _ISalpha = ((2) < 8 ? ((1 << (2)) << 8) : ((1 << (2)) >> 8)),
  _ISdigit = ((3) < 8 ? ((1 << (3)) << 8) : ((1 << (3)) >> 8)),
  _ISxdigit = ((4) < 8 ? ((1 << (4)) << 8) : ((1 << (4)) >> 8)),
  _ISspace = ((5) < 8 ? ((1 << (5)) << 8) : ((1 << (5)) >> 8)),
  _ISprint = ((6) < 8 ? ((1 << (6)) << 8) : ((1 << (6)) >> 8)),
  _ISgraph = ((7) < 8 ? ((1 << (7)) << 8) : ((1 << (7)) >> 8)),
  _ISblank = ((8) < 8 ? ((1 << (8)) << 8) : ((1 << (8)) >> 8)),
  _IScntrl = ((9) < 8 ? ((1 << (9)) << 8) : ((1 << (9)) >> 8)),
  _ISpunct = ((10) < 8 ? ((1 << (10)) << 8) : ((1 << (10)) >> 8)),
  _ISalnum = ((11) < 8 ? ((1 << (11)) << 8) : ((1 << (11)) >> 8))
};
# 79 "/usr/include/ctype.h" 3 4
extern const unsigned short int **__ctype_b_loc (void)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
extern const __int32_t **__ctype_tolower_loc (void)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
extern const __int32_t **__ctype_toupper_loc (void)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
# 108 "/usr/include/ctype.h" 3 4
extern int isalnum (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isalpha (int) __attribute__ ((__nothrow__ , __leaf__));
extern int iscntrl (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isdigit (int) __attribute__ ((__nothrow__ , __leaf__));
extern int islower (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isgraph (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isprint (int) __attribute__ ((__nothrow__ , __leaf__));
extern int ispunct (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isspace (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isupper (int) __attribute__ ((__nothrow__ , __leaf__));
extern int isxdigit (int) __attribute__ ((__nothrow__ , __leaf__));



extern int tolower (int __c) __attribute__ ((__nothrow__ , __leaf__));


extern int toupper (int __c) __attribute__ ((__nothrow__ , __leaf__));




extern int isblank (int) __attribute__ ((__nothrow__ , __leaf__));




extern int isctype (int __c, int __mask) __attribute__ ((__nothrow__ , __leaf__));






extern int isascii (int __c) __attribute__ ((__nothrow__ , __leaf__));



extern int toascii (int __c) __attribute__ ((__nothrow__ , __leaf__));



extern int _toupper (int) __attribute__ ((__nothrow__ , __leaf__));
extern int _tolower (int) __attribute__ ((__nothrow__ , __leaf__));
# 251 "/usr/include/ctype.h" 3 4
extern int isalnum_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isalpha_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int iscntrl_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isdigit_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int islower_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isgraph_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isprint_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int ispunct_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isspace_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isupper_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));
extern int isxdigit_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));

extern int isblank_l (int, locale_t) __attribute__ ((__nothrow__ , __leaf__));



extern int __tolower_l (int __c, locale_t __l) __attribute__ ((__nothrow__ , __leaf__));
extern int tolower_l (int __c, locale_t __l) __attribute__ ((__nothrow__ , __leaf__));


extern int __toupper_l (int __c, locale_t __l) __attribute__ ((__nothrow__ , __leaf__));
extern int toupper_l (int __c, locale_t __l) __attribute__ ((__nothrow__ , __leaf__));
# 327 "/usr/include/ctype.h" 3 4

# 24 "./grub-core/lib/gnulib/argp.h" 2
# 1 "/usr/include/getopt.h" 1 3 4
# 36 "/usr/include/getopt.h" 3 4
# 1 "/usr/include/bits/getopt_ext.h" 1 3 4
# 27 "/usr/include/bits/getopt_ext.h" 3 4

# 50 "/usr/include/bits/getopt_ext.h" 3 4
struct option
{
  const char *name;


  int has_arg;
  int *flag;
  int val;
};







extern int getopt_long (int ___argc, char *const *___argv,
   const char *__shortopts,
          const struct option *__longopts, int *__longind)
       __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
extern int getopt_long_only (int ___argc, char *const *___argv,
        const char *__shortopts,
               const struct option *__longopts, int *__longind)
       __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));


# 37 "/usr/include/getopt.h" 2 3 4
# 25 "./grub-core/lib/gnulib/argp.h" 2
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include-fixed/limits.h" 1 3 4
# 34 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include-fixed/limits.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include-fixed/syslimits.h" 1 3 4






# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include-fixed/limits.h" 1 3 4
# 195 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include-fixed/limits.h" 3 4
# 1 "/usr/include/limits.h" 1 3 4
# 26 "/usr/include/limits.h" 3 4
# 1 "/usr/include/bits/libc-header-start.h" 1 3 4
# 27 "/usr/include/limits.h" 2 3 4
# 187 "/usr/include/limits.h" 3 4
# 1 "/usr/include/bits/posix2_lim.h" 1 3 4
# 188 "/usr/include/limits.h" 2 3 4



# 1 "/usr/include/bits/xopen_lim.h" 1 3 4
# 64 "/usr/include/bits/xopen_lim.h" 3 4
# 1 "/usr/include/bits/uio_lim.h" 1 3 4
# 65 "/usr/include/bits/xopen_lim.h" 2 3 4
# 192 "/usr/include/limits.h" 2 3 4
# 196 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include-fixed/limits.h" 2 3 4
# 8 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include-fixed/syslimits.h" 2 3 4
# 35 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include-fixed/limits.h" 2 3 4
# 26 "./grub-core/lib/gnulib/argp.h" 2
# 77 "./grub-core/lib/gnulib/argp.h"

# 77 "./grub-core/lib/gnulib/argp.h"
struct argp_option
{


  const char *name;



  int key;



  const char *arg;


  int flags;
# 101 "./grub-core/lib/gnulib/argp.h"
  const char *doc;
# 110 "./grub-core/lib/gnulib/argp.h"
  int group;
};
# 150 "./grub-core/lib/gnulib/argp.h"
struct argp;
struct argp_state;
struct argp_child;


typedef error_t (*argp_parser_t) (int __key, char *__arg,
                                  struct argp_state *__state);
# 224 "./grub-core/lib/gnulib/argp.h"
struct argp
{


  const struct argp_option *options;
# 237 "./grub-core/lib/gnulib/argp.h"
  argp_parser_t parser;






  const char *args_doc;






  const char *doc;







  const struct argp_child *children;
# 271 "./grub-core/lib/gnulib/argp.h"
  char *(*help_filter) (int __key, const char *__text, void *__input);




  const char *argp_domain;
};
# 292 "./grub-core/lib/gnulib/argp.h"
struct argp_child
{

  const struct argp *argp;


  int flags;





  const char *header;







  int group;
};



struct argp_state
{

  const struct argp *root_argp;


  int argc;
  char **argv;


  int next;


  unsigned flags;





  unsigned arg_num;




  int quoted;


  void *input;


  void **child_inputs;


  void *hook;



  char *name;


  FILE *err_stream;
  FILE *out_stream;

  void *pstate;
};
# 414 "./grub-core/lib/gnulib/argp.h"
extern error_t argp_parse (const struct argp *__restrict __argp,
                           int , char **__restrict ,
                           unsigned __flags, int *__restrict __arg_index,
                           void *__restrict __input);
extern error_t __argp_parse (const struct argp *__restrict __argp,
                             int , char **__restrict ,
                             unsigned __flags, int *__restrict __arg_index,
                             void *__restrict __input);
# 443 "./grub-core/lib/gnulib/argp.h"
extern const char *argp_program_version;






extern void (*argp_program_version_hook) (FILE *__restrict __stream,
                                          struct argp_state *__restrict
                                          __state);






extern const char *argp_program_bug_address;




extern error_t argp_err_exit_status;
# 497 "./grub-core/lib/gnulib/argp.h"
extern void argp_help (const struct argp *__restrict __argp,
                       FILE *__restrict __stream,
                       unsigned __flags, char *__restrict __name);
extern void __argp_help (const struct argp *__restrict __argp,
                         FILE *__restrict __stream, unsigned __flags,
                         char *__name);
# 514 "./grub-core/lib/gnulib/argp.h"
extern void argp_state_help (const struct argp_state *__restrict __state,
                             FILE *__restrict __stream,
                             unsigned int __flags);
extern void __argp_state_help (const struct argp_state *__restrict __state,
                               FILE *__restrict __stream,
                               unsigned int __flags);
# 530 "./grub-core/lib/gnulib/argp.h"
extern void argp_error (const struct argp_state *__restrict __state,
                        const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));
extern void __argp_error (const struct argp_state *__restrict __state,
                          const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));
# 545 "./grub-core/lib/gnulib/argp.h"
extern void argp_failure (const struct argp_state *__restrict __state,
                          int __status, int __errnum,
                          const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 4, 5)));
extern void __argp_failure (const struct argp_state *__restrict __state,
                            int __status, int __errnum,
                            const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 4, 5)));
# 567 "./grub-core/lib/gnulib/argp.h"
extern void *_argp_input (const struct argp *__restrict __argp,
                          const struct argp_state *__restrict __state)
     
# 569 "./grub-core/lib/gnulib/argp.h" 3 4
    __attribute__ ((__nothrow__ , __leaf__))
# 569 "./grub-core/lib/gnulib/argp.h"
           ;
extern void *__argp_input (const struct argp *__restrict __argp,
                           const struct argp_state *__restrict __state)
     
# 572 "./grub-core/lib/gnulib/argp.h" 3 4
    __attribute__ ((__nothrow__ , __leaf__))
# 572 "./grub-core/lib/gnulib/argp.h"
           ;
# 584 "./grub-core/lib/gnulib/argp.h"

# 594 "./grub-core/lib/gnulib/argp.h"
inline void
argp_usage (const struct argp_state *__state)
{
  argp_state_help (__state, 
# 597 "./grub-core/lib/gnulib/argp.h" 3 4
                             stderr
# 597 "./grub-core/lib/gnulib/argp.h"
                                   , (0x02 | 0x04 | 0x100));
}

inline int

# 601 "./grub-core/lib/gnulib/argp.h" 3 4
__attribute__ ((__nothrow__ , __leaf__)) 
# 601 "./grub-core/lib/gnulib/argp.h"
_option_is_short (const struct argp_option *__opt)
{
  if (__opt->flags & 0x8)
    return 0;
  else
    {
      int __key = __opt->key;
      return __key > 0 && __key <= 
# 608 "./grub-core/lib/gnulib/argp.h" 3 4
                                  (0x7f * 2 + 1) 
# 608 "./grub-core/lib/gnulib/argp.h"
                                            && 
# 608 "./grub-core/lib/gnulib/argp.h" 3 4
                                               ((*__ctype_b_loc ())[(int) ((
# 608 "./grub-core/lib/gnulib/argp.h"
                                               __key
# 608 "./grub-core/lib/gnulib/argp.h" 3 4
                                               ))] & (unsigned short int) _ISprint)
# 608 "./grub-core/lib/gnulib/argp.h"
                                                              ;
    }
}

inline int

# 613 "./grub-core/lib/gnulib/argp.h" 3 4
__attribute__ ((__nothrow__ , __leaf__)) 
# 613 "./grub-core/lib/gnulib/argp.h"
_option_is_end (const struct argp_option *__opt)
{
  return !__opt->key && !__opt->name && !__opt->doc && !__opt->group;
}







# 47 "util/grub-fstest.c" 2
#pragma GCC diagnostic error "-Wmissing-prototypes"
#pragma GCC diagnostic error "-Wmissing-declarations"

static grub_err_t
execute_command (const char *name, int n, char **args)
{
  grub_command_t cmd;

  cmd = grub_command_find (name);
  if (! cmd)
    grub_util_error (_("can't find command `%s'"), name);

  return (cmd->func) (cmd, n, args);
}

enum {
  CMD_LS = 1,
  CMD_CP,
  CMD_CAT,
  CMD_CMP,
  CMD_HEX,
  CMD_CRC,
  CMD_BLOCKLIST,
  CMD_TESTLOAD,
  CMD_ZFSINFO,
  CMD_XNU_UUID
};


static grub_disk_addr_t skip, leng;
static int uncompress = 0;

static void
read_file (char *pathname, int (*hook) (grub_off_t ofs, char *buf, int len, void *hook_arg), void *hook_arg)
{
  static char buf[32256];
  grub_file_t file;

  if ((pathname[0] == '-') && (pathname[1] == 0))
    {
      grub_device_t dev;

      dev = grub_device_open (0);
      if ((! dev) || (! dev->disk))
        grub_util_error ("%s", grub_errmsg);

      grub_util_info ("total sectors : %" "llu",
                      (unsigned long long) dev->disk->total_sectors);

      if (! leng)
        leng = (dev->disk->total_sectors << 9) - skip;

      while (leng)
        {
          grub_size_t len;

          len = (leng > 32256) ? 32256 : leng;

          if (grub_disk_read (dev->disk, 0, skip, len, buf))
     {
       char *msg = grub_xasprintf (_("disk read fails at offset %lld, length %lld"),
       (long long) skip, (long long) len);
       grub_util_error ("%s", msg);
     }

          if (hook (skip, buf, len, hook_arg))
            break;

          skip += len;
          leng -= len;
        }

      grub_device_close (dev);
      return;
    }

  file = grub_file_open (pathname, ((uncompress == 0)
        ? GRUB_FILE_TYPE_NO_DECOMPRESS : GRUB_FILE_TYPE_NONE)
    | GRUB_FILE_TYPE_FSTEST);
  if (!file)
    {
      grub_util_error (_("cannot open `%s': %s"), pathname,
         grub_errmsg);
      return;
    }

  grub_util_info ("file size : %" "llu",
    (unsigned long long) file->size);

  if (skip > file->size)
    {
      char *msg = grub_xasprintf (_("invalid skip value %lld"),
      (unsigned long long) skip);
      grub_util_error ("%s", msg);
      return;
    }

  {
    grub_off_t ofs, len;
    ofs = skip;
    len = file->size - skip;
    if ((leng) && (leng < len))
      len = leng;

    file->offset = skip;

    while (len)
      {
 grub_ssize_t sz;

 sz = grub_file_read (file, buf, (len > 32256) ? 32256 : len);
 if (sz < 0)
   {
     char *msg = grub_xasprintf (_("read error at offset %llu: %s"),
     (unsigned long long) ofs, grub_errmsg);
     grub_util_error ("%s", msg);
     break;
   }

 if ((sz == 0) || (hook (ofs, buf, sz, hook_arg)))
   break;

 ofs += sz;
 len -= sz;
      }
  }

  grub_file_close (file);
}

struct cp_hook_ctx
{
  FILE *ff;
  const char *dest;
};

static int
cp_hook (grub_off_t ofs, char *buf, int len, void *_ctx)
{
  struct cp_hook_ctx *ctx = _ctx;
  (void) ofs;

  if ((int) fwrite (buf, 1, len, ctx->ff) != len)
    {
      grub_util_error (_("cannot write to `%s': %s"),
         ctx->dest, strerror (
# 192 "util/grub-fstest.c" 3 4
                             (*__errno_location ())
# 192 "util/grub-fstest.c"
                                  ));
      return 1;
    }

  return 0;
}

static void
cmd_cp (char *src, const char *dest)
{
  struct cp_hook_ctx ctx =
    {
      .dest = dest
    };

  ctx.ff = grub_util_fopen (dest, "wb");
  if (ctx.ff == 
# 208 "util/grub-fstest.c" 3 4
               ((void *)0)
# 208 "util/grub-fstest.c"
                   )
    {
      grub_util_error (_("cannot open OS file `%s': %s"), dest,
         strerror (
# 211 "util/grub-fstest.c" 3 4
                  (*__errno_location ())
# 211 "util/grub-fstest.c"
                       ));
      return;
    }
  read_file (src, cp_hook, &ctx);
  fclose (ctx.ff);
}

static int
cat_hook (grub_off_t ofs, char *buf, int len, void *_arg __attribute__ ((unused)))
{
  (void) ofs;

  if ((int) fwrite (buf, 1, len, 
# 223 "util/grub-fstest.c" 3 4
                                stdout
# 223 "util/grub-fstest.c"
                                      ) != len)
    {
      grub_util_error (_("cannot write to the stdout: %s"),
         strerror (
# 226 "util/grub-fstest.c" 3 4
                  (*__errno_location ())
# 226 "util/grub-fstest.c"
                       ));
      return 1;
    }

  return 0;
}

static void
cmd_cat (char *src)
{
  read_file (src, cat_hook, 0);
}

static int
cmp_hook (grub_off_t ofs, char *buf, int len, void *ff_in)
{
  FILE *ff = ff_in;
  static char buf_1[32256];
  if ((int) fread (buf_1, 1, len, ff) != len)
    {
      char *msg = grub_xasprintf (_("read error at offset %llu: %s"),
      (unsigned long long) ofs, grub_errmsg);
      grub_util_error ("%s", msg);
      return 1;
    }

  if (grub_memcmp (buf, buf_1, len) != 0)
    {
      int i;

      for (i = 0; i < len; i++, ofs++)
 if (buf_1[i] != buf[i])
   {
     char *msg = grub_xasprintf (_("compare fail at offset %llu"),
     (unsigned long long) ofs);
     grub_util_error ("%s", msg);
     return 1;
   }
    }
  return 0;
}


static void
cmd_cmp (char *src, char *dest)
{
  FILE *ff;

  if (grub_util_is_directory (dest))
    {
      grub_util_fd_dir_t dir = grub_util_fd_opendir (dest);
      grub_util_fd_dirent_t entry;
      if (dir == 
# 278 "util/grub-fstest.c" 3 4
                ((void *)0)
# 278 "util/grub-fstest.c"
                    )
 {
   grub_util_error (_("OS file %s open error: %s"), dest,
      grub_util_fd_strerror ());
   return;
 }
      while ((entry = grub_util_fd_readdir (dir)))
 {
   char *srcnew, *destnew;
   char *ptr;
   if (strcmp (entry->d_name, ".") == 0
       || strcmp (entry->d_name, "..") == 0)
     continue;
   srcnew = xmalloc (strlen (src) + sizeof ("/")
       + strlen (entry->d_name));
   destnew = xmalloc (strlen (dest) + sizeof ("/")
       + strlen (entry->d_name));
   ptr = grub_stpcpy (srcnew, src);
   *ptr++ = '/';
   strcpy (ptr, entry->d_name);
   ptr = grub_stpcpy (destnew, dest);
   *ptr++ = '/';
   strcpy (ptr, entry->d_name);

   if (grub_util_is_special_file (destnew))
     continue;

   cmd_cmp (srcnew, destnew);
 }
      grub_util_fd_closedir (dir);
      return;
    }

  ff = grub_util_fopen (dest, "rb");
  if (ff == 
# 312 "util/grub-fstest.c" 3 4
           ((void *)0)
# 312 "util/grub-fstest.c"
               )
    {
      grub_util_error (_("OS file %s open error: %s"), dest,
         strerror (
# 315 "util/grub-fstest.c" 3 4
                  (*__errno_location ())
# 315 "util/grub-fstest.c"
                       ));
      return;
    }

  if ((skip) && (fseeko (ff, skip, 
# 319 "util/grub-fstest.c" 3 4
                                  0
# 319 "util/grub-fstest.c"
                                          )))
    grub_util_error (_("cannot seek `%s': %s"), dest,
       strerror (
# 321 "util/grub-fstest.c" 3 4
                (*__errno_location ())
# 321 "util/grub-fstest.c"
                     ));

  read_file (src, cmp_hook, ff);

  {
    grub_uint64_t pre;
    pre = ftell (ff);
    fseek (ff, 0, 
# 328 "util/grub-fstest.c" 3 4
                 2
# 328 "util/grub-fstest.c"
                         );
    if (pre != ftell (ff))
      grub_util_error ("%s", _("unexpected end of file"));
  }
  fclose (ff);
}

static int
hex_hook (grub_off_t ofs, char *buf, int len, void *arg __attribute__ ((unused)))
{
  hexdump (ofs, buf, len);
  return 0;
}

static void
cmd_hex (char *pathname)
{
  read_file (pathname, hex_hook, 0);
}

static int
crc_hook (grub_off_t ofs, char *buf, int len, void *crc_ctx)
{
  (void) ofs;

  ((const gcry_md_spec_t *) &_gcry_digest_spec_crc32)->write(crc_ctx, buf, len);
  return 0;
}

static void
cmd_crc (char *pathname)
{
  grub_uint8_t *crc32_context = xmalloc (((const gcry_md_spec_t *) &_gcry_digest_spec_crc32)->contextsize);
  ((const gcry_md_spec_t *) &_gcry_digest_spec_crc32)->init(crc32_context);

  read_file (pathname, crc_hook, crc32_context);
  ((const gcry_md_spec_t *) &_gcry_digest_spec_crc32)->final(crc32_context);
  printf ("%08x\n",
   grub_swap_bytes32(grub_get_unaligned32 (((const gcry_md_spec_t *) &_gcry_digest_spec_crc32)->read (crc32_context))));
  free (crc32_context);
}

static const char *root = 
# 370 "util/grub-fstest.c" 3 4
                         ((void *)0)
# 370 "util/grub-fstest.c"
                             ;
static int args_count = 0;
static int nparm = 0;
static int num_disks = 1;
static char **images = 
# 374 "util/grub-fstest.c" 3 4
                      ((void *)0)
# 374 "util/grub-fstest.c"
                          ;
static int cmd = 0;
static char *debug_str = 
# 376 "util/grub-fstest.c" 3 4
                        ((void *)0)
# 376 "util/grub-fstest.c"
                            ;
static char **args = 
# 377 "util/grub-fstest.c" 3 4
                    ((void *)0)
# 377 "util/grub-fstest.c"
                        ;
static int mount_crypt = 0;

static void
fstest (int n)
{
  char *host_file;
  char *loop_name;
  int i;

  for (i = 0; i < num_disks; i++)
    {
      char *argv[2];
      loop_name = grub_xasprintf ("loop%d", i);
      if (!loop_name)
 grub_util_error ("%s", grub_errmsg);

      host_file = grub_xasprintf ("(host)%s", images[i]);
      if (!host_file)
 grub_util_error ("%s", grub_errmsg);

      argv[0] = loop_name;
      argv[1] = host_file;

      if (execute_command ("loopback", 2, argv))
        grub_util_error (_("`loopback' command fails: %s"), grub_errmsg);

      grub_free (loop_name);
      grub_free (host_file);
    }

  {
    if (mount_crypt)
      {
 char *argv[2] = { xstrdup ("-a"), 
# 411 "util/grub-fstest.c" 3 4
                                  ((void *)0)
# 411 "util/grub-fstest.c"
                                      };
 if (execute_command ("cryptomount", 1, argv))
   grub_util_error (_("`cryptomount' command fails: %s"),
      grub_errmsg);
 free (argv[0]);
      }
  }

  grub_ldm_fini ();
  grub_lvm_fini ();
  grub_mdraid09_fini ();
  grub_mdraid1x_fini ();
  grub_diskfilter_fini ();
  grub_diskfilter_init ();
  grub_mdraid09_init ();
  grub_mdraid1x_init ();
  grub_lvm_init ();
  grub_ldm_init ();

  switch (cmd)
    {
    case CMD_LS:
      execute_command ("ls", n, args);
      break;
    case CMD_ZFSINFO:
      execute_command ("zfsinfo", n, args);
      break;
    case CMD_CP:
      cmd_cp (args[0], args[1]);
      break;
    case CMD_CAT:
      cmd_cat (args[0]);
      break;
    case CMD_CMP:
      cmd_cmp (args[0], args[1]);
      break;
    case CMD_HEX:
      cmd_hex (args[0]);
      break;
    case CMD_CRC:
      cmd_crc (args[0]);
      break;
    case CMD_BLOCKLIST:
      execute_command ("blocklist", n, args);
      grub_printf ("\n");
      break;
    case CMD_TESTLOAD:
      execute_command ("testload", n, args);
      grub_printf ("\n");
      break;
    case CMD_XNU_UUID:
      {
 grub_device_t dev;
 grub_fs_t fs;
 char *uuid = 0;
 char *argv[3] = { xstrdup ("-l"), 
# 466 "util/grub-fstest.c" 3 4
                                  ((void *)0)
# 466 "util/grub-fstest.c"
                                      , 
# 466 "util/grub-fstest.c" 3 4
                                        ((void *)0)
# 466 "util/grub-fstest.c"
                                            };
 dev = grub_device_open (n ? args[0] : 0);
 if (!dev)
   grub_util_error ("%s", grub_errmsg);
 fs = grub_fs_probe (dev);
 if (!fs)
   grub_util_error ("%s", grub_errmsg);
 if (!fs->fs_uuid)
   grub_util_error ("%s", _("couldn't retrieve UUID"));
 if (fs->fs_uuid (dev, &uuid))
   grub_util_error ("%s", grub_errmsg);
 if (!uuid)
   grub_util_error ("%s", _("couldn't retrieve UUID"));
 argv[1] = uuid;
 execute_command ("xnu_uuid", 2, argv);
 grub_free (argv[0]);
 grub_free (uuid);
 grub_device_close (dev);
      }
    }

  for (i = 0; i < num_disks; i++)
    {
      char *argv[2];

      loop_name = grub_xasprintf ("loop%d", i);
      if (!loop_name)
 grub_util_error ("%s", grub_errmsg);

      argv[0] = xstrdup ("-d");
      argv[1] = loop_name;

      execute_command ("loopback", 2, argv);

      grub_free (loop_name);
      grub_free (argv[0]);
    }
}

static struct argp_option options[] = {
  {0, 0, 0 , 0x8, "Commands:", 1},
  {"ls PATH", 0, 0 , 0x8, "List files in PATH.", 1},
  {"cp FILE LOCAL", 0, 0, 0x8, "Copy FILE to local file LOCAL.", 1},
  {"cat FILE", 0, 0 , 0x8, "Copy FILE to standard output.", 1},
  {"cmp FILE LOCAL", 0, 0, 0x8, "Compare FILE with local file LOCAL.", 1},
  {"hex FILE", 0, 0 , 0x8, "Show contents of FILE in hex.", 1},
  {"crc FILE", 0, 0 , 0x8, "Get crc32 checksum of FILE.", 1},
  {"blocklist FILE", 0, 0, 0x8, "Display blocklist of FILE.", 1},
  {"xnu_uuid DEVICE", 0, 0, 0x8, "Compute XNU UUID of the device.", 1},

  {"root", 'r', "DEVICE_NAME", 0, "Set root device.", 2},
  {"skip", 's', "NUM", 0, "Skip N bytes from output file.", 2},
  {"length", 'n', "NUM", 0, "Handle N bytes in output file.", 2},
  {"diskcount", 'c', "NUM", 0, "Specify the number of input files.", 2},
  {"debug", 'd', "STRING", 0, "Set debug environment variable.", 2},
  {"crypto", 'C', 
# 521 "util/grub-fstest.c" 3 4
                   ((void *)0)
# 521 "util/grub-fstest.c"
                       , 0, "Mount crypto devices.", 2},
  {"zfs-key", 'K',

   "FILE|prompt", 0, "Load zfs crypto key.", 2},
  {"verbose", 'v', 
# 525 "util/grub-fstest.c" 3 4
                    ((void *)0)
# 525 "util/grub-fstest.c"
                        , 0, "print verbose messages.", 2},
  {"uncompress", 'u', 
# 526 "util/grub-fstest.c" 3 4
                     ((void *)0)
# 526 "util/grub-fstest.c"
                         , 0, "Uncompress data.", 2},
  {0, 0, 0, 0, 0, 0}
};


static void
print_version (FILE *stream, struct argp_state *state)
{
  fprintf (stream, "%s (%s) %s\n", program_name, "GRUB", "2.05");
}
void (*argp_program_version_hook) (FILE *, struct argp_state *) = print_version;

static error_t
argp_parser (int key, char *arg, struct argp_state *state)
{
  const char *p;

  switch (key)
    {
    case 'r':
      root = arg;
      return 0;

    case 'K':
      if (strcmp (arg, "prompt") == 0)
 {
   char buf[1024];
   grub_puts_ ("Enter ZFS password: ");
   if (grub_password_get (buf, 1023))
     {
       grub_zfs_add_key ((grub_uint8_t *) buf, grub_strlen (buf), 1);
     }
 }
      else
      {
 FILE *f;
 ssize_t real_size;
 grub_uint8_t buf[1024];
 f = grub_util_fopen (arg, "rb");
 if (!f)
   {
     printf (_("%s: error:"), program_name);
     printf (_("cannot open `%s': %s"), arg, strerror (
# 568 "util/grub-fstest.c" 3 4
                                                      (*__errno_location ())
# 568 "util/grub-fstest.c"
                                                           ));
     printf ("\n");
     return 0;
   }
 real_size = fread (buf, 1, 1024, f);
 fclose (f);
 if (real_size < 0)
   {
     printf (_("%s: error:"), program_name);
     printf (_("cannot read `%s': %s"), arg, strerror (
# 577 "util/grub-fstest.c" 3 4
                                                      (*__errno_location ())
# 577 "util/grub-fstest.c"
                                                           ));
     printf ("\n");
     return 0;
   }
 grub_zfs_add_key (buf, real_size, 0);
      }
      return 0;

    case 'C':
      mount_crypt = 1;
      return 0;

    case 's':
      skip = grub_strtoul (arg, &p, 0);
      if (*p == 's')
 skip <<= 9;
      return 0;

    case 'n':
      leng = grub_strtoul (arg, &p, 0);
      if (*p == 's')
 leng <<= 9;
      return 0;

    case 'c':
      num_disks = grub_strtoul (arg, 
# 602 "util/grub-fstest.c" 3 4
                                    ((void *)0)
# 602 "util/grub-fstest.c"
                                        , 0);
      if (num_disks < 1)
 {
   fprintf (
# 605 "util/grub-fstest.c" 3 4
           stderr
# 605 "util/grub-fstest.c"
                 , "%s", _("Invalid disk count.\n"));
   argp_usage (state);
 }
      if (args_count != 0)
 {



   fprintf (
# 613 "util/grub-fstest.c" 3 4
           stderr
# 613 "util/grub-fstest.c"
                 , "%s", _("Disk count must precede disks list.\n"));
   argp_usage (state);
 }
      return 0;

    case 'd':
      debug_str = arg;
      return 0;

    case 'v':
      verbosity++;
      return 0;

    case 'u':
      uncompress = 1;
      return 0;

    case 0x1000001:
      if (args_count < num_disks)
 {
   fprintf (
# 633 "util/grub-fstest.c" 3 4
           stderr
# 633 "util/grub-fstest.c"
                 , "%s", _("No command is specified.\n"));
   argp_usage (state);
 }
      if (args_count - 1 - num_disks < nparm)
 {
   fprintf (
# 638 "util/grub-fstest.c" 3 4
           stderr
# 638 "util/grub-fstest.c"
                 , "%s", _("Not enough parameters to command.\n"));
   argp_usage (state);
 }
      return 0;

    case 0:
      break;

    default:
      return 
# 647 "util/grub-fstest.c" 3 4
            7
# 647 "util/grub-fstest.c"
                            ;
    }

  if (args_count < num_disks)
    {
      if (args_count == 0)
 images = xcalloc (num_disks, sizeof (images[0]));
      images[args_count] = grub_canonicalize_file_name (arg);
      args_count++;
      return 0;
    }

  if (args_count == num_disks)
    {
      if (!grub_strcmp (arg, "ls"))
        {
          cmd = CMD_LS;
        }
      else if (!grub_strcmp (arg, "zfsinfo"))
        {
          cmd = CMD_ZFSINFO;
        }
      else if (!grub_strcmp (arg, "cp"))
 {
   cmd = CMD_CP;
          nparm = 2;
 }
      else if (!grub_strcmp (arg, "cat"))
 {
   cmd = CMD_CAT;
   nparm = 1;
 }
      else if (!grub_strcmp (arg, "cmp"))
 {
   cmd = CMD_CMP;
          nparm = 2;
 }
      else if (!grub_strcmp (arg, "hex"))
 {
   cmd = CMD_HEX;
          nparm = 1;
 }
      else if (!grub_strcmp (arg, "crc"))
 {
   cmd = CMD_CRC;
          nparm = 1;
 }
      else if (!grub_strcmp (arg, "blocklist"))
 {
   cmd = CMD_BLOCKLIST;
          nparm = 1;
 }
      else if (!grub_strcmp (arg, "testload"))
 {
   cmd = CMD_TESTLOAD;
          nparm = 1;
 }
      else if (grub_strcmp (arg, "xnu_uuid") == 0)
 {
   cmd = CMD_XNU_UUID;
   nparm = 0;
 }
      else
 {
   fprintf (
# 711 "util/grub-fstest.c" 3 4
           stderr
# 711 "util/grub-fstest.c"
                 , _("Invalid command %s.\n"), arg);
   argp_usage (state);
 }
      args_count++;
      return 0;
    }

  args[args_count - 1 - num_disks] = xstrdup (arg);
  args_count++;
  return 0;
}

struct argp argp = {
  options, argp_parser, "IMAGE_PATH COMMANDS",
  "Debug tool for filesystem driver.",
  
# 726 "util/grub-fstest.c" 3 4
 ((void *)0)
# 726 "util/grub-fstest.c"
     , 
# 726 "util/grub-fstest.c" 3 4
       ((void *)0)
# 726 "util/grub-fstest.c"
           , 
# 726 "util/grub-fstest.c" 3 4
             ((void *)0)

# 727 "util/grub-fstest.c"
};

int
main (int argc, char *argv[])
{
  const char *default_root;
  char *alloc_root;

  grub_util_host_init (&argc, &argv);

  args = xcalloc (argc, sizeof (args[0]));

  argp_parse (&argp, argc, argv, 0, 0, 0);


  grub_init_all ();
  grub_gcry_init_all ();

  if (debug_str)
    grub_env_set ("debug", debug_str);

  default_root = (num_disks == 1) ? "loop0" : "md0";
  alloc_root = 0;
  if (root)
    {
      if ((*root >= '0') && (*root <= '9'))
        {
          alloc_root = xmalloc (strlen (default_root) + strlen (root) + 2);

          sprintf (alloc_root, "%s,%s", default_root, root);
          root = alloc_root;
        }
    }
  else
    root = default_root;

  grub_env_set ("root", root);

  if (alloc_root)
    free (alloc_root);


  fstest (args_count - 1 - num_disks);


  grub_gcry_fini_all ();
  grub_fini_all ();

  return 0;
}
# 1 "grub-core/kern/emu/hostfs.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "grub-core/kern/emu/hostfs.c"
# 20 "grub-core/kern/emu/hostfs.c"
# 1 "./config-util.h" 1
# 21 "grub-core/kern/emu/hostfs.c" 2

# 1 "./include/grub/fs.h" 1
# 23 "./include/grub/fs.h"
# 1 "./include/grub/device.h" 1
# 23 "./include/grub/device.h"
# 1 "./include/grub/symbol.h" 1
# 22 "./include/grub/symbol.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/symbol.h" 2
# 24 "./include/grub/device.h" 2
# 1 "./include/grub/err.h" 1
# 24 "./include/grub/err.h"
# 1 "./include/grub/compiler.h" 1
# 25 "./include/grub/err.h" 2



typedef enum
  {
    GRUB_ERR_NONE = 0,
    GRUB_ERR_TEST_FAILURE,
    GRUB_ERR_BAD_MODULE,
    GRUB_ERR_OUT_OF_MEMORY,
    GRUB_ERR_BAD_FILE_TYPE,
    GRUB_ERR_FILE_NOT_FOUND,
    GRUB_ERR_FILE_READ_ERROR,
    GRUB_ERR_BAD_FILENAME,
    GRUB_ERR_UNKNOWN_FS,
    GRUB_ERR_BAD_FS,
    GRUB_ERR_BAD_NUMBER,
    GRUB_ERR_OUT_OF_RANGE,
    GRUB_ERR_UNKNOWN_DEVICE,
    GRUB_ERR_BAD_DEVICE,
    GRUB_ERR_READ_ERROR,
    GRUB_ERR_WRITE_ERROR,
    GRUB_ERR_UNKNOWN_COMMAND,
    GRUB_ERR_INVALID_COMMAND,
    GRUB_ERR_BAD_ARGUMENT,
    GRUB_ERR_BAD_PART_TABLE,
    GRUB_ERR_UNKNOWN_OS,
    GRUB_ERR_BAD_OS,
    GRUB_ERR_NO_KERNEL,
    GRUB_ERR_BAD_FONT,
    GRUB_ERR_NOT_IMPLEMENTED_YET,
    GRUB_ERR_SYMLINK_LOOP,
    GRUB_ERR_BAD_COMPRESSED_DATA,
    GRUB_ERR_MENU,
    GRUB_ERR_TIMEOUT,
    GRUB_ERR_IO,
    GRUB_ERR_ACCESS_DENIED,
    GRUB_ERR_EXTRACTOR,
    GRUB_ERR_NET_BAD_ADDRESS,
    GRUB_ERR_NET_ROUTE_LOOP,
    GRUB_ERR_NET_NO_ROUTE,
    GRUB_ERR_NET_NO_ANSWER,
    GRUB_ERR_NET_NO_CARD,
    GRUB_ERR_WAIT,
    GRUB_ERR_BUG,
    GRUB_ERR_NET_PORT_CLOSED,
    GRUB_ERR_NET_INVALID_RESPONSE,
    GRUB_ERR_NET_UNKNOWN_ERROR,
    GRUB_ERR_NET_PACKET_TOO_BIG,
    GRUB_ERR_NET_NO_DOMAIN,
    GRUB_ERR_EOF,
    GRUB_ERR_BAD_SIGNATURE
  }
grub_err_t;

struct grub_error_saved
{
  grub_err_t grub_errno;
  char errmsg[256];
};

extern grub_err_t grub_errno;
extern char grub_errmsg[256];

grub_err_t grub_error (grub_err_t n, const char *fmt, ...);
void grub_fatal (const char *fmt, ...) __attribute__ ((noreturn));
void grub_error_push (void);
int grub_error_pop (void);
void grub_print_error (void);
extern int grub_err_printed_errors;
int grub_err_printf (const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 1, 2)));
# 25 "./include/grub/device.h" 2

struct grub_disk;
struct grub_net;

struct grub_device
{
  struct grub_disk *disk;
  struct grub_net *net;
};
typedef struct grub_device *grub_device_t;

typedef int (*grub_device_iterate_hook_t) (const char *name, void *data);

grub_device_t grub_device_open (const char *name);
grub_err_t grub_device_close (grub_device_t device);
int grub_device_iterate (grub_device_iterate_hook_t hook,
          void *hook_data);
# 24 "./include/grub/fs.h" 2

# 1 "./include/grub/types.h" 1
# 22 "./include/grub/types.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/types.h" 2
# 76 "./include/grub/types.h"
typedef signed char grub_int8_t;
typedef short grub_int16_t;
typedef int grub_int32_t;

typedef long grub_int64_t;




typedef unsigned char grub_uint8_t;
typedef unsigned short grub_uint16_t;
typedef unsigned grub_uint32_t;



typedef unsigned long grub_uint64_t;
# 103 "./include/grub/types.h"
typedef grub_uint64_t grub_addr_t;
typedef grub_uint64_t grub_size_t;
typedef grub_int64_t grub_ssize_t;
# 154 "./include/grub/types.h"
typedef grub_uint64_t grub_properly_aligned_t;




typedef grub_uint64_t grub_off_t;


typedef grub_uint64_t grub_disk_addr_t;


static inline grub_uint16_t grub_swap_bytes16(grub_uint16_t _x)
{
   return (grub_uint16_t) ((_x << 8) | (_x >> 8));
}
# 186 "./include/grub/types.h"
static inline grub_uint32_t grub_swap_bytes32(grub_uint32_t x)
{
 return __builtin_bswap32(x);
}

static inline grub_uint64_t grub_swap_bytes64(grub_uint64_t x)
{
 return __builtin_bswap64(x);
}
# 260 "./include/grub/types.h"
struct grub_unaligned_uint16
{
  grub_uint16_t val;
} __attribute__ ((packed));
struct grub_unaligned_uint32
{
  grub_uint32_t val;
} __attribute__ ((packed));
struct grub_unaligned_uint64
{
  grub_uint64_t val;
} __attribute__ ((packed));

typedef struct grub_unaligned_uint16 grub_unaligned_uint16_t;
typedef struct grub_unaligned_uint32 grub_unaligned_uint32_t;
typedef struct grub_unaligned_uint64 grub_unaligned_uint64_t;

static inline grub_uint16_t grub_get_unaligned16 (const void *ptr)
{
  const struct grub_unaligned_uint16 *dd
    = (const struct grub_unaligned_uint16 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned16 (void *ptr, grub_uint16_t val)
{
  struct grub_unaligned_uint16 *dd = (struct grub_unaligned_uint16 *) ptr;
  dd->val = val;
}

static inline grub_uint32_t grub_get_unaligned32 (const void *ptr)
{
  const struct grub_unaligned_uint32 *dd
    = (const struct grub_unaligned_uint32 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned32 (void *ptr, grub_uint32_t val)
{
  struct grub_unaligned_uint32 *dd = (struct grub_unaligned_uint32 *) ptr;
  dd->val = val;
}

static inline grub_uint64_t grub_get_unaligned64 (const void *ptr)
{
  const struct grub_unaligned_uint64 *dd
    = (const struct grub_unaligned_uint64 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned64 (void *ptr, grub_uint64_t val)
{
  struct grub_unaligned_uint64_t
  {
    grub_uint64_t d;
  } __attribute__ ((packed));
  struct grub_unaligned_uint64_t *dd = (struct grub_unaligned_uint64_t *) ptr;
  dd->d = val;
}
# 26 "./include/grub/fs.h" 2

# 1 "./include/grub/list.h" 1
# 27 "./include/grub/list.h"
struct grub_list
{
  struct grub_list *next;
  struct grub_list **prev;
};
typedef struct grub_list *grub_list_t;

void grub_list_push (grub_list_t *head, grub_list_t item);
void grub_list_remove (grub_list_t item);





static inline void *
grub_bad_type_cast_real (int line, const char *file)
     __attribute__ ((__error__ ("bad type cast between incompatible grub types")));

static inline void *
grub_bad_type_cast_real (int line, const char *file)
{
  grub_fatal ("error:%s:%u: bad type cast between incompatible grub types",
       file, line);
}
# 65 "./include/grub/list.h"
struct grub_named_list
{
  struct grub_named_list *next;
  struct grub_named_list **prev;
  char *name;
};
typedef struct grub_named_list *grub_named_list_t;

void * grub_named_list_find (grub_named_list_t head,
       const char *name);
# 28 "./include/grub/fs.h" 2


# 1 "./include/grub/partition.h" 1
# 22 "./include/grub/partition.h"
# 1 "./include/grub/dl.h" 1
# 27 "./include/grub/dl.h"
# 1 "./include/grub/elf.h" 1
# 28 "./include/grub/elf.h"
typedef grub_uint16_t Elf32_Half;
typedef grub_uint16_t Elf64_Half;


typedef grub_uint32_t Elf32_Word;
typedef grub_int32_t Elf32_Sword;
typedef grub_uint32_t Elf64_Word;
typedef grub_int32_t Elf64_Sword;


typedef grub_uint64_t Elf32_Xword;
typedef grub_int64_t Elf32_Sxword;
typedef grub_uint64_t Elf64_Xword;
typedef grub_int64_t Elf64_Sxword;


typedef grub_uint32_t Elf32_Addr;
typedef grub_uint64_t Elf64_Addr;


typedef grub_uint32_t Elf32_Off;
typedef grub_uint64_t Elf64_Off;


typedef grub_uint16_t Elf32_Section;
typedef grub_uint16_t Elf64_Section;


typedef Elf32_Half Elf32_Versym;
typedef Elf64_Half Elf64_Versym;






typedef struct
{
  unsigned char e_ident[(16)];
  Elf32_Half e_type;
  Elf32_Half e_machine;
  Elf32_Word e_version;
  Elf32_Addr e_entry;
  Elf32_Off e_phoff;
  Elf32_Off e_shoff;
  Elf32_Word e_flags;
  Elf32_Half e_ehsize;
  Elf32_Half e_phentsize;
  Elf32_Half e_phnum;
  Elf32_Half e_shentsize;
  Elf32_Half e_shnum;
  Elf32_Half e_shstrndx;
} Elf32_Ehdr;

typedef struct
{
  unsigned char e_ident[(16)];
  Elf64_Half e_type;
  Elf64_Half e_machine;
  Elf64_Word e_version;
  Elf64_Addr e_entry;
  Elf64_Off e_phoff;
  Elf64_Off e_shoff;
  Elf64_Word e_flags;
  Elf64_Half e_ehsize;
  Elf64_Half e_phentsize;
  Elf64_Half e_phnum;
  Elf64_Half e_shentsize;
  Elf64_Half e_shnum;
  Elf64_Half e_shstrndx;
} Elf64_Ehdr;
# 266 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word sh_name;
  Elf32_Word sh_type;
  Elf32_Word sh_flags;
  Elf32_Addr sh_addr;
  Elf32_Off sh_offset;
  Elf32_Word sh_size;
  Elf32_Word sh_link;
  Elf32_Word sh_info;
  Elf32_Word sh_addralign;
  Elf32_Word sh_entsize;
} Elf32_Shdr;

typedef struct
{
  Elf64_Word sh_name;
  Elf64_Word sh_type;
  Elf64_Xword sh_flags;
  Elf64_Addr sh_addr;
  Elf64_Off sh_offset;
  Elf64_Xword sh_size;
  Elf64_Word sh_link;
  Elf64_Word sh_info;
  Elf64_Xword sh_addralign;
  Elf64_Xword sh_entsize;
} Elf64_Shdr;
# 365 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word st_name;
  Elf32_Addr st_value;
  Elf32_Word st_size;
  unsigned char st_info;
  unsigned char st_other;
  Elf32_Section st_shndx;
} Elf32_Sym;

typedef struct
{
  Elf64_Word st_name;
  unsigned char st_info;
  unsigned char st_other;
  Elf64_Section st_shndx;
  Elf64_Addr st_value;
  Elf64_Xword st_size;
} Elf64_Sym;




typedef struct
{
  Elf32_Half si_boundto;
  Elf32_Half si_flags;
} Elf32_Syminfo;

typedef struct
{
  Elf64_Half si_boundto;
  Elf64_Half si_flags;
} Elf64_Syminfo;
# 479 "./include/grub/elf.h"
typedef struct
{
  Elf32_Addr r_offset;
  Elf32_Word r_info;
} Elf32_Rel;






typedef struct
{
  Elf64_Addr r_offset;
  Elf64_Xword r_info;
} Elf64_Rel;



typedef struct
{
  Elf32_Addr r_offset;
  Elf32_Word r_info;
  Elf32_Sword r_addend;
} Elf32_Rela;

typedef struct
{
  Elf64_Addr r_offset;
  Elf64_Xword r_info;
  Elf64_Sxword r_addend;
} Elf64_Rela;
# 524 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word p_type;
  Elf32_Off p_offset;
  Elf32_Addr p_vaddr;
  Elf32_Addr p_paddr;
  Elf32_Word p_filesz;
  Elf32_Word p_memsz;
  Elf32_Word p_flags;
  Elf32_Word p_align;
} Elf32_Phdr;

typedef struct
{
  Elf64_Word p_type;
  Elf64_Word p_flags;
  Elf64_Off p_offset;
  Elf64_Addr p_vaddr;
  Elf64_Addr p_paddr;
  Elf64_Xword p_filesz;
  Elf64_Xword p_memsz;
  Elf64_Xword p_align;
} Elf64_Phdr;
# 603 "./include/grub/elf.h"
typedef struct
{
  Elf32_Sword d_tag;
  union
    {
      Elf32_Word d_val;
      Elf32_Addr d_ptr;
    } d_un;
} Elf32_Dyn;

typedef struct
{
  Elf64_Sxword d_tag;
  union
    {
      Elf64_Xword d_val;
      Elf64_Addr d_ptr;
    } d_un;
} Elf64_Dyn;
# 767 "./include/grub/elf.h"
typedef struct
{
  Elf32_Half vd_version;
  Elf32_Half vd_flags;
  Elf32_Half vd_ndx;
  Elf32_Half vd_cnt;
  Elf32_Word vd_hash;
  Elf32_Word vd_aux;
  Elf32_Word vd_next;

} Elf32_Verdef;

typedef struct
{
  Elf64_Half vd_version;
  Elf64_Half vd_flags;
  Elf64_Half vd_ndx;
  Elf64_Half vd_cnt;
  Elf64_Word vd_hash;
  Elf64_Word vd_aux;
  Elf64_Word vd_next;

} Elf64_Verdef;
# 809 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word vda_name;
  Elf32_Word vda_next;

} Elf32_Verdaux;

typedef struct
{
  Elf64_Word vda_name;
  Elf64_Word vda_next;

} Elf64_Verdaux;




typedef struct
{
  Elf32_Half vn_version;
  Elf32_Half vn_cnt;
  Elf32_Word vn_file;

  Elf32_Word vn_aux;
  Elf32_Word vn_next;

} Elf32_Verneed;

typedef struct
{
  Elf64_Half vn_version;
  Elf64_Half vn_cnt;
  Elf64_Word vn_file;

  Elf64_Word vn_aux;
  Elf64_Word vn_next;

} Elf64_Verneed;
# 856 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word vna_hash;
  Elf32_Half vna_flags;
  Elf32_Half vna_other;
  Elf32_Word vna_name;
  Elf32_Word vna_next;

} Elf32_Vernaux;

typedef struct
{
  Elf64_Word vna_hash;
  Elf64_Half vna_flags;
  Elf64_Half vna_other;
  Elf64_Word vna_name;
  Elf64_Word vna_next;

} Elf64_Vernaux;
# 890 "./include/grub/elf.h"
typedef struct
{
  int a_type;
  union
    {
      long int a_val;
      void *a_ptr;
      void (*a_fcn) (void);
    } a_un;
} Elf32_auxv_t;

typedef struct
{
  long int a_type;
  union
    {
      long int a_val;
      void *a_ptr;
      void (*a_fcn) (void);
    } a_un;
} Elf64_auxv_t;
# 953 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word n_namesz;
  Elf32_Word n_descsz;
  Elf32_Word n_type;
} Elf32_Nhdr;

typedef struct
{
  Elf64_Word n_namesz;
  Elf64_Word n_descsz;
  Elf64_Word n_type;
} Elf64_Nhdr;
# 1000 "./include/grub/elf.h"
typedef struct
{
  Elf32_Xword m_value;
  Elf32_Word m_info;
  Elf32_Word m_poffset;
  Elf32_Half m_repeat;
  Elf32_Half m_stride;
} Elf32_Move;

typedef struct
{
  Elf64_Xword m_value;
  Elf64_Xword m_info;
  Elf64_Xword m_poffset;
  Elf64_Half m_repeat;
  Elf64_Half m_stride;
} Elf64_Move;
# 1365 "./include/grub/elf.h"
typedef union
{
  struct
    {
      Elf32_Word gt_current_g_value;
      Elf32_Word gt_unused;
    } gt_header;
  struct
    {
      Elf32_Word gt_g_value;
      Elf32_Word gt_bytes;
    } gt_entry;
} Elf32_gptab;



typedef struct
{
  Elf32_Word ri_gprmask;
  Elf32_Word ri_cprmask[4];
  Elf32_Sword ri_gp_value;
} Elf32_RegInfo;



typedef struct
{
  unsigned char kind;

  unsigned char size;
  Elf32_Section section;

  Elf32_Word info;
} Elf_Options;
# 1441 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word hwp_flags1;
  Elf32_Word hwp_flags2;
} Elf_Options_Hw;
# 1580 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word l_name;
  Elf32_Word l_time_stamp;
  Elf32_Word l_checksum;
  Elf32_Word l_version;
  Elf32_Word l_flags;
} Elf32_Lib;

typedef struct
{
  Elf64_Word l_name;
  Elf64_Word l_time_stamp;
  Elf64_Word l_checksum;
  Elf64_Word l_version;
  Elf64_Word l_flags;
} Elf64_Lib;
# 1611 "./include/grub/elf.h"
typedef Elf32_Addr Elf32_Conflict;
# 28 "./include/grub/dl.h" 2

# 1 "./include/grub/misc.h" 1
# 23 "./include/grub/misc.h"
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 3 4

# 40 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 99 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 24 "./include/grub/misc.h" 2



# 1 "./include/grub/i18n.h" 1
# 22 "./include/grub/i18n.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/i18n.h" 2






# 28 "./include/grub/i18n.h"
extern const char *(*grub_gettext) (const char *s) __attribute__ ((format_arg (1)));



# 1 "/usr/include/locale.h" 1 3 4
# 25 "/usr/include/locale.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 465 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 452 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 453 "/usr/include/sys/cdefs.h" 2 3 4
# 1 "/usr/include/bits/long-double.h" 1 3 4
# 454 "/usr/include/sys/cdefs.h" 2 3 4
# 466 "/usr/include/features.h" 2 3 4
# 489 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4
# 10 "/usr/include/gnu/stubs.h" 3 4
# 1 "/usr/include/gnu/stubs-64.h" 1 3 4
# 11 "/usr/include/gnu/stubs.h" 2 3 4
# 490 "/usr/include/features.h" 2 3 4
# 26 "/usr/include/locale.h" 2 3 4


# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 29 "/usr/include/locale.h" 2 3 4
# 1 "/usr/include/bits/locale.h" 1 3 4
# 30 "/usr/include/locale.h" 2 3 4


# 51 "/usr/include/locale.h" 3 4

# 51 "/usr/include/locale.h" 3 4
struct lconv
{


  char *decimal_point;
  char *thousands_sep;





  char *grouping;





  char *int_curr_symbol;
  char *currency_symbol;
  char *mon_decimal_point;
  char *mon_thousands_sep;
  char *mon_grouping;
  char *positive_sign;
  char *negative_sign;
  char int_frac_digits;
  char frac_digits;

  char p_cs_precedes;

  char p_sep_by_space;

  char n_cs_precedes;

  char n_sep_by_space;






  char p_sign_posn;
  char n_sign_posn;


  char int_p_cs_precedes;

  char int_p_sep_by_space;

  char int_n_cs_precedes;

  char int_n_sep_by_space;






  char int_p_sign_posn;
  char int_n_sign_posn;
# 118 "/usr/include/locale.h" 3 4
};



extern char *setlocale (int __category, const char *__locale) __attribute__ ((__nothrow__ , __leaf__));


extern struct lconv *localeconv (void) __attribute__ ((__nothrow__ , __leaf__));
# 135 "/usr/include/locale.h" 3 4
# 1 "/usr/include/bits/types/locale_t.h" 1 3 4
# 22 "/usr/include/bits/types/locale_t.h" 3 4
# 1 "/usr/include/bits/types/__locale_t.h" 1 3 4
# 28 "/usr/include/bits/types/__locale_t.h" 3 4
struct __locale_struct
{

  struct __locale_data *__locales[13];


  const unsigned short int *__ctype_b;
  const int *__ctype_tolower;
  const int *__ctype_toupper;


  const char *__names[13];
};

typedef struct __locale_struct *__locale_t;
# 23 "/usr/include/bits/types/locale_t.h" 2 3 4

typedef __locale_t locale_t;
# 136 "/usr/include/locale.h" 2 3 4





extern locale_t newlocale (int __category_mask, const char *__locale,
      locale_t __base) __attribute__ ((__nothrow__ , __leaf__));
# 176 "/usr/include/locale.h" 3 4
extern locale_t duplocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));



extern void freelocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));






extern locale_t uselocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));








# 33 "./include/grub/i18n.h" 2
# 1 "/usr/include/libintl.h" 1 3 4
# 34 "/usr/include/libintl.h" 3 4





extern char *gettext (const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (1)));



extern char *dgettext (const char *__domainname, const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));
extern char *__dgettext (const char *__domainname, const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));



extern char *dcgettext (const char *__domainname,
   const char *__msgid, int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));
extern char *__dcgettext (const char *__domainname,
     const char *__msgid, int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));




extern char *ngettext (const char *__msgid1, const char *__msgid2,
         unsigned long int __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (1))) __attribute__ ((__format_arg__ (2)));



extern char *dngettext (const char *__domainname, const char *__msgid1,
   const char *__msgid2, unsigned long int __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2))) __attribute__ ((__format_arg__ (3)));



extern char *dcngettext (const char *__domainname, const char *__msgid1,
    const char *__msgid2, unsigned long int __n,
    int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2))) __attribute__ ((__format_arg__ (3)));





extern char *textdomain (const char *__domainname) __attribute__ ((__nothrow__ , __leaf__));



extern char *bindtextdomain (const char *__domainname,
        const char *__dirname) __attribute__ ((__nothrow__ , __leaf__));



extern char *bind_textdomain_codeset (const char *__domainname,
          const char *__codeset) __attribute__ ((__nothrow__ , __leaf__));
# 121 "/usr/include/libintl.h" 3 4

# 34 "./include/grub/i18n.h" 2
# 53 "./include/grub/i18n.h"

# 53 "./include/grub/i18n.h"
static inline const char * __attribute__ ((always_inline,format_arg (1)))
_ (const char *str)
{
  return gettext(str);
}
# 28 "./include/grub/misc.h" 2
# 40 "./include/grub/misc.h"
void *grub_memmove (void *dest, const void *src, grub_size_t n);
char *grub_strcpy (char *dest, const char *src);

static inline char *
grub_strncpy (char *dest, const char *src, int c)
{
  char *p = dest;

  while ((*p++ = *src++) != '\0' && --c)
    ;

  return dest;
}

static inline char *
grub_stpcpy (char *dest, const char *src)
{
  char *d = dest;
  const char *s = src;

  do
    *d++ = *s;
  while (*s++ != '\0');

  return d - 1;
}


static inline void *
grub_memcpy (void *dest, const void *src, grub_size_t n)
{
  return grub_memmove (dest, src, n);
}
# 82 "./include/grub/misc.h"
int grub_memcmp (const void *s1, const void *s2, grub_size_t n);
int grub_strcmp (const char *s1, const char *s2);
int grub_strncmp (const char *s1, const char *s2, grub_size_t n);

char *grub_strchr (const char *s, int c);
char *grub_strrchr (const char *s, int c);
int grub_strword (const char *s, const char *w);



static inline char *
grub_strstr (const char *haystack, const char *needle)
{





  if (*needle != '\0')
    {


      char b = *needle++;

      for (;; haystack++)
 {
   if (*haystack == '\0')

     return 0;
   if (*haystack == b)

     {
       const char *rhaystack = haystack + 1;
       const char *rneedle = needle;

       for (;; rhaystack++, rneedle++)
  {
    if (*rneedle == '\0')

      return (char *) haystack;
    if (*rhaystack == '\0')

      return 0;
    if (*rhaystack != *rneedle)

      break;
  }
     }
 }
    }
  else
    return (char *) haystack;
}

int grub_isspace (int c);

static inline int
grub_isprint (int c)
{
  return (c >= ' ' && c <= '~');
}

static inline int
grub_iscntrl (int c)
{
  return (c >= 0x00 && c <= 0x1F) || c == 0x7F;
}

static inline int
grub_isalpha (int c)
{
  return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

static inline int
grub_islower (int c)
{
  return (c >= 'a' && c <= 'z');
}

static inline int
grub_isupper (int c)
{
  return (c >= 'A' && c <= 'Z');
}

static inline int
grub_isgraph (int c)
{
  return (c >= '!' && c <= '~');
}

static inline int
grub_isdigit (int c)
{
  return (c >= '0' && c <= '9');
}

static inline int
grub_isxdigit (int c)
{
  return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F');
}

static inline int
grub_isalnum (int c)
{
  return grub_isalpha (c) || grub_isdigit (c);
}

static inline int
grub_tolower (int c)
{
  if (c >= 'A' && c <= 'Z')
    return c - 'A' + 'a';

  return c;
}

static inline int
grub_toupper (int c)
{
  if (c >= 'a' && c <= 'z')
    return c - 'a' + 'A';

  return c;
}

static inline int
grub_strcasecmp (const char *s1, const char *s2)
{
  while (*s1 && *s2)
    {
      if (grub_tolower ((grub_uint8_t) *s1)
   != grub_tolower ((grub_uint8_t) *s2))
 break;

      s1++;
      s2++;
    }

  return (int) grub_tolower ((grub_uint8_t) *s1)
    - (int) grub_tolower ((grub_uint8_t) *s2);
}

static inline int
grub_strncasecmp (const char *s1, const char *s2, grub_size_t n)
{
  if (n == 0)
    return 0;

  while (*s1 && *s2 && --n)
    {
      if (grub_tolower (*s1) != grub_tolower (*s2))
 break;

      s1++;
      s2++;
    }

  return (int) grub_tolower ((grub_uint8_t) *s1)
    - (int) grub_tolower ((grub_uint8_t) *s2);
}
# 264 "./include/grub/misc.h"
unsigned long grub_strtoul (const char * __restrict str, const char ** const __restrict end, int base);
unsigned long long grub_strtoull (const char * __restrict str, const char ** const __restrict end, int base);

static inline long
grub_strtol (const char * __restrict str, const char ** const __restrict end, int base)
{
  int negative = 0;
  unsigned long long magnitude;

  while (*str && grub_isspace (*str))
    str++;

  if (*str == '-')
    {
      negative = 1;
      str++;
    }

  magnitude = grub_strtoull (str, end, base);
  if (negative)
    {
      if (magnitude > (unsigned long) 9223372036854775807L + 1)
        {
          grub_error (GRUB_ERR_OUT_OF_RANGE, "overflow is detected");
          return (-9223372036854775807L - 1);
        }
      return -((long) magnitude);
    }
  else
    {
      if (magnitude > 9223372036854775807L)
        {
          grub_error (GRUB_ERR_OUT_OF_RANGE, "overflow is detected");
          return 9223372036854775807L;
        }
      return (long) magnitude;
    }
}

char *grub_strdup (const char *s) __attribute__ ((warn_unused_result));
char *grub_strndup (const char *s, grub_size_t n) __attribute__ ((warn_unused_result));
void *grub_memset (void *s, int c, grub_size_t n);
grub_size_t grub_strlen (const char *s) __attribute__ ((warn_unused_result));
int grub_printf (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));
int grub_printf_ (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));



static inline char *
grub_strchrsub (char *output, const char *input, char ch, const char *with)
{
  while (*input)
    {
      if (*input == ch)
 {
   grub_strcpy (output, with);
   output += grub_strlen (with);
   input++;
   continue;
 }
      *output++ = *input++;
    }
  *output = '\0';
  return output;
}

extern void (*grub_xputs) (const char *str);

static inline int
grub_puts (const char *s)
{
  const char nl[2] = "\n";
  grub_xputs (s);
  grub_xputs (nl);

  return 1;
}

int grub_puts_ (const char *s);
int grub_debug_enabled (const char *condition);
void grub_real_dprintf (const char *file,
                                     const int line,
                                     const char *condition,
                                     const char *fmt, ...) __attribute__ ((format (gnu_printf, 4, 5)));
int grub_vprintf (const char *fmt, va_list args);
int grub_snprintf (char *str, grub_size_t n, const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 3, 4)));
int grub_vsnprintf (char *str, grub_size_t n, const char *fmt,
     va_list args);
char *grub_xasprintf (const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 1, 2))) __attribute__ ((warn_unused_result));
char *grub_xvasprintf (const char *fmt, va_list args) __attribute__ ((warn_unused_result));
void grub_exit (void) __attribute__ ((noreturn));
grub_uint64_t grub_divmod64 (grub_uint64_t n,
       grub_uint64_t d,
       grub_uint64_t *r);
# 378 "./include/grub/misc.h"
grub_int64_t
grub_divmod64s (grub_int64_t n,
     grub_int64_t d,
     grub_int64_t *r);

grub_uint32_t
grub_divmod32 (grub_uint32_t n,
     grub_uint32_t d,
     grub_uint32_t *r);

grub_int32_t
grub_divmod32s (grub_int32_t n,
      grub_int32_t d,
      grub_int32_t *r);



static inline char *
grub_memchr (const void *p, int c, grub_size_t len)
{
  const char *s = (const char *) p;
  const char *e = s + len;

  for (; s < e; s++)
    if (*s == c)
      return (char *) s;

  return 0;
}


static inline unsigned int
grub_abs (int x)
{
  if (x < 0)
    return (unsigned int) (-x);
  else
    return (unsigned int) x;
}






void grub_reboot (void) __attribute__ ((noreturn));
# 437 "./include/grub/misc.h"
void grub_halt (void) __attribute__ ((noreturn));
# 447 "./include/grub/misc.h"
static inline void
grub_error_save (struct grub_error_saved *save)
{
  grub_memcpy (save->errmsg, grub_errmsg, sizeof (save->errmsg));
  save->grub_errno = grub_errno;
  grub_errno = GRUB_ERR_NONE;
}

static inline void
grub_error_load (const struct grub_error_saved *save)
{
  grub_memcpy (grub_errmsg, save->errmsg, sizeof (grub_errmsg));
  grub_errno = save->grub_errno;
}
# 30 "./include/grub/dl.h" 2
# 155 "./include/grub/dl.h"
struct grub_dl_segment
{
  struct grub_dl_segment *next;
  void *addr;
  grub_size_t size;
  unsigned section;
};
typedef struct grub_dl_segment *grub_dl_segment_t;

struct grub_dl;

struct grub_dl_dep
{
  struct grub_dl_dep *next;
  struct grub_dl *mod;
};
typedef struct grub_dl_dep *grub_dl_dep_t;
# 199 "./include/grub/dl.h"
typedef struct grub_dl *grub_dl_t;

grub_dl_t grub_dl_load_file (const char *filename);
grub_dl_t grub_dl_load (const char *name);
grub_dl_t grub_dl_load_core (void *addr, grub_size_t size);
grub_dl_t grub_dl_load_core_noinit (void *addr, grub_size_t size);
int grub_dl_unload (grub_dl_t mod);
void grub_dl_unload_unneeded (void);
int grub_dl_ref (grub_dl_t mod);
int grub_dl_unref (grub_dl_t mod);
extern grub_dl_t grub_dl_head;
# 258 "./include/grub/dl.h"
grub_err_t grub_dl_register_symbol (const char *name, void *addr,
        int isfunc, grub_dl_t mod);

grub_err_t grub_arch_dl_check_header (void *ehdr);
# 276 "./include/grub/dl.h"
grub_err_t
grub_ia64_dl_get_tramp_got_size (const void *ehdr, grub_size_t *tramp,
     grub_size_t *got);
grub_err_t
grub_arm64_dl_get_tramp_got_size (const void *ehdr, grub_size_t *tramp,
      grub_size_t *got);
# 290 "./include/grub/dl.h"
grub_err_t
grub_arch_dl_get_tramp_got_size (const void *ehdr, grub_size_t *tramp,
     grub_size_t *got);
# 23 "./include/grub/partition.h" 2


struct grub_disk;

typedef struct grub_partition *grub_partition_t;


typedef enum
{
  GRUB_EMBED_PCBIOS
} grub_embed_type_t;


typedef int (*grub_partition_iterate_hook_t) (struct grub_disk *disk,
           const grub_partition_t partition,
           void *data);


struct grub_partition_map
{

  struct grub_partition_map *next;
  struct grub_partition_map **prev;


  const char *name;


  grub_err_t (*iterate) (struct grub_disk *disk,
    grub_partition_iterate_hook_t hook, void *hook_data);


  grub_err_t (*embed) (struct grub_disk *disk, unsigned int *nsectors,
         unsigned int max_nsectors,
         grub_embed_type_t embed_type,
         grub_disk_addr_t **sectors);

};
typedef struct grub_partition_map *grub_partition_map_t;


struct grub_partition
{

  int number;


  grub_disk_addr_t start;


  grub_uint64_t len;


  grub_disk_addr_t offset;


  int index;


  struct grub_partition *parent;


  grub_partition_map_t partmap;



  grub_uint8_t msdostype;
};

grub_partition_t grub_partition_probe (struct grub_disk *disk,
          const char *str);
int grub_partition_iterate (struct grub_disk *disk,
      grub_partition_iterate_hook_t hook,
      void *hook_data);
char *grub_partition_get_name (const grub_partition_t partition);


extern grub_partition_map_t grub_partition_map_list;


static inline void
grub_partition_map_register (grub_partition_map_t partmap)
{
  grub_list_push ((((char *) &(*&grub_partition_map_list)->next == (char *) &((grub_list_t) (*&grub_partition_map_list))->next) && ((char *) &(*&grub_partition_map_list)->prev == (char *) &((grub_list_t) (*&grub_partition_map_list))->prev) ? (grub_list_t *) (void *) &grub_partition_map_list : (grub_list_t *) grub_bad_type_cast_real(106, "util/grub-fstest.c")),
    (((char *) &(partmap)->next == (char *) &((grub_list_t) (partmap))->next) && ((char *) &(partmap)->prev == (char *) &((grub_list_t) (partmap))->prev) ? (grub_list_t) partmap : (grub_list_t) grub_bad_type_cast_real(107, "util/grub-fstest.c")));
}


static inline void
grub_partition_map_unregister (grub_partition_map_t partmap)
{
  grub_list_remove ((((char *) &(partmap)->next == (char *) &((grub_list_t) (partmap))->next) && ((char *) &(partmap)->prev == (char *) &((grub_list_t) (partmap))->prev) ? (grub_list_t) partmap : (grub_list_t) grub_bad_type_cast_real(114, "util/grub-fstest.c")));
}




static inline grub_disk_addr_t
grub_partition_get_start (const grub_partition_t p)
{
  grub_partition_t part;
  grub_uint64_t part_start = 0;

  for (part = p; part; part = part->parent)
    part_start += part->start;

  return part_start;
}

static inline grub_uint64_t
grub_partition_get_len (const grub_partition_t p)
{
  return p->len;
}
# 31 "./include/grub/fs.h" 2



struct grub_file;

struct grub_dirhook_info
{
  unsigned dir:1;
  unsigned mtimeset:1;
  unsigned case_insensitive:1;
  unsigned inodeset:1;
  grub_int32_t mtime;
  grub_uint64_t inode;
};

typedef int (*grub_fs_dir_hook_t) (const char *filename,
       const struct grub_dirhook_info *info,
       void *data);


struct grub_fs
{

  struct grub_fs *next;
  struct grub_fs **prev;


  const char *name;


  grub_err_t (*fs_dir) (grub_device_t device, const char *path,
       grub_fs_dir_hook_t hook, void *hook_data);


  grub_err_t (*fs_open) (struct grub_file *file, const char *name);


  grub_ssize_t (*fs_read) (struct grub_file *file, char *buf, grub_size_t len);


  grub_err_t (*fs_close) (struct grub_file *file);




  grub_err_t (*fs_label) (grub_device_t device, char **label);




  grub_err_t (*fs_uuid) (grub_device_t device, char **uuid);


  grub_err_t (*fs_mtime) (grub_device_t device, grub_int32_t *timebuf);



  grub_err_t (*fs_embed) (grub_device_t device, unsigned int *nsectors,
         unsigned int max_nsectors,
         grub_embed_type_t embed_type,
         grub_disk_addr_t **sectors);


  int reserved_first_sector;


  int blocklist_install;

};
typedef struct grub_fs *grub_fs_t;


extern struct grub_fs grub_fs_blocklist;





typedef int (*grub_fs_autoload_hook_t) (void);
extern grub_fs_autoload_hook_t grub_fs_autoload_hook;
extern grub_fs_t grub_fs_list;


static inline void
grub_fs_register (grub_fs_t fs)
{
  grub_list_push ((((char *) &(*&grub_fs_list)->next == (char *) &((grub_list_t) (*&grub_fs_list))->next) && ((char *) &(*&grub_fs_list)->prev == (char *) &((grub_list_t) (*&grub_fs_list))->prev) ? (grub_list_t *) (void *) &grub_fs_list : (grub_list_t *) grub_bad_type_cast_real(117, "util/grub-fstest.c")), (((char *) &(fs)->next == (char *) &((grub_list_t) (fs))->next) && ((char *) &(fs)->prev == (char *) &((grub_list_t) (fs))->prev) ? (grub_list_t) fs : (grub_list_t) grub_bad_type_cast_real(117, "util/grub-fstest.c")));
}


static inline void
grub_fs_unregister (grub_fs_t fs)
{
  grub_list_remove ((((char *) &(fs)->next == (char *) &((grub_list_t) (fs))->next) && ((char *) &(fs)->prev == (char *) &((grub_list_t) (fs))->prev) ? (grub_list_t) fs : (grub_list_t) grub_bad_type_cast_real(124, "util/grub-fstest.c")));
}



grub_fs_t grub_fs_probe (grub_device_t device);
# 23 "grub-core/kern/emu/hostfs.c" 2
# 1 "./include/grub/file.h" 1
# 26 "./include/grub/file.h"
# 1 "./include/grub/disk.h" 1
# 22 "./include/grub/disk.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/disk.h" 2






# 1 "./include/grub/mm.h" 1
# 25 "./include/grub/mm.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 26 "./include/grub/mm.h" 2





void grub_mm_init_region (void *addr, grub_size_t size);
void *grub_calloc (grub_size_t nmemb, grub_size_t size);
void *grub_malloc (grub_size_t size);
void *grub_zalloc (grub_size_t size);
void grub_free (void *ptr);
void *grub_realloc (void *ptr, grub_size_t size);

void *grub_memalign (grub_size_t align, grub_size_t size);


void grub_mm_check_real (const char *file, int line);
# 30 "./include/grub/disk.h" 2



enum grub_disk_dev_id
  {
    GRUB_DISK_DEVICE_BIOSDISK_ID,
    GRUB_DISK_DEVICE_OFDISK_ID,
    GRUB_DISK_DEVICE_LOOPBACK_ID,
    GRUB_DISK_DEVICE_EFIDISK_ID,
    GRUB_DISK_DEVICE_DISKFILTER_ID,
    GRUB_DISK_DEVICE_HOST_ID,
    GRUB_DISK_DEVICE_ATA_ID,
    GRUB_DISK_DEVICE_MEMDISK_ID,
    GRUB_DISK_DEVICE_NAND_ID,
    GRUB_DISK_DEVICE_SCSI_ID,
    GRUB_DISK_DEVICE_CRYPTODISK_ID,
    GRUB_DISK_DEVICE_ARCDISK_ID,
    GRUB_DISK_DEVICE_HOSTDISK_ID,
    GRUB_DISK_DEVICE_PROCFS_ID,
    GRUB_DISK_DEVICE_CBFSDISK_ID,
    GRUB_DISK_DEVICE_UBOOTDISK_ID,
    GRUB_DISK_DEVICE_XEN,
    GRUB_DISK_DEVICE_OBDISK_ID,
  };

struct grub_disk;

struct grub_disk_memberlist;


typedef enum
  {
    GRUB_DISK_PULL_NONE,
    GRUB_DISK_PULL_REMOVABLE,
    GRUB_DISK_PULL_RESCAN,
    GRUB_DISK_PULL_MAX
  } grub_disk_pull_t;

typedef int (*grub_disk_dev_iterate_hook_t) (const char *name, void *data);


struct grub_disk_dev
{

  const char *name;


  enum grub_disk_dev_id id;


  int (*disk_iterate) (grub_disk_dev_iterate_hook_t hook, void *hook_data,
    grub_disk_pull_t pull);


  grub_err_t (*disk_open) (const char *name, struct grub_disk *disk);


  void (*disk_close) (struct grub_disk *disk);


  grub_err_t (*disk_read) (struct grub_disk *disk, grub_disk_addr_t sector,
        grub_size_t size, char *buf);


  grub_err_t (*disk_write) (struct grub_disk *disk, grub_disk_addr_t sector,
         grub_size_t size, const char *buf);


  struct grub_disk_memberlist *(*disk_memberlist) (struct grub_disk *disk);
  const char * (*disk_raidname) (struct grub_disk *disk);



  struct grub_disk_dev *next;
};
typedef struct grub_disk_dev *grub_disk_dev_t;

extern grub_disk_dev_t grub_disk_dev_list;

struct grub_partition;

typedef void (*grub_disk_read_hook_t) (grub_disk_addr_t sector,
           unsigned offset, unsigned length,
           void *data);


struct grub_disk
{

  const char *name;


  grub_disk_dev_t dev;


  grub_uint64_t total_sectors;


  unsigned int log_sector_size;


  unsigned int max_agglomerate;


  unsigned long id;


  struct grub_partition *partition;



  grub_disk_read_hook_t read_hook;


  void *read_hook_data;


  void *data;
};
typedef struct grub_disk *grub_disk_t;


struct grub_disk_memberlist
{
  grub_disk_t disk;
  struct grub_disk_memberlist *next;
};
typedef struct grub_disk_memberlist *grub_disk_memberlist_t;
# 178 "./include/grub/disk.h"
static inline grub_disk_addr_t
grub_disk_from_native_sector (grub_disk_t disk, grub_disk_addr_t sector)
{
  return sector << (disk->log_sector_size - 9);
}


void grub_disk_cache_invalidate_all (void);

void grub_disk_dev_register (grub_disk_dev_t dev);
void grub_disk_dev_unregister (grub_disk_dev_t dev);
static inline int
grub_disk_dev_iterate (grub_disk_dev_iterate_hook_t hook, void *hook_data)
{
  grub_disk_dev_t p;
  grub_disk_pull_t pull;

  for (pull = 0; pull < GRUB_DISK_PULL_MAX; pull++)
    for (p = grub_disk_dev_list; p; p = p->next)
      if (p->disk_iterate && (p->disk_iterate) (hook, hook_data, pull))
 return 1;

  return 0;
}

grub_disk_t grub_disk_open (const char *name);
void grub_disk_close (grub_disk_t disk);
grub_err_t grub_disk_read (grub_disk_t disk,
     grub_disk_addr_t sector,
     grub_off_t offset,
     grub_size_t size,
     void *buf);
grub_err_t grub_disk_write (grub_disk_t disk,
       grub_disk_addr_t sector,
       grub_off_t offset,
       grub_size_t size,
       const void *buf);
extern grub_err_t (*grub_disk_write_weak) (grub_disk_t disk,
             grub_disk_addr_t sector,
             grub_off_t offset,
             grub_size_t size,
             const void *buf);


grub_uint64_t grub_disk_get_size (grub_disk_t disk);






extern void (* grub_disk_firmware_fini) (void);
extern int grub_disk_firmware_is_tainted;

static inline void
grub_stop_disk_firmware (void)
{

  grub_disk_firmware_is_tainted = 1;
  if (grub_disk_firmware_fini)
    {
      grub_disk_firmware_fini ();
      grub_disk_firmware_fini = 
# 240 "./include/grub/disk.h" 3 4
                               ((void *)0)
# 240 "./include/grub/disk.h"
                                   ;
    }
}


struct grub_disk_cache
{
  enum grub_disk_dev_id dev_id;
  unsigned long disk_id;
  grub_disk_addr_t sector;
  char *data;
  int lock;
};

extern struct grub_disk_cache grub_disk_cache_table[1021];


void grub_lvm_init (void);
void grub_ldm_init (void);
void grub_mdraid09_init (void);
void grub_mdraid1x_init (void);
void grub_diskfilter_init (void);
void grub_lvm_fini (void);
void grub_ldm_fini (void);
void grub_mdraid09_fini (void);
void grub_mdraid1x_fini (void);
void grub_diskfilter_fini (void);
# 27 "./include/grub/file.h" 2

enum grub_file_type
  {
    GRUB_FILE_TYPE_NONE = 0,

    GRUB_FILE_TYPE_GRUB_MODULE,

    GRUB_FILE_TYPE_LOOPBACK,

    GRUB_FILE_TYPE_LINUX_KERNEL,

    GRUB_FILE_TYPE_LINUX_INITRD,


    GRUB_FILE_TYPE_MULTIBOOT_KERNEL,

    GRUB_FILE_TYPE_MULTIBOOT_MODULE,


    GRUB_FILE_TYPE_XEN_HYPERVISOR,

    GRUB_FILE_TYPE_XEN_MODULE,

    GRUB_FILE_TYPE_BSD_KERNEL,
    GRUB_FILE_TYPE_FREEBSD_ENV,
    GRUB_FILE_TYPE_FREEBSD_MODULE,
    GRUB_FILE_TYPE_FREEBSD_MODULE_ELF,
    GRUB_FILE_TYPE_NETBSD_MODULE,
    GRUB_FILE_TYPE_OPENBSD_RAMDISK,

    GRUB_FILE_TYPE_XNU_INFO_PLIST,
    GRUB_FILE_TYPE_XNU_MKEXT,
    GRUB_FILE_TYPE_XNU_KEXT,
    GRUB_FILE_TYPE_XNU_KERNEL,
    GRUB_FILE_TYPE_XNU_RAMDISK,
    GRUB_FILE_TYPE_XNU_HIBERNATE_IMAGE,
    GRUB_FILE_XNU_DEVPROP,

    GRUB_FILE_TYPE_PLAN9_KERNEL,

    GRUB_FILE_TYPE_NTLDR,
    GRUB_FILE_TYPE_TRUECRYPT,
    GRUB_FILE_TYPE_FREEDOS,
    GRUB_FILE_TYPE_PXECHAINLOADER,
    GRUB_FILE_TYPE_PCCHAINLOADER,

    GRUB_FILE_TYPE_COREBOOT_CHAINLOADER,

    GRUB_FILE_TYPE_EFI_CHAINLOADED_IMAGE,


    GRUB_FILE_TYPE_SIGNATURE,

    GRUB_FILE_TYPE_PUBLIC_KEY,

    GRUB_FILE_TYPE_PUBLIC_KEY_TRUST,

    GRUB_FILE_TYPE_PRINT_BLOCKLIST,

    GRUB_FILE_TYPE_TESTLOAD,

    GRUB_FILE_TYPE_GET_SIZE,

    GRUB_FILE_TYPE_FONT,

    GRUB_FILE_TYPE_ZFS_ENCRYPTION_KEY,

    GRUB_FILE_TYPE_FSTEST,

    GRUB_FILE_TYPE_MOUNT,

    GRUB_FILE_TYPE_FILE_ID,

    GRUB_FILE_TYPE_ACPI_TABLE,

    GRUB_FILE_TYPE_DEVICE_TREE_IMAGE,

    GRUB_FILE_TYPE_CAT,
    GRUB_FILE_TYPE_HEXCAT,

    GRUB_FILE_TYPE_CMP,

    GRUB_FILE_TYPE_HASHLIST,

    GRUB_FILE_TYPE_TO_HASH,

    GRUB_FILE_TYPE_KEYBOARD_LAYOUT,

    GRUB_FILE_TYPE_PIXMAP,

    GRUB_FILE_TYPE_GRUB_MODULE_LIST,

    GRUB_FILE_TYPE_CONFIG,
    GRUB_FILE_TYPE_THEME,
    GRUB_FILE_TYPE_GETTEXT_CATALOG,
    GRUB_FILE_TYPE_FS_SEARCH,
    GRUB_FILE_TYPE_AUDIO,
    GRUB_FILE_TYPE_VBE_DUMP,

    GRUB_FILE_TYPE_LOADENV,
    GRUB_FILE_TYPE_SAVEENV,

    GRUB_FILE_TYPE_VERIFY_SIGNATURE,

    GRUB_FILE_TYPE_MASK = 0xffff,


    GRUB_FILE_TYPE_SKIP_SIGNATURE = 0x10000,
    GRUB_FILE_TYPE_NO_DECOMPRESS = 0x20000
  };


struct grub_file
{

  char *name;


  grub_device_t device;


  grub_fs_t fs;


  grub_off_t offset;
  grub_off_t progress_offset;


  grub_uint64_t last_progress_time;
  grub_off_t last_progress_offset;
  grub_uint64_t estimated_speed;


  grub_off_t size;


  int not_easily_seekable;


  void *data;


  grub_disk_read_hook_t read_hook;


  void *read_hook_data;
};
typedef struct grub_file *grub_file_t;

extern grub_disk_read_hook_t grub_file_progress_hook;


typedef enum grub_file_filter_id
  {
    GRUB_FILE_FILTER_VERIFY,
    GRUB_FILE_FILTER_GZIO,
    GRUB_FILE_FILTER_XZIO,
    GRUB_FILE_FILTER_LZOPIO,
    GRUB_FILE_FILTER_MAX,
    GRUB_FILE_FILTER_COMPRESSION_FIRST = GRUB_FILE_FILTER_GZIO,
    GRUB_FILE_FILTER_COMPRESSION_LAST = GRUB_FILE_FILTER_LZOPIO,
  } grub_file_filter_id_t;

typedef grub_file_t (*grub_file_filter_t) (grub_file_t in, enum grub_file_type type);

extern grub_file_filter_t grub_file_filters[GRUB_FILE_FILTER_MAX];

static inline void
grub_file_filter_register (grub_file_filter_id_t id, grub_file_filter_t filter)
{
  grub_file_filters[id] = filter;
}

static inline void
grub_file_filter_unregister (grub_file_filter_id_t id)
{
  grub_file_filters[id] = 0;
}


char *grub_file_get_device_name (const char *name);

grub_file_t grub_file_open (const char *name, enum grub_file_type type);
grub_ssize_t grub_file_read (grub_file_t file, void *buf,
       grub_size_t len);
grub_off_t grub_file_seek (grub_file_t file, grub_off_t offset);
grub_err_t grub_file_close (grub_file_t file);




static inline grub_off_t
grub_file_size (const grub_file_t file)
{
  return file->size;
}

static inline grub_off_t
grub_file_tell (const grub_file_t file)
{
  return file->offset;
}

static inline int
grub_file_seekable (const grub_file_t file)
{
  return !file->not_easily_seekable;
}

grub_file_t
grub_file_offset_open (grub_file_t parent, enum grub_file_type type,
         grub_off_t start, grub_off_t size);
void
grub_file_offset_close (grub_file_t file);
# 24 "grub-core/kern/emu/hostfs.c" 2




# 1 "./include/grub/util/misc.h" 1
# 22 "./include/grub/util/misc.h"
# 1 "/usr/include/stdlib.h" 1 3 4
# 25 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/bits/libc-header-start.h" 1 3 4
# 26 "/usr/include/stdlib.h" 2 3 4





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 209 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 3 4

# 209 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 321 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 3 4
typedef int wchar_t;
# 32 "/usr/include/stdlib.h" 2 3 4







# 1 "/usr/include/bits/waitflags.h" 1 3 4
# 40 "/usr/include/stdlib.h" 2 3 4
# 1 "/usr/include/bits/waitstatus.h" 1 3 4
# 41 "/usr/include/stdlib.h" 2 3 4
# 55 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/bits/floatn.h" 1 3 4
# 119 "/usr/include/bits/floatn.h" 3 4
# 1 "/usr/include/bits/floatn-common.h" 1 3 4
# 24 "/usr/include/bits/floatn-common.h" 3 4
# 1 "/usr/include/bits/long-double.h" 1 3 4
# 25 "/usr/include/bits/floatn-common.h" 2 3 4
# 120 "/usr/include/bits/floatn.h" 2 3 4
# 56 "/usr/include/stdlib.h" 2 3 4


typedef struct
  {
    int quot;
    int rem;
  } div_t;



typedef struct
  {
    long int quot;
    long int rem;
  } ldiv_t;





__extension__ typedef struct
  {
    long long int quot;
    long long int rem;
  } lldiv_t;
# 97 "/usr/include/stdlib.h" 3 4
extern size_t __ctype_get_mb_cur_max (void) __attribute__ ((__nothrow__ , __leaf__)) ;



extern double atof (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern int atoi (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern long int atol (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;



__extension__ extern long long int atoll (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;



extern double strtod (const char *__restrict __nptr,
        char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern float strtof (const char *__restrict __nptr,
       char **__restrict __endptr) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

extern long double strtold (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 140 "/usr/include/stdlib.h" 3 4
extern _Float32 strtof32 (const char *__restrict __nptr,
     char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float64 strtof64 (const char *__restrict __nptr,
     char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float128 strtof128 (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float32x strtof32x (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float64x strtof64x (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 176 "/usr/include/stdlib.h" 3 4
extern long int strtol (const char *__restrict __nptr,
   char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

extern unsigned long int strtoul (const char *__restrict __nptr,
      char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



__extension__
extern long long int strtoq (const char *__restrict __nptr,
        char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

__extension__
extern unsigned long long int strtouq (const char *__restrict __nptr,
           char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




__extension__
extern long long int strtoll (const char *__restrict __nptr,
         char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

__extension__
extern unsigned long long int strtoull (const char *__restrict __nptr,
     char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int strfromd (char *__dest, size_t __size, const char *__format,
       double __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));

extern int strfromf (char *__dest, size_t __size, const char *__format,
       float __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));

extern int strfroml (char *__dest, size_t __size, const char *__format,
       long double __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));
# 232 "/usr/include/stdlib.h" 3 4
extern int strfromf32 (char *__dest, size_t __size, const char * __format,
         _Float32 __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf64 (char *__dest, size_t __size, const char * __format,
         _Float64 __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf128 (char *__dest, size_t __size, const char * __format,
   _Float128 __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf32x (char *__dest, size_t __size, const char * __format,
   _Float32x __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf64x (char *__dest, size_t __size, const char * __format,
   _Float64x __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));
# 274 "/usr/include/stdlib.h" 3 4
extern long int strtol_l (const char *__restrict __nptr,
     char **__restrict __endptr, int __base,
     locale_t __loc) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

extern unsigned long int strtoul_l (const char *__restrict __nptr,
        char **__restrict __endptr,
        int __base, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

__extension__
extern long long int strtoll_l (const char *__restrict __nptr,
    char **__restrict __endptr, int __base,
    locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

__extension__
extern unsigned long long int strtoull_l (const char *__restrict __nptr,
       char **__restrict __endptr,
       int __base, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

extern double strtod_l (const char *__restrict __nptr,
   char **__restrict __endptr, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));

extern float strtof_l (const char *__restrict __nptr,
         char **__restrict __endptr, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));

extern long double strtold_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));
# 316 "/usr/include/stdlib.h" 3 4
extern _Float32 strtof32_l (const char *__restrict __nptr,
       char **__restrict __endptr,
       locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float64 strtof64_l (const char *__restrict __nptr,
       char **__restrict __endptr,
       locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float128 strtof128_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float32x strtof32x_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float64x strtof64x_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));
# 385 "/usr/include/stdlib.h" 3 4
extern char *l64a (long int __n) __attribute__ ((__nothrow__ , __leaf__)) ;


extern long int a64l (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;




# 1 "/usr/include/sys/types.h" 1 3 4
# 27 "/usr/include/sys/types.h" 3 4


# 1 "/usr/include/bits/types.h" 1 3 4
# 27 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 28 "/usr/include/bits/types.h" 2 3 4
# 1 "/usr/include/bits/timesize.h" 1 3 4
# 29 "/usr/include/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;






typedef __int8_t __int_least8_t;
typedef __uint8_t __uint_least8_t;
typedef __int16_t __int_least16_t;
typedef __uint16_t __uint_least16_t;
typedef __int32_t __int_least32_t;
typedef __uint32_t __uint_least32_t;
typedef __int64_t __int_least64_t;
typedef __uint64_t __uint_least64_t;



typedef long int __quad_t;
typedef unsigned long int __u_quad_t;







typedef long int __intmax_t;
typedef unsigned long int __uintmax_t;
# 141 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/typesizes.h" 1 3 4
# 142 "/usr/include/bits/types.h" 2 3 4
# 1 "/usr/include/bits/time64.h" 1 3 4
# 143 "/usr/include/bits/types.h" 2 3 4


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;
typedef long int __suseconds64_t;

typedef int __daddr_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;


typedef long int __fsword_t;

typedef long int __ssize_t;


typedef long int __syscall_slong_t;

typedef unsigned long int __syscall_ulong_t;



typedef __off64_t __loff_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;




typedef int __sig_atomic_t;
# 30 "/usr/include/sys/types.h" 2 3 4



typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;


typedef __loff_t loff_t;






typedef __ino64_t ino_t;




typedef __ino64_t ino64_t;




typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;







typedef __off64_t off_t;




typedef __off64_t off64_t;




typedef __pid_t pid_t;





typedef __id_t id_t;




typedef __ssize_t ssize_t;





typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;




# 1 "/usr/include/bits/types/clock_t.h" 1 3 4






typedef __clock_t clock_t;
# 127 "/usr/include/sys/types.h" 2 3 4

# 1 "/usr/include/bits/types/clockid_t.h" 1 3 4






typedef __clockid_t clockid_t;
# 129 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/bits/types/time_t.h" 1 3 4






typedef __time_t time_t;
# 130 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/bits/types/timer_t.h" 1 3 4






typedef __timer_t timer_t;
# 131 "/usr/include/sys/types.h" 2 3 4



typedef __useconds_t useconds_t;



typedef __suseconds_t suseconds_t;





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 145 "/usr/include/sys/types.h" 2 3 4



typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;




# 1 "/usr/include/bits/stdint-intn.h" 1 3 4
# 24 "/usr/include/bits/stdint-intn.h" 3 4
typedef __int8_t int8_t;
typedef __int16_t int16_t;
typedef __int32_t int32_t;
typedef __int64_t int64_t;
# 156 "/usr/include/sys/types.h" 2 3 4


typedef __uint8_t u_int8_t;
typedef __uint16_t u_int16_t;
typedef __uint32_t u_int32_t;
typedef __uint64_t u_int64_t;


typedef int register_t __attribute__ ((__mode__ (__word__)));
# 176 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 24 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 35 "/usr/include/bits/endian.h" 3 4
# 1 "/usr/include/bits/endianness.h" 1 3 4
# 36 "/usr/include/bits/endian.h" 2 3 4
# 25 "/usr/include/endian.h" 2 3 4
# 35 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/byteswap.h" 1 3 4
# 33 "/usr/include/bits/byteswap.h" 3 4
static __inline __uint16_t
__bswap_16 (__uint16_t __bsx)
{

  return __builtin_bswap16 (__bsx);



}






static __inline __uint32_t
__bswap_32 (__uint32_t __bsx)
{

  return __builtin_bswap32 (__bsx);



}
# 69 "/usr/include/bits/byteswap.h" 3 4
__extension__ static __inline __uint64_t
__bswap_64 (__uint64_t __bsx)
{

  return __builtin_bswap64 (__bsx);



}
# 36 "/usr/include/endian.h" 2 3 4
# 1 "/usr/include/bits/uintn-identity.h" 1 3 4
# 32 "/usr/include/bits/uintn-identity.h" 3 4
static __inline __uint16_t
__uint16_identity (__uint16_t __x)
{
  return __x;
}

static __inline __uint32_t
__uint32_identity (__uint32_t __x)
{
  return __x;
}

static __inline __uint64_t
__uint64_identity (__uint64_t __x)
{
  return __x;
}
# 37 "/usr/include/endian.h" 2 3 4
# 177 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/select.h" 1 3 4
# 30 "/usr/include/sys/select.h" 3 4
# 1 "/usr/include/bits/select.h" 1 3 4
# 31 "/usr/include/sys/select.h" 2 3 4


# 1 "/usr/include/bits/types/sigset_t.h" 1 3 4



# 1 "/usr/include/bits/types/__sigset_t.h" 1 3 4




typedef struct
{
  unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
} __sigset_t;
# 5 "/usr/include/bits/types/sigset_t.h" 2 3 4


typedef __sigset_t sigset_t;
# 34 "/usr/include/sys/select.h" 2 3 4



# 1 "/usr/include/bits/types/struct_timeval.h" 1 3 4







struct timeval
{
  __time_t tv_sec;
  __suseconds_t tv_usec;
};
# 38 "/usr/include/sys/select.h" 2 3 4

# 1 "/usr/include/bits/types/struct_timespec.h" 1 3 4
# 10 "/usr/include/bits/types/struct_timespec.h" 3 4
struct timespec
{
  __time_t tv_sec;



  __syscall_slong_t tv_nsec;
# 26 "/usr/include/bits/types/struct_timespec.h" 3 4
};
# 40 "/usr/include/sys/select.h" 2 3 4
# 49 "/usr/include/sys/select.h" 3 4
typedef long int __fd_mask;
# 59 "/usr/include/sys/select.h" 3 4
typedef struct
  {



    __fd_mask fds_bits[1024 / (8 * (int) sizeof (__fd_mask))];





  } fd_set;






typedef __fd_mask fd_mask;
# 91 "/usr/include/sys/select.h" 3 4

# 101 "/usr/include/sys/select.h" 3 4
extern int select (int __nfds, fd_set *__restrict __readfds,
     fd_set *__restrict __writefds,
     fd_set *__restrict __exceptfds,
     struct timeval *__restrict __timeout);
# 113 "/usr/include/sys/select.h" 3 4
extern int pselect (int __nfds, fd_set *__restrict __readfds,
      fd_set *__restrict __writefds,
      fd_set *__restrict __exceptfds,
      const struct timespec *__restrict __timeout,
      const __sigset_t *__restrict __sigmask);
# 126 "/usr/include/sys/select.h" 3 4

# 180 "/usr/include/sys/types.h" 2 3 4





typedef __blksize_t blksize_t;
# 205 "/usr/include/sys/types.h" 3 4
typedef __blkcnt64_t blkcnt_t;



typedef __fsblkcnt64_t fsblkcnt_t;



typedef __fsfilcnt64_t fsfilcnt_t;





typedef __blkcnt64_t blkcnt64_t;
typedef __fsblkcnt64_t fsblkcnt64_t;
typedef __fsfilcnt64_t fsfilcnt64_t;





# 1 "/usr/include/bits/pthreadtypes.h" 1 3 4
# 23 "/usr/include/bits/pthreadtypes.h" 3 4
# 1 "/usr/include/bits/thread-shared-types.h" 1 3 4
# 44 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/pthreadtypes-arch.h" 1 3 4
# 21 "/usr/include/bits/pthreadtypes-arch.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 22 "/usr/include/bits/pthreadtypes-arch.h" 2 3 4
# 45 "/usr/include/bits/thread-shared-types.h" 2 3 4




typedef struct __pthread_internal_list
{
  struct __pthread_internal_list *__prev;
  struct __pthread_internal_list *__next;
} __pthread_list_t;

typedef struct __pthread_internal_slist
{
  struct __pthread_internal_slist *__next;
} __pthread_slist_t;
# 74 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/struct_mutex.h" 1 3 4
# 22 "/usr/include/bits/struct_mutex.h" 3 4
struct __pthread_mutex_s
{
  int __lock;
  unsigned int __count;
  int __owner;

  unsigned int __nusers;



  int __kind;

  short __spins;
  short __elision;
  __pthread_list_t __list;
# 53 "/usr/include/bits/struct_mutex.h" 3 4
};
# 75 "/usr/include/bits/thread-shared-types.h" 2 3 4
# 87 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/struct_rwlock.h" 1 3 4
# 23 "/usr/include/bits/struct_rwlock.h" 3 4
struct __pthread_rwlock_arch_t
{
  unsigned int __readers;
  unsigned int __writers;
  unsigned int __wrphase_futex;
  unsigned int __writers_futex;
  unsigned int __pad3;
  unsigned int __pad4;

  int __cur_writer;
  int __shared;
  signed char __rwelision;




  unsigned char __pad1[7];


  unsigned long int __pad2;


  unsigned int __flags;
# 55 "/usr/include/bits/struct_rwlock.h" 3 4
};
# 88 "/usr/include/bits/thread-shared-types.h" 2 3 4




struct __pthread_cond_s
{
  __extension__ union
  {
    __extension__ unsigned long long int __wseq;
    struct
    {
      unsigned int __low;
      unsigned int __high;
    } __wseq32;
  };
  __extension__ union
  {
    __extension__ unsigned long long int __g1_start;
    struct
    {
      unsigned int __low;
      unsigned int __high;
    } __g1_start32;
  };
  unsigned int __g_refs[2] ;
  unsigned int __g_size[2];
  unsigned int __g1_orig_size;
  unsigned int __wrefs;
  unsigned int __g_signals[2];
};

typedef unsigned int __tss_t;
typedef unsigned long int __thrd_t;

typedef struct
{
  int __data ;
} __once_flag;
# 24 "/usr/include/bits/pthreadtypes.h" 2 3 4



typedef unsigned long int pthread_t;




typedef union
{
  char __size[4];
  int __align;
} pthread_mutexattr_t;




typedef union
{
  char __size[4];
  int __align;
} pthread_condattr_t;



typedef unsigned int pthread_key_t;



typedef int pthread_once_t;


union pthread_attr_t
{
  char __size[56];
  long int __align;
};

typedef union pthread_attr_t pthread_attr_t;




typedef union
{
  struct __pthread_mutex_s __data;
  char __size[40];
  long int __align;
} pthread_mutex_t;


typedef union
{
  struct __pthread_cond_s __data;
  char __size[48];
  __extension__ long long int __align;
} pthread_cond_t;





typedef union
{
  struct __pthread_rwlock_arch_t __data;
  char __size[56];
  long int __align;
} pthread_rwlock_t;

typedef union
{
  char __size[8];
  long int __align;
} pthread_rwlockattr_t;





typedef volatile int pthread_spinlock_t;




typedef union
{
  char __size[32];
  long int __align;
} pthread_barrier_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_barrierattr_t;
# 228 "/usr/include/sys/types.h" 2 3 4



# 395 "/usr/include/stdlib.h" 2 3 4






extern long int random (void) __attribute__ ((__nothrow__ , __leaf__));


extern void srandom (unsigned int __seed) __attribute__ ((__nothrow__ , __leaf__));





extern char *initstate (unsigned int __seed, char *__statebuf,
   size_t __statelen) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



extern char *setstate (char *__statebuf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







struct random_data
  {
    int32_t *fptr;
    int32_t *rptr;
    int32_t *state;
    int rand_type;
    int rand_deg;
    int rand_sep;
    int32_t *end_ptr;
  };

extern int random_r (struct random_data *__restrict __buf,
       int32_t *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern int srandom_r (unsigned int __seed, struct random_data *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

extern int initstate_r (unsigned int __seed, char *__restrict __statebuf,
   size_t __statelen,
   struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));

extern int setstate_r (char *__restrict __statebuf,
         struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern int rand (void) __attribute__ ((__nothrow__ , __leaf__));

extern void srand (unsigned int __seed) __attribute__ ((__nothrow__ , __leaf__));



extern int rand_r (unsigned int *__seed) __attribute__ ((__nothrow__ , __leaf__));







extern double drand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern double erand48 (unsigned short int __xsubi[3]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int lrand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern long int nrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int mrand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern long int jrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern void srand48 (long int __seedval) __attribute__ ((__nothrow__ , __leaf__));
extern unsigned short int *seed48 (unsigned short int __seed16v[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
extern void lcong48 (unsigned short int __param[7]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





struct drand48_data
  {
    unsigned short int __x[3];
    unsigned short int __old_x[3];
    unsigned short int __c;
    unsigned short int __init;
    __extension__ unsigned long long int __a;

  };


extern int drand48_r (struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int erand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int lrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int nrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int mrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int jrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int srand48_r (long int __seedval, struct drand48_data *__buffer)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

extern int seed48_r (unsigned short int __seed16v[3],
       struct drand48_data *__buffer) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern int lcong48_r (unsigned short int __param[7],
        struct drand48_data *__buffer)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern void *malloc (size_t __size) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__))
     __attribute__ ((__alloc_size__ (1))) ;

extern void *calloc (size_t __nmemb, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__alloc_size__ (1, 2))) ;






extern void *realloc (void *__ptr, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__warn_unused_result__)) __attribute__ ((__alloc_size__ (2)));







extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__warn_unused_result__))
     __attribute__ ((__alloc_size__ (2, 3)));



extern void free (void *__ptr) __attribute__ ((__nothrow__ , __leaf__));


# 1 "/usr/include/alloca.h" 1 3 4
# 24 "/usr/include/alloca.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 25 "/usr/include/alloca.h" 2 3 4







extern void *alloca (size_t __size) __attribute__ ((__nothrow__ , __leaf__));






# 569 "/usr/include/stdlib.h" 2 3 4





extern void *valloc (size_t __size) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__))
     __attribute__ ((__alloc_size__ (1))) ;




extern int posix_memalign (void **__memptr, size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;




extern void *aligned_alloc (size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__alloc_size__ (2))) ;



extern void abort (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));



extern int atexit (void (*__func) (void)) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







extern int at_quick_exit (void (*__func) (void)) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int on_exit (void (*__func) (int __status, void *__arg), void *__arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern void exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));





extern void quick_exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));





extern void _Exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));




extern char *getenv (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;




extern char *secure_getenv (const char *__name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;






extern int putenv (char *__string) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int setenv (const char *__name, const char *__value, int __replace)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));


extern int unsetenv (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int clearenv (void) __attribute__ ((__nothrow__ , __leaf__));
# 675 "/usr/include/stdlib.h" 3 4
extern char *mktemp (char *__template) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 691 "/usr/include/stdlib.h" 3 4
extern int mkstemp (char *__template) __asm__ ("" "mkstemp64")
     __attribute__ ((__nonnull__ (1))) ;





extern int mkstemp64 (char *__template) __attribute__ ((__nonnull__ (1))) ;
# 713 "/usr/include/stdlib.h" 3 4
extern int mkstemps (char *__template, int __suffixlen) __asm__ ("" "mkstemps64")
                     __attribute__ ((__nonnull__ (1))) ;





extern int mkstemps64 (char *__template, int __suffixlen)
     __attribute__ ((__nonnull__ (1))) ;
# 731 "/usr/include/stdlib.h" 3 4
extern char *mkdtemp (char *__template) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 745 "/usr/include/stdlib.h" 3 4
extern int mkostemp (char *__template, int __flags) __asm__ ("" "mkostemp64")
     __attribute__ ((__nonnull__ (1))) ;





extern int mkostemp64 (char *__template, int __flags) __attribute__ ((__nonnull__ (1))) ;
# 766 "/usr/include/stdlib.h" 3 4
extern int mkostemps (char *__template, int __suffixlen, int __flags) __asm__ ("" "mkostemps64")

     __attribute__ ((__nonnull__ (1))) ;





extern int mkostemps64 (char *__template, int __suffixlen, int __flags)
     __attribute__ ((__nonnull__ (1))) ;
# 784 "/usr/include/stdlib.h" 3 4
extern int system (const char *__command) ;





extern char *canonicalize_file_name (const char *__name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 800 "/usr/include/stdlib.h" 3 4
extern char *realpath (const char *__restrict __name,
         char *__restrict __resolved) __attribute__ ((__nothrow__ , __leaf__)) ;






typedef int (*__compar_fn_t) (const void *, const void *);


typedef __compar_fn_t comparison_fn_t;



typedef int (*__compar_d_fn_t) (const void *, const void *, void *);




extern void *bsearch (const void *__key, const void *__base,
        size_t __nmemb, size_t __size, __compar_fn_t __compar)
     __attribute__ ((__nonnull__ (1, 2, 5))) ;







extern void qsort (void *__base, size_t __nmemb, size_t __size,
     __compar_fn_t __compar) __attribute__ ((__nonnull__ (1, 4)));

extern void qsort_r (void *__base, size_t __nmemb, size_t __size,
       __compar_d_fn_t __compar, void *__arg)
  __attribute__ ((__nonnull__ (1, 4)));




extern int abs (int __x) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
extern long int labs (long int __x) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;


__extension__ extern long long int llabs (long long int __x)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;






extern div_t div (int __numer, int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
extern ldiv_t ldiv (long int __numer, long int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;


__extension__ extern lldiv_t lldiv (long long int __numer,
        long long int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
# 872 "/usr/include/stdlib.h" 3 4
extern char *ecvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *fcvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *gcvt (double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3))) ;




extern char *qecvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qfcvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qgcvt (long double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3))) ;




extern int ecvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int fcvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));

extern int qecvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int qfcvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));





extern int mblen (const char *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__));


extern int mbtowc (wchar_t *__restrict __pwc,
     const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__ , __leaf__));


extern int wctomb (char *__s, wchar_t __wchar) __attribute__ ((__nothrow__ , __leaf__));



extern size_t mbstowcs (wchar_t *__restrict __pwcs,
   const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__read_only__, 2)));

extern size_t wcstombs (char *__restrict __s,
   const wchar_t *__restrict __pwcs, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__))
  __attribute__ ((__access__ (__write_only__, 1, 3))) __attribute__ ((__access__ (__read_only__, 2)));






extern int rpmatch (const char *__response) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 958 "/usr/include/stdlib.h" 3 4
extern int getsubopt (char **__restrict __optionp,
        char *const *__restrict __tokens,
        char **__restrict __valuep)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2, 3))) ;







extern int posix_openpt (int __oflag) ;







extern int grantpt (int __fd) __attribute__ ((__nothrow__ , __leaf__));



extern int unlockpt (int __fd) __attribute__ ((__nothrow__ , __leaf__));




extern char *ptsname (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int ptsname_r (int __fd, char *__buf, size_t __buflen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 2, 3)));


extern int getpt (void);






extern int getloadavg (double __loadavg[], int __nelem)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 1014 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/bits/stdlib-float.h" 1 3 4
# 1015 "/usr/include/stdlib.h" 2 3 4
# 1026 "/usr/include/stdlib.h" 3 4

# 23 "./include/grub/util/misc.h" 2
# 1 "/usr/include/stdio.h" 1 3 4
# 27 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/libc-header-start.h" 1 3 4
# 28 "/usr/include/stdio.h" 2 3 4





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 34 "/usr/include/stdio.h" 2 3 4





# 1 "/usr/include/bits/types/__fpos_t.h" 1 3 4




# 1 "/usr/include/bits/types/__mbstate_t.h" 1 3 4
# 13 "/usr/include/bits/types/__mbstate_t.h" 3 4
typedef struct
{
  int __count;
  union
  {
    unsigned int __wch;
    char __wchb[4];
  } __value;
} __mbstate_t;
# 6 "/usr/include/bits/types/__fpos_t.h" 2 3 4




typedef struct _G_fpos_t
{
  __off_t __pos;
  __mbstate_t __state;
} __fpos_t;
# 40 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/__fpos64_t.h" 1 3 4
# 10 "/usr/include/bits/types/__fpos64_t.h" 3 4
typedef struct _G_fpos64_t
{
  __off64_t __pos;
  __mbstate_t __state;
} __fpos64_t;
# 41 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/__FILE.h" 1 3 4



struct _IO_FILE;
typedef struct _IO_FILE __FILE;
# 42 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/FILE.h" 1 3 4



struct _IO_FILE;


typedef struct _IO_FILE FILE;
# 43 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/struct_FILE.h" 1 3 4
# 35 "/usr/include/bits/types/struct_FILE.h" 3 4
struct _IO_FILE;
struct _IO_marker;
struct _IO_codecvt;
struct _IO_wide_data;




typedef void _IO_lock_t;





struct _IO_FILE
{
  int _flags;


  char *_IO_read_ptr;
  char *_IO_read_end;
  char *_IO_read_base;
  char *_IO_write_base;
  char *_IO_write_ptr;
  char *_IO_write_end;
  char *_IO_buf_base;
  char *_IO_buf_end;


  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;
  int _flags2;
  __off_t _old_offset;


  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];

  _IO_lock_t *_lock;







  __off64_t _offset;

  struct _IO_codecvt *_codecvt;
  struct _IO_wide_data *_wide_data;
  struct _IO_FILE *_freeres_list;
  void *_freeres_buf;
  size_t __pad5;
  int _mode;

  char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];
};
# 44 "/usr/include/stdio.h" 2 3 4


# 1 "/usr/include/bits/types/cookie_io_functions_t.h" 1 3 4
# 27 "/usr/include/bits/types/cookie_io_functions_t.h" 3 4
typedef __ssize_t cookie_read_function_t (void *__cookie, char *__buf,
                                          size_t __nbytes);







typedef __ssize_t cookie_write_function_t (void *__cookie, const char *__buf,
                                           size_t __nbytes);







typedef int cookie_seek_function_t (void *__cookie, __off64_t *__pos, int __w);


typedef int cookie_close_function_t (void *__cookie);






typedef struct _IO_cookie_io_functions_t
{
  cookie_read_function_t *read;
  cookie_write_function_t *write;
  cookie_seek_function_t *seek;
  cookie_close_function_t *close;
} cookie_io_functions_t;
# 47 "/usr/include/stdio.h" 2 3 4
# 86 "/usr/include/stdio.h" 3 4
typedef __fpos64_t fpos_t;


typedef __fpos64_t fpos64_t;
# 133 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 134 "/usr/include/stdio.h" 2 3 4



extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;






extern int remove (const char *__filename) __attribute__ ((__nothrow__ , __leaf__));

extern int rename (const char *__old, const char *__new) __attribute__ ((__nothrow__ , __leaf__));



extern int renameat (int __oldfd, const char *__old, int __newfd,
       const char *__new) __attribute__ ((__nothrow__ , __leaf__));
# 164 "/usr/include/stdio.h" 3 4
extern int renameat2 (int __oldfd, const char *__old, int __newfd,
        const char *__new, unsigned int __flags) __attribute__ ((__nothrow__ , __leaf__));
# 176 "/usr/include/stdio.h" 3 4
extern FILE *tmpfile (void) __asm__ ("" "tmpfile64") ;






extern FILE *tmpfile64 (void) ;



extern char *tmpnam (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;




extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;
# 204 "/usr/include/stdio.h" 3 4
extern char *tempnam (const char *__dir, const char *__pfx)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;







extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);
# 227 "/usr/include/stdio.h" 3 4
extern int fflush_unlocked (FILE *__stream);
# 237 "/usr/include/stdio.h" 3 4
extern int fcloseall (void);
# 257 "/usr/include/stdio.h" 3 4
extern FILE *fopen (const char *__restrict __filename, const char *__restrict __modes) __asm__ ("" "fopen64")

  ;
extern FILE *freopen (const char *__restrict __filename, const char *__restrict __modes, FILE *__restrict __stream) __asm__ ("" "freopen64")


  ;






extern FILE *fopen64 (const char *__restrict __filename,
        const char *__restrict __modes) ;
extern FILE *freopen64 (const char *__restrict __filename,
   const char *__restrict __modes,
   FILE *__restrict __stream) ;




extern FILE *fdopen (int __fd, const char *__modes) __attribute__ ((__nothrow__ , __leaf__)) ;





extern FILE *fopencookie (void *__restrict __magic_cookie,
     const char *__restrict __modes,
     cookie_io_functions_t __io_funcs) __attribute__ ((__nothrow__ , __leaf__)) ;




extern FILE *fmemopen (void *__s, size_t __len, const char *__modes)
  __attribute__ ((__nothrow__ , __leaf__)) ;




extern FILE *open_memstream (char **__bufloc, size_t *__sizeloc) __attribute__ ((__nothrow__ , __leaf__)) ;





extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));



extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
      int __modes, size_t __n) __attribute__ ((__nothrow__ , __leaf__));




extern void setbuffer (FILE *__restrict __stream, char *__restrict __buf,
         size_t __size) __attribute__ ((__nothrow__ , __leaf__));


extern void setlinebuf (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));







extern int fprintf (FILE *__restrict __stream,
      const char *__restrict __format, ...);




extern int printf (const char *__restrict __format, ...);

extern int sprintf (char *__restrict __s,
      const char *__restrict __format, ...) __attribute__ ((__nothrow__));





extern int vfprintf (FILE *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg);




extern int vprintf (const char *__restrict __format, __gnuc_va_list __arg);

extern int vsprintf (char *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg) __attribute__ ((__nothrow__));



extern int snprintf (char *__restrict __s, size_t __maxlen,
       const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 4)));

extern int vsnprintf (char *__restrict __s, size_t __maxlen,
        const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 0)));





extern int vasprintf (char **__restrict __ptr, const char *__restrict __f,
        __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 0))) ;
extern int __asprintf (char **__restrict __ptr,
         const char *__restrict __fmt, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3))) ;
extern int asprintf (char **__restrict __ptr,
       const char *__restrict __fmt, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3))) ;




extern int vdprintf (int __fd, const char *__restrict __fmt,
       __gnuc_va_list __arg)
     __attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));







extern int fscanf (FILE *__restrict __stream,
     const char *__restrict __format, ...) ;




extern int scanf (const char *__restrict __format, ...) ;

extern int sscanf (const char *__restrict __s,
     const char *__restrict __format, ...) __attribute__ ((__nothrow__ , __leaf__));
# 410 "/usr/include/stdio.h" 3 4
extern int fscanf (FILE *__restrict __stream, const char *__restrict __format, ...) __asm__ ("" "__isoc99_fscanf")

                               ;
extern int scanf (const char *__restrict __format, ...) __asm__ ("" "__isoc99_scanf")
                              ;
extern int sscanf (const char *__restrict __s, const char *__restrict __format, ...) __asm__ ("" "__isoc99_sscanf") __attribute__ ((__nothrow__ , __leaf__))

                      ;
# 435 "/usr/include/stdio.h" 3 4
extern int vfscanf (FILE *__restrict __s, const char *__restrict __format,
      __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;





extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;


extern int vsscanf (const char *__restrict __s,
      const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format__ (__scanf__, 2, 0)));





extern int vfscanf (FILE *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vfscanf")



     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vscanf")

     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (const char *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vsscanf") __attribute__ ((__nothrow__ , __leaf__))



     __attribute__ ((__format__ (__scanf__, 2, 0)));
# 489 "/usr/include/stdio.h" 3 4
extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);






extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
# 514 "/usr/include/stdio.h" 3 4
extern int fgetc_unlocked (FILE *__stream);
# 525 "/usr/include/stdio.h" 3 4
extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);
# 541 "/usr/include/stdio.h" 3 4
extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);







extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     __attribute__ ((__access__ (__write_only__, 1, 2)));
# 591 "/usr/include/stdio.h" 3 4
extern char *fgets_unlocked (char *__restrict __s, int __n,
        FILE *__restrict __stream)
    __attribute__ ((__access__ (__write_only__, 1, 2)));
# 608 "/usr/include/stdio.h" 3 4
extern __ssize_t __getdelim (char **__restrict __lineptr,
                             size_t *__restrict __n, int __delimiter,
                             FILE *__restrict __stream) ;
extern __ssize_t getdelim (char **__restrict __lineptr,
                           size_t *__restrict __n, int __delimiter,
                           FILE *__restrict __stream) ;







extern __ssize_t getline (char **__restrict __lineptr,
                          size_t *__restrict __n,
                          FILE *__restrict __stream) ;







extern int fputs (const char *__restrict __s, FILE *__restrict __stream);





extern int puts (const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void *__restrict __ptr, size_t __size,
       size_t __n, FILE *__restrict __stream) ;




extern size_t fwrite (const void *__restrict __ptr, size_t __size,
        size_t __n, FILE *__restrict __s);
# 667 "/usr/include/stdio.h" 3 4
extern int fputs_unlocked (const char *__restrict __s,
      FILE *__restrict __stream);
# 678 "/usr/include/stdio.h" 3 4
extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream);







extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream) ;




extern void rewind (FILE *__stream);
# 720 "/usr/include/stdio.h" 3 4
extern int fseeko (FILE *__stream, __off64_t __off, int __whence) __asm__ ("" "fseeko64")

                  ;
extern __off64_t ftello (FILE *__stream) __asm__ ("" "ftello64");
# 744 "/usr/include/stdio.h" 3 4
extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos) __asm__ ("" "fgetpos64")
                                          ;
extern int fsetpos (FILE *__stream, const fpos_t *__pos) __asm__ ("" "fsetpos64")
                                                          ;







extern int fseeko64 (FILE *__stream, __off64_t __off, int __whence);
extern __off64_t ftello64 (FILE *__stream) ;
extern int fgetpos64 (FILE *__restrict __stream, fpos64_t *__restrict __pos);
extern int fsetpos64 (FILE *__stream, const fpos64_t *__pos);



extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));

extern int feof (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;

extern int ferror (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;



extern void clearerr_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
extern int feof_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern int ferror_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;







extern void perror (const char *__s);




extern int fileno (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
# 799 "/usr/include/stdio.h" 3 4
extern FILE *popen (const char *__command, const char *__modes) ;





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) __attribute__ ((__nothrow__ , __leaf__));





extern char *cuserid (char *__s);




struct obstack;


extern int obstack_printf (struct obstack *__restrict __obstack,
      const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3)));
extern int obstack_vprintf (struct obstack *__restrict __obstack,
       const char *__restrict __format,
       __gnuc_va_list __args)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 0)));







extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));



extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;


extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
# 857 "/usr/include/stdio.h" 3 4
extern int __uflow (FILE *);
extern int __overflow (FILE *, int);
# 874 "/usr/include/stdio.h" 3 4

# 24 "./include/grub/util/misc.h" 2

# 1 "/usr/include/setjmp.h" 1 3 4
# 27 "/usr/include/setjmp.h" 3 4


# 1 "/usr/include/bits/setjmp.h" 1 3 4
# 26 "/usr/include/bits/setjmp.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 27 "/usr/include/bits/setjmp.h" 2 3 4




typedef long int __jmp_buf[8];
# 30 "/usr/include/setjmp.h" 2 3 4



struct __jmp_buf_tag
  {




    __jmp_buf __jmpbuf;
    int __mask_was_saved;
    __sigset_t __saved_mask;
  };


typedef struct __jmp_buf_tag jmp_buf[1];



extern int setjmp (jmp_buf __env) __attribute__ ((__nothrow__));




extern int __sigsetjmp (struct __jmp_buf_tag __env[1], int __savemask) __attribute__ ((__nothrow__));



extern int _setjmp (struct __jmp_buf_tag __env[1]) __attribute__ ((__nothrow__));
# 67 "/usr/include/setjmp.h" 3 4
extern void longjmp (struct __jmp_buf_tag __env[1], int __val)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));





extern void _longjmp (struct __jmp_buf_tag __env[1], int __val)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));







typedef struct __jmp_buf_tag sigjmp_buf[1];
# 93 "/usr/include/setjmp.h" 3 4
extern void siglongjmp (sigjmp_buf __env, int __val)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));
# 103 "/usr/include/setjmp.h" 3 4

# 26 "./include/grub/util/misc.h" 2
# 1 "/usr/include/unistd.h" 1 3 4
# 27 "/usr/include/unistd.h" 3 4

# 202 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/posix_opt.h" 1 3 4
# 203 "/usr/include/unistd.h" 2 3 4



# 1 "/usr/include/bits/environments.h" 1 3 4
# 22 "/usr/include/bits/environments.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 23 "/usr/include/bits/environments.h" 2 3 4
# 207 "/usr/include/unistd.h" 2 3 4
# 226 "/usr/include/unistd.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 227 "/usr/include/unistd.h" 2 3 4
# 267 "/usr/include/unistd.h" 3 4
typedef __intptr_t intptr_t;






typedef __socklen_t socklen_t;
# 287 "/usr/include/unistd.h" 3 4
extern int access (const char *__name, int __type) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int euidaccess (const char *__name, int __type)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int eaccess (const char *__name, int __type)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int faccessat (int __fd, const char *__file, int __type, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;
# 337 "/usr/include/unistd.h" 3 4
extern __off64_t lseek (int __fd, __off64_t __offset, int __whence) __asm__ ("" "lseek64") __attribute__ ((__nothrow__ , __leaf__))

             ;





extern __off64_t lseek64 (int __fd, __off64_t __offset, int __whence)
     __attribute__ ((__nothrow__ , __leaf__));






extern int close (int __fd);






extern ssize_t read (int __fd, void *__buf, size_t __nbytes)
    __attribute__ ((__access__ (__write_only__, 2, 3)));





extern ssize_t write (int __fd, const void *__buf, size_t __n)
    __attribute__ ((__access__ (__read_only__, 2, 3)));
# 393 "/usr/include/unistd.h" 3 4
extern ssize_t pread (int __fd, void *__buf, size_t __nbytes, __off64_t __offset) __asm__ ("" "pread64")


    __attribute__ ((__access__ (__write_only__, 2, 3)));
extern ssize_t pwrite (int __fd, const void *__buf, size_t __nbytes, __off64_t __offset) __asm__ ("" "pwrite64")


    __attribute__ ((__access__ (__read_only__, 2, 3)));
# 411 "/usr/include/unistd.h" 3 4
extern ssize_t pread64 (int __fd, void *__buf, size_t __nbytes,
   __off64_t __offset)
    __attribute__ ((__access__ (__write_only__, 2, 3)));


extern ssize_t pwrite64 (int __fd, const void *__buf, size_t __n,
    __off64_t __offset)
    __attribute__ ((__access__ (__read_only__, 2, 3)));







extern int pipe (int __pipedes[2]) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int pipe2 (int __pipedes[2], int __flags) __attribute__ ((__nothrow__ , __leaf__)) ;
# 441 "/usr/include/unistd.h" 3 4
extern unsigned int alarm (unsigned int __seconds) __attribute__ ((__nothrow__ , __leaf__));
# 453 "/usr/include/unistd.h" 3 4
extern unsigned int sleep (unsigned int __seconds);







extern __useconds_t ualarm (__useconds_t __value, __useconds_t __interval)
     __attribute__ ((__nothrow__ , __leaf__));






extern int usleep (__useconds_t __useconds);
# 478 "/usr/include/unistd.h" 3 4
extern int pause (void);



extern int chown (const char *__file, __uid_t __owner, __gid_t __group)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern int fchown (int __fd, __uid_t __owner, __gid_t __group) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int lchown (const char *__file, __uid_t __owner, __gid_t __group)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;






extern int fchownat (int __fd, const char *__file, __uid_t __owner,
       __gid_t __group, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;



extern int chdir (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern int fchdir (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;
# 520 "/usr/include/unistd.h" 3 4
extern char *getcwd (char *__buf, size_t __size) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 1, 2)));





extern char *get_current_dir_name (void) __attribute__ ((__nothrow__ , __leaf__));







extern char *getwd (char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__deprecated__))
    __attribute__ ((__access__ (__write_only__, 1)));




extern int dup (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;


extern int dup2 (int __fd, int __fd2) __attribute__ ((__nothrow__ , __leaf__));




extern int dup3 (int __fd, int __fd2, int __flags) __attribute__ ((__nothrow__ , __leaf__));



extern char **__environ;

extern char **environ;





extern int execve (const char *__path, char *const __argv[],
     char *const __envp[]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int fexecve (int __fd, char *const __argv[], char *const __envp[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));




extern int execv (const char *__path, char *const __argv[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execle (const char *__path, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execl (const char *__path, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execvp (const char *__file, char *const __argv[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int execlp (const char *__file, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int execvpe (const char *__file, char *const __argv[],
      char *const __envp[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern int nice (int __inc) __attribute__ ((__nothrow__ , __leaf__)) ;




extern void _exit (int __status) __attribute__ ((__noreturn__));





# 1 "/usr/include/bits/confname.h" 1 3 4
# 24 "/usr/include/bits/confname.h" 3 4
enum
  {
    _PC_LINK_MAX,

    _PC_MAX_CANON,

    _PC_MAX_INPUT,

    _PC_NAME_MAX,

    _PC_PATH_MAX,

    _PC_PIPE_BUF,

    _PC_CHOWN_RESTRICTED,

    _PC_NO_TRUNC,

    _PC_VDISABLE,

    _PC_SYNC_IO,

    _PC_ASYNC_IO,

    _PC_PRIO_IO,

    _PC_SOCK_MAXBUF,

    _PC_FILESIZEBITS,

    _PC_REC_INCR_XFER_SIZE,

    _PC_REC_MAX_XFER_SIZE,

    _PC_REC_MIN_XFER_SIZE,

    _PC_REC_XFER_ALIGN,

    _PC_ALLOC_SIZE_MIN,

    _PC_SYMLINK_MAX,

    _PC_2_SYMLINKS

  };


enum
  {
    _SC_ARG_MAX,

    _SC_CHILD_MAX,

    _SC_CLK_TCK,

    _SC_NGROUPS_MAX,

    _SC_OPEN_MAX,

    _SC_STREAM_MAX,

    _SC_TZNAME_MAX,

    _SC_JOB_CONTROL,

    _SC_SAVED_IDS,

    _SC_REALTIME_SIGNALS,

    _SC_PRIORITY_SCHEDULING,

    _SC_TIMERS,

    _SC_ASYNCHRONOUS_IO,

    _SC_PRIORITIZED_IO,

    _SC_SYNCHRONIZED_IO,

    _SC_FSYNC,

    _SC_MAPPED_FILES,

    _SC_MEMLOCK,

    _SC_MEMLOCK_RANGE,

    _SC_MEMORY_PROTECTION,

    _SC_MESSAGE_PASSING,

    _SC_SEMAPHORES,

    _SC_SHARED_MEMORY_OBJECTS,

    _SC_AIO_LISTIO_MAX,

    _SC_AIO_MAX,

    _SC_AIO_PRIO_DELTA_MAX,

    _SC_DELAYTIMER_MAX,

    _SC_MQ_OPEN_MAX,

    _SC_MQ_PRIO_MAX,

    _SC_VERSION,

    _SC_PAGESIZE,


    _SC_RTSIG_MAX,

    _SC_SEM_NSEMS_MAX,

    _SC_SEM_VALUE_MAX,

    _SC_SIGQUEUE_MAX,

    _SC_TIMER_MAX,




    _SC_BC_BASE_MAX,

    _SC_BC_DIM_MAX,

    _SC_BC_SCALE_MAX,

    _SC_BC_STRING_MAX,

    _SC_COLL_WEIGHTS_MAX,

    _SC_EQUIV_CLASS_MAX,

    _SC_EXPR_NEST_MAX,

    _SC_LINE_MAX,

    _SC_RE_DUP_MAX,

    _SC_CHARCLASS_NAME_MAX,


    _SC_2_VERSION,

    _SC_2_C_BIND,

    _SC_2_C_DEV,

    _SC_2_FORT_DEV,

    _SC_2_FORT_RUN,

    _SC_2_SW_DEV,

    _SC_2_LOCALEDEF,


    _SC_PII,

    _SC_PII_XTI,

    _SC_PII_SOCKET,

    _SC_PII_INTERNET,

    _SC_PII_OSI,

    _SC_POLL,

    _SC_SELECT,

    _SC_UIO_MAXIOV,

    _SC_IOV_MAX = _SC_UIO_MAXIOV,

    _SC_PII_INTERNET_STREAM,

    _SC_PII_INTERNET_DGRAM,

    _SC_PII_OSI_COTS,

    _SC_PII_OSI_CLTS,

    _SC_PII_OSI_M,

    _SC_T_IOV_MAX,



    _SC_THREADS,

    _SC_THREAD_SAFE_FUNCTIONS,

    _SC_GETGR_R_SIZE_MAX,

    _SC_GETPW_R_SIZE_MAX,

    _SC_LOGIN_NAME_MAX,

    _SC_TTY_NAME_MAX,

    _SC_THREAD_DESTRUCTOR_ITERATIONS,

    _SC_THREAD_KEYS_MAX,

    _SC_THREAD_STACK_MIN,

    _SC_THREAD_THREADS_MAX,

    _SC_THREAD_ATTR_STACKADDR,

    _SC_THREAD_ATTR_STACKSIZE,

    _SC_THREAD_PRIORITY_SCHEDULING,

    _SC_THREAD_PRIO_INHERIT,

    _SC_THREAD_PRIO_PROTECT,

    _SC_THREAD_PROCESS_SHARED,


    _SC_NPROCESSORS_CONF,

    _SC_NPROCESSORS_ONLN,

    _SC_PHYS_PAGES,

    _SC_AVPHYS_PAGES,

    _SC_ATEXIT_MAX,

    _SC_PASS_MAX,


    _SC_XOPEN_VERSION,

    _SC_XOPEN_XCU_VERSION,

    _SC_XOPEN_UNIX,

    _SC_XOPEN_CRYPT,

    _SC_XOPEN_ENH_I18N,

    _SC_XOPEN_SHM,


    _SC_2_CHAR_TERM,

    _SC_2_C_VERSION,

    _SC_2_UPE,


    _SC_XOPEN_XPG2,

    _SC_XOPEN_XPG3,

    _SC_XOPEN_XPG4,


    _SC_CHAR_BIT,

    _SC_CHAR_MAX,

    _SC_CHAR_MIN,

    _SC_INT_MAX,

    _SC_INT_MIN,

    _SC_LONG_BIT,

    _SC_WORD_BIT,

    _SC_MB_LEN_MAX,

    _SC_NZERO,

    _SC_SSIZE_MAX,

    _SC_SCHAR_MAX,

    _SC_SCHAR_MIN,

    _SC_SHRT_MAX,

    _SC_SHRT_MIN,

    _SC_UCHAR_MAX,

    _SC_UINT_MAX,

    _SC_ULONG_MAX,

    _SC_USHRT_MAX,


    _SC_NL_ARGMAX,

    _SC_NL_LANGMAX,

    _SC_NL_MSGMAX,

    _SC_NL_NMAX,

    _SC_NL_SETMAX,

    _SC_NL_TEXTMAX,


    _SC_XBS5_ILP32_OFF32,

    _SC_XBS5_ILP32_OFFBIG,

    _SC_XBS5_LP64_OFF64,

    _SC_XBS5_LPBIG_OFFBIG,


    _SC_XOPEN_LEGACY,

    _SC_XOPEN_REALTIME,

    _SC_XOPEN_REALTIME_THREADS,


    _SC_ADVISORY_INFO,

    _SC_BARRIERS,

    _SC_BASE,

    _SC_C_LANG_SUPPORT,

    _SC_C_LANG_SUPPORT_R,

    _SC_CLOCK_SELECTION,

    _SC_CPUTIME,

    _SC_THREAD_CPUTIME,

    _SC_DEVICE_IO,

    _SC_DEVICE_SPECIFIC,

    _SC_DEVICE_SPECIFIC_R,

    _SC_FD_MGMT,

    _SC_FIFO,

    _SC_PIPE,

    _SC_FILE_ATTRIBUTES,

    _SC_FILE_LOCKING,

    _SC_FILE_SYSTEM,

    _SC_MONOTONIC_CLOCK,

    _SC_MULTI_PROCESS,

    _SC_SINGLE_PROCESS,

    _SC_NETWORKING,

    _SC_READER_WRITER_LOCKS,

    _SC_SPIN_LOCKS,

    _SC_REGEXP,

    _SC_REGEX_VERSION,

    _SC_SHELL,

    _SC_SIGNALS,

    _SC_SPAWN,

    _SC_SPORADIC_SERVER,

    _SC_THREAD_SPORADIC_SERVER,

    _SC_SYSTEM_DATABASE,

    _SC_SYSTEM_DATABASE_R,

    _SC_TIMEOUTS,

    _SC_TYPED_MEMORY_OBJECTS,

    _SC_USER_GROUPS,

    _SC_USER_GROUPS_R,

    _SC_2_PBS,

    _SC_2_PBS_ACCOUNTING,

    _SC_2_PBS_LOCATE,

    _SC_2_PBS_MESSAGE,

    _SC_2_PBS_TRACK,

    _SC_SYMLOOP_MAX,

    _SC_STREAMS,

    _SC_2_PBS_CHECKPOINT,


    _SC_V6_ILP32_OFF32,

    _SC_V6_ILP32_OFFBIG,

    _SC_V6_LP64_OFF64,

    _SC_V6_LPBIG_OFFBIG,


    _SC_HOST_NAME_MAX,

    _SC_TRACE,

    _SC_TRACE_EVENT_FILTER,

    _SC_TRACE_INHERIT,

    _SC_TRACE_LOG,


    _SC_LEVEL1_ICACHE_SIZE,

    _SC_LEVEL1_ICACHE_ASSOC,

    _SC_LEVEL1_ICACHE_LINESIZE,

    _SC_LEVEL1_DCACHE_SIZE,

    _SC_LEVEL1_DCACHE_ASSOC,

    _SC_LEVEL1_DCACHE_LINESIZE,

    _SC_LEVEL2_CACHE_SIZE,

    _SC_LEVEL2_CACHE_ASSOC,

    _SC_LEVEL2_CACHE_LINESIZE,

    _SC_LEVEL3_CACHE_SIZE,

    _SC_LEVEL3_CACHE_ASSOC,

    _SC_LEVEL3_CACHE_LINESIZE,

    _SC_LEVEL4_CACHE_SIZE,

    _SC_LEVEL4_CACHE_ASSOC,

    _SC_LEVEL4_CACHE_LINESIZE,



    _SC_IPV6 = _SC_LEVEL1_ICACHE_SIZE + 50,

    _SC_RAW_SOCKETS,


    _SC_V7_ILP32_OFF32,

    _SC_V7_ILP32_OFFBIG,

    _SC_V7_LP64_OFF64,

    _SC_V7_LPBIG_OFFBIG,


    _SC_SS_REPL_MAX,


    _SC_TRACE_EVENT_NAME_MAX,

    _SC_TRACE_NAME_MAX,

    _SC_TRACE_SYS_MAX,

    _SC_TRACE_USER_EVENT_MAX,


    _SC_XOPEN_STREAMS,


    _SC_THREAD_ROBUST_PRIO_INHERIT,

    _SC_THREAD_ROBUST_PRIO_PROTECT

  };


enum
  {
    _CS_PATH,


    _CS_V6_WIDTH_RESTRICTED_ENVS,



    _CS_GNU_LIBC_VERSION,

    _CS_GNU_LIBPTHREAD_VERSION,


    _CS_V5_WIDTH_RESTRICTED_ENVS,



    _CS_V7_WIDTH_RESTRICTED_ENVS,



    _CS_LFS_CFLAGS = 1000,

    _CS_LFS_LDFLAGS,

    _CS_LFS_LIBS,

    _CS_LFS_LINTFLAGS,

    _CS_LFS64_CFLAGS,

    _CS_LFS64_LDFLAGS,

    _CS_LFS64_LIBS,

    _CS_LFS64_LINTFLAGS,


    _CS_XBS5_ILP32_OFF32_CFLAGS = 1100,

    _CS_XBS5_ILP32_OFF32_LDFLAGS,

    _CS_XBS5_ILP32_OFF32_LIBS,

    _CS_XBS5_ILP32_OFF32_LINTFLAGS,

    _CS_XBS5_ILP32_OFFBIG_CFLAGS,

    _CS_XBS5_ILP32_OFFBIG_LDFLAGS,

    _CS_XBS5_ILP32_OFFBIG_LIBS,

    _CS_XBS5_ILP32_OFFBIG_LINTFLAGS,

    _CS_XBS5_LP64_OFF64_CFLAGS,

    _CS_XBS5_LP64_OFF64_LDFLAGS,

    _CS_XBS5_LP64_OFF64_LIBS,

    _CS_XBS5_LP64_OFF64_LINTFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_CFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_LDFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_LIBS,

    _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS,


    _CS_POSIX_V6_ILP32_OFF32_CFLAGS,

    _CS_POSIX_V6_ILP32_OFF32_LDFLAGS,

    _CS_POSIX_V6_ILP32_OFF32_LIBS,

    _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_LIBS,

    _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS,

    _CS_POSIX_V6_LP64_OFF64_CFLAGS,

    _CS_POSIX_V6_LP64_OFF64_LDFLAGS,

    _CS_POSIX_V6_LP64_OFF64_LIBS,

    _CS_POSIX_V6_LP64_OFF64_LINTFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LIBS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS,


    _CS_POSIX_V7_ILP32_OFF32_CFLAGS,

    _CS_POSIX_V7_ILP32_OFF32_LDFLAGS,

    _CS_POSIX_V7_ILP32_OFF32_LIBS,

    _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_LIBS,

    _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS,

    _CS_POSIX_V7_LP64_OFF64_CFLAGS,

    _CS_POSIX_V7_LP64_OFF64_LDFLAGS,

    _CS_POSIX_V7_LP64_OFF64_LIBS,

    _CS_POSIX_V7_LP64_OFF64_LINTFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LIBS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS,


    _CS_V6_ENV,

    _CS_V7_ENV

  };
# 621 "/usr/include/unistd.h" 2 3 4


extern long int pathconf (const char *__path, int __name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int fpathconf (int __fd, int __name) __attribute__ ((__nothrow__ , __leaf__));


extern long int sysconf (int __name) __attribute__ ((__nothrow__ , __leaf__));



extern size_t confstr (int __name, char *__buf, size_t __len) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 2, 3)));




extern __pid_t getpid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t getppid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t getpgrp (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t __getpgid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));

extern __pid_t getpgid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));






extern int setpgid (__pid_t __pid, __pid_t __pgid) __attribute__ ((__nothrow__ , __leaf__));
# 672 "/usr/include/unistd.h" 3 4
extern int setpgrp (void) __attribute__ ((__nothrow__ , __leaf__));






extern __pid_t setsid (void) __attribute__ ((__nothrow__ , __leaf__));



extern __pid_t getsid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));



extern __uid_t getuid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __uid_t geteuid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __gid_t getgid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __gid_t getegid (void) __attribute__ ((__nothrow__ , __leaf__));




extern int getgroups (int __size, __gid_t __list[]) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 2, 1)));


extern int group_member (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__));






extern int setuid (__uid_t __uid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setreuid (__uid_t __ruid, __uid_t __euid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int seteuid (__uid_t __uid) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int setgid (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setregid (__gid_t __rgid, __gid_t __egid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setegid (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__)) ;





extern int getresuid (__uid_t *__ruid, __uid_t *__euid, __uid_t *__suid)
     __attribute__ ((__nothrow__ , __leaf__));



extern int getresgid (__gid_t *__rgid, __gid_t *__egid, __gid_t *__sgid)
     __attribute__ ((__nothrow__ , __leaf__));



extern int setresuid (__uid_t __ruid, __uid_t __euid, __uid_t __suid)
     __attribute__ ((__nothrow__ , __leaf__)) ;



extern int setresgid (__gid_t __rgid, __gid_t __egid, __gid_t __sgid)
     __attribute__ ((__nothrow__ , __leaf__)) ;






extern __pid_t fork (void) __attribute__ ((__nothrow__));







extern __pid_t vfork (void) __attribute__ ((__nothrow__ , __leaf__));





extern char *ttyname (int __fd) __attribute__ ((__nothrow__ , __leaf__));



extern int ttyname_r (int __fd, char *__buf, size_t __buflen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 2, 3)));



extern int isatty (int __fd) __attribute__ ((__nothrow__ , __leaf__));




extern int ttyslot (void) __attribute__ ((__nothrow__ , __leaf__));




extern int link (const char *__from, const char *__to)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) ;




extern int linkat (int __fromfd, const char *__from, int __tofd,
     const char *__to, int __flags)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4))) ;




extern int symlink (const char *__from, const char *__to)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) ;




extern ssize_t readlink (const char *__restrict __path,
    char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) __attribute__ ((__access__ (__write_only__, 2, 3)));





extern int symlinkat (const char *__from, int __tofd,
        const char *__to) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3))) ;


extern ssize_t readlinkat (int __fd, const char *__restrict __path,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3))) __attribute__ ((__access__ (__read_only__, 3, 4)));



extern int unlink (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int unlinkat (int __fd, const char *__name, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



extern int rmdir (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern __pid_t tcgetpgrp (int __fd) __attribute__ ((__nothrow__ , __leaf__));


extern int tcsetpgrp (int __fd, __pid_t __pgrp_id) __attribute__ ((__nothrow__ , __leaf__));






extern char *getlogin (void);







extern int getlogin_r (char *__name, size_t __name_len) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));




extern int setlogin (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







# 1 "/usr/include/bits/getopt_posix.h" 1 3 4
# 27 "/usr/include/bits/getopt_posix.h" 3 4
# 1 "/usr/include/bits/getopt_core.h" 1 3 4
# 28 "/usr/include/bits/getopt_core.h" 3 4








extern char *optarg;
# 50 "/usr/include/bits/getopt_core.h" 3 4
extern int optind;




extern int opterr;



extern int optopt;
# 91 "/usr/include/bits/getopt_core.h" 3 4
extern int getopt (int ___argc, char *const *___argv, const char *__shortopts)
       __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));


# 28 "/usr/include/bits/getopt_posix.h" 2 3 4


# 49 "/usr/include/bits/getopt_posix.h" 3 4

# 884 "/usr/include/unistd.h" 2 3 4







extern int gethostname (char *__name, size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));






extern int sethostname (const char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__read_only__, 1, 2)));



extern int sethostid (long int __id) __attribute__ ((__nothrow__ , __leaf__)) ;





extern int getdomainname (char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__write_only__, 1, 2)));
extern int setdomainname (const char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__read_only__, 1, 2)));




extern int vhangup (void) __attribute__ ((__nothrow__ , __leaf__));


extern int revoke (const char *__file) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;







extern int profil (unsigned short int *__sample_buffer, size_t __size,
     size_t __offset, unsigned int __scale)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int acct (const char *__name) __attribute__ ((__nothrow__ , __leaf__));



extern char *getusershell (void) __attribute__ ((__nothrow__ , __leaf__));
extern void endusershell (void) __attribute__ ((__nothrow__ , __leaf__));
extern void setusershell (void) __attribute__ ((__nothrow__ , __leaf__));





extern int daemon (int __nochdir, int __noclose) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int chroot (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern char *getpass (const char *__prompt) __attribute__ ((__nonnull__ (1)));







extern int fsync (int __fd);





extern int syncfs (int __fd) __attribute__ ((__nothrow__ , __leaf__));






extern long int gethostid (void);


extern void sync (void) __attribute__ ((__nothrow__ , __leaf__));





extern int getpagesize (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));




extern int getdtablesize (void) __attribute__ ((__nothrow__ , __leaf__));
# 1009 "/usr/include/unistd.h" 3 4
extern int truncate (const char *__file, __off64_t __length) __asm__ ("" "truncate64") __attribute__ ((__nothrow__ , __leaf__))

                  __attribute__ ((__nonnull__ (1))) ;





extern int truncate64 (const char *__file, __off64_t __length)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 1031 "/usr/include/unistd.h" 3 4
extern int ftruncate (int __fd, __off64_t __length) __asm__ ("" "ftruncate64") __attribute__ ((__nothrow__ , __leaf__))
                        ;





extern int ftruncate64 (int __fd, __off64_t __length) __attribute__ ((__nothrow__ , __leaf__)) ;
# 1049 "/usr/include/unistd.h" 3 4
extern int brk (void *__addr) __attribute__ ((__nothrow__ , __leaf__)) ;





extern void *sbrk (intptr_t __delta) __attribute__ ((__nothrow__ , __leaf__));
# 1070 "/usr/include/unistd.h" 3 4
extern long int syscall (long int __sysno, ...) __attribute__ ((__nothrow__ , __leaf__));
# 1096 "/usr/include/unistd.h" 3 4
extern int lockf (int __fd, int __cmd, __off64_t __len) __asm__ ("" "lockf64")
                       ;





extern int lockf64 (int __fd, int __cmd, __off64_t __len) ;
# 1121 "/usr/include/unistd.h" 3 4
ssize_t copy_file_range (int __infd, __off64_t *__pinoff,
    int __outfd, __off64_t *__poutoff,
    size_t __length, unsigned int __flags);





extern int fdatasync (int __fildes);
# 1138 "/usr/include/unistd.h" 3 4
extern char *crypt (const char *__key, const char *__salt)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));







extern void swab (const void *__restrict __from, void *__restrict __to,
    ssize_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)))
    __attribute__ ((__access__ (__read_only__, 1, 3)))
    __attribute__ ((__access__ (__write_only__, 2, 3)));
# 1177 "/usr/include/unistd.h" 3 4
int getentropy (void *__buffer, size_t __length)
    __attribute__ ((__access__ (__write_only__, 1, 2)));
# 1187 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/unistd_ext.h" 1 3 4
# 34 "/usr/include/bits/unistd_ext.h" 3 4
extern __pid_t gettid (void) __attribute__ ((__nothrow__ , __leaf__));
# 1188 "/usr/include/unistd.h" 2 3 4


# 27 "./include/grub/util/misc.h" 2

# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 29 "./include/grub/util/misc.h" 2


# 1 "./include/grub/emu/misc.h" 1
# 22 "./include/grub/emu/misc.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/emu/misc.h" 2
# 31 "./include/grub/emu/misc.h"
# 1 "./include/grub/util/misc.h" 1
# 32 "./include/grub/emu/misc.h" 2


# 33 "./include/grub/emu/misc.h"
extern int verbosity;
extern const char *program_name;

void grub_init_all (void);
void grub_fini_all (void);

void grub_find_zpool_from_dir (const char *dir,
          char **poolname, char **poolfs);

char *grub_make_system_path_relative_to_its_root (const char *path)
 __attribute__ ((warn_unused_result));
int
grub_util_device_is_mapped (const char *dev);




void * xcalloc (grub_size_t nmemb, grub_size_t size) __attribute__ ((warn_unused_result));
void * xmalloc (grub_size_t size) __attribute__ ((warn_unused_result));
void * xrealloc (void *ptr, grub_size_t size) __attribute__ ((warn_unused_result));
char * xstrdup (const char *str) __attribute__ ((warn_unused_result));
char * xasprintf (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2))) __attribute__ ((warn_unused_result));

void grub_util_warn (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));
void grub_util_info (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));
void grub_util_error (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2), noreturn));

grub_uint64_t grub_util_get_cpu_time_ms (void);


int grub_device_mapper_supported (void);





FILE *
grub_util_fopen (const char *path, const char *mode);


int grub_util_file_sync (FILE *f);
# 32 "./include/grub/util/misc.h" 2

char *grub_util_get_path (const char *dir, const char *file);
size_t grub_util_get_image_size (const char *path);
char *grub_util_read_image (const char *path);
void grub_util_load_image (const char *path, char *buf);
void grub_util_write_image (const char *img, size_t size, FILE *out,
       const char *name);
void grub_util_write_image_at (const void *img, size_t size, off_t offset,
          FILE *out, const char *name);

char *make_system_path_relative_to_its_root (const char *path);

char *grub_canonicalize_file_name (const char *path);

void grub_util_init_nls (void);

void grub_util_host_init (int *argc, char ***argv);

int grub_qsort_strcmp (const void *, const void *);
# 29 "grub-core/kern/emu/hostfs.c" 2
# 1 "./include/grub/emu/hostdisk.h" 1
# 26 "./include/grub/emu/hostdisk.h"
# 1 "./include/grub/emu/hostfile.h" 1
# 25 "./include/grub/emu/hostfile.h"
# 1 "./include/grub/osdep/hostfile.h" 1





# 1 "./include/grub/osdep/hostfile_unix.h" 1
# 22 "./include/grub/osdep/hostfile_unix.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/osdep/hostfile_unix.h" 2






# 1 "/usr/include/sys/stat.h" 1 3 4
# 99 "/usr/include/sys/stat.h" 3 4


# 1 "/usr/include/bits/stat.h" 1 3 4
# 46 "/usr/include/bits/stat.h" 3 4

# 46 "/usr/include/bits/stat.h" 3 4
struct stat
  {
    __dev_t st_dev;




    __ino_t st_ino;







    __nlink_t st_nlink;
    __mode_t st_mode;

    __uid_t st_uid;
    __gid_t st_gid;

    int __pad0;

    __dev_t st_rdev;




    __off_t st_size;



    __blksize_t st_blksize;

    __blkcnt_t st_blocks;
# 91 "/usr/include/bits/stat.h" 3 4
    struct timespec st_atim;
    struct timespec st_mtim;
    struct timespec st_ctim;
# 106 "/usr/include/bits/stat.h" 3 4
    __syscall_slong_t __glibc_reserved[3];
# 115 "/usr/include/bits/stat.h" 3 4
  };



struct stat64
  {
    __dev_t st_dev;

    __ino64_t st_ino;
    __nlink_t st_nlink;
    __mode_t st_mode;






    __uid_t st_uid;
    __gid_t st_gid;

    int __pad0;
    __dev_t st_rdev;
    __off_t st_size;





    __blksize_t st_blksize;
    __blkcnt64_t st_blocks;







    struct timespec st_atim;
    struct timespec st_mtim;
    struct timespec st_ctim;
# 164 "/usr/include/bits/stat.h" 3 4
    __syscall_slong_t __glibc_reserved[3];



  };
# 102 "/usr/include/sys/stat.h" 2 3 4
# 213 "/usr/include/sys/stat.h" 3 4
extern int stat (const char *__restrict __file, struct stat *__restrict __buf) __asm__ ("" "stat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (1, 2)));
extern int fstat (int __fd, struct stat *__buf) __asm__ ("" "fstat64") __attribute__ ((__nothrow__ , __leaf__))
     __attribute__ ((__nonnull__ (2)));






extern int stat64 (const char *__restrict __file,
     struct stat64 *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int fstat64 (int __fd, struct stat64 *__buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));
# 239 "/usr/include/sys/stat.h" 3 4
extern int fstatat (int __fd, const char *__restrict __file, struct stat *__restrict __buf, int __flag) __asm__ ("" "fstatat64") __attribute__ ((__nothrow__ , __leaf__))


                 __attribute__ ((__nonnull__ (2, 3)));






extern int fstatat64 (int __fd, const char *__restrict __file,
        struct stat64 *__restrict __buf, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
# 263 "/usr/include/sys/stat.h" 3 4
extern int lstat (const char *__restrict __file, struct stat *__restrict __buf) __asm__ ("" "lstat64") __attribute__ ((__nothrow__ , __leaf__))


     __attribute__ ((__nonnull__ (1, 2)));





extern int lstat64 (const char *__restrict __file,
      struct stat64 *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern int chmod (const char *__file, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int lchmod (const char *__file, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int fchmod (int __fd, __mode_t __mode) __attribute__ ((__nothrow__ , __leaf__));





extern int fchmodat (int __fd, const char *__file, __mode_t __mode,
       int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;






extern __mode_t umask (__mode_t __mask) __attribute__ ((__nothrow__ , __leaf__));




extern __mode_t getumask (void) __attribute__ ((__nothrow__ , __leaf__));



extern int mkdir (const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mkdirat (int __fd, const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));






extern int mknod (const char *__path, __mode_t __mode, __dev_t __dev)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mknodat (int __fd, const char *__path, __mode_t __mode,
      __dev_t __dev) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));





extern int mkfifo (const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mkfifoat (int __fd, const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));





extern int utimensat (int __fd, const char *__path,
        const struct timespec __times[2],
        int __flags)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));




extern int futimens (int __fd, const struct timespec __times[2]) __attribute__ ((__nothrow__ , __leaf__));
# 406 "/usr/include/sys/stat.h" 3 4
extern int __fxstat (int __ver, int __fildes, struct stat *__stat_buf) __asm__ ("" "__fxstat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (3)));
extern int __xstat (int __ver, const char *__filename, struct stat *__stat_buf) __asm__ ("" "__xstat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (2, 3)));
extern int __lxstat (int __ver, const char *__filename, struct stat *__stat_buf) __asm__ ("" "__lxstat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (2, 3)));
extern int __fxstatat (int __ver, int __fildes, const char *__filename, struct stat *__stat_buf, int __flag) __asm__ ("" "__fxstatat64") __attribute__ ((__nothrow__ , __leaf__))


                    __attribute__ ((__nonnull__ (3, 4)));
# 428 "/usr/include/sys/stat.h" 3 4
extern int __fxstat64 (int __ver, int __fildes, struct stat64 *__stat_buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));
extern int __xstat64 (int __ver, const char *__filename,
        struct stat64 *__stat_buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
extern int __lxstat64 (int __ver, const char *__filename,
         struct stat64 *__stat_buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
extern int __fxstatat64 (int __ver, int __fildes, const char *__filename,
    struct stat64 *__stat_buf, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4)));

extern int __xmknod (int __ver, const char *__path, __mode_t __mode,
       __dev_t *__dev) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));

extern int __xmknodat (int __ver, int __fd, const char *__path,
         __mode_t __mode, __dev_t *__dev)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 5)));


# 1 "/usr/include/bits/statx.h" 1 3 4
# 31 "/usr/include/bits/statx.h" 3 4
# 1 "/usr/include/linux/stat.h" 1 3 4




# 1 "/usr/include/linux/types.h" 1 3 4




# 1 "/usr/include/asm/types.h" 1 3 4
# 1 "/usr/include/asm-generic/types.h" 1 3 4






# 1 "/usr/include/asm-generic/int-ll64.h" 1 3 4
# 12 "/usr/include/asm-generic/int-ll64.h" 3 4
# 1 "/usr/include/asm/bitsperlong.h" 1 3 4
# 11 "/usr/include/asm/bitsperlong.h" 3 4
# 1 "/usr/include/asm-generic/bitsperlong.h" 1 3 4
# 12 "/usr/include/asm/bitsperlong.h" 2 3 4
# 13 "/usr/include/asm-generic/int-ll64.h" 2 3 4







typedef __signed__ char __s8;
typedef unsigned char __u8;

typedef __signed__ short __s16;
typedef unsigned short __u16;

typedef __signed__ int __s32;
typedef unsigned int __u32;


__extension__ typedef __signed__ long long __s64;
__extension__ typedef unsigned long long __u64;
# 8 "/usr/include/asm-generic/types.h" 2 3 4
# 2 "/usr/include/asm/types.h" 2 3 4
# 6 "/usr/include/linux/types.h" 2 3 4



# 1 "/usr/include/linux/posix_types.h" 1 3 4




# 1 "/usr/include/linux/stddef.h" 1 3 4
# 6 "/usr/include/linux/posix_types.h" 2 3 4
# 25 "/usr/include/linux/posix_types.h" 3 4
typedef struct {
 unsigned long fds_bits[1024 / (8 * sizeof(long))];
} __kernel_fd_set;


typedef void (*__kernel_sighandler_t)(int);


typedef int __kernel_key_t;
typedef int __kernel_mqd_t;

# 1 "/usr/include/asm/posix_types.h" 1 3 4






# 1 "/usr/include/asm/posix_types_64.h" 1 3 4
# 11 "/usr/include/asm/posix_types_64.h" 3 4
typedef unsigned short __kernel_old_uid_t;
typedef unsigned short __kernel_old_gid_t;


typedef unsigned long __kernel_old_dev_t;


# 1 "/usr/include/asm-generic/posix_types.h" 1 3 4
# 15 "/usr/include/asm-generic/posix_types.h" 3 4
typedef long __kernel_long_t;
typedef unsigned long __kernel_ulong_t;



typedef __kernel_ulong_t __kernel_ino_t;



typedef unsigned int __kernel_mode_t;



typedef int __kernel_pid_t;



typedef int __kernel_ipc_pid_t;



typedef unsigned int __kernel_uid_t;
typedef unsigned int __kernel_gid_t;



typedef __kernel_long_t __kernel_suseconds_t;



typedef int __kernel_daddr_t;



typedef unsigned int __kernel_uid32_t;
typedef unsigned int __kernel_gid32_t;
# 72 "/usr/include/asm-generic/posix_types.h" 3 4
typedef __kernel_ulong_t __kernel_size_t;
typedef __kernel_long_t __kernel_ssize_t;
typedef __kernel_long_t __kernel_ptrdiff_t;




typedef struct {
 int val[2];
} __kernel_fsid_t;





typedef __kernel_long_t __kernel_off_t;
typedef long long __kernel_loff_t;
typedef __kernel_long_t __kernel_old_time_t;
typedef __kernel_long_t __kernel_time_t;
typedef long long __kernel_time64_t;
typedef __kernel_long_t __kernel_clock_t;
typedef int __kernel_timer_t;
typedef int __kernel_clockid_t;
typedef char * __kernel_caddr_t;
typedef unsigned short __kernel_uid16_t;
typedef unsigned short __kernel_gid16_t;
# 19 "/usr/include/asm/posix_types_64.h" 2 3 4
# 8 "/usr/include/asm/posix_types.h" 2 3 4
# 37 "/usr/include/linux/posix_types.h" 2 3 4
# 10 "/usr/include/linux/types.h" 2 3 4
# 24 "/usr/include/linux/types.h" 3 4
typedef __u16 __le16;
typedef __u16 __be16;
typedef __u32 __le32;
typedef __u32 __be32;
typedef __u64 __le64;
typedef __u64 __be64;

typedef __u16 __sum16;
typedef __u32 __wsum;
# 47 "/usr/include/linux/types.h" 3 4
typedef unsigned __poll_t;
# 6 "/usr/include/linux/stat.h" 2 3 4
# 56 "/usr/include/linux/stat.h" 3 4
struct statx_timestamp {
 __s64 tv_sec;
 __u32 tv_nsec;
 __s32 __reserved;
};
# 99 "/usr/include/linux/stat.h" 3 4
struct statx {

 __u32 stx_mask;
 __u32 stx_blksize;
 __u64 stx_attributes;

 __u32 stx_nlink;
 __u32 stx_uid;
 __u32 stx_gid;
 __u16 stx_mode;
 __u16 __spare0[1];

 __u64 stx_ino;
 __u64 stx_size;
 __u64 stx_blocks;
 __u64 stx_attributes_mask;

 struct statx_timestamp stx_atime;
 struct statx_timestamp stx_btime;
 struct statx_timestamp stx_ctime;
 struct statx_timestamp stx_mtime;

 __u32 stx_rdev_major;
 __u32 stx_rdev_minor;
 __u32 stx_dev_major;
 __u32 stx_dev_minor;

 __u64 stx_mnt_id;
 __u64 __spare2;

 __u64 __spare3[12];

};
# 32 "/usr/include/bits/statx.h" 2 3 4







# 1 "/usr/include/bits/statx-generic.h" 1 3 4
# 25 "/usr/include/bits/statx-generic.h" 3 4
# 1 "/usr/include/bits/types/struct_statx_timestamp.h" 1 3 4
# 26 "/usr/include/bits/statx-generic.h" 2 3 4
# 1 "/usr/include/bits/types/struct_statx.h" 1 3 4
# 27 "/usr/include/bits/statx-generic.h" 2 3 4
# 54 "/usr/include/bits/statx-generic.h" 3 4



int statx (int __dirfd, const char *__restrict __path, int __flags,
           unsigned int __mask, struct statx *__restrict __buf)
  __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 5)));


# 40 "/usr/include/bits/statx.h" 2 3 4
# 447 "/usr/include/sys/stat.h" 2 3 4
# 534 "/usr/include/sys/stat.h" 3 4

# 30 "./include/grub/osdep/hostfile_unix.h" 2
# 1 "/usr/include/fcntl.h" 1 3 4
# 28 "/usr/include/fcntl.h" 3 4







# 1 "/usr/include/bits/fcntl.h" 1 3 4
# 35 "/usr/include/bits/fcntl.h" 3 4
struct flock
  {
    short int l_type;
    short int l_whence;




    __off64_t l_start;
    __off64_t l_len;

    __pid_t l_pid;
  };


struct flock64
  {
    short int l_type;
    short int l_whence;
    __off64_t l_start;
    __off64_t l_len;
    __pid_t l_pid;
  };



# 1 "/usr/include/bits/fcntl-linux.h" 1 3 4
# 38 "/usr/include/bits/fcntl-linux.h" 3 4
# 1 "/usr/include/bits/types/struct_iovec.h" 1 3 4
# 23 "/usr/include/bits/types/struct_iovec.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 24 "/usr/include/bits/types/struct_iovec.h" 2 3 4


struct iovec
  {
    void *iov_base;
    size_t iov_len;
  };
# 39 "/usr/include/bits/fcntl-linux.h" 2 3 4
# 265 "/usr/include/bits/fcntl-linux.h" 3 4
enum __pid_type
  {
    F_OWNER_TID = 0,
    F_OWNER_PID,
    F_OWNER_PGRP,
    F_OWNER_GID = F_OWNER_PGRP
  };


struct f_owner_ex
  {
    enum __pid_type type;
    __pid_t pid;
  };
# 354 "/usr/include/bits/fcntl-linux.h" 3 4
# 1 "/usr/include/linux/falloc.h" 1 3 4
# 355 "/usr/include/bits/fcntl-linux.h" 2 3 4



struct file_handle
{
  unsigned int handle_bytes;
  int handle_type;

  unsigned char f_handle[0];
};










extern __ssize_t readahead (int __fd, __off64_t __offset, size_t __count)
    __attribute__ ((__nothrow__ , __leaf__));






extern int sync_file_range (int __fd, __off64_t __offset, __off64_t __count,
       unsigned int __flags);






extern __ssize_t vmsplice (int __fdout, const struct iovec *__iov,
      size_t __count, unsigned int __flags);





extern __ssize_t splice (int __fdin, __off64_t *__offin, int __fdout,
    __off64_t *__offout, size_t __len,
    unsigned int __flags);





extern __ssize_t tee (int __fdin, int __fdout, size_t __len,
        unsigned int __flags);
# 417 "/usr/include/bits/fcntl-linux.h" 3 4
extern int fallocate (int __fd, int __mode, __off64_t __offset, __off64_t __len) __asm__ ("" "fallocate64")

                     ;





extern int fallocate64 (int __fd, int __mode, __off64_t __offset,
   __off64_t __len);




extern int name_to_handle_at (int __dfd, const char *__name,
         struct file_handle *__handle, int *__mnt_id,
         int __flags) __attribute__ ((__nothrow__ , __leaf__));





extern int open_by_handle_at (int __mountdirfd, struct file_handle *__handle,
         int __flags);




# 62 "/usr/include/bits/fcntl.h" 2 3 4
# 36 "/usr/include/fcntl.h" 2 3 4
# 78 "/usr/include/fcntl.h" 3 4
# 1 "/usr/include/bits/stat.h" 1 3 4
# 79 "/usr/include/fcntl.h" 2 3 4
# 179 "/usr/include/fcntl.h" 3 4
extern int fcntl (int __fd, int __cmd, ...) __asm__ ("" "fcntl64");





extern int fcntl64 (int __fd, int __cmd, ...);
# 199 "/usr/include/fcntl.h" 3 4
extern int open (const char *__file, int __oflag, ...) __asm__ ("" "open64")
     __attribute__ ((__nonnull__ (1)));





extern int open64 (const char *__file, int __oflag, ...) __attribute__ ((__nonnull__ (1)));
# 224 "/usr/include/fcntl.h" 3 4
extern int openat (int __fd, const char *__file, int __oflag, ...) __asm__ ("" "openat64")
                    __attribute__ ((__nonnull__ (2)));





extern int openat64 (int __fd, const char *__file, int __oflag, ...)
     __attribute__ ((__nonnull__ (2)));
# 245 "/usr/include/fcntl.h" 3 4
extern int creat (const char *__file, mode_t __mode) __asm__ ("" "creat64")
                  __attribute__ ((__nonnull__ (1)));





extern int creat64 (const char *__file, mode_t __mode) __attribute__ ((__nonnull__ (1)));
# 292 "/usr/include/fcntl.h" 3 4
extern int posix_fadvise (int __fd, __off64_t __offset, __off64_t __len, int __advise) __asm__ ("" "posix_fadvise64") __attribute__ ((__nothrow__ , __leaf__))

                      ;





extern int posix_fadvise64 (int __fd, off64_t __offset, off64_t __len,
       int __advise) __attribute__ ((__nothrow__ , __leaf__));
# 313 "/usr/include/fcntl.h" 3 4
extern int posix_fallocate (int __fd, __off64_t __offset, __off64_t __len) __asm__ ("" "posix_fallocate64")

                           ;





extern int posix_fallocate64 (int __fd, off64_t __offset, off64_t __len);
# 332 "/usr/include/fcntl.h" 3 4

# 31 "./include/grub/osdep/hostfile_unix.h" 2
# 1 "/usr/include/dirent.h" 1 3 4
# 27 "/usr/include/dirent.h" 3 4

# 61 "/usr/include/dirent.h" 3 4
# 1 "/usr/include/bits/dirent.h" 1 3 4
# 22 "/usr/include/bits/dirent.h" 3 4
struct dirent
  {




    __ino64_t d_ino;
    __off64_t d_off;

    unsigned short int d_reclen;
    unsigned char d_type;
    char d_name[256];
  };


struct dirent64
  {
    __ino64_t d_ino;
    __off64_t d_off;
    unsigned short int d_reclen;
    unsigned char d_type;
    char d_name[256];
  };
# 62 "/usr/include/dirent.h" 2 3 4
# 97 "/usr/include/dirent.h" 3 4
enum
  {
    DT_UNKNOWN = 0,

    DT_FIFO = 1,

    DT_CHR = 2,

    DT_DIR = 4,

    DT_BLK = 6,

    DT_REG = 8,

    DT_LNK = 10,

    DT_SOCK = 12,

    DT_WHT = 14

  };
# 127 "/usr/include/dirent.h" 3 4
typedef struct __dirstream DIR;






extern DIR *opendir (const char *__name) __attribute__ ((__nonnull__ (1)));






extern DIR *fdopendir (int __fd);







extern int closedir (DIR *__dirp) __attribute__ ((__nonnull__ (1)));
# 165 "/usr/include/dirent.h" 3 4
extern struct dirent *readdir (DIR *__dirp) __asm__ ("" "readdir64")
     __attribute__ ((__nonnull__ (1)));






extern struct dirent64 *readdir64 (DIR *__dirp) __attribute__ ((__nonnull__ (1)));
# 189 "/usr/include/dirent.h" 3 4
extern int readdir_r (DIR *__restrict __dirp, struct dirent *__restrict __entry, struct dirent **__restrict __result) __asm__ ("" "readdir64_r")




  __attribute__ ((__nonnull__ (1, 2, 3))) __attribute__ ((__deprecated__));






extern int readdir64_r (DIR *__restrict __dirp,
   struct dirent64 *__restrict __entry,
   struct dirent64 **__restrict __result)
  __attribute__ ((__nonnull__ (1, 2, 3))) __attribute__ ((__deprecated__));




extern void rewinddir (DIR *__dirp) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern void seekdir (DIR *__dirp, long int __pos) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int telldir (DIR *__dirp) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int dirfd (DIR *__dirp) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 233 "/usr/include/dirent.h" 3 4
# 1 "/usr/include/bits/posix1_lim.h" 1 3 4
# 27 "/usr/include/bits/posix1_lim.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 28 "/usr/include/bits/posix1_lim.h" 2 3 4
# 161 "/usr/include/bits/posix1_lim.h" 3 4
# 1 "/usr/include/bits/local_lim.h" 1 3 4
# 38 "/usr/include/bits/local_lim.h" 3 4
# 1 "/usr/include/linux/limits.h" 1 3 4
# 39 "/usr/include/bits/local_lim.h" 2 3 4
# 162 "/usr/include/bits/posix1_lim.h" 2 3 4
# 234 "/usr/include/dirent.h" 2 3 4
# 245 "/usr/include/dirent.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 246 "/usr/include/dirent.h" 2 3 4
# 263 "/usr/include/dirent.h" 3 4
extern int scandir (const char *__restrict __dir, struct dirent ***__restrict __namelist, int (*__selector) (const struct dirent *), int (*__cmp) (const struct dirent **, const struct dirent **)) __asm__ ("" "scandir64")





                    __attribute__ ((__nonnull__ (1, 2)));
# 278 "/usr/include/dirent.h" 3 4
extern int scandir64 (const char *__restrict __dir,
        struct dirent64 ***__restrict __namelist,
        int (*__selector) (const struct dirent64 *),
        int (*__cmp) (const struct dirent64 **,
        const struct dirent64 **))
     __attribute__ ((__nonnull__ (1, 2)));
# 301 "/usr/include/dirent.h" 3 4
extern int scandirat (int __dfd, const char *__restrict __dir, struct dirent ***__restrict __namelist, int (*__selector) (const struct dirent *), int (*__cmp) (const struct dirent **, const struct dirent **)) __asm__ ("" "scandirat64")





                      __attribute__ ((__nonnull__ (2, 3)));







extern int scandirat64 (int __dfd, const char *__restrict __dir,
   struct dirent64 ***__restrict __namelist,
   int (*__selector) (const struct dirent64 *),
   int (*__cmp) (const struct dirent64 **,
          const struct dirent64 **))
     __attribute__ ((__nonnull__ (2, 3)));
# 330 "/usr/include/dirent.h" 3 4
extern int alphasort (const struct dirent **__e1, const struct dirent **__e2) __asm__ ("" "alphasort64") __attribute__ ((__nothrow__ , __leaf__))


                   __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));






extern int alphasort64 (const struct dirent64 **__e1,
   const struct dirent64 **__e2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 359 "/usr/include/dirent.h" 3 4
extern __ssize_t getdirentries (int __fd, char *__restrict __buf, size_t __nbytes, __off64_t *__restrict __basep) __asm__ ("" "getdirentries64") __attribute__ ((__nothrow__ , __leaf__))



                      __attribute__ ((__nonnull__ (2, 4)));






extern __ssize_t getdirentries64 (int __fd, char *__restrict __buf,
      size_t __nbytes,
      __off64_t *__restrict __basep)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));
# 385 "/usr/include/dirent.h" 3 4
extern int versionsort (const struct dirent **__e1, const struct dirent **__e2) __asm__ ("" "versionsort64") __attribute__ ((__nothrow__ , __leaf__))



     __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));






extern int versionsort64 (const struct dirent64 **__e1,
     const struct dirent64 **__e2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));





# 1 "/usr/include/bits/dirent_ext.h" 1 3 4
# 23 "/usr/include/bits/dirent_ext.h" 3 4






extern __ssize_t getdents64 (int __fd, void *__buffer, size_t __length)
  __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



# 405 "/usr/include/dirent.h" 2 3 4
# 32 "./include/grub/osdep/hostfile_unix.h" 2




# 35 "./include/grub/osdep/hostfile_unix.h"
typedef struct dirent *grub_util_fd_dirent_t;
typedef DIR *grub_util_fd_dir_t;

static inline grub_util_fd_dir_t
grub_util_fd_opendir (const char *name)
{
  return opendir (name);
}

static inline void
grub_util_fd_closedir (grub_util_fd_dir_t dirp)
{
  closedir (dirp);
}

static inline grub_util_fd_dirent_t
grub_util_fd_readdir (grub_util_fd_dir_t dirp)
{
  return readdir (dirp);
}

static inline int
grub_util_unlink (const char *pathname)
{
  return unlink (pathname);
}

static inline int
grub_util_rmdir (const char *pathname)
{
  return rmdir (pathname);
}

static inline int
grub_util_rename (const char *from, const char *to)
{
  return rename (from, to);
}

static inline ssize_t
grub_util_readlink (const char *name, char *buf, size_t bufsize)
{
  return readlink(name, buf, bufsize);
}
# 89 "./include/grub/osdep/hostfile_unix.h"
enum grub_util_fd_open_flags_t
  {
    GRUB_UTIL_FD_O_RDONLY = 
# 91 "./include/grub/osdep/hostfile_unix.h" 3 4
                           00
# 91 "./include/grub/osdep/hostfile_unix.h"
                                   ,
    GRUB_UTIL_FD_O_WRONLY = 
# 92 "./include/grub/osdep/hostfile_unix.h" 3 4
                           01
# 92 "./include/grub/osdep/hostfile_unix.h"
                                   ,
    GRUB_UTIL_FD_O_RDWR = 
# 93 "./include/grub/osdep/hostfile_unix.h" 3 4
                         02
# 93 "./include/grub/osdep/hostfile_unix.h"
                               ,
    GRUB_UTIL_FD_O_CREATTRUNC = 
# 94 "./include/grub/osdep/hostfile_unix.h" 3 4
                               0100 
# 94 "./include/grub/osdep/hostfile_unix.h"
                                       | 
# 94 "./include/grub/osdep/hostfile_unix.h" 3 4
                                         01000
# 94 "./include/grub/osdep/hostfile_unix.h"
                                                ,
    GRUB_UTIL_FD_O_SYNC = (0

      | 
# 97 "./include/grub/osdep/hostfile_unix.h" 3 4
       04010000


      
# 100 "./include/grub/osdep/hostfile_unix.h"
     | 
# 100 "./include/grub/osdep/hostfile_unix.h" 3 4
       04010000

      
# 102 "./include/grub/osdep/hostfile_unix.h"
     )
  };



typedef int grub_util_fd_t;
# 7 "./include/grub/osdep/hostfile.h" 2
# 26 "./include/grub/emu/hostfile.h" 2

int
grub_util_is_directory (const char *path);
int
grub_util_is_special_file (const char *path);
int
grub_util_is_regular (const char *path);

char *
grub_util_path_concat (size_t n, ...);
char *
grub_util_path_concat_ext (size_t n, ...);

int
grub_util_fd_seek (grub_util_fd_t fd, grub_uint64_t off);
ssize_t
grub_util_fd_read (grub_util_fd_t fd, char *buf, size_t len);
ssize_t
grub_util_fd_write (grub_util_fd_t fd, const char *buf, size_t len);

grub_util_fd_t
grub_util_fd_open (const char *os_dev, int flags);
const char *
grub_util_fd_strerror (void);
int
grub_util_fd_sync (grub_util_fd_t fd);
void
grub_util_disable_fd_syncs (void);
int
grub_util_fd_close (grub_util_fd_t fd);

grub_uint64_t
grub_util_get_fd_size (grub_util_fd_t fd, const char *name, unsigned *log_secsize);
char *
grub_util_make_temporary_file (void);
char *
grub_util_make_temporary_dir (void);
void
grub_util_unlink_recursive (const char *name);
grub_uint32_t
grub_util_get_mtime (const char *name);
# 27 "./include/grub/emu/hostdisk.h" 2

grub_util_fd_t
grub_util_fd_open_device (const grub_disk_t disk, grub_disk_addr_t sector, int flags,
     grub_disk_addr_t *max);

void grub_util_biosdisk_init (const char *dev_map);
void grub_util_biosdisk_fini (void);
char *grub_util_biosdisk_get_grub_dev (const char *os_dev);
const char *grub_util_biosdisk_get_osdev (grub_disk_t disk);
int grub_util_biosdisk_is_present (const char *name);
int grub_util_biosdisk_is_floppy (grub_disk_t disk);
const char *
grub_util_biosdisk_get_compatibility_hint (grub_disk_t disk);
grub_err_t grub_util_biosdisk_flush (struct grub_disk *disk);
grub_err_t
grub_cryptodisk_cheat_mount (const char *sourcedev, const char *cheat);
const char *
grub_util_cryptodisk_get_uuid (grub_disk_t disk);
char *
grub_util_get_ldm (grub_disk_t disk, grub_disk_addr_t start);
int
grub_util_is_ldm (grub_disk_t disk);

grub_err_t
grub_util_ldm_embed (struct grub_disk *disk, unsigned int *nsectors,
       unsigned int max_nsectors,
       grub_embed_type_t embed_type,
       grub_disk_addr_t **sectors);

const char *
grub_hostdisk_os_dev_to_grub_drive (const char *os_dev, int add);


char *
grub_util_get_os_disk (const char *os_dev);

int
grub_util_get_dm_node_linear_info (dev_t dev,
       int *maj, int *min,
       grub_disk_addr_t *st);



grub_int64_t
grub_util_get_fd_size_os (grub_util_fd_t fd, const char *name, unsigned *log_secsize);

grub_disk_addr_t
grub_hostdisk_find_partition_start_os (const char *dev);
void
grub_hostdisk_flush_initial_buffer (const char *os_dev);







struct grub_util_hostdisk_data
{
  char *dev;
  int access_mode;
  grub_util_fd_t fd;
  int is_disk;
  int device_map;
};

void grub_host_init (void);
void grub_host_fini (void);
void grub_hostfs_init (void);
void grub_hostfs_fini (void);
# 30 "grub-core/kern/emu/hostfs.c" 2



# 1 "/usr/include/errno.h" 1 3 4
# 28 "/usr/include/errno.h" 3 4
# 1 "/usr/include/bits/errno.h" 1 3 4
# 26 "/usr/include/bits/errno.h" 3 4
# 1 "/usr/include/linux/errno.h" 1 3 4
# 1 "/usr/include/asm/errno.h" 1 3 4
# 1 "/usr/include/asm-generic/errno.h" 1 3 4




# 1 "/usr/include/asm-generic/errno-base.h" 1 3 4
# 6 "/usr/include/asm-generic/errno.h" 2 3 4
# 2 "/usr/include/asm/errno.h" 2 3 4
# 2 "/usr/include/linux/errno.h" 2 3 4
# 27 "/usr/include/bits/errno.h" 2 3 4
# 29 "/usr/include/errno.h" 2 3 4









# 37 "/usr/include/errno.h" 3 4
extern int *__errno_location (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));







extern char *program_invocation_name;
extern char *program_invocation_short_name;

# 1 "/usr/include/bits/types/error_t.h" 1 3 4
# 22 "/usr/include/bits/types/error_t.h" 3 4
typedef int error_t;
# 49 "/usr/include/errno.h" 2 3 4




# 34 "grub-core/kern/emu/hostfs.c" 2
# 1 "/usr/include/string.h" 1 3 4
# 26 "/usr/include/string.h" 3 4
# 1 "/usr/include/bits/libc-header-start.h" 1 3 4
# 27 "/usr/include/string.h" 2 3 4






# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 34 "/usr/include/string.h" 2 3 4
# 43 "/usr/include/string.h" 3 4
extern void *memcpy (void *__restrict __dest, const void *__restrict __src,
       size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern void *memmove (void *__dest, const void *__src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern void *memccpy (void *__restrict __dest, const void *__restrict __src,
        int __c, size_t __n)
    __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) __attribute__ ((__access__ (__write_only__, 1, 4)));




extern void *memset (void *__s, int __c, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int memcmp (const void *__s1, const void *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 91 "/usr/include/string.h" 3 4
extern void *memchr (const void *__s, int __c, size_t __n)
      __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 104 "/usr/include/string.h" 3 4
extern void *rawmemchr (const void *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 117 "/usr/include/string.h" 3 4
extern void *memrchr (const void *__s, int __c, size_t __n)
      __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)))
      __attribute__ ((__access__ (__read_only__, 1, 3)));





extern char *strcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern char *strncpy (char *__restrict __dest,
        const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern char *strcat (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern char *strncat (char *__restrict __dest, const char *__restrict __src,
        size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strcmp (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));

extern int strncmp (const char *__s1, const char *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strcoll (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));

extern size_t strxfrm (char *__restrict __dest,
         const char *__restrict __src, size_t __n)
    __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 1, 3)));






extern int strcoll_l (const char *__s1, const char *__s2, locale_t __l)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 3)));


extern size_t strxfrm_l (char *__dest, const char *__src, size_t __n,
    locale_t __l) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)))
     __attribute__ ((__access__ (__write_only__, 1, 3)));





extern char *strdup (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));






extern char *strndup (const char *__string, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__nonnull__ (1)));
# 230 "/usr/include/string.h" 3 4
extern char *strchr (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 257 "/usr/include/string.h" 3 4
extern char *strrchr (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 270 "/usr/include/string.h" 3 4
extern char *strchrnul (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));





extern size_t strcspn (const char *__s, const char *__reject)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern size_t strspn (const char *__s, const char *__accept)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 307 "/usr/include/string.h" 3 4
extern char *strpbrk (const char *__s, const char *__accept)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 334 "/usr/include/string.h" 3 4
extern char *strstr (const char *__haystack, const char *__needle)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));




extern char *strtok (char *__restrict __s, const char *__restrict __delim)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



extern char *__strtok_r (char *__restrict __s,
    const char *__restrict __delim,
    char **__restrict __save_ptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));

extern char *strtok_r (char *__restrict __s, const char *__restrict __delim,
         char **__restrict __save_ptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
# 364 "/usr/include/string.h" 3 4
extern char *strcasestr (const char *__haystack, const char *__needle)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));







extern void *memmem (const void *__haystack, size_t __haystacklen,
       const void *__needle, size_t __needlelen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 3)))
    __attribute__ ((__access__ (__read_only__, 1, 2)))
    __attribute__ ((__access__ (__read_only__, 3, 4)));



extern void *__mempcpy (void *__restrict __dest,
   const void *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern void *mempcpy (void *__restrict __dest,
        const void *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern size_t strlen (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));




extern size_t strnlen (const char *__string, size_t __maxlen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));




extern char *strerror (int __errnum) __attribute__ ((__nothrow__ , __leaf__));
# 428 "/usr/include/string.h" 3 4
extern char *strerror_r (int __errnum, char *__buf, size_t __buflen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 2, 3)));




extern const char *strerrordesc_np (int __err) __attribute__ ((__nothrow__ , __leaf__));

extern const char *strerrorname_np (int __err) __attribute__ ((__nothrow__ , __leaf__));





extern char *strerror_l (int __errnum, locale_t __l) __attribute__ ((__nothrow__ , __leaf__));



# 1 "/usr/include/strings.h" 1 3 4
# 23 "/usr/include/strings.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 24 "/usr/include/strings.h" 2 3 4










extern int bcmp (const void *__s1, const void *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern void bcopy (const void *__src, void *__dest, size_t __n)
  __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern void bzero (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 68 "/usr/include/strings.h" 3 4
extern char *index (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));
# 96 "/usr/include/strings.h" 3 4
extern char *rindex (const char *__s, int __c)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1)));






extern int ffs (int __i) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));





extern int ffsl (long int __l) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));
__extension__ extern int ffsll (long long int __ll)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));



extern int strcasecmp (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern int strncasecmp (const char *__s1, const char *__s2, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));






extern int strcasecmp_l (const char *__s1, const char *__s2, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 3)));



extern int strncasecmp_l (const char *__s1, const char *__s2,
     size_t __n, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2, 4)));



# 447 "/usr/include/string.h" 2 3 4



extern void explicit_bzero (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));



extern char *strsep (char **__restrict __stringp,
       const char *__restrict __delim)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern char *strsignal (int __sig) __attribute__ ((__nothrow__ , __leaf__));



extern const char *sigabbrev_np (int __sig) __attribute__ ((__nothrow__ , __leaf__));


extern const char *sigdescr_np (int __sig) __attribute__ ((__nothrow__ , __leaf__));



extern char *__stpcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpcpy (char *__restrict __dest, const char *__restrict __src)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern char *__stpncpy (char *__restrict __dest,
   const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern char *stpncpy (char *__restrict __dest,
        const char *__restrict __src, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int strverscmp (const char *__s1, const char *__s2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));


extern char *strfry (char *__string) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern void *memfrob (void *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));
# 511 "/usr/include/string.h" 3 4
extern char *basename (const char *__filename) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 523 "/usr/include/string.h" 3 4

# 35 "grub-core/kern/emu/hostfs.c" 2


# 36 "grub-core/kern/emu/hostfs.c"
static int
is_dir (const char *path, const char *name)
{
  int len1 = strlen(path);
  int len2 = strlen(name);
  int ret;

  char *pathname = xmalloc (len1 + 1 + len2 + 1 + 13);
  strcpy (pathname, path);


  if (len1 > 0 && pathname[len1 - 1] != '/')
    strcat (pathname, "/");

  strcat (pathname, name);

  ret = grub_util_is_directory (pathname);
  free (pathname);
  return ret;
}

struct grub_hostfs_data
{
  char *filename;
  grub_util_fd_t f;
};

static grub_err_t
grub_hostfs_dir (grub_device_t device, const char *path,
   grub_fs_dir_hook_t hook, void *hook_data)
{
  grub_util_fd_dir_t dir;


  if (grub_strcmp (device->disk->name, "host"))
    return grub_error (GRUB_ERR_BAD_FS, "not a hostfs");

  dir = grub_util_fd_opendir (path);
  if (! dir)
    return grub_error (GRUB_ERR_BAD_FILENAME,
         "can't open `%s': %s", path,
         grub_util_fd_strerror ());

  while (1)
    {
      grub_util_fd_dirent_t de;
      struct grub_dirhook_info info;
      grub_memset (&info, 0, sizeof (info));

      de = grub_util_fd_readdir (dir);
      if (! de)
 break;

      info.dir = !! is_dir (path, de->d_name);
      hook (de->d_name, &info, hook_data);

    }

  grub_util_fd_closedir (dir);

  return GRUB_ERR_NONE;
}


static grub_err_t
grub_hostfs_open (struct grub_file *file, const char *name)
{
  grub_util_fd_t f;
  struct grub_hostfs_data *data;

  f = grub_util_fd_open (name, GRUB_UTIL_FD_O_RDONLY);
  if (! ((f) >= 0))
    return grub_error (GRUB_ERR_BAD_FILENAME,
         "can't open `%s': %s", name,
         strerror (
# 110 "grub-core/kern/emu/hostfs.c" 3 4
                  (*__errno_location ())
# 110 "grub-core/kern/emu/hostfs.c"
                       ));
  data = grub_malloc (sizeof (*data));
  if (!data)
    {
      grub_util_fd_close (f);
      return grub_errno;
    }
  data->filename = grub_strdup (name);
  if (!data->filename)
    {
      grub_free (data);
      grub_util_fd_close (f);
      return grub_errno;
    }

  data->f = f;

  file->data = data;

  file->size = grub_util_get_fd_size (f, name, 
# 129 "grub-core/kern/emu/hostfs.c" 3 4
                                              ((void *)0)
# 129 "grub-core/kern/emu/hostfs.c"
                                                  );

  return GRUB_ERR_NONE;
}

static grub_ssize_t
grub_hostfs_read (grub_file_t file, char *buf, grub_size_t len)
{
  struct grub_hostfs_data *data;

  data = file->data;
  if (grub_util_fd_seek (data->f, file->offset) != 0)
    {
      grub_error (GRUB_ERR_OUT_OF_RANGE, "cannot seek `%s': %s",
    data->filename, grub_util_fd_strerror ());
      return -1;
    }

  unsigned int s = grub_util_fd_read (data->f, buf, len);
  if (s != len)
    grub_error (GRUB_ERR_FILE_READ_ERROR, "cannot read `%s': %s",
  data->filename, grub_util_fd_strerror ());

  return (signed) s;
}

static grub_err_t
grub_hostfs_close (grub_file_t file)
{
  struct grub_hostfs_data *data;

  data = file->data;
  grub_util_fd_close (data->f);
  grub_free (data->filename);
  grub_free (data);

  return GRUB_ERR_NONE;
}

static grub_err_t
grub_hostfs_label (grub_device_t device __attribute ((unused)),
     char **label __attribute ((unused)))
{
  *label = 0;
  return GRUB_ERR_NONE;
}




static struct grub_fs grub_hostfs_fs =
  {
    .name = "hostfs",
    .fs_dir = grub_hostfs_dir,
    .fs_open = grub_hostfs_open,
    .fs_read = grub_hostfs_read,
    .fs_close = grub_hostfs_close,
    .fs_label = grub_hostfs_label,
    .next = 0
  };



@MARKER@hostfs@
{
  grub_fs_register (&grub_hostfs_fs);
}

GRUB_MOD_FINI(hostfs)
{
  grub_fs_unregister (&grub_hostfs_fs);
}
# 1 "grub-core/disk/host.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "grub-core/disk/host.c"
# 23 "grub-core/disk/host.c"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 24 "grub-core/disk/host.c" 2
# 1 "./config-util.h" 1
# 25 "grub-core/disk/host.c" 2

# 1 "./include/grub/dl.h" 1
# 23 "./include/grub/dl.h"
# 1 "./include/grub/symbol.h" 1
# 22 "./include/grub/symbol.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/symbol.h" 2
# 24 "./include/grub/dl.h" 2

# 1 "./include/grub/err.h" 1
# 24 "./include/grub/err.h"
# 1 "./include/grub/compiler.h" 1
# 25 "./include/grub/err.h" 2



typedef enum
  {
    GRUB_ERR_NONE = 0,
    GRUB_ERR_TEST_FAILURE,
    GRUB_ERR_BAD_MODULE,
    GRUB_ERR_OUT_OF_MEMORY,
    GRUB_ERR_BAD_FILE_TYPE,
    GRUB_ERR_FILE_NOT_FOUND,
    GRUB_ERR_FILE_READ_ERROR,
    GRUB_ERR_BAD_FILENAME,
    GRUB_ERR_UNKNOWN_FS,
    GRUB_ERR_BAD_FS,
    GRUB_ERR_BAD_NUMBER,
    GRUB_ERR_OUT_OF_RANGE,
    GRUB_ERR_UNKNOWN_DEVICE,
    GRUB_ERR_BAD_DEVICE,
    GRUB_ERR_READ_ERROR,
    GRUB_ERR_WRITE_ERROR,
    GRUB_ERR_UNKNOWN_COMMAND,
    GRUB_ERR_INVALID_COMMAND,
    GRUB_ERR_BAD_ARGUMENT,
    GRUB_ERR_BAD_PART_TABLE,
    GRUB_ERR_UNKNOWN_OS,
    GRUB_ERR_BAD_OS,
    GRUB_ERR_NO_KERNEL,
    GRUB_ERR_BAD_FONT,
    GRUB_ERR_NOT_IMPLEMENTED_YET,
    GRUB_ERR_SYMLINK_LOOP,
    GRUB_ERR_BAD_COMPRESSED_DATA,
    GRUB_ERR_MENU,
    GRUB_ERR_TIMEOUT,
    GRUB_ERR_IO,
    GRUB_ERR_ACCESS_DENIED,
    GRUB_ERR_EXTRACTOR,
    GRUB_ERR_NET_BAD_ADDRESS,
    GRUB_ERR_NET_ROUTE_LOOP,
    GRUB_ERR_NET_NO_ROUTE,
    GRUB_ERR_NET_NO_ANSWER,
    GRUB_ERR_NET_NO_CARD,
    GRUB_ERR_WAIT,
    GRUB_ERR_BUG,
    GRUB_ERR_NET_PORT_CLOSED,
    GRUB_ERR_NET_INVALID_RESPONSE,
    GRUB_ERR_NET_UNKNOWN_ERROR,
    GRUB_ERR_NET_PACKET_TOO_BIG,
    GRUB_ERR_NET_NO_DOMAIN,
    GRUB_ERR_EOF,
    GRUB_ERR_BAD_SIGNATURE
  }
grub_err_t;

struct grub_error_saved
{
  grub_err_t grub_errno;
  char errmsg[256];
};

extern grub_err_t grub_errno;
extern char grub_errmsg[256];

grub_err_t grub_error (grub_err_t n, const char *fmt, ...);
void grub_fatal (const char *fmt, ...) __attribute__ ((noreturn));
void grub_error_push (void);
int grub_error_pop (void);
void grub_print_error (void);
extern int grub_err_printed_errors;
int grub_err_printf (const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 1, 2)));
# 26 "./include/grub/dl.h" 2
# 1 "./include/grub/types.h" 1
# 22 "./include/grub/types.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/types.h" 2
# 76 "./include/grub/types.h"
typedef signed char grub_int8_t;
typedef short grub_int16_t;
typedef int grub_int32_t;

typedef long grub_int64_t;




typedef unsigned char grub_uint8_t;
typedef unsigned short grub_uint16_t;
typedef unsigned grub_uint32_t;



typedef unsigned long grub_uint64_t;
# 103 "./include/grub/types.h"
typedef grub_uint64_t grub_addr_t;
typedef grub_uint64_t grub_size_t;
typedef grub_int64_t grub_ssize_t;
# 154 "./include/grub/types.h"
typedef grub_uint64_t grub_properly_aligned_t;




typedef grub_uint64_t grub_off_t;


typedef grub_uint64_t grub_disk_addr_t;


static inline grub_uint16_t grub_swap_bytes16(grub_uint16_t _x)
{
   return (grub_uint16_t) ((_x << 8) | (_x >> 8));
}
# 186 "./include/grub/types.h"
static inline grub_uint32_t grub_swap_bytes32(grub_uint32_t x)
{
 return __builtin_bswap32(x);
}

static inline grub_uint64_t grub_swap_bytes64(grub_uint64_t x)
{
 return __builtin_bswap64(x);
}
# 260 "./include/grub/types.h"
struct grub_unaligned_uint16
{
  grub_uint16_t val;
} __attribute__ ((packed));
struct grub_unaligned_uint32
{
  grub_uint32_t val;
} __attribute__ ((packed));
struct grub_unaligned_uint64
{
  grub_uint64_t val;
} __attribute__ ((packed));

typedef struct grub_unaligned_uint16 grub_unaligned_uint16_t;
typedef struct grub_unaligned_uint32 grub_unaligned_uint32_t;
typedef struct grub_unaligned_uint64 grub_unaligned_uint64_t;

static inline grub_uint16_t grub_get_unaligned16 (const void *ptr)
{
  const struct grub_unaligned_uint16 *dd
    = (const struct grub_unaligned_uint16 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned16 (void *ptr, grub_uint16_t val)
{
  struct grub_unaligned_uint16 *dd = (struct grub_unaligned_uint16 *) ptr;
  dd->val = val;
}

static inline grub_uint32_t grub_get_unaligned32 (const void *ptr)
{
  const struct grub_unaligned_uint32 *dd
    = (const struct grub_unaligned_uint32 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned32 (void *ptr, grub_uint32_t val)
{
  struct grub_unaligned_uint32 *dd = (struct grub_unaligned_uint32 *) ptr;
  dd->val = val;
}

static inline grub_uint64_t grub_get_unaligned64 (const void *ptr)
{
  const struct grub_unaligned_uint64 *dd
    = (const struct grub_unaligned_uint64 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned64 (void *ptr, grub_uint64_t val)
{
  struct grub_unaligned_uint64_t
  {
    grub_uint64_t d;
  } __attribute__ ((packed));
  struct grub_unaligned_uint64_t *dd = (struct grub_unaligned_uint64_t *) ptr;
  dd->d = val;
}
# 27 "./include/grub/dl.h" 2
# 1 "./include/grub/elf.h" 1
# 28 "./include/grub/elf.h"
typedef grub_uint16_t Elf32_Half;
typedef grub_uint16_t Elf64_Half;


typedef grub_uint32_t Elf32_Word;
typedef grub_int32_t Elf32_Sword;
typedef grub_uint32_t Elf64_Word;
typedef grub_int32_t Elf64_Sword;


typedef grub_uint64_t Elf32_Xword;
typedef grub_int64_t Elf32_Sxword;
typedef grub_uint64_t Elf64_Xword;
typedef grub_int64_t Elf64_Sxword;


typedef grub_uint32_t Elf32_Addr;
typedef grub_uint64_t Elf64_Addr;


typedef grub_uint32_t Elf32_Off;
typedef grub_uint64_t Elf64_Off;


typedef grub_uint16_t Elf32_Section;
typedef grub_uint16_t Elf64_Section;


typedef Elf32_Half Elf32_Versym;
typedef Elf64_Half Elf64_Versym;






typedef struct
{
  unsigned char e_ident[(16)];
  Elf32_Half e_type;
  Elf32_Half e_machine;
  Elf32_Word e_version;
  Elf32_Addr e_entry;
  Elf32_Off e_phoff;
  Elf32_Off e_shoff;
  Elf32_Word e_flags;
  Elf32_Half e_ehsize;
  Elf32_Half e_phentsize;
  Elf32_Half e_phnum;
  Elf32_Half e_shentsize;
  Elf32_Half e_shnum;
  Elf32_Half e_shstrndx;
} Elf32_Ehdr;

typedef struct
{
  unsigned char e_ident[(16)];
  Elf64_Half e_type;
  Elf64_Half e_machine;
  Elf64_Word e_version;
  Elf64_Addr e_entry;
  Elf64_Off e_phoff;
  Elf64_Off e_shoff;
  Elf64_Word e_flags;
  Elf64_Half e_ehsize;
  Elf64_Half e_phentsize;
  Elf64_Half e_phnum;
  Elf64_Half e_shentsize;
  Elf64_Half e_shnum;
  Elf64_Half e_shstrndx;
} Elf64_Ehdr;
# 266 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word sh_name;
  Elf32_Word sh_type;
  Elf32_Word sh_flags;
  Elf32_Addr sh_addr;
  Elf32_Off sh_offset;
  Elf32_Word sh_size;
  Elf32_Word sh_link;
  Elf32_Word sh_info;
  Elf32_Word sh_addralign;
  Elf32_Word sh_entsize;
} Elf32_Shdr;

typedef struct
{
  Elf64_Word sh_name;
  Elf64_Word sh_type;
  Elf64_Xword sh_flags;
  Elf64_Addr sh_addr;
  Elf64_Off sh_offset;
  Elf64_Xword sh_size;
  Elf64_Word sh_link;
  Elf64_Word sh_info;
  Elf64_Xword sh_addralign;
  Elf64_Xword sh_entsize;
} Elf64_Shdr;
# 365 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word st_name;
  Elf32_Addr st_value;
  Elf32_Word st_size;
  unsigned char st_info;
  unsigned char st_other;
  Elf32_Section st_shndx;
} Elf32_Sym;

typedef struct
{
  Elf64_Word st_name;
  unsigned char st_info;
  unsigned char st_other;
  Elf64_Section st_shndx;
  Elf64_Addr st_value;
  Elf64_Xword st_size;
} Elf64_Sym;




typedef struct
{
  Elf32_Half si_boundto;
  Elf32_Half si_flags;
} Elf32_Syminfo;

typedef struct
{
  Elf64_Half si_boundto;
  Elf64_Half si_flags;
} Elf64_Syminfo;
# 479 "./include/grub/elf.h"
typedef struct
{
  Elf32_Addr r_offset;
  Elf32_Word r_info;
} Elf32_Rel;






typedef struct
{
  Elf64_Addr r_offset;
  Elf64_Xword r_info;
} Elf64_Rel;



typedef struct
{
  Elf32_Addr r_offset;
  Elf32_Word r_info;
  Elf32_Sword r_addend;
} Elf32_Rela;

typedef struct
{
  Elf64_Addr r_offset;
  Elf64_Xword r_info;
  Elf64_Sxword r_addend;
} Elf64_Rela;
# 524 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word p_type;
  Elf32_Off p_offset;
  Elf32_Addr p_vaddr;
  Elf32_Addr p_paddr;
  Elf32_Word p_filesz;
  Elf32_Word p_memsz;
  Elf32_Word p_flags;
  Elf32_Word p_align;
} Elf32_Phdr;

typedef struct
{
  Elf64_Word p_type;
  Elf64_Word p_flags;
  Elf64_Off p_offset;
  Elf64_Addr p_vaddr;
  Elf64_Addr p_paddr;
  Elf64_Xword p_filesz;
  Elf64_Xword p_memsz;
  Elf64_Xword p_align;
} Elf64_Phdr;
# 603 "./include/grub/elf.h"
typedef struct
{
  Elf32_Sword d_tag;
  union
    {
      Elf32_Word d_val;
      Elf32_Addr d_ptr;
    } d_un;
} Elf32_Dyn;

typedef struct
{
  Elf64_Sxword d_tag;
  union
    {
      Elf64_Xword d_val;
      Elf64_Addr d_ptr;
    } d_un;
} Elf64_Dyn;
# 767 "./include/grub/elf.h"
typedef struct
{
  Elf32_Half vd_version;
  Elf32_Half vd_flags;
  Elf32_Half vd_ndx;
  Elf32_Half vd_cnt;
  Elf32_Word vd_hash;
  Elf32_Word vd_aux;
  Elf32_Word vd_next;

} Elf32_Verdef;

typedef struct
{
  Elf64_Half vd_version;
  Elf64_Half vd_flags;
  Elf64_Half vd_ndx;
  Elf64_Half vd_cnt;
  Elf64_Word vd_hash;
  Elf64_Word vd_aux;
  Elf64_Word vd_next;

} Elf64_Verdef;
# 809 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word vda_name;
  Elf32_Word vda_next;

} Elf32_Verdaux;

typedef struct
{
  Elf64_Word vda_name;
  Elf64_Word vda_next;

} Elf64_Verdaux;




typedef struct
{
  Elf32_Half vn_version;
  Elf32_Half vn_cnt;
  Elf32_Word vn_file;

  Elf32_Word vn_aux;
  Elf32_Word vn_next;

} Elf32_Verneed;

typedef struct
{
  Elf64_Half vn_version;
  Elf64_Half vn_cnt;
  Elf64_Word vn_file;

  Elf64_Word vn_aux;
  Elf64_Word vn_next;

} Elf64_Verneed;
# 856 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word vna_hash;
  Elf32_Half vna_flags;
  Elf32_Half vna_other;
  Elf32_Word vna_name;
  Elf32_Word vna_next;

} Elf32_Vernaux;

typedef struct
{
  Elf64_Word vna_hash;
  Elf64_Half vna_flags;
  Elf64_Half vna_other;
  Elf64_Word vna_name;
  Elf64_Word vna_next;

} Elf64_Vernaux;
# 890 "./include/grub/elf.h"
typedef struct
{
  int a_type;
  union
    {
      long int a_val;
      void *a_ptr;
      void (*a_fcn) (void);
    } a_un;
} Elf32_auxv_t;

typedef struct
{
  long int a_type;
  union
    {
      long int a_val;
      void *a_ptr;
      void (*a_fcn) (void);
    } a_un;
} Elf64_auxv_t;
# 953 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word n_namesz;
  Elf32_Word n_descsz;
  Elf32_Word n_type;
} Elf32_Nhdr;

typedef struct
{
  Elf64_Word n_namesz;
  Elf64_Word n_descsz;
  Elf64_Word n_type;
} Elf64_Nhdr;
# 1000 "./include/grub/elf.h"
typedef struct
{
  Elf32_Xword m_value;
  Elf32_Word m_info;
  Elf32_Word m_poffset;
  Elf32_Half m_repeat;
  Elf32_Half m_stride;
} Elf32_Move;

typedef struct
{
  Elf64_Xword m_value;
  Elf64_Xword m_info;
  Elf64_Xword m_poffset;
  Elf64_Half m_repeat;
  Elf64_Half m_stride;
} Elf64_Move;
# 1365 "./include/grub/elf.h"
typedef union
{
  struct
    {
      Elf32_Word gt_current_g_value;
      Elf32_Word gt_unused;
    } gt_header;
  struct
    {
      Elf32_Word gt_g_value;
      Elf32_Word gt_bytes;
    } gt_entry;
} Elf32_gptab;



typedef struct
{
  Elf32_Word ri_gprmask;
  Elf32_Word ri_cprmask[4];
  Elf32_Sword ri_gp_value;
} Elf32_RegInfo;



typedef struct
{
  unsigned char kind;

  unsigned char size;
  Elf32_Section section;

  Elf32_Word info;
} Elf_Options;
# 1441 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word hwp_flags1;
  Elf32_Word hwp_flags2;
} Elf_Options_Hw;
# 1580 "./include/grub/elf.h"
typedef struct
{
  Elf32_Word l_name;
  Elf32_Word l_time_stamp;
  Elf32_Word l_checksum;
  Elf32_Word l_version;
  Elf32_Word l_flags;
} Elf32_Lib;

typedef struct
{
  Elf64_Word l_name;
  Elf64_Word l_time_stamp;
  Elf64_Word l_checksum;
  Elf64_Word l_version;
  Elf64_Word l_flags;
} Elf64_Lib;
# 1611 "./include/grub/elf.h"
typedef Elf32_Addr Elf32_Conflict;
# 28 "./include/grub/dl.h" 2
# 1 "./include/grub/list.h" 1
# 27 "./include/grub/list.h"
struct grub_list
{
  struct grub_list *next;
  struct grub_list **prev;
};
typedef struct grub_list *grub_list_t;

void grub_list_push (grub_list_t *head, grub_list_t item);
void grub_list_remove (grub_list_t item);





static inline void *
grub_bad_type_cast_real (int line, const char *file)
     __attribute__ ((__error__ ("bad type cast between incompatible grub types")));

static inline void *
grub_bad_type_cast_real (int line, const char *file)
{
  grub_fatal ("error:%s:%u: bad type cast between incompatible grub types",
       file, line);
}
# 65 "./include/grub/list.h"
struct grub_named_list
{
  struct grub_named_list *next;
  struct grub_named_list **prev;
  char *name;
};
typedef struct grub_named_list *grub_named_list_t;

void * grub_named_list_find (grub_named_list_t head,
       const char *name);
# 29 "./include/grub/dl.h" 2
# 1 "./include/grub/misc.h" 1
# 23 "./include/grub/misc.h"
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 3 4

# 40 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 99 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 3 4
typedef __gnuc_va_list va_list;
# 24 "./include/grub/misc.h" 2



# 1 "./include/grub/i18n.h" 1
# 22 "./include/grub/i18n.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/i18n.h" 2






# 28 "./include/grub/i18n.h"
extern const char *(*grub_gettext) (const char *s) __attribute__ ((format_arg (1)));



# 1 "/usr/include/locale.h" 1 3 4
# 25 "/usr/include/locale.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 465 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 452 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 453 "/usr/include/sys/cdefs.h" 2 3 4
# 1 "/usr/include/bits/long-double.h" 1 3 4
# 454 "/usr/include/sys/cdefs.h" 2 3 4
# 466 "/usr/include/features.h" 2 3 4
# 489 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4
# 10 "/usr/include/gnu/stubs.h" 3 4
# 1 "/usr/include/gnu/stubs-64.h" 1 3 4
# 11 "/usr/include/gnu/stubs.h" 2 3 4
# 490 "/usr/include/features.h" 2 3 4
# 26 "/usr/include/locale.h" 2 3 4


# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 29 "/usr/include/locale.h" 2 3 4
# 1 "/usr/include/bits/locale.h" 1 3 4
# 30 "/usr/include/locale.h" 2 3 4


# 51 "/usr/include/locale.h" 3 4

# 51 "/usr/include/locale.h" 3 4
struct lconv
{


  char *decimal_point;
  char *thousands_sep;





  char *grouping;





  char *int_curr_symbol;
  char *currency_symbol;
  char *mon_decimal_point;
  char *mon_thousands_sep;
  char *mon_grouping;
  char *positive_sign;
  char *negative_sign;
  char int_frac_digits;
  char frac_digits;

  char p_cs_precedes;

  char p_sep_by_space;

  char n_cs_precedes;

  char n_sep_by_space;






  char p_sign_posn;
  char n_sign_posn;


  char int_p_cs_precedes;

  char int_p_sep_by_space;

  char int_n_cs_precedes;

  char int_n_sep_by_space;






  char int_p_sign_posn;
  char int_n_sign_posn;
# 118 "/usr/include/locale.h" 3 4
};



extern char *setlocale (int __category, const char *__locale) __attribute__ ((__nothrow__ , __leaf__));


extern struct lconv *localeconv (void) __attribute__ ((__nothrow__ , __leaf__));
# 135 "/usr/include/locale.h" 3 4
# 1 "/usr/include/bits/types/locale_t.h" 1 3 4
# 22 "/usr/include/bits/types/locale_t.h" 3 4
# 1 "/usr/include/bits/types/__locale_t.h" 1 3 4
# 28 "/usr/include/bits/types/__locale_t.h" 3 4
struct __locale_struct
{

  struct __locale_data *__locales[13];


  const unsigned short int *__ctype_b;
  const int *__ctype_tolower;
  const int *__ctype_toupper;


  const char *__names[13];
};

typedef struct __locale_struct *__locale_t;
# 23 "/usr/include/bits/types/locale_t.h" 2 3 4

typedef __locale_t locale_t;
# 136 "/usr/include/locale.h" 2 3 4





extern locale_t newlocale (int __category_mask, const char *__locale,
      locale_t __base) __attribute__ ((__nothrow__ , __leaf__));
# 176 "/usr/include/locale.h" 3 4
extern locale_t duplocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));



extern void freelocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));






extern locale_t uselocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));








# 33 "./include/grub/i18n.h" 2
# 1 "/usr/include/libintl.h" 1 3 4
# 34 "/usr/include/libintl.h" 3 4





extern char *gettext (const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (1)));



extern char *dgettext (const char *__domainname, const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));
extern char *__dgettext (const char *__domainname, const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));



extern char *dcgettext (const char *__domainname,
   const char *__msgid, int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));
extern char *__dcgettext (const char *__domainname,
     const char *__msgid, int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));




extern char *ngettext (const char *__msgid1, const char *__msgid2,
         unsigned long int __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (1))) __attribute__ ((__format_arg__ (2)));



extern char *dngettext (const char *__domainname, const char *__msgid1,
   const char *__msgid2, unsigned long int __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2))) __attribute__ ((__format_arg__ (3)));



extern char *dcngettext (const char *__domainname, const char *__msgid1,
    const char *__msgid2, unsigned long int __n,
    int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2))) __attribute__ ((__format_arg__ (3)));





extern char *textdomain (const char *__domainname) __attribute__ ((__nothrow__ , __leaf__));



extern char *bindtextdomain (const char *__domainname,
        const char *__dirname) __attribute__ ((__nothrow__ , __leaf__));



extern char *bind_textdomain_codeset (const char *__domainname,
          const char *__codeset) __attribute__ ((__nothrow__ , __leaf__));
# 121 "/usr/include/libintl.h" 3 4

# 34 "./include/grub/i18n.h" 2
# 53 "./include/grub/i18n.h"

# 53 "./include/grub/i18n.h"
static inline const char * __attribute__ ((always_inline,format_arg (1)))
_ (const char *str)
{
  return gettext(str);
}
# 28 "./include/grub/misc.h" 2
# 40 "./include/grub/misc.h"
void *grub_memmove (void *dest, const void *src, grub_size_t n);
char *grub_strcpy (char *dest, const char *src);

static inline char *
grub_strncpy (char *dest, const char *src, int c)
{
  char *p = dest;

  while ((*p++ = *src++) != '\0' && --c)
    ;

  return dest;
}

static inline char *
grub_stpcpy (char *dest, const char *src)
{
  char *d = dest;
  const char *s = src;

  do
    *d++ = *s;
  while (*s++ != '\0');

  return d - 1;
}


static inline void *
grub_memcpy (void *dest, const void *src, grub_size_t n)
{
  return grub_memmove (dest, src, n);
}
# 82 "./include/grub/misc.h"
int grub_memcmp (const void *s1, const void *s2, grub_size_t n);
int grub_strcmp (const char *s1, const char *s2);
int grub_strncmp (const char *s1, const char *s2, grub_size_t n);

char *grub_strchr (const char *s, int c);
char *grub_strrchr (const char *s, int c);
int grub_strword (const char *s, const char *w);



static inline char *
grub_strstr (const char *haystack, const char *needle)
{





  if (*needle != '\0')
    {


      char b = *needle++;

      for (;; haystack++)
 {
   if (*haystack == '\0')

     return 0;
   if (*haystack == b)

     {
       const char *rhaystack = haystack + 1;
       const char *rneedle = needle;

       for (;; rhaystack++, rneedle++)
  {
    if (*rneedle == '\0')

      return (char *) haystack;
    if (*rhaystack == '\0')

      return 0;
    if (*rhaystack != *rneedle)

      break;
  }
     }
 }
    }
  else
    return (char *) haystack;
}

int grub_isspace (int c);

static inline int
grub_isprint (int c)
{
  return (c >= ' ' && c <= '~');
}

static inline int
grub_iscntrl (int c)
{
  return (c >= 0x00 && c <= 0x1F) || c == 0x7F;
}

static inline int
grub_isalpha (int c)
{
  return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

static inline int
grub_islower (int c)
{
  return (c >= 'a' && c <= 'z');
}

static inline int
grub_isupper (int c)
{
  return (c >= 'A' && c <= 'Z');
}

static inline int
grub_isgraph (int c)
{
  return (c >= '!' && c <= '~');
}

static inline int
grub_isdigit (int c)
{
  return (c >= '0' && c <= '9');
}

static inline int
grub_isxdigit (int c)
{
  return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F');
}

static inline int
grub_isalnum (int c)
{
  return grub_isalpha (c) || grub_isdigit (c);
}

static inline int
grub_tolower (int c)
{
  if (c >= 'A' && c <= 'Z')
    return c - 'A' + 'a';

  return c;
}

static inline int
grub_toupper (int c)
{
  if (c >= 'a' && c <= 'z')
    return c - 'a' + 'A';

  return c;
}

static inline int
grub_strcasecmp (const char *s1, const char *s2)
{
  while (*s1 && *s2)
    {
      if (grub_tolower ((grub_uint8_t) *s1)
   != grub_tolower ((grub_uint8_t) *s2))
 break;

      s1++;
      s2++;
    }

  return (int) grub_tolower ((grub_uint8_t) *s1)
    - (int) grub_tolower ((grub_uint8_t) *s2);
}

static inline int
grub_strncasecmp (const char *s1, const char *s2, grub_size_t n)
{
  if (n == 0)
    return 0;

  while (*s1 && *s2 && --n)
    {
      if (grub_tolower (*s1) != grub_tolower (*s2))
 break;

      s1++;
      s2++;
    }

  return (int) grub_tolower ((grub_uint8_t) *s1)
    - (int) grub_tolower ((grub_uint8_t) *s2);
}
# 264 "./include/grub/misc.h"
unsigned long grub_strtoul (const char * __restrict str, const char ** const __restrict end, int base);
unsigned long long grub_strtoull (const char * __restrict str, const char ** const __restrict end, int base);

static inline long
grub_strtol (const char * __restrict str, const char ** const __restrict end, int base)
{
  int negative = 0;
  unsigned long long magnitude;

  while (*str && grub_isspace (*str))
    str++;

  if (*str == '-')
    {
      negative = 1;
      str++;
    }

  magnitude = grub_strtoull (str, end, base);
  if (negative)
    {
      if (magnitude > (unsigned long) 9223372036854775807L + 1)
        {
          grub_error (GRUB_ERR_OUT_OF_RANGE, "overflow is detected");
          return (-9223372036854775807L - 1);
        }
      return -((long) magnitude);
    }
  else
    {
      if (magnitude > 9223372036854775807L)
        {
          grub_error (GRUB_ERR_OUT_OF_RANGE, "overflow is detected");
          return 9223372036854775807L;
        }
      return (long) magnitude;
    }
}

char *grub_strdup (const char *s) __attribute__ ((warn_unused_result));
char *grub_strndup (const char *s, grub_size_t n) __attribute__ ((warn_unused_result));
void *grub_memset (void *s, int c, grub_size_t n);
grub_size_t grub_strlen (const char *s) __attribute__ ((warn_unused_result));
int grub_printf (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));
int grub_printf_ (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));



static inline char *
grub_strchrsub (char *output, const char *input, char ch, const char *with)
{
  while (*input)
    {
      if (*input == ch)
 {
   grub_strcpy (output, with);
   output += grub_strlen (with);
   input++;
   continue;
 }
      *output++ = *input++;
    }
  *output = '\0';
  return output;
}

extern void (*grub_xputs) (const char *str);

static inline int
grub_puts (const char *s)
{
  const char nl[2] = "\n";
  grub_xputs (s);
  grub_xputs (nl);

  return 1;
}

int grub_puts_ (const char *s);
int grub_debug_enabled (const char *condition);
void grub_real_dprintf (const char *file,
                                     const int line,
                                     const char *condition,
                                     const char *fmt, ...) __attribute__ ((format (gnu_printf, 4, 5)));
int grub_vprintf (const char *fmt, va_list args);
int grub_snprintf (char *str, grub_size_t n, const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 3, 4)));
int grub_vsnprintf (char *str, grub_size_t n, const char *fmt,
     va_list args);
char *grub_xasprintf (const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 1, 2))) __attribute__ ((warn_unused_result));
char *grub_xvasprintf (const char *fmt, va_list args) __attribute__ ((warn_unused_result));
void grub_exit (void) __attribute__ ((noreturn));
grub_uint64_t grub_divmod64 (grub_uint64_t n,
       grub_uint64_t d,
       grub_uint64_t *r);
# 378 "./include/grub/misc.h"
grub_int64_t
grub_divmod64s (grub_int64_t n,
     grub_int64_t d,
     grub_int64_t *r);

grub_uint32_t
grub_divmod32 (grub_uint32_t n,
     grub_uint32_t d,
     grub_uint32_t *r);

grub_int32_t
grub_divmod32s (grub_int32_t n,
      grub_int32_t d,
      grub_int32_t *r);



static inline char *
grub_memchr (const void *p, int c, grub_size_t len)
{
  const char *s = (const char *) p;
  const char *e = s + len;

  for (; s < e; s++)
    if (*s == c)
      return (char *) s;

  return 0;
}


static inline unsigned int
grub_abs (int x)
{
  if (x < 0)
    return (unsigned int) (-x);
  else
    return (unsigned int) x;
}






void grub_reboot (void) __attribute__ ((noreturn));
# 437 "./include/grub/misc.h"
void grub_halt (void) __attribute__ ((noreturn));
# 447 "./include/grub/misc.h"
static inline void
grub_error_save (struct grub_error_saved *save)
{
  grub_memcpy (save->errmsg, grub_errmsg, sizeof (save->errmsg));
  save->grub_errno = grub_errno;
  grub_errno = GRUB_ERR_NONE;
}

static inline void
grub_error_load (const struct grub_error_saved *save)
{
  grub_memcpy (grub_errmsg, save->errmsg, sizeof (grub_errmsg));
  grub_errno = save->grub_errno;
}
# 30 "./include/grub/dl.h" 2
# 155 "./include/grub/dl.h"
struct grub_dl_segment
{
  struct grub_dl_segment *next;
  void *addr;
  grub_size_t size;
  unsigned section;
};
typedef struct grub_dl_segment *grub_dl_segment_t;

struct grub_dl;

struct grub_dl_dep
{
  struct grub_dl_dep *next;
  struct grub_dl *mod;
};
typedef struct grub_dl_dep *grub_dl_dep_t;
# 199 "./include/grub/dl.h"
typedef struct grub_dl *grub_dl_t;

grub_dl_t grub_dl_load_file (const char *filename);
grub_dl_t grub_dl_load (const char *name);
grub_dl_t grub_dl_load_core (void *addr, grub_size_t size);
grub_dl_t grub_dl_load_core_noinit (void *addr, grub_size_t size);
int grub_dl_unload (grub_dl_t mod);
void grub_dl_unload_unneeded (void);
int grub_dl_ref (grub_dl_t mod);
int grub_dl_unref (grub_dl_t mod);
extern grub_dl_t grub_dl_head;
# 258 "./include/grub/dl.h"
grub_err_t grub_dl_register_symbol (const char *name, void *addr,
        int isfunc, grub_dl_t mod);

grub_err_t grub_arch_dl_check_header (void *ehdr);
# 276 "./include/grub/dl.h"
grub_err_t
grub_ia64_dl_get_tramp_got_size (const void *ehdr, grub_size_t *tramp,
     grub_size_t *got);
grub_err_t
grub_arm64_dl_get_tramp_got_size (const void *ehdr, grub_size_t *tramp,
      grub_size_t *got);
# 290 "./include/grub/dl.h"
grub_err_t
grub_arch_dl_get_tramp_got_size (const void *ehdr, grub_size_t *tramp,
     grub_size_t *got);
# 27 "grub-core/disk/host.c" 2
# 1 "./include/grub/disk.h" 1
# 22 "./include/grub/disk.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/disk.h" 2




# 1 "./include/grub/device.h" 1
# 26 "./include/grub/device.h"
struct grub_disk;
struct grub_net;

struct grub_device
{
  struct grub_disk *disk;
  struct grub_net *net;
};
typedef struct grub_device *grub_device_t;

typedef int (*grub_device_iterate_hook_t) (const char *name, void *data);

grub_device_t grub_device_open (const char *name);
grub_err_t grub_device_close (grub_device_t device);
int grub_device_iterate (grub_device_iterate_hook_t hook,
          void *hook_data);
# 28 "./include/grub/disk.h" 2

# 1 "./include/grub/mm.h" 1
# 25 "./include/grub/mm.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 26 "./include/grub/mm.h" 2





void grub_mm_init_region (void *addr, grub_size_t size);
void *grub_calloc (grub_size_t nmemb, grub_size_t size);
void *grub_malloc (grub_size_t size);
void *grub_zalloc (grub_size_t size);
void grub_free (void *ptr);
void *grub_realloc (void *ptr, grub_size_t size);

void *grub_memalign (grub_size_t align, grub_size_t size);


void grub_mm_check_real (const char *file, int line);
# 30 "./include/grub/disk.h" 2



enum grub_disk_dev_id
  {
    GRUB_DISK_DEVICE_BIOSDISK_ID,
    GRUB_DISK_DEVICE_OFDISK_ID,
    GRUB_DISK_DEVICE_LOOPBACK_ID,
    GRUB_DISK_DEVICE_EFIDISK_ID,
    GRUB_DISK_DEVICE_DISKFILTER_ID,
    GRUB_DISK_DEVICE_HOST_ID,
    GRUB_DISK_DEVICE_ATA_ID,
    GRUB_DISK_DEVICE_MEMDISK_ID,
    GRUB_DISK_DEVICE_NAND_ID,
    GRUB_DISK_DEVICE_SCSI_ID,
    GRUB_DISK_DEVICE_CRYPTODISK_ID,
    GRUB_DISK_DEVICE_ARCDISK_ID,
    GRUB_DISK_DEVICE_HOSTDISK_ID,
    GRUB_DISK_DEVICE_PROCFS_ID,
    GRUB_DISK_DEVICE_CBFSDISK_ID,
    GRUB_DISK_DEVICE_UBOOTDISK_ID,
    GRUB_DISK_DEVICE_XEN,
    GRUB_DISK_DEVICE_OBDISK_ID,
  };

struct grub_disk;

struct grub_disk_memberlist;


typedef enum
  {
    GRUB_DISK_PULL_NONE,
    GRUB_DISK_PULL_REMOVABLE,
    GRUB_DISK_PULL_RESCAN,
    GRUB_DISK_PULL_MAX
  } grub_disk_pull_t;

typedef int (*grub_disk_dev_iterate_hook_t) (const char *name, void *data);


struct grub_disk_dev
{

  const char *name;


  enum grub_disk_dev_id id;


  int (*disk_iterate) (grub_disk_dev_iterate_hook_t hook, void *hook_data,
    grub_disk_pull_t pull);


  grub_err_t (*disk_open) (const char *name, struct grub_disk *disk);


  void (*disk_close) (struct grub_disk *disk);


  grub_err_t (*disk_read) (struct grub_disk *disk, grub_disk_addr_t sector,
        grub_size_t size, char *buf);


  grub_err_t (*disk_write) (struct grub_disk *disk, grub_disk_addr_t sector,
         grub_size_t size, const char *buf);


  struct grub_disk_memberlist *(*disk_memberlist) (struct grub_disk *disk);
  const char * (*disk_raidname) (struct grub_disk *disk);



  struct grub_disk_dev *next;
};
typedef struct grub_disk_dev *grub_disk_dev_t;

extern grub_disk_dev_t grub_disk_dev_list;

struct grub_partition;

typedef void (*grub_disk_read_hook_t) (grub_disk_addr_t sector,
           unsigned offset, unsigned length,
           void *data);


struct grub_disk
{

  const char *name;


  grub_disk_dev_t dev;


  grub_uint64_t total_sectors;


  unsigned int log_sector_size;


  unsigned int max_agglomerate;


  unsigned long id;


  struct grub_partition *partition;



  grub_disk_read_hook_t read_hook;


  void *read_hook_data;


  void *data;
};
typedef struct grub_disk *grub_disk_t;


struct grub_disk_memberlist
{
  grub_disk_t disk;
  struct grub_disk_memberlist *next;
};
typedef struct grub_disk_memberlist *grub_disk_memberlist_t;
# 178 "./include/grub/disk.h"
static inline grub_disk_addr_t
grub_disk_from_native_sector (grub_disk_t disk, grub_disk_addr_t sector)
{
  return sector << (disk->log_sector_size - 9);
}


void grub_disk_cache_invalidate_all (void);

void grub_disk_dev_register (grub_disk_dev_t dev);
void grub_disk_dev_unregister (grub_disk_dev_t dev);
static inline int
grub_disk_dev_iterate (grub_disk_dev_iterate_hook_t hook, void *hook_data)
{
  grub_disk_dev_t p;
  grub_disk_pull_t pull;

  for (pull = 0; pull < GRUB_DISK_PULL_MAX; pull++)
    for (p = grub_disk_dev_list; p; p = p->next)
      if (p->disk_iterate && (p->disk_iterate) (hook, hook_data, pull))
 return 1;

  return 0;
}

grub_disk_t grub_disk_open (const char *name);
void grub_disk_close (grub_disk_t disk);
grub_err_t grub_disk_read (grub_disk_t disk,
     grub_disk_addr_t sector,
     grub_off_t offset,
     grub_size_t size,
     void *buf);
grub_err_t grub_disk_write (grub_disk_t disk,
       grub_disk_addr_t sector,
       grub_off_t offset,
       grub_size_t size,
       const void *buf);
extern grub_err_t (*grub_disk_write_weak) (grub_disk_t disk,
             grub_disk_addr_t sector,
             grub_off_t offset,
             grub_size_t size,
             const void *buf);


grub_uint64_t grub_disk_get_size (grub_disk_t disk);






extern void (* grub_disk_firmware_fini) (void);
extern int grub_disk_firmware_is_tainted;

static inline void
grub_stop_disk_firmware (void)
{

  grub_disk_firmware_is_tainted = 1;
  if (grub_disk_firmware_fini)
    {
      grub_disk_firmware_fini ();
      grub_disk_firmware_fini = 
# 240 "./include/grub/disk.h" 3 4
                               ((void *)0)
# 240 "./include/grub/disk.h"
                                   ;
    }
}


struct grub_disk_cache
{
  enum grub_disk_dev_id dev_id;
  unsigned long disk_id;
  grub_disk_addr_t sector;
  char *data;
  int lock;
};

extern struct grub_disk_cache grub_disk_cache_table[1021];


void grub_lvm_init (void);
void grub_ldm_init (void);
void grub_mdraid09_init (void);
void grub_mdraid1x_init (void);
void grub_diskfilter_init (void);
void grub_lvm_fini (void);
void grub_ldm_fini (void);
void grub_mdraid09_fini (void);
void grub_mdraid1x_fini (void);
void grub_diskfilter_fini (void);
# 28 "grub-core/disk/host.c" 2

# 1 "./include/grub/emu/hostdisk.h" 1
# 24 "./include/grub/emu/hostdisk.h"
# 1 "./include/grub/partition.h" 1
# 25 "./include/grub/partition.h"
struct grub_disk;

typedef struct grub_partition *grub_partition_t;


typedef enum
{
  GRUB_EMBED_PCBIOS
} grub_embed_type_t;


typedef int (*grub_partition_iterate_hook_t) (struct grub_disk *disk,
           const grub_partition_t partition,
           void *data);


struct grub_partition_map
{

  struct grub_partition_map *next;
  struct grub_partition_map **prev;


  const char *name;


  grub_err_t (*iterate) (struct grub_disk *disk,
    grub_partition_iterate_hook_t hook, void *hook_data);


  grub_err_t (*embed) (struct grub_disk *disk, unsigned int *nsectors,
         unsigned int max_nsectors,
         grub_embed_type_t embed_type,
         grub_disk_addr_t **sectors);

};
typedef struct grub_partition_map *grub_partition_map_t;


struct grub_partition
{

  int number;


  grub_disk_addr_t start;


  grub_uint64_t len;


  grub_disk_addr_t offset;


  int index;


  struct grub_partition *parent;


  grub_partition_map_t partmap;



  grub_uint8_t msdostype;
};

grub_partition_t grub_partition_probe (struct grub_disk *disk,
          const char *str);
int grub_partition_iterate (struct grub_disk *disk,
      grub_partition_iterate_hook_t hook,
      void *hook_data);
char *grub_partition_get_name (const grub_partition_t partition);


extern grub_partition_map_t grub_partition_map_list;


static inline void
grub_partition_map_register (grub_partition_map_t partmap)
{
  grub_list_push ((((char *) &(*&grub_partition_map_list)->next == (char *) &((grub_list_t) (*&grub_partition_map_list))->next) && ((char *) &(*&grub_partition_map_list)->prev == (char *) &((grub_list_t) (*&grub_partition_map_list))->prev) ? (grub_list_t *) (void *) &grub_partition_map_list : (grub_list_t *) grub_bad_type_cast_real(106, "util/grub-fstest.c")),
    (((char *) &(partmap)->next == (char *) &((grub_list_t) (partmap))->next) && ((char *) &(partmap)->prev == (char *) &((grub_list_t) (partmap))->prev) ? (grub_list_t) partmap : (grub_list_t) grub_bad_type_cast_real(107, "util/grub-fstest.c")));
}


static inline void
grub_partition_map_unregister (grub_partition_map_t partmap)
{
  grub_list_remove ((((char *) &(partmap)->next == (char *) &((grub_list_t) (partmap))->next) && ((char *) &(partmap)->prev == (char *) &((grub_list_t) (partmap))->prev) ? (grub_list_t) partmap : (grub_list_t) grub_bad_type_cast_real(114, "util/grub-fstest.c")));
}




static inline grub_disk_addr_t
grub_partition_get_start (const grub_partition_t p)
{
  grub_partition_t part;
  grub_uint64_t part_start = 0;

  for (part = p; part; part = part->parent)
    part_start += part->start;

  return part_start;
}

static inline grub_uint64_t
grub_partition_get_len (const grub_partition_t p)
{
  return p->len;
}
# 25 "./include/grub/emu/hostdisk.h" 2
# 1 "/usr/include/sys/types.h" 1 3 4
# 27 "/usr/include/sys/types.h" 3 4


# 1 "/usr/include/bits/types.h" 1 3 4
# 27 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 28 "/usr/include/bits/types.h" 2 3 4
# 1 "/usr/include/bits/timesize.h" 1 3 4
# 29 "/usr/include/bits/types.h" 2 3 4



# 31 "/usr/include/bits/types.h" 3 4
typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;






typedef __int8_t __int_least8_t;
typedef __uint8_t __uint_least8_t;
typedef __int16_t __int_least16_t;
typedef __uint16_t __uint_least16_t;
typedef __int32_t __int_least32_t;
typedef __uint32_t __uint_least32_t;
typedef __int64_t __int_least64_t;
typedef __uint64_t __uint_least64_t;



typedef long int __quad_t;
typedef unsigned long int __u_quad_t;







typedef long int __intmax_t;
typedef unsigned long int __uintmax_t;
# 141 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/typesizes.h" 1 3 4
# 142 "/usr/include/bits/types.h" 2 3 4
# 1 "/usr/include/bits/time64.h" 1 3 4
# 143 "/usr/include/bits/types.h" 2 3 4


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;
typedef long int __suseconds64_t;

typedef int __daddr_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;


typedef long int __fsword_t;

typedef long int __ssize_t;


typedef long int __syscall_slong_t;

typedef unsigned long int __syscall_ulong_t;



typedef __off64_t __loff_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;




typedef int __sig_atomic_t;
# 30 "/usr/include/sys/types.h" 2 3 4



typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;


typedef __loff_t loff_t;






typedef __ino64_t ino_t;




typedef __ino64_t ino64_t;




typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;







typedef __off64_t off_t;




typedef __off64_t off64_t;




typedef __pid_t pid_t;





typedef __id_t id_t;




typedef __ssize_t ssize_t;





typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;




# 1 "/usr/include/bits/types/clock_t.h" 1 3 4






typedef __clock_t clock_t;
# 127 "/usr/include/sys/types.h" 2 3 4

# 1 "/usr/include/bits/types/clockid_t.h" 1 3 4






typedef __clockid_t clockid_t;
# 129 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/bits/types/time_t.h" 1 3 4






typedef __time_t time_t;
# 130 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/bits/types/timer_t.h" 1 3 4






typedef __timer_t timer_t;
# 131 "/usr/include/sys/types.h" 2 3 4



typedef __useconds_t useconds_t;



typedef __suseconds_t suseconds_t;





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 209 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 145 "/usr/include/sys/types.h" 2 3 4



typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;




# 1 "/usr/include/bits/stdint-intn.h" 1 3 4
# 24 "/usr/include/bits/stdint-intn.h" 3 4
typedef __int8_t int8_t;
typedef __int16_t int16_t;
typedef __int32_t int32_t;
typedef __int64_t int64_t;
# 156 "/usr/include/sys/types.h" 2 3 4


typedef __uint8_t u_int8_t;
typedef __uint16_t u_int16_t;
typedef __uint32_t u_int32_t;
typedef __uint64_t u_int64_t;


typedef int register_t __attribute__ ((__mode__ (__word__)));
# 176 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 24 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 35 "/usr/include/bits/endian.h" 3 4
# 1 "/usr/include/bits/endianness.h" 1 3 4
# 36 "/usr/include/bits/endian.h" 2 3 4
# 25 "/usr/include/endian.h" 2 3 4
# 35 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/byteswap.h" 1 3 4
# 33 "/usr/include/bits/byteswap.h" 3 4
static __inline __uint16_t
__bswap_16 (__uint16_t __bsx)
{

  return __builtin_bswap16 (__bsx);



}






static __inline __uint32_t
__bswap_32 (__uint32_t __bsx)
{

  return __builtin_bswap32 (__bsx);



}
# 69 "/usr/include/bits/byteswap.h" 3 4
__extension__ static __inline __uint64_t
__bswap_64 (__uint64_t __bsx)
{

  return __builtin_bswap64 (__bsx);



}
# 36 "/usr/include/endian.h" 2 3 4
# 1 "/usr/include/bits/uintn-identity.h" 1 3 4
# 32 "/usr/include/bits/uintn-identity.h" 3 4
static __inline __uint16_t
__uint16_identity (__uint16_t __x)
{
  return __x;
}

static __inline __uint32_t
__uint32_identity (__uint32_t __x)
{
  return __x;
}

static __inline __uint64_t
__uint64_identity (__uint64_t __x)
{
  return __x;
}
# 37 "/usr/include/endian.h" 2 3 4
# 177 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/select.h" 1 3 4
# 30 "/usr/include/sys/select.h" 3 4
# 1 "/usr/include/bits/select.h" 1 3 4
# 31 "/usr/include/sys/select.h" 2 3 4


# 1 "/usr/include/bits/types/sigset_t.h" 1 3 4



# 1 "/usr/include/bits/types/__sigset_t.h" 1 3 4




typedef struct
{
  unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
} __sigset_t;
# 5 "/usr/include/bits/types/sigset_t.h" 2 3 4


typedef __sigset_t sigset_t;
# 34 "/usr/include/sys/select.h" 2 3 4



# 1 "/usr/include/bits/types/struct_timeval.h" 1 3 4







struct timeval
{
  __time_t tv_sec;
  __suseconds_t tv_usec;
};
# 38 "/usr/include/sys/select.h" 2 3 4

# 1 "/usr/include/bits/types/struct_timespec.h" 1 3 4
# 10 "/usr/include/bits/types/struct_timespec.h" 3 4
struct timespec
{
  __time_t tv_sec;



  __syscall_slong_t tv_nsec;
# 26 "/usr/include/bits/types/struct_timespec.h" 3 4
};
# 40 "/usr/include/sys/select.h" 2 3 4
# 49 "/usr/include/sys/select.h" 3 4
typedef long int __fd_mask;
# 59 "/usr/include/sys/select.h" 3 4
typedef struct
  {



    __fd_mask fds_bits[1024 / (8 * (int) sizeof (__fd_mask))];





  } fd_set;






typedef __fd_mask fd_mask;
# 91 "/usr/include/sys/select.h" 3 4

# 101 "/usr/include/sys/select.h" 3 4
extern int select (int __nfds, fd_set *__restrict __readfds,
     fd_set *__restrict __writefds,
     fd_set *__restrict __exceptfds,
     struct timeval *__restrict __timeout);
# 113 "/usr/include/sys/select.h" 3 4
extern int pselect (int __nfds, fd_set *__restrict __readfds,
      fd_set *__restrict __writefds,
      fd_set *__restrict __exceptfds,
      const struct timespec *__restrict __timeout,
      const __sigset_t *__restrict __sigmask);
# 126 "/usr/include/sys/select.h" 3 4

# 180 "/usr/include/sys/types.h" 2 3 4





typedef __blksize_t blksize_t;
# 205 "/usr/include/sys/types.h" 3 4
typedef __blkcnt64_t blkcnt_t;



typedef __fsblkcnt64_t fsblkcnt_t;



typedef __fsfilcnt64_t fsfilcnt_t;





typedef __blkcnt64_t blkcnt64_t;
typedef __fsblkcnt64_t fsblkcnt64_t;
typedef __fsfilcnt64_t fsfilcnt64_t;





# 1 "/usr/include/bits/pthreadtypes.h" 1 3 4
# 23 "/usr/include/bits/pthreadtypes.h" 3 4
# 1 "/usr/include/bits/thread-shared-types.h" 1 3 4
# 44 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/pthreadtypes-arch.h" 1 3 4
# 21 "/usr/include/bits/pthreadtypes-arch.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 22 "/usr/include/bits/pthreadtypes-arch.h" 2 3 4
# 45 "/usr/include/bits/thread-shared-types.h" 2 3 4




typedef struct __pthread_internal_list
{
  struct __pthread_internal_list *__prev;
  struct __pthread_internal_list *__next;
} __pthread_list_t;

typedef struct __pthread_internal_slist
{
  struct __pthread_internal_slist *__next;
} __pthread_slist_t;
# 74 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/struct_mutex.h" 1 3 4
# 22 "/usr/include/bits/struct_mutex.h" 3 4
struct __pthread_mutex_s
{
  int __lock;
  unsigned int __count;
  int __owner;

  unsigned int __nusers;



  int __kind;

  short __spins;
  short __elision;
  __pthread_list_t __list;
# 53 "/usr/include/bits/struct_mutex.h" 3 4
};
# 75 "/usr/include/bits/thread-shared-types.h" 2 3 4
# 87 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/struct_rwlock.h" 1 3 4
# 23 "/usr/include/bits/struct_rwlock.h" 3 4
struct __pthread_rwlock_arch_t
{
  unsigned int __readers;
  unsigned int __writers;
  unsigned int __wrphase_futex;
  unsigned int __writers_futex;
  unsigned int __pad3;
  unsigned int __pad4;

  int __cur_writer;
  int __shared;
  signed char __rwelision;




  unsigned char __pad1[7];


  unsigned long int __pad2;


  unsigned int __flags;
# 55 "/usr/include/bits/struct_rwlock.h" 3 4
};
# 88 "/usr/include/bits/thread-shared-types.h" 2 3 4




struct __pthread_cond_s
{
  __extension__ union
  {
    __extension__ unsigned long long int __wseq;
    struct
    {
      unsigned int __low;
      unsigned int __high;
    } __wseq32;
  };
  __extension__ union
  {
    __extension__ unsigned long long int __g1_start;
    struct
    {
      unsigned int __low;
      unsigned int __high;
    } __g1_start32;
  };
  unsigned int __g_refs[2] ;
  unsigned int __g_size[2];
  unsigned int __g1_orig_size;
  unsigned int __wrefs;
  unsigned int __g_signals[2];
};

typedef unsigned int __tss_t;
typedef unsigned long int __thrd_t;

typedef struct
{
  int __data ;
} __once_flag;
# 24 "/usr/include/bits/pthreadtypes.h" 2 3 4



typedef unsigned long int pthread_t;




typedef union
{
  char __size[4];
  int __align;
} pthread_mutexattr_t;




typedef union
{
  char __size[4];
  int __align;
} pthread_condattr_t;



typedef unsigned int pthread_key_t;



typedef int pthread_once_t;


union pthread_attr_t
{
  char __size[56];
  long int __align;
};

typedef union pthread_attr_t pthread_attr_t;




typedef union
{
  struct __pthread_mutex_s __data;
  char __size[40];
  long int __align;
} pthread_mutex_t;


typedef union
{
  struct __pthread_cond_s __data;
  char __size[48];
  __extension__ long long int __align;
} pthread_cond_t;





typedef union
{
  struct __pthread_rwlock_arch_t __data;
  char __size[56];
  long int __align;
} pthread_rwlock_t;

typedef union
{
  char __size[8];
  long int __align;
} pthread_rwlockattr_t;





typedef volatile int pthread_spinlock_t;




typedef union
{
  char __size[32];
  long int __align;
} pthread_barrier_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_barrierattr_t;
# 228 "/usr/include/sys/types.h" 2 3 4



# 26 "./include/grub/emu/hostdisk.h" 2
# 1 "./include/grub/emu/hostfile.h" 1
# 25 "./include/grub/emu/hostfile.h"
# 1 "./include/grub/osdep/hostfile.h" 1





# 1 "./include/grub/osdep/hostfile_unix.h" 1
# 22 "./include/grub/osdep/hostfile_unix.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/osdep/hostfile_unix.h" 2






# 1 "/usr/include/sys/stat.h" 1 3 4
# 99 "/usr/include/sys/stat.h" 3 4


# 1 "/usr/include/bits/stat.h" 1 3 4
# 46 "/usr/include/bits/stat.h" 3 4
struct stat
  {
    __dev_t st_dev;




    __ino_t st_ino;







    __nlink_t st_nlink;
    __mode_t st_mode;

    __uid_t st_uid;
    __gid_t st_gid;

    int __pad0;

    __dev_t st_rdev;




    __off_t st_size;



    __blksize_t st_blksize;

    __blkcnt_t st_blocks;
# 91 "/usr/include/bits/stat.h" 3 4
    struct timespec st_atim;
    struct timespec st_mtim;
    struct timespec st_ctim;
# 106 "/usr/include/bits/stat.h" 3 4
    __syscall_slong_t __glibc_reserved[3];
# 115 "/usr/include/bits/stat.h" 3 4
  };



struct stat64
  {
    __dev_t st_dev;

    __ino64_t st_ino;
    __nlink_t st_nlink;
    __mode_t st_mode;






    __uid_t st_uid;
    __gid_t st_gid;

    int __pad0;
    __dev_t st_rdev;
    __off_t st_size;





    __blksize_t st_blksize;
    __blkcnt64_t st_blocks;







    struct timespec st_atim;
    struct timespec st_mtim;
    struct timespec st_ctim;
# 164 "/usr/include/bits/stat.h" 3 4
    __syscall_slong_t __glibc_reserved[3];



  };
# 102 "/usr/include/sys/stat.h" 2 3 4
# 213 "/usr/include/sys/stat.h" 3 4
extern int stat (const char *__restrict __file, struct stat *__restrict __buf) __asm__ ("" "stat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (1, 2)));
extern int fstat (int __fd, struct stat *__buf) __asm__ ("" "fstat64") __attribute__ ((__nothrow__ , __leaf__))
     __attribute__ ((__nonnull__ (2)));






extern int stat64 (const char *__restrict __file,
     struct stat64 *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int fstat64 (int __fd, struct stat64 *__buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));
# 239 "/usr/include/sys/stat.h" 3 4
extern int fstatat (int __fd, const char *__restrict __file, struct stat *__restrict __buf, int __flag) __asm__ ("" "fstatat64") __attribute__ ((__nothrow__ , __leaf__))


                 __attribute__ ((__nonnull__ (2, 3)));






extern int fstatat64 (int __fd, const char *__restrict __file,
        struct stat64 *__restrict __buf, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
# 263 "/usr/include/sys/stat.h" 3 4
extern int lstat (const char *__restrict __file, struct stat *__restrict __buf) __asm__ ("" "lstat64") __attribute__ ((__nothrow__ , __leaf__))


     __attribute__ ((__nonnull__ (1, 2)));





extern int lstat64 (const char *__restrict __file,
      struct stat64 *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern int chmod (const char *__file, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int lchmod (const char *__file, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int fchmod (int __fd, __mode_t __mode) __attribute__ ((__nothrow__ , __leaf__));





extern int fchmodat (int __fd, const char *__file, __mode_t __mode,
       int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;






extern __mode_t umask (__mode_t __mask) __attribute__ ((__nothrow__ , __leaf__));




extern __mode_t getumask (void) __attribute__ ((__nothrow__ , __leaf__));



extern int mkdir (const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mkdirat (int __fd, const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));






extern int mknod (const char *__path, __mode_t __mode, __dev_t __dev)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mknodat (int __fd, const char *__path, __mode_t __mode,
      __dev_t __dev) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));





extern int mkfifo (const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int mkfifoat (int __fd, const char *__path, __mode_t __mode)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));





extern int utimensat (int __fd, const char *__path,
        const struct timespec __times[2],
        int __flags)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));




extern int futimens (int __fd, const struct timespec __times[2]) __attribute__ ((__nothrow__ , __leaf__));
# 406 "/usr/include/sys/stat.h" 3 4
extern int __fxstat (int __ver, int __fildes, struct stat *__stat_buf) __asm__ ("" "__fxstat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (3)));
extern int __xstat (int __ver, const char *__filename, struct stat *__stat_buf) __asm__ ("" "__xstat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (2, 3)));
extern int __lxstat (int __ver, const char *__filename, struct stat *__stat_buf) __asm__ ("" "__lxstat64") __attribute__ ((__nothrow__ , __leaf__))

     __attribute__ ((__nonnull__ (2, 3)));
extern int __fxstatat (int __ver, int __fildes, const char *__filename, struct stat *__stat_buf, int __flag) __asm__ ("" "__fxstatat64") __attribute__ ((__nothrow__ , __leaf__))


                    __attribute__ ((__nonnull__ (3, 4)));
# 428 "/usr/include/sys/stat.h" 3 4
extern int __fxstat64 (int __ver, int __fildes, struct stat64 *__stat_buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));
extern int __xstat64 (int __ver, const char *__filename,
        struct stat64 *__stat_buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
extern int __lxstat64 (int __ver, const char *__filename,
         struct stat64 *__stat_buf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));
extern int __fxstatat64 (int __ver, int __fildes, const char *__filename,
    struct stat64 *__stat_buf, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4)));

extern int __xmknod (int __ver, const char *__path, __mode_t __mode,
       __dev_t *__dev) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));

extern int __xmknodat (int __ver, int __fd, const char *__path,
         __mode_t __mode, __dev_t *__dev)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 5)));


# 1 "/usr/include/bits/statx.h" 1 3 4
# 31 "/usr/include/bits/statx.h" 3 4
# 1 "/usr/include/linux/stat.h" 1 3 4




# 1 "/usr/include/linux/types.h" 1 3 4




# 1 "/usr/include/asm/types.h" 1 3 4
# 1 "/usr/include/asm-generic/types.h" 1 3 4






# 1 "/usr/include/asm-generic/int-ll64.h" 1 3 4
# 12 "/usr/include/asm-generic/int-ll64.h" 3 4
# 1 "/usr/include/asm/bitsperlong.h" 1 3 4
# 11 "/usr/include/asm/bitsperlong.h" 3 4
# 1 "/usr/include/asm-generic/bitsperlong.h" 1 3 4
# 12 "/usr/include/asm/bitsperlong.h" 2 3 4
# 13 "/usr/include/asm-generic/int-ll64.h" 2 3 4







typedef __signed__ char __s8;
typedef unsigned char __u8;

typedef __signed__ short __s16;
typedef unsigned short __u16;

typedef __signed__ int __s32;
typedef unsigned int __u32;


__extension__ typedef __signed__ long long __s64;
__extension__ typedef unsigned long long __u64;
# 8 "/usr/include/asm-generic/types.h" 2 3 4
# 2 "/usr/include/asm/types.h" 2 3 4
# 6 "/usr/include/linux/types.h" 2 3 4



# 1 "/usr/include/linux/posix_types.h" 1 3 4




# 1 "/usr/include/linux/stddef.h" 1 3 4
# 6 "/usr/include/linux/posix_types.h" 2 3 4
# 25 "/usr/include/linux/posix_types.h" 3 4
typedef struct {
 unsigned long fds_bits[1024 / (8 * sizeof(long))];
} __kernel_fd_set;


typedef void (*__kernel_sighandler_t)(int);


typedef int __kernel_key_t;
typedef int __kernel_mqd_t;

# 1 "/usr/include/asm/posix_types.h" 1 3 4






# 1 "/usr/include/asm/posix_types_64.h" 1 3 4
# 11 "/usr/include/asm/posix_types_64.h" 3 4
typedef unsigned short __kernel_old_uid_t;
typedef unsigned short __kernel_old_gid_t;


typedef unsigned long __kernel_old_dev_t;


# 1 "/usr/include/asm-generic/posix_types.h" 1 3 4
# 15 "/usr/include/asm-generic/posix_types.h" 3 4
typedef long __kernel_long_t;
typedef unsigned long __kernel_ulong_t;



typedef __kernel_ulong_t __kernel_ino_t;



typedef unsigned int __kernel_mode_t;



typedef int __kernel_pid_t;



typedef int __kernel_ipc_pid_t;



typedef unsigned int __kernel_uid_t;
typedef unsigned int __kernel_gid_t;



typedef __kernel_long_t __kernel_suseconds_t;



typedef int __kernel_daddr_t;



typedef unsigned int __kernel_uid32_t;
typedef unsigned int __kernel_gid32_t;
# 72 "/usr/include/asm-generic/posix_types.h" 3 4
typedef __kernel_ulong_t __kernel_size_t;
typedef __kernel_long_t __kernel_ssize_t;
typedef __kernel_long_t __kernel_ptrdiff_t;




typedef struct {
 int val[2];
} __kernel_fsid_t;





typedef __kernel_long_t __kernel_off_t;
typedef long long __kernel_loff_t;
typedef __kernel_long_t __kernel_old_time_t;
typedef __kernel_long_t __kernel_time_t;
typedef long long __kernel_time64_t;
typedef __kernel_long_t __kernel_clock_t;
typedef int __kernel_timer_t;
typedef int __kernel_clockid_t;
typedef char * __kernel_caddr_t;
typedef unsigned short __kernel_uid16_t;
typedef unsigned short __kernel_gid16_t;
# 19 "/usr/include/asm/posix_types_64.h" 2 3 4
# 8 "/usr/include/asm/posix_types.h" 2 3 4
# 37 "/usr/include/linux/posix_types.h" 2 3 4
# 10 "/usr/include/linux/types.h" 2 3 4
# 24 "/usr/include/linux/types.h" 3 4
typedef __u16 __le16;
typedef __u16 __be16;
typedef __u32 __le32;
typedef __u32 __be32;
typedef __u64 __le64;
typedef __u64 __be64;

typedef __u16 __sum16;
typedef __u32 __wsum;
# 47 "/usr/include/linux/types.h" 3 4
typedef unsigned __poll_t;
# 6 "/usr/include/linux/stat.h" 2 3 4
# 56 "/usr/include/linux/stat.h" 3 4
struct statx_timestamp {
 __s64 tv_sec;
 __u32 tv_nsec;
 __s32 __reserved;
};
# 99 "/usr/include/linux/stat.h" 3 4
struct statx {

 __u32 stx_mask;
 __u32 stx_blksize;
 __u64 stx_attributes;

 __u32 stx_nlink;
 __u32 stx_uid;
 __u32 stx_gid;
 __u16 stx_mode;
 __u16 __spare0[1];

 __u64 stx_ino;
 __u64 stx_size;
 __u64 stx_blocks;
 __u64 stx_attributes_mask;

 struct statx_timestamp stx_atime;
 struct statx_timestamp stx_btime;
 struct statx_timestamp stx_ctime;
 struct statx_timestamp stx_mtime;

 __u32 stx_rdev_major;
 __u32 stx_rdev_minor;
 __u32 stx_dev_major;
 __u32 stx_dev_minor;

 __u64 stx_mnt_id;
 __u64 __spare2;

 __u64 __spare3[12];

};
# 32 "/usr/include/bits/statx.h" 2 3 4







# 1 "/usr/include/bits/statx-generic.h" 1 3 4
# 25 "/usr/include/bits/statx-generic.h" 3 4
# 1 "/usr/include/bits/types/struct_statx_timestamp.h" 1 3 4
# 26 "/usr/include/bits/statx-generic.h" 2 3 4
# 1 "/usr/include/bits/types/struct_statx.h" 1 3 4
# 27 "/usr/include/bits/statx-generic.h" 2 3 4
# 54 "/usr/include/bits/statx-generic.h" 3 4



int statx (int __dirfd, const char *__restrict __path, int __flags,
           unsigned int __mask, struct statx *__restrict __buf)
  __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 5)));


# 40 "/usr/include/bits/statx.h" 2 3 4
# 447 "/usr/include/sys/stat.h" 2 3 4
# 534 "/usr/include/sys/stat.h" 3 4

# 30 "./include/grub/osdep/hostfile_unix.h" 2
# 1 "/usr/include/fcntl.h" 1 3 4
# 28 "/usr/include/fcntl.h" 3 4







# 1 "/usr/include/bits/fcntl.h" 1 3 4
# 35 "/usr/include/bits/fcntl.h" 3 4
struct flock
  {
    short int l_type;
    short int l_whence;




    __off64_t l_start;
    __off64_t l_len;

    __pid_t l_pid;
  };


struct flock64
  {
    short int l_type;
    short int l_whence;
    __off64_t l_start;
    __off64_t l_len;
    __pid_t l_pid;
  };



# 1 "/usr/include/bits/fcntl-linux.h" 1 3 4
# 38 "/usr/include/bits/fcntl-linux.h" 3 4
# 1 "/usr/include/bits/types/struct_iovec.h" 1 3 4
# 23 "/usr/include/bits/types/struct_iovec.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 24 "/usr/include/bits/types/struct_iovec.h" 2 3 4


struct iovec
  {
    void *iov_base;
    size_t iov_len;
  };
# 39 "/usr/include/bits/fcntl-linux.h" 2 3 4
# 265 "/usr/include/bits/fcntl-linux.h" 3 4
enum __pid_type
  {
    F_OWNER_TID = 0,
    F_OWNER_PID,
    F_OWNER_PGRP,
    F_OWNER_GID = F_OWNER_PGRP
  };


struct f_owner_ex
  {
    enum __pid_type type;
    __pid_t pid;
  };
# 354 "/usr/include/bits/fcntl-linux.h" 3 4
# 1 "/usr/include/linux/falloc.h" 1 3 4
# 355 "/usr/include/bits/fcntl-linux.h" 2 3 4



struct file_handle
{
  unsigned int handle_bytes;
  int handle_type;

  unsigned char f_handle[0];
};










extern __ssize_t readahead (int __fd, __off64_t __offset, size_t __count)
    __attribute__ ((__nothrow__ , __leaf__));






extern int sync_file_range (int __fd, __off64_t __offset, __off64_t __count,
       unsigned int __flags);






extern __ssize_t vmsplice (int __fdout, const struct iovec *__iov,
      size_t __count, unsigned int __flags);





extern __ssize_t splice (int __fdin, __off64_t *__offin, int __fdout,
    __off64_t *__offout, size_t __len,
    unsigned int __flags);





extern __ssize_t tee (int __fdin, int __fdout, size_t __len,
        unsigned int __flags);
# 417 "/usr/include/bits/fcntl-linux.h" 3 4
extern int fallocate (int __fd, int __mode, __off64_t __offset, __off64_t __len) __asm__ ("" "fallocate64")

                     ;





extern int fallocate64 (int __fd, int __mode, __off64_t __offset,
   __off64_t __len);




extern int name_to_handle_at (int __dfd, const char *__name,
         struct file_handle *__handle, int *__mnt_id,
         int __flags) __attribute__ ((__nothrow__ , __leaf__));





extern int open_by_handle_at (int __mountdirfd, struct file_handle *__handle,
         int __flags);




# 62 "/usr/include/bits/fcntl.h" 2 3 4
# 36 "/usr/include/fcntl.h" 2 3 4
# 78 "/usr/include/fcntl.h" 3 4
# 1 "/usr/include/bits/stat.h" 1 3 4
# 79 "/usr/include/fcntl.h" 2 3 4
# 179 "/usr/include/fcntl.h" 3 4
extern int fcntl (int __fd, int __cmd, ...) __asm__ ("" "fcntl64");





extern int fcntl64 (int __fd, int __cmd, ...);
# 199 "/usr/include/fcntl.h" 3 4
extern int open (const char *__file, int __oflag, ...) __asm__ ("" "open64")
     __attribute__ ((__nonnull__ (1)));





extern int open64 (const char *__file, int __oflag, ...) __attribute__ ((__nonnull__ (1)));
# 224 "/usr/include/fcntl.h" 3 4
extern int openat (int __fd, const char *__file, int __oflag, ...) __asm__ ("" "openat64")
                    __attribute__ ((__nonnull__ (2)));





extern int openat64 (int __fd, const char *__file, int __oflag, ...)
     __attribute__ ((__nonnull__ (2)));
# 245 "/usr/include/fcntl.h" 3 4
extern int creat (const char *__file, mode_t __mode) __asm__ ("" "creat64")
                  __attribute__ ((__nonnull__ (1)));





extern int creat64 (const char *__file, mode_t __mode) __attribute__ ((__nonnull__ (1)));
# 274 "/usr/include/fcntl.h" 3 4
extern int lockf (int __fd, int __cmd, __off64_t __len) __asm__ ("" "lockf64");





extern int lockf64 (int __fd, int __cmd, off64_t __len);
# 292 "/usr/include/fcntl.h" 3 4
extern int posix_fadvise (int __fd, __off64_t __offset, __off64_t __len, int __advise) __asm__ ("" "posix_fadvise64") __attribute__ ((__nothrow__ , __leaf__))

                      ;





extern int posix_fadvise64 (int __fd, off64_t __offset, off64_t __len,
       int __advise) __attribute__ ((__nothrow__ , __leaf__));
# 313 "/usr/include/fcntl.h" 3 4
extern int posix_fallocate (int __fd, __off64_t __offset, __off64_t __len) __asm__ ("" "posix_fallocate64")

                           ;





extern int posix_fallocate64 (int __fd, off64_t __offset, off64_t __len);
# 332 "/usr/include/fcntl.h" 3 4

# 31 "./include/grub/osdep/hostfile_unix.h" 2
# 1 "/usr/include/dirent.h" 1 3 4
# 27 "/usr/include/dirent.h" 3 4

# 61 "/usr/include/dirent.h" 3 4
# 1 "/usr/include/bits/dirent.h" 1 3 4
# 22 "/usr/include/bits/dirent.h" 3 4
struct dirent
  {




    __ino64_t d_ino;
    __off64_t d_off;

    unsigned short int d_reclen;
    unsigned char d_type;
    char d_name[256];
  };


struct dirent64
  {
    __ino64_t d_ino;
    __off64_t d_off;
    unsigned short int d_reclen;
    unsigned char d_type;
    char d_name[256];
  };
# 62 "/usr/include/dirent.h" 2 3 4
# 97 "/usr/include/dirent.h" 3 4
enum
  {
    DT_UNKNOWN = 0,

    DT_FIFO = 1,

    DT_CHR = 2,

    DT_DIR = 4,

    DT_BLK = 6,

    DT_REG = 8,

    DT_LNK = 10,

    DT_SOCK = 12,

    DT_WHT = 14

  };
# 127 "/usr/include/dirent.h" 3 4
typedef struct __dirstream DIR;






extern DIR *opendir (const char *__name) __attribute__ ((__nonnull__ (1)));






extern DIR *fdopendir (int __fd);







extern int closedir (DIR *__dirp) __attribute__ ((__nonnull__ (1)));
# 165 "/usr/include/dirent.h" 3 4
extern struct dirent *readdir (DIR *__dirp) __asm__ ("" "readdir64")
     __attribute__ ((__nonnull__ (1)));






extern struct dirent64 *readdir64 (DIR *__dirp) __attribute__ ((__nonnull__ (1)));
# 189 "/usr/include/dirent.h" 3 4
extern int readdir_r (DIR *__restrict __dirp, struct dirent *__restrict __entry, struct dirent **__restrict __result) __asm__ ("" "readdir64_r")




  __attribute__ ((__nonnull__ (1, 2, 3))) __attribute__ ((__deprecated__));






extern int readdir64_r (DIR *__restrict __dirp,
   struct dirent64 *__restrict __entry,
   struct dirent64 **__restrict __result)
  __attribute__ ((__nonnull__ (1, 2, 3))) __attribute__ ((__deprecated__));




extern void rewinddir (DIR *__dirp) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern void seekdir (DIR *__dirp, long int __pos) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int telldir (DIR *__dirp) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int dirfd (DIR *__dirp) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 233 "/usr/include/dirent.h" 3 4
# 1 "/usr/include/bits/posix1_lim.h" 1 3 4
# 27 "/usr/include/bits/posix1_lim.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 28 "/usr/include/bits/posix1_lim.h" 2 3 4
# 161 "/usr/include/bits/posix1_lim.h" 3 4
# 1 "/usr/include/bits/local_lim.h" 1 3 4
# 38 "/usr/include/bits/local_lim.h" 3 4
# 1 "/usr/include/linux/limits.h" 1 3 4
# 39 "/usr/include/bits/local_lim.h" 2 3 4
# 162 "/usr/include/bits/posix1_lim.h" 2 3 4
# 234 "/usr/include/dirent.h" 2 3 4
# 245 "/usr/include/dirent.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 246 "/usr/include/dirent.h" 2 3 4
# 263 "/usr/include/dirent.h" 3 4
extern int scandir (const char *__restrict __dir, struct dirent ***__restrict __namelist, int (*__selector) (const struct dirent *), int (*__cmp) (const struct dirent **, const struct dirent **)) __asm__ ("" "scandir64")





                    __attribute__ ((__nonnull__ (1, 2)));
# 278 "/usr/include/dirent.h" 3 4
extern int scandir64 (const char *__restrict __dir,
        struct dirent64 ***__restrict __namelist,
        int (*__selector) (const struct dirent64 *),
        int (*__cmp) (const struct dirent64 **,
        const struct dirent64 **))
     __attribute__ ((__nonnull__ (1, 2)));
# 301 "/usr/include/dirent.h" 3 4
extern int scandirat (int __dfd, const char *__restrict __dir, struct dirent ***__restrict __namelist, int (*__selector) (const struct dirent *), int (*__cmp) (const struct dirent **, const struct dirent **)) __asm__ ("" "scandirat64")





                      __attribute__ ((__nonnull__ (2, 3)));







extern int scandirat64 (int __dfd, const char *__restrict __dir,
   struct dirent64 ***__restrict __namelist,
   int (*__selector) (const struct dirent64 *),
   int (*__cmp) (const struct dirent64 **,
          const struct dirent64 **))
     __attribute__ ((__nonnull__ (2, 3)));
# 330 "/usr/include/dirent.h" 3 4
extern int alphasort (const struct dirent **__e1, const struct dirent **__e2) __asm__ ("" "alphasort64") __attribute__ ((__nothrow__ , __leaf__))


                   __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));






extern int alphasort64 (const struct dirent64 **__e1,
   const struct dirent64 **__e2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));
# 359 "/usr/include/dirent.h" 3 4
extern __ssize_t getdirentries (int __fd, char *__restrict __buf, size_t __nbytes, __off64_t *__restrict __basep) __asm__ ("" "getdirentries64") __attribute__ ((__nothrow__ , __leaf__))



                      __attribute__ ((__nonnull__ (2, 4)));






extern __ssize_t getdirentries64 (int __fd, char *__restrict __buf,
      size_t __nbytes,
      __off64_t *__restrict __basep)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));
# 385 "/usr/include/dirent.h" 3 4
extern int versionsort (const struct dirent **__e1, const struct dirent **__e2) __asm__ ("" "versionsort64") __attribute__ ((__nothrow__ , __leaf__))



     __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));






extern int versionsort64 (const struct dirent64 **__e1,
     const struct dirent64 **__e2)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1, 2)));





# 1 "/usr/include/bits/dirent_ext.h" 1 3 4
# 23 "/usr/include/bits/dirent_ext.h" 3 4






extern __ssize_t getdents64 (int __fd, void *__buffer, size_t __length)
  __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



# 405 "/usr/include/dirent.h" 2 3 4
# 32 "./include/grub/osdep/hostfile_unix.h" 2
# 1 "/usr/include/unistd.h" 1 3 4
# 27 "/usr/include/unistd.h" 3 4

# 202 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/posix_opt.h" 1 3 4
# 203 "/usr/include/unistd.h" 2 3 4



# 1 "/usr/include/bits/environments.h" 1 3 4
# 22 "/usr/include/bits/environments.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 23 "/usr/include/bits/environments.h" 2 3 4
# 207 "/usr/include/unistd.h" 2 3 4
# 226 "/usr/include/unistd.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 227 "/usr/include/unistd.h" 2 3 4
# 267 "/usr/include/unistd.h" 3 4
typedef __intptr_t intptr_t;






typedef __socklen_t socklen_t;
# 287 "/usr/include/unistd.h" 3 4
extern int access (const char *__name, int __type) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int euidaccess (const char *__name, int __type)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int eaccess (const char *__name, int __type)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int faccessat (int __fd, const char *__file, int __type, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;
# 337 "/usr/include/unistd.h" 3 4
extern __off64_t lseek (int __fd, __off64_t __offset, int __whence) __asm__ ("" "lseek64") __attribute__ ((__nothrow__ , __leaf__))

             ;





extern __off64_t lseek64 (int __fd, __off64_t __offset, int __whence)
     __attribute__ ((__nothrow__ , __leaf__));






extern int close (int __fd);






extern ssize_t read (int __fd, void *__buf, size_t __nbytes)
    __attribute__ ((__access__ (__write_only__, 2, 3)));





extern ssize_t write (int __fd, const void *__buf, size_t __n)
    __attribute__ ((__access__ (__read_only__, 2, 3)));
# 393 "/usr/include/unistd.h" 3 4
extern ssize_t pread (int __fd, void *__buf, size_t __nbytes, __off64_t __offset) __asm__ ("" "pread64")


    __attribute__ ((__access__ (__write_only__, 2, 3)));
extern ssize_t pwrite (int __fd, const void *__buf, size_t __nbytes, __off64_t __offset) __asm__ ("" "pwrite64")


    __attribute__ ((__access__ (__read_only__, 2, 3)));
# 411 "/usr/include/unistd.h" 3 4
extern ssize_t pread64 (int __fd, void *__buf, size_t __nbytes,
   __off64_t __offset)
    __attribute__ ((__access__ (__write_only__, 2, 3)));


extern ssize_t pwrite64 (int __fd, const void *__buf, size_t __n,
    __off64_t __offset)
    __attribute__ ((__access__ (__read_only__, 2, 3)));







extern int pipe (int __pipedes[2]) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int pipe2 (int __pipedes[2], int __flags) __attribute__ ((__nothrow__ , __leaf__)) ;
# 441 "/usr/include/unistd.h" 3 4
extern unsigned int alarm (unsigned int __seconds) __attribute__ ((__nothrow__ , __leaf__));
# 453 "/usr/include/unistd.h" 3 4
extern unsigned int sleep (unsigned int __seconds);







extern __useconds_t ualarm (__useconds_t __value, __useconds_t __interval)
     __attribute__ ((__nothrow__ , __leaf__));






extern int usleep (__useconds_t __useconds);
# 478 "/usr/include/unistd.h" 3 4
extern int pause (void);



extern int chown (const char *__file, __uid_t __owner, __gid_t __group)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern int fchown (int __fd, __uid_t __owner, __gid_t __group) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int lchown (const char *__file, __uid_t __owner, __gid_t __group)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;






extern int fchownat (int __fd, const char *__file, __uid_t __owner,
       __gid_t __group, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;



extern int chdir (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern int fchdir (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;
# 520 "/usr/include/unistd.h" 3 4
extern char *getcwd (char *__buf, size_t __size) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 1, 2)));





extern char *get_current_dir_name (void) __attribute__ ((__nothrow__ , __leaf__));







extern char *getwd (char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__deprecated__))
    __attribute__ ((__access__ (__write_only__, 1)));




extern int dup (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;


extern int dup2 (int __fd, int __fd2) __attribute__ ((__nothrow__ , __leaf__));




extern int dup3 (int __fd, int __fd2, int __flags) __attribute__ ((__nothrow__ , __leaf__));



extern char **__environ;

extern char **environ;





extern int execve (const char *__path, char *const __argv[],
     char *const __envp[]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int fexecve (int __fd, char *const __argv[], char *const __envp[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));




extern int execv (const char *__path, char *const __argv[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execle (const char *__path, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execl (const char *__path, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execvp (const char *__file, char *const __argv[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int execlp (const char *__file, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int execvpe (const char *__file, char *const __argv[],
      char *const __envp[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern int nice (int __inc) __attribute__ ((__nothrow__ , __leaf__)) ;




extern void _exit (int __status) __attribute__ ((__noreturn__));





# 1 "/usr/include/bits/confname.h" 1 3 4
# 24 "/usr/include/bits/confname.h" 3 4
enum
  {
    _PC_LINK_MAX,

    _PC_MAX_CANON,

    _PC_MAX_INPUT,

    _PC_NAME_MAX,

    _PC_PATH_MAX,

    _PC_PIPE_BUF,

    _PC_CHOWN_RESTRICTED,

    _PC_NO_TRUNC,

    _PC_VDISABLE,

    _PC_SYNC_IO,

    _PC_ASYNC_IO,

    _PC_PRIO_IO,

    _PC_SOCK_MAXBUF,

    _PC_FILESIZEBITS,

    _PC_REC_INCR_XFER_SIZE,

    _PC_REC_MAX_XFER_SIZE,

    _PC_REC_MIN_XFER_SIZE,

    _PC_REC_XFER_ALIGN,

    _PC_ALLOC_SIZE_MIN,

    _PC_SYMLINK_MAX,

    _PC_2_SYMLINKS

  };


enum
  {
    _SC_ARG_MAX,

    _SC_CHILD_MAX,

    _SC_CLK_TCK,

    _SC_NGROUPS_MAX,

    _SC_OPEN_MAX,

    _SC_STREAM_MAX,

    _SC_TZNAME_MAX,

    _SC_JOB_CONTROL,

    _SC_SAVED_IDS,

    _SC_REALTIME_SIGNALS,

    _SC_PRIORITY_SCHEDULING,

    _SC_TIMERS,

    _SC_ASYNCHRONOUS_IO,

    _SC_PRIORITIZED_IO,

    _SC_SYNCHRONIZED_IO,

    _SC_FSYNC,

    _SC_MAPPED_FILES,

    _SC_MEMLOCK,

    _SC_MEMLOCK_RANGE,

    _SC_MEMORY_PROTECTION,

    _SC_MESSAGE_PASSING,

    _SC_SEMAPHORES,

    _SC_SHARED_MEMORY_OBJECTS,

    _SC_AIO_LISTIO_MAX,

    _SC_AIO_MAX,

    _SC_AIO_PRIO_DELTA_MAX,

    _SC_DELAYTIMER_MAX,

    _SC_MQ_OPEN_MAX,

    _SC_MQ_PRIO_MAX,

    _SC_VERSION,

    _SC_PAGESIZE,


    _SC_RTSIG_MAX,

    _SC_SEM_NSEMS_MAX,

    _SC_SEM_VALUE_MAX,

    _SC_SIGQUEUE_MAX,

    _SC_TIMER_MAX,




    _SC_BC_BASE_MAX,

    _SC_BC_DIM_MAX,

    _SC_BC_SCALE_MAX,

    _SC_BC_STRING_MAX,

    _SC_COLL_WEIGHTS_MAX,

    _SC_EQUIV_CLASS_MAX,

    _SC_EXPR_NEST_MAX,

    _SC_LINE_MAX,

    _SC_RE_DUP_MAX,

    _SC_CHARCLASS_NAME_MAX,


    _SC_2_VERSION,

    _SC_2_C_BIND,

    _SC_2_C_DEV,

    _SC_2_FORT_DEV,

    _SC_2_FORT_RUN,

    _SC_2_SW_DEV,

    _SC_2_LOCALEDEF,


    _SC_PII,

    _SC_PII_XTI,

    _SC_PII_SOCKET,

    _SC_PII_INTERNET,

    _SC_PII_OSI,

    _SC_POLL,

    _SC_SELECT,

    _SC_UIO_MAXIOV,

    _SC_IOV_MAX = _SC_UIO_MAXIOV,

    _SC_PII_INTERNET_STREAM,

    _SC_PII_INTERNET_DGRAM,

    _SC_PII_OSI_COTS,

    _SC_PII_OSI_CLTS,

    _SC_PII_OSI_M,

    _SC_T_IOV_MAX,



    _SC_THREADS,

    _SC_THREAD_SAFE_FUNCTIONS,

    _SC_GETGR_R_SIZE_MAX,

    _SC_GETPW_R_SIZE_MAX,

    _SC_LOGIN_NAME_MAX,

    _SC_TTY_NAME_MAX,

    _SC_THREAD_DESTRUCTOR_ITERATIONS,

    _SC_THREAD_KEYS_MAX,

    _SC_THREAD_STACK_MIN,

    _SC_THREAD_THREADS_MAX,

    _SC_THREAD_ATTR_STACKADDR,

    _SC_THREAD_ATTR_STACKSIZE,

    _SC_THREAD_PRIORITY_SCHEDULING,

    _SC_THREAD_PRIO_INHERIT,

    _SC_THREAD_PRIO_PROTECT,

    _SC_THREAD_PROCESS_SHARED,


    _SC_NPROCESSORS_CONF,

    _SC_NPROCESSORS_ONLN,

    _SC_PHYS_PAGES,

    _SC_AVPHYS_PAGES,

    _SC_ATEXIT_MAX,

    _SC_PASS_MAX,


    _SC_XOPEN_VERSION,

    _SC_XOPEN_XCU_VERSION,

    _SC_XOPEN_UNIX,

    _SC_XOPEN_CRYPT,

    _SC_XOPEN_ENH_I18N,

    _SC_XOPEN_SHM,


    _SC_2_CHAR_TERM,

    _SC_2_C_VERSION,

    _SC_2_UPE,


    _SC_XOPEN_XPG2,

    _SC_XOPEN_XPG3,

    _SC_XOPEN_XPG4,


    _SC_CHAR_BIT,

    _SC_CHAR_MAX,

    _SC_CHAR_MIN,

    _SC_INT_MAX,

    _SC_INT_MIN,

    _SC_LONG_BIT,

    _SC_WORD_BIT,

    _SC_MB_LEN_MAX,

    _SC_NZERO,

    _SC_SSIZE_MAX,

    _SC_SCHAR_MAX,

    _SC_SCHAR_MIN,

    _SC_SHRT_MAX,

    _SC_SHRT_MIN,

    _SC_UCHAR_MAX,

    _SC_UINT_MAX,

    _SC_ULONG_MAX,

    _SC_USHRT_MAX,


    _SC_NL_ARGMAX,

    _SC_NL_LANGMAX,

    _SC_NL_MSGMAX,

    _SC_NL_NMAX,

    _SC_NL_SETMAX,

    _SC_NL_TEXTMAX,


    _SC_XBS5_ILP32_OFF32,

    _SC_XBS5_ILP32_OFFBIG,

    _SC_XBS5_LP64_OFF64,

    _SC_XBS5_LPBIG_OFFBIG,


    _SC_XOPEN_LEGACY,

    _SC_XOPEN_REALTIME,

    _SC_XOPEN_REALTIME_THREADS,


    _SC_ADVISORY_INFO,

    _SC_BARRIERS,

    _SC_BASE,

    _SC_C_LANG_SUPPORT,

    _SC_C_LANG_SUPPORT_R,

    _SC_CLOCK_SELECTION,

    _SC_CPUTIME,

    _SC_THREAD_CPUTIME,

    _SC_DEVICE_IO,

    _SC_DEVICE_SPECIFIC,

    _SC_DEVICE_SPECIFIC_R,

    _SC_FD_MGMT,

    _SC_FIFO,

    _SC_PIPE,

    _SC_FILE_ATTRIBUTES,

    _SC_FILE_LOCKING,

    _SC_FILE_SYSTEM,

    _SC_MONOTONIC_CLOCK,

    _SC_MULTI_PROCESS,

    _SC_SINGLE_PROCESS,

    _SC_NETWORKING,

    _SC_READER_WRITER_LOCKS,

    _SC_SPIN_LOCKS,

    _SC_REGEXP,

    _SC_REGEX_VERSION,

    _SC_SHELL,

    _SC_SIGNALS,

    _SC_SPAWN,

    _SC_SPORADIC_SERVER,

    _SC_THREAD_SPORADIC_SERVER,

    _SC_SYSTEM_DATABASE,

    _SC_SYSTEM_DATABASE_R,

    _SC_TIMEOUTS,

    _SC_TYPED_MEMORY_OBJECTS,

    _SC_USER_GROUPS,

    _SC_USER_GROUPS_R,

    _SC_2_PBS,

    _SC_2_PBS_ACCOUNTING,

    _SC_2_PBS_LOCATE,

    _SC_2_PBS_MESSAGE,

    _SC_2_PBS_TRACK,

    _SC_SYMLOOP_MAX,

    _SC_STREAMS,

    _SC_2_PBS_CHECKPOINT,


    _SC_V6_ILP32_OFF32,

    _SC_V6_ILP32_OFFBIG,

    _SC_V6_LP64_OFF64,

    _SC_V6_LPBIG_OFFBIG,


    _SC_HOST_NAME_MAX,

    _SC_TRACE,

    _SC_TRACE_EVENT_FILTER,

    _SC_TRACE_INHERIT,

    _SC_TRACE_LOG,


    _SC_LEVEL1_ICACHE_SIZE,

    _SC_LEVEL1_ICACHE_ASSOC,

    _SC_LEVEL1_ICACHE_LINESIZE,

    _SC_LEVEL1_DCACHE_SIZE,

    _SC_LEVEL1_DCACHE_ASSOC,

    _SC_LEVEL1_DCACHE_LINESIZE,

    _SC_LEVEL2_CACHE_SIZE,

    _SC_LEVEL2_CACHE_ASSOC,

    _SC_LEVEL2_CACHE_LINESIZE,

    _SC_LEVEL3_CACHE_SIZE,

    _SC_LEVEL3_CACHE_ASSOC,

    _SC_LEVEL3_CACHE_LINESIZE,

    _SC_LEVEL4_CACHE_SIZE,

    _SC_LEVEL4_CACHE_ASSOC,

    _SC_LEVEL4_CACHE_LINESIZE,



    _SC_IPV6 = _SC_LEVEL1_ICACHE_SIZE + 50,

    _SC_RAW_SOCKETS,


    _SC_V7_ILP32_OFF32,

    _SC_V7_ILP32_OFFBIG,

    _SC_V7_LP64_OFF64,

    _SC_V7_LPBIG_OFFBIG,


    _SC_SS_REPL_MAX,


    _SC_TRACE_EVENT_NAME_MAX,

    _SC_TRACE_NAME_MAX,

    _SC_TRACE_SYS_MAX,

    _SC_TRACE_USER_EVENT_MAX,


    _SC_XOPEN_STREAMS,


    _SC_THREAD_ROBUST_PRIO_INHERIT,

    _SC_THREAD_ROBUST_PRIO_PROTECT

  };


enum
  {
    _CS_PATH,


    _CS_V6_WIDTH_RESTRICTED_ENVS,



    _CS_GNU_LIBC_VERSION,

    _CS_GNU_LIBPTHREAD_VERSION,


    _CS_V5_WIDTH_RESTRICTED_ENVS,



    _CS_V7_WIDTH_RESTRICTED_ENVS,



    _CS_LFS_CFLAGS = 1000,

    _CS_LFS_LDFLAGS,

    _CS_LFS_LIBS,

    _CS_LFS_LINTFLAGS,

    _CS_LFS64_CFLAGS,

    _CS_LFS64_LDFLAGS,

    _CS_LFS64_LIBS,

    _CS_LFS64_LINTFLAGS,


    _CS_XBS5_ILP32_OFF32_CFLAGS = 1100,

    _CS_XBS5_ILP32_OFF32_LDFLAGS,

    _CS_XBS5_ILP32_OFF32_LIBS,

    _CS_XBS5_ILP32_OFF32_LINTFLAGS,

    _CS_XBS5_ILP32_OFFBIG_CFLAGS,

    _CS_XBS5_ILP32_OFFBIG_LDFLAGS,

    _CS_XBS5_ILP32_OFFBIG_LIBS,

    _CS_XBS5_ILP32_OFFBIG_LINTFLAGS,

    _CS_XBS5_LP64_OFF64_CFLAGS,

    _CS_XBS5_LP64_OFF64_LDFLAGS,

    _CS_XBS5_LP64_OFF64_LIBS,

    _CS_XBS5_LP64_OFF64_LINTFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_CFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_LDFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_LIBS,

    _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS,


    _CS_POSIX_V6_ILP32_OFF32_CFLAGS,

    _CS_POSIX_V6_ILP32_OFF32_LDFLAGS,

    _CS_POSIX_V6_ILP32_OFF32_LIBS,

    _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_LIBS,

    _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS,

    _CS_POSIX_V6_LP64_OFF64_CFLAGS,

    _CS_POSIX_V6_LP64_OFF64_LDFLAGS,

    _CS_POSIX_V6_LP64_OFF64_LIBS,

    _CS_POSIX_V6_LP64_OFF64_LINTFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LIBS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS,


    _CS_POSIX_V7_ILP32_OFF32_CFLAGS,

    _CS_POSIX_V7_ILP32_OFF32_LDFLAGS,

    _CS_POSIX_V7_ILP32_OFF32_LIBS,

    _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_LIBS,

    _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS,

    _CS_POSIX_V7_LP64_OFF64_CFLAGS,

    _CS_POSIX_V7_LP64_OFF64_LDFLAGS,

    _CS_POSIX_V7_LP64_OFF64_LIBS,

    _CS_POSIX_V7_LP64_OFF64_LINTFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LIBS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS,


    _CS_V6_ENV,

    _CS_V7_ENV

  };
# 621 "/usr/include/unistd.h" 2 3 4


extern long int pathconf (const char *__path, int __name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int fpathconf (int __fd, int __name) __attribute__ ((__nothrow__ , __leaf__));


extern long int sysconf (int __name) __attribute__ ((__nothrow__ , __leaf__));



extern size_t confstr (int __name, char *__buf, size_t __len) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 2, 3)));




extern __pid_t getpid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t getppid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t getpgrp (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t __getpgid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));

extern __pid_t getpgid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));






extern int setpgid (__pid_t __pid, __pid_t __pgid) __attribute__ ((__nothrow__ , __leaf__));
# 672 "/usr/include/unistd.h" 3 4
extern int setpgrp (void) __attribute__ ((__nothrow__ , __leaf__));






extern __pid_t setsid (void) __attribute__ ((__nothrow__ , __leaf__));



extern __pid_t getsid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));



extern __uid_t getuid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __uid_t geteuid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __gid_t getgid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __gid_t getegid (void) __attribute__ ((__nothrow__ , __leaf__));




extern int getgroups (int __size, __gid_t __list[]) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 2, 1)));


extern int group_member (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__));






extern int setuid (__uid_t __uid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setreuid (__uid_t __ruid, __uid_t __euid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int seteuid (__uid_t __uid) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int setgid (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setregid (__gid_t __rgid, __gid_t __egid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setegid (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__)) ;





extern int getresuid (__uid_t *__ruid, __uid_t *__euid, __uid_t *__suid)
     __attribute__ ((__nothrow__ , __leaf__));



extern int getresgid (__gid_t *__rgid, __gid_t *__egid, __gid_t *__sgid)
     __attribute__ ((__nothrow__ , __leaf__));



extern int setresuid (__uid_t __ruid, __uid_t __euid, __uid_t __suid)
     __attribute__ ((__nothrow__ , __leaf__)) ;



extern int setresgid (__gid_t __rgid, __gid_t __egid, __gid_t __sgid)
     __attribute__ ((__nothrow__ , __leaf__)) ;






extern __pid_t fork (void) __attribute__ ((__nothrow__));







extern __pid_t vfork (void) __attribute__ ((__nothrow__ , __leaf__));





extern char *ttyname (int __fd) __attribute__ ((__nothrow__ , __leaf__));



extern int ttyname_r (int __fd, char *__buf, size_t __buflen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 2, 3)));



extern int isatty (int __fd) __attribute__ ((__nothrow__ , __leaf__));




extern int ttyslot (void) __attribute__ ((__nothrow__ , __leaf__));




extern int link (const char *__from, const char *__to)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) ;




extern int linkat (int __fromfd, const char *__from, int __tofd,
     const char *__to, int __flags)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4))) ;




extern int symlink (const char *__from, const char *__to)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) ;




extern ssize_t readlink (const char *__restrict __path,
    char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) __attribute__ ((__access__ (__write_only__, 2, 3)));





extern int symlinkat (const char *__from, int __tofd,
        const char *__to) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3))) ;


extern ssize_t readlinkat (int __fd, const char *__restrict __path,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3))) __attribute__ ((__access__ (__read_only__, 3, 4)));



extern int unlink (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int unlinkat (int __fd, const char *__name, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



extern int rmdir (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern __pid_t tcgetpgrp (int __fd) __attribute__ ((__nothrow__ , __leaf__));


extern int tcsetpgrp (int __fd, __pid_t __pgrp_id) __attribute__ ((__nothrow__ , __leaf__));






extern char *getlogin (void);







extern int getlogin_r (char *__name, size_t __name_len) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));




extern int setlogin (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







# 1 "/usr/include/bits/getopt_posix.h" 1 3 4
# 27 "/usr/include/bits/getopt_posix.h" 3 4
# 1 "/usr/include/bits/getopt_core.h" 1 3 4
# 28 "/usr/include/bits/getopt_core.h" 3 4








extern char *optarg;
# 50 "/usr/include/bits/getopt_core.h" 3 4
extern int optind;




extern int opterr;



extern int optopt;
# 91 "/usr/include/bits/getopt_core.h" 3 4
extern int getopt (int ___argc, char *const *___argv, const char *__shortopts)
       __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));


# 28 "/usr/include/bits/getopt_posix.h" 2 3 4


# 49 "/usr/include/bits/getopt_posix.h" 3 4

# 884 "/usr/include/unistd.h" 2 3 4







extern int gethostname (char *__name, size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));






extern int sethostname (const char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__read_only__, 1, 2)));



extern int sethostid (long int __id) __attribute__ ((__nothrow__ , __leaf__)) ;





extern int getdomainname (char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__write_only__, 1, 2)));
extern int setdomainname (const char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__read_only__, 1, 2)));




extern int vhangup (void) __attribute__ ((__nothrow__ , __leaf__));


extern int revoke (const char *__file) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;







extern int profil (unsigned short int *__sample_buffer, size_t __size,
     size_t __offset, unsigned int __scale)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int acct (const char *__name) __attribute__ ((__nothrow__ , __leaf__));



extern char *getusershell (void) __attribute__ ((__nothrow__ , __leaf__));
extern void endusershell (void) __attribute__ ((__nothrow__ , __leaf__));
extern void setusershell (void) __attribute__ ((__nothrow__ , __leaf__));





extern int daemon (int __nochdir, int __noclose) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int chroot (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern char *getpass (const char *__prompt) __attribute__ ((__nonnull__ (1)));







extern int fsync (int __fd);





extern int syncfs (int __fd) __attribute__ ((__nothrow__ , __leaf__));






extern long int gethostid (void);


extern void sync (void) __attribute__ ((__nothrow__ , __leaf__));





extern int getpagesize (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));




extern int getdtablesize (void) __attribute__ ((__nothrow__ , __leaf__));
# 1009 "/usr/include/unistd.h" 3 4
extern int truncate (const char *__file, __off64_t __length) __asm__ ("" "truncate64") __attribute__ ((__nothrow__ , __leaf__))

                  __attribute__ ((__nonnull__ (1))) ;





extern int truncate64 (const char *__file, __off64_t __length)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 1031 "/usr/include/unistd.h" 3 4
extern int ftruncate (int __fd, __off64_t __length) __asm__ ("" "ftruncate64") __attribute__ ((__nothrow__ , __leaf__))
                        ;





extern int ftruncate64 (int __fd, __off64_t __length) __attribute__ ((__nothrow__ , __leaf__)) ;
# 1049 "/usr/include/unistd.h" 3 4
extern int brk (void *__addr) __attribute__ ((__nothrow__ , __leaf__)) ;





extern void *sbrk (intptr_t __delta) __attribute__ ((__nothrow__ , __leaf__));
# 1070 "/usr/include/unistd.h" 3 4
extern long int syscall (long int __sysno, ...) __attribute__ ((__nothrow__ , __leaf__));
# 1121 "/usr/include/unistd.h" 3 4
ssize_t copy_file_range (int __infd, __off64_t *__pinoff,
    int __outfd, __off64_t *__poutoff,
    size_t __length, unsigned int __flags);





extern int fdatasync (int __fildes);
# 1138 "/usr/include/unistd.h" 3 4
extern char *crypt (const char *__key, const char *__salt)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));







extern void swab (const void *__restrict __from, void *__restrict __to,
    ssize_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)))
    __attribute__ ((__access__ (__read_only__, 1, 3)))
    __attribute__ ((__access__ (__write_only__, 2, 3)));
# 1177 "/usr/include/unistd.h" 3 4
int getentropy (void *__buffer, size_t __length)
    __attribute__ ((__access__ (__write_only__, 1, 2)));
# 1187 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/unistd_ext.h" 1 3 4
# 34 "/usr/include/bits/unistd_ext.h" 3 4
extern __pid_t gettid (void) __attribute__ ((__nothrow__ , __leaf__));
# 1188 "/usr/include/unistd.h" 2 3 4


# 33 "./include/grub/osdep/hostfile_unix.h" 2
# 1 "/usr/include/stdio.h" 1 3 4
# 27 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/libc-header-start.h" 1 3 4
# 28 "/usr/include/stdio.h" 2 3 4





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 34 "/usr/include/stdio.h" 2 3 4





# 1 "/usr/include/bits/types/__fpos_t.h" 1 3 4




# 1 "/usr/include/bits/types/__mbstate_t.h" 1 3 4
# 13 "/usr/include/bits/types/__mbstate_t.h" 3 4
typedef struct
{
  int __count;
  union
  {
    unsigned int __wch;
    char __wchb[4];
  } __value;
} __mbstate_t;
# 6 "/usr/include/bits/types/__fpos_t.h" 2 3 4




typedef struct _G_fpos_t
{
  __off_t __pos;
  __mbstate_t __state;
} __fpos_t;
# 40 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/__fpos64_t.h" 1 3 4
# 10 "/usr/include/bits/types/__fpos64_t.h" 3 4
typedef struct _G_fpos64_t
{
  __off64_t __pos;
  __mbstate_t __state;
} __fpos64_t;
# 41 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/__FILE.h" 1 3 4



struct _IO_FILE;
typedef struct _IO_FILE __FILE;
# 42 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/FILE.h" 1 3 4



struct _IO_FILE;


typedef struct _IO_FILE FILE;
# 43 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/struct_FILE.h" 1 3 4
# 35 "/usr/include/bits/types/struct_FILE.h" 3 4
struct _IO_FILE;
struct _IO_marker;
struct _IO_codecvt;
struct _IO_wide_data;




typedef void _IO_lock_t;





struct _IO_FILE
{
  int _flags;


  char *_IO_read_ptr;
  char *_IO_read_end;
  char *_IO_read_base;
  char *_IO_write_base;
  char *_IO_write_ptr;
  char *_IO_write_end;
  char *_IO_buf_base;
  char *_IO_buf_end;


  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;
  int _flags2;
  __off_t _old_offset;


  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];

  _IO_lock_t *_lock;







  __off64_t _offset;

  struct _IO_codecvt *_codecvt;
  struct _IO_wide_data *_wide_data;
  struct _IO_FILE *_freeres_list;
  void *_freeres_buf;
  size_t __pad5;
  int _mode;

  char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];
};
# 44 "/usr/include/stdio.h" 2 3 4


# 1 "/usr/include/bits/types/cookie_io_functions_t.h" 1 3 4
# 27 "/usr/include/bits/types/cookie_io_functions_t.h" 3 4
typedef __ssize_t cookie_read_function_t (void *__cookie, char *__buf,
                                          size_t __nbytes);







typedef __ssize_t cookie_write_function_t (void *__cookie, const char *__buf,
                                           size_t __nbytes);







typedef int cookie_seek_function_t (void *__cookie, __off64_t *__pos, int __w);


typedef int cookie_close_function_t (void *__cookie);






typedef struct _IO_cookie_io_functions_t
{
  cookie_read_function_t *read;
  cookie_write_function_t *write;
  cookie_seek_function_t *seek;
  cookie_close_function_t *close;
} cookie_io_functions_t;
# 47 "/usr/include/stdio.h" 2 3 4
# 86 "/usr/include/stdio.h" 3 4
typedef __fpos64_t fpos_t;


typedef __fpos64_t fpos64_t;
# 133 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 134 "/usr/include/stdio.h" 2 3 4



extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;






extern int remove (const char *__filename) __attribute__ ((__nothrow__ , __leaf__));

extern int rename (const char *__old, const char *__new) __attribute__ ((__nothrow__ , __leaf__));



extern int renameat (int __oldfd, const char *__old, int __newfd,
       const char *__new) __attribute__ ((__nothrow__ , __leaf__));
# 164 "/usr/include/stdio.h" 3 4
extern int renameat2 (int __oldfd, const char *__old, int __newfd,
        const char *__new, unsigned int __flags) __attribute__ ((__nothrow__ , __leaf__));
# 176 "/usr/include/stdio.h" 3 4
extern FILE *tmpfile (void) __asm__ ("" "tmpfile64") ;






extern FILE *tmpfile64 (void) ;



extern char *tmpnam (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;




extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;
# 204 "/usr/include/stdio.h" 3 4
extern char *tempnam (const char *__dir, const char *__pfx)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;







extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);
# 227 "/usr/include/stdio.h" 3 4
extern int fflush_unlocked (FILE *__stream);
# 237 "/usr/include/stdio.h" 3 4
extern int fcloseall (void);
# 257 "/usr/include/stdio.h" 3 4
extern FILE *fopen (const char *__restrict __filename, const char *__restrict __modes) __asm__ ("" "fopen64")

  ;
extern FILE *freopen (const char *__restrict __filename, const char *__restrict __modes, FILE *__restrict __stream) __asm__ ("" "freopen64")


  ;






extern FILE *fopen64 (const char *__restrict __filename,
        const char *__restrict __modes) ;
extern FILE *freopen64 (const char *__restrict __filename,
   const char *__restrict __modes,
   FILE *__restrict __stream) ;




extern FILE *fdopen (int __fd, const char *__modes) __attribute__ ((__nothrow__ , __leaf__)) ;





extern FILE *fopencookie (void *__restrict __magic_cookie,
     const char *__restrict __modes,
     cookie_io_functions_t __io_funcs) __attribute__ ((__nothrow__ , __leaf__)) ;




extern FILE *fmemopen (void *__s, size_t __len, const char *__modes)
  __attribute__ ((__nothrow__ , __leaf__)) ;




extern FILE *open_memstream (char **__bufloc, size_t *__sizeloc) __attribute__ ((__nothrow__ , __leaf__)) ;





extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));



extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
      int __modes, size_t __n) __attribute__ ((__nothrow__ , __leaf__));




extern void setbuffer (FILE *__restrict __stream, char *__restrict __buf,
         size_t __size) __attribute__ ((__nothrow__ , __leaf__));


extern void setlinebuf (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));







extern int fprintf (FILE *__restrict __stream,
      const char *__restrict __format, ...);




extern int printf (const char *__restrict __format, ...);

extern int sprintf (char *__restrict __s,
      const char *__restrict __format, ...) __attribute__ ((__nothrow__));





extern int vfprintf (FILE *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg);




extern int vprintf (const char *__restrict __format, __gnuc_va_list __arg);

extern int vsprintf (char *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg) __attribute__ ((__nothrow__));



extern int snprintf (char *__restrict __s, size_t __maxlen,
       const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 4)));

extern int vsnprintf (char *__restrict __s, size_t __maxlen,
        const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 0)));





extern int vasprintf (char **__restrict __ptr, const char *__restrict __f,
        __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 0))) ;
extern int __asprintf (char **__restrict __ptr,
         const char *__restrict __fmt, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3))) ;
extern int asprintf (char **__restrict __ptr,
       const char *__restrict __fmt, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3))) ;




extern int vdprintf (int __fd, const char *__restrict __fmt,
       __gnuc_va_list __arg)
     __attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));







extern int fscanf (FILE *__restrict __stream,
     const char *__restrict __format, ...) ;




extern int scanf (const char *__restrict __format, ...) ;

extern int sscanf (const char *__restrict __s,
     const char *__restrict __format, ...) __attribute__ ((__nothrow__ , __leaf__));





# 1 "/usr/include/bits/floatn.h" 1 3 4
# 119 "/usr/include/bits/floatn.h" 3 4
# 1 "/usr/include/bits/floatn-common.h" 1 3 4
# 24 "/usr/include/bits/floatn-common.h" 3 4
# 1 "/usr/include/bits/long-double.h" 1 3 4
# 25 "/usr/include/bits/floatn-common.h" 2 3 4
# 120 "/usr/include/bits/floatn.h" 2 3 4
# 407 "/usr/include/stdio.h" 2 3 4



extern int fscanf (FILE *__restrict __stream, const char *__restrict __format, ...) __asm__ ("" "__isoc99_fscanf")

                               ;
extern int scanf (const char *__restrict __format, ...) __asm__ ("" "__isoc99_scanf")
                              ;
extern int sscanf (const char *__restrict __s, const char *__restrict __format, ...) __asm__ ("" "__isoc99_sscanf") __attribute__ ((__nothrow__ , __leaf__))

                      ;
# 435 "/usr/include/stdio.h" 3 4
extern int vfscanf (FILE *__restrict __s, const char *__restrict __format,
      __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;





extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;


extern int vsscanf (const char *__restrict __s,
      const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format__ (__scanf__, 2, 0)));





extern int vfscanf (FILE *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vfscanf")



     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vscanf")

     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (const char *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vsscanf") __attribute__ ((__nothrow__ , __leaf__))



     __attribute__ ((__format__ (__scanf__, 2, 0)));
# 489 "/usr/include/stdio.h" 3 4
extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);






extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
# 514 "/usr/include/stdio.h" 3 4
extern int fgetc_unlocked (FILE *__stream);
# 525 "/usr/include/stdio.h" 3 4
extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);
# 541 "/usr/include/stdio.h" 3 4
extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);







extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     __attribute__ ((__access__ (__write_only__, 1, 2)));
# 591 "/usr/include/stdio.h" 3 4
extern char *fgets_unlocked (char *__restrict __s, int __n,
        FILE *__restrict __stream)
    __attribute__ ((__access__ (__write_only__, 1, 2)));
# 608 "/usr/include/stdio.h" 3 4
extern __ssize_t __getdelim (char **__restrict __lineptr,
                             size_t *__restrict __n, int __delimiter,
                             FILE *__restrict __stream) ;
extern __ssize_t getdelim (char **__restrict __lineptr,
                           size_t *__restrict __n, int __delimiter,
                           FILE *__restrict __stream) ;







extern __ssize_t getline (char **__restrict __lineptr,
                          size_t *__restrict __n,
                          FILE *__restrict __stream) ;







extern int fputs (const char *__restrict __s, FILE *__restrict __stream);





extern int puts (const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void *__restrict __ptr, size_t __size,
       size_t __n, FILE *__restrict __stream) ;




extern size_t fwrite (const void *__restrict __ptr, size_t __size,
        size_t __n, FILE *__restrict __s);
# 667 "/usr/include/stdio.h" 3 4
extern int fputs_unlocked (const char *__restrict __s,
      FILE *__restrict __stream);
# 678 "/usr/include/stdio.h" 3 4
extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream);







extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream) ;




extern void rewind (FILE *__stream);
# 720 "/usr/include/stdio.h" 3 4
extern int fseeko (FILE *__stream, __off64_t __off, int __whence) __asm__ ("" "fseeko64")

                  ;
extern __off64_t ftello (FILE *__stream) __asm__ ("" "ftello64");
# 744 "/usr/include/stdio.h" 3 4
extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos) __asm__ ("" "fgetpos64")
                                          ;
extern int fsetpos (FILE *__stream, const fpos_t *__pos) __asm__ ("" "fsetpos64")
                                                          ;







extern int fseeko64 (FILE *__stream, __off64_t __off, int __whence);
extern __off64_t ftello64 (FILE *__stream) ;
extern int fgetpos64 (FILE *__restrict __stream, fpos64_t *__restrict __pos);
extern int fsetpos64 (FILE *__stream, const fpos64_t *__pos);



extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));

extern int feof (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;

extern int ferror (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;



extern void clearerr_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
extern int feof_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern int ferror_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;







extern void perror (const char *__s);




extern int fileno (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
# 799 "/usr/include/stdio.h" 3 4
extern FILE *popen (const char *__command, const char *__modes) ;





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) __attribute__ ((__nothrow__ , __leaf__));





extern char *cuserid (char *__s);




struct obstack;


extern int obstack_printf (struct obstack *__restrict __obstack,
      const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3)));
extern int obstack_vprintf (struct obstack *__restrict __obstack,
       const char *__restrict __format,
       __gnuc_va_list __args)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 0)));







extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));



extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;


extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
# 857 "/usr/include/stdio.h" 3 4
extern int __uflow (FILE *);
extern int __overflow (FILE *, int);
# 874 "/usr/include/stdio.h" 3 4

# 34 "./include/grub/osdep/hostfile_unix.h" 2


# 35 "./include/grub/osdep/hostfile_unix.h"
typedef struct dirent *grub_util_fd_dirent_t;
typedef DIR *grub_util_fd_dir_t;

static inline grub_util_fd_dir_t
grub_util_fd_opendir (const char *name)
{
  return opendir (name);
}

static inline void
grub_util_fd_closedir (grub_util_fd_dir_t dirp)
{
  closedir (dirp);
}

static inline grub_util_fd_dirent_t
grub_util_fd_readdir (grub_util_fd_dir_t dirp)
{
  return readdir (dirp);
}

static inline int
grub_util_unlink (const char *pathname)
{
  return unlink (pathname);
}

static inline int
grub_util_rmdir (const char *pathname)
{
  return rmdir (pathname);
}

static inline int
grub_util_rename (const char *from, const char *to)
{
  return rename (from, to);
}

static inline ssize_t
grub_util_readlink (const char *name, char *buf, size_t bufsize)
{
  return readlink(name, buf, bufsize);
}
# 89 "./include/grub/osdep/hostfile_unix.h"
enum grub_util_fd_open_flags_t
  {
    GRUB_UTIL_FD_O_RDONLY = 
# 91 "./include/grub/osdep/hostfile_unix.h" 3 4
                           00
# 91 "./include/grub/osdep/hostfile_unix.h"
                                   ,
    GRUB_UTIL_FD_O_WRONLY = 
# 92 "./include/grub/osdep/hostfile_unix.h" 3 4
                           01
# 92 "./include/grub/osdep/hostfile_unix.h"
                                   ,
    GRUB_UTIL_FD_O_RDWR = 
# 93 "./include/grub/osdep/hostfile_unix.h" 3 4
                         02
# 93 "./include/grub/osdep/hostfile_unix.h"
                               ,
    GRUB_UTIL_FD_O_CREATTRUNC = 
# 94 "./include/grub/osdep/hostfile_unix.h" 3 4
                               0100 
# 94 "./include/grub/osdep/hostfile_unix.h"
                                       | 
# 94 "./include/grub/osdep/hostfile_unix.h" 3 4
                                         01000
# 94 "./include/grub/osdep/hostfile_unix.h"
                                                ,
    GRUB_UTIL_FD_O_SYNC = (0

      | 
# 97 "./include/grub/osdep/hostfile_unix.h" 3 4
       04010000


      
# 100 "./include/grub/osdep/hostfile_unix.h"
     | 
# 100 "./include/grub/osdep/hostfile_unix.h" 3 4
       04010000

      
# 102 "./include/grub/osdep/hostfile_unix.h"
     )
  };



typedef int grub_util_fd_t;
# 7 "./include/grub/osdep/hostfile.h" 2
# 26 "./include/grub/emu/hostfile.h" 2

int
grub_util_is_directory (const char *path);
int
grub_util_is_special_file (const char *path);
int
grub_util_is_regular (const char *path);

char *
grub_util_path_concat (size_t n, ...);
char *
grub_util_path_concat_ext (size_t n, ...);

int
grub_util_fd_seek (grub_util_fd_t fd, grub_uint64_t off);
ssize_t
grub_util_fd_read (grub_util_fd_t fd, char *buf, size_t len);
ssize_t
grub_util_fd_write (grub_util_fd_t fd, const char *buf, size_t len);

grub_util_fd_t
grub_util_fd_open (const char *os_dev, int flags);
const char *
grub_util_fd_strerror (void);
int
grub_util_fd_sync (grub_util_fd_t fd);
void
grub_util_disable_fd_syncs (void);
int
grub_util_fd_close (grub_util_fd_t fd);

grub_uint64_t
grub_util_get_fd_size (grub_util_fd_t fd, const char *name, unsigned *log_secsize);
char *
grub_util_make_temporary_file (void);
char *
grub_util_make_temporary_dir (void);
void
grub_util_unlink_recursive (const char *name);
grub_uint32_t
grub_util_get_mtime (const char *name);
# 27 "./include/grub/emu/hostdisk.h" 2

grub_util_fd_t
grub_util_fd_open_device (const grub_disk_t disk, grub_disk_addr_t sector, int flags,
     grub_disk_addr_t *max);

void grub_util_biosdisk_init (const char *dev_map);
void grub_util_biosdisk_fini (void);
char *grub_util_biosdisk_get_grub_dev (const char *os_dev);
const char *grub_util_biosdisk_get_osdev (grub_disk_t disk);
int grub_util_biosdisk_is_present (const char *name);
int grub_util_biosdisk_is_floppy (grub_disk_t disk);
const char *
grub_util_biosdisk_get_compatibility_hint (grub_disk_t disk);
grub_err_t grub_util_biosdisk_flush (struct grub_disk *disk);
grub_err_t
grub_cryptodisk_cheat_mount (const char *sourcedev, const char *cheat);
const char *
grub_util_cryptodisk_get_uuid (grub_disk_t disk);
char *
grub_util_get_ldm (grub_disk_t disk, grub_disk_addr_t start);
int
grub_util_is_ldm (grub_disk_t disk);

grub_err_t
grub_util_ldm_embed (struct grub_disk *disk, unsigned int *nsectors,
       unsigned int max_nsectors,
       grub_embed_type_t embed_type,
       grub_disk_addr_t **sectors);

const char *
grub_hostdisk_os_dev_to_grub_drive (const char *os_dev, int add);


char *
grub_util_get_os_disk (const char *os_dev);

int
grub_util_get_dm_node_linear_info (dev_t dev,
       int *maj, int *min,
       grub_disk_addr_t *st);



grub_int64_t
grub_util_get_fd_size_os (grub_util_fd_t fd, const char *name, unsigned *log_secsize);

grub_disk_addr_t
grub_hostdisk_find_partition_start_os (const char *dev);
void
grub_hostdisk_flush_initial_buffer (const char *os_dev);







struct grub_util_hostdisk_data
{
  char *dev;
  int access_mode;
  grub_util_fd_t fd;
  int is_disk;
  int device_map;
};

void grub_host_init (void);
void grub_host_fini (void);
void grub_hostfs_init (void);
void grub_hostfs_fini (void);
# 30 "grub-core/disk/host.c" 2

int grub_disk_host_i_want_a_reference;

static int
grub_host_iterate (grub_disk_dev_iterate_hook_t hook, void *hook_data,
     grub_disk_pull_t pull)
{
  if (pull != GRUB_DISK_PULL_NONE)
    return 0;

  if (hook ("host", hook_data))
    return 1;
  return 0;
}

static grub_err_t
grub_host_open (const char *name, grub_disk_t disk)
{
  if (grub_strcmp (name, "host"))
      return grub_error (GRUB_ERR_UNKNOWN_DEVICE, "not a host disk");

  disk->total_sectors = 0;
  disk->id = 0;

  disk->data = 0;

  return GRUB_ERR_NONE;
}

static void
grub_host_close (grub_disk_t disk __attribute((unused)))
{
}

static grub_err_t
grub_host_read (grub_disk_t disk __attribute((unused)),
  grub_disk_addr_t sector __attribute((unused)),
  grub_size_t size __attribute((unused)),
  char *buf __attribute((unused)))
{
  return GRUB_ERR_OUT_OF_RANGE;
}

static grub_err_t
grub_host_write (grub_disk_t disk __attribute ((unused)),
       grub_disk_addr_t sector __attribute ((unused)),
       grub_size_t size __attribute ((unused)),
       const char *buf __attribute ((unused)))
{
  return GRUB_ERR_OUT_OF_RANGE;
}

static struct grub_disk_dev grub_host_dev =
  {

    .name = "host",
    .id = GRUB_DISK_DEVICE_HOST_ID,
    .disk_iterate = grub_host_iterate,
    .disk_open = grub_host_open,
    .disk_close = grub_host_close,
    .disk_read = grub_host_read,
    .disk_write = grub_host_write,
    .next = 0
  };

@MARKER@host@
{
  grub_disk_dev_register (&grub_host_dev);
}

GRUB_MOD_FINI(host)
{
  grub_disk_dev_unregister (&grub_host_dev);
}
# 1 "grub-core/osdep/init.c"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "grub-core/osdep/init.c"



# 1 "grub-core/osdep/basic/init.c" 1
# 19 "grub-core/osdep/basic/init.c"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 20 "grub-core/osdep/basic/init.c" 2
# 1 "./config-util.h" 1
# 21 "grub-core/osdep/basic/init.c" 2

# 1 "./include/grub/util/misc.h" 1
# 22 "./include/grub/util/misc.h"
# 1 "/usr/include/stdlib.h" 1 3 4
# 25 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/bits/libc-header-start.h" 1 3 4
# 33 "/usr/include/bits/libc-header-start.h" 3 4
# 1 "/usr/include/features.h" 1 3 4
# 465 "/usr/include/features.h" 3 4
# 1 "/usr/include/sys/cdefs.h" 1 3 4
# 452 "/usr/include/sys/cdefs.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 453 "/usr/include/sys/cdefs.h" 2 3 4
# 1 "/usr/include/bits/long-double.h" 1 3 4
# 454 "/usr/include/sys/cdefs.h" 2 3 4
# 466 "/usr/include/features.h" 2 3 4
# 489 "/usr/include/features.h" 3 4
# 1 "/usr/include/gnu/stubs.h" 1 3 4
# 10 "/usr/include/gnu/stubs.h" 3 4
# 1 "/usr/include/gnu/stubs-64.h" 1 3 4
# 11 "/usr/include/gnu/stubs.h" 2 3 4
# 490 "/usr/include/features.h" 2 3 4
# 34 "/usr/include/bits/libc-header-start.h" 2 3 4
# 26 "/usr/include/stdlib.h" 2 3 4





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 209 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 3 4

# 209 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 3 4
typedef long unsigned int size_t;
# 321 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 3 4
typedef int wchar_t;
# 32 "/usr/include/stdlib.h" 2 3 4







# 1 "/usr/include/bits/waitflags.h" 1 3 4
# 40 "/usr/include/stdlib.h" 2 3 4
# 1 "/usr/include/bits/waitstatus.h" 1 3 4
# 41 "/usr/include/stdlib.h" 2 3 4
# 55 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/bits/floatn.h" 1 3 4
# 119 "/usr/include/bits/floatn.h" 3 4
# 1 "/usr/include/bits/floatn-common.h" 1 3 4
# 24 "/usr/include/bits/floatn-common.h" 3 4
# 1 "/usr/include/bits/long-double.h" 1 3 4
# 25 "/usr/include/bits/floatn-common.h" 2 3 4
# 120 "/usr/include/bits/floatn.h" 2 3 4
# 56 "/usr/include/stdlib.h" 2 3 4


typedef struct
  {
    int quot;
    int rem;
  } div_t;



typedef struct
  {
    long int quot;
    long int rem;
  } ldiv_t;





__extension__ typedef struct
  {
    long long int quot;
    long long int rem;
  } lldiv_t;
# 97 "/usr/include/stdlib.h" 3 4
extern size_t __ctype_get_mb_cur_max (void) __attribute__ ((__nothrow__ , __leaf__)) ;



extern double atof (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern int atoi (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;

extern long int atol (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;



__extension__ extern long long int atoll (const char *__nptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;



extern double strtod (const char *__restrict __nptr,
        char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern float strtof (const char *__restrict __nptr,
       char **__restrict __endptr) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

extern long double strtold (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 140 "/usr/include/stdlib.h" 3 4
extern _Float32 strtof32 (const char *__restrict __nptr,
     char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float64 strtof64 (const char *__restrict __nptr,
     char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float128 strtof128 (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float32x strtof32x (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern _Float64x strtof64x (const char *__restrict __nptr,
       char **__restrict __endptr)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 176 "/usr/include/stdlib.h" 3 4
extern long int strtol (const char *__restrict __nptr,
   char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

extern unsigned long int strtoul (const char *__restrict __nptr,
      char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



__extension__
extern long long int strtoq (const char *__restrict __nptr,
        char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

__extension__
extern unsigned long long int strtouq (const char *__restrict __nptr,
           char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




__extension__
extern long long int strtoll (const char *__restrict __nptr,
         char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));

__extension__
extern unsigned long long int strtoull (const char *__restrict __nptr,
     char **__restrict __endptr, int __base)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int strfromd (char *__dest, size_t __size, const char *__format,
       double __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));

extern int strfromf (char *__dest, size_t __size, const char *__format,
       float __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));

extern int strfroml (char *__dest, size_t __size, const char *__format,
       long double __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));
# 232 "/usr/include/stdlib.h" 3 4
extern int strfromf32 (char *__dest, size_t __size, const char * __format,
         _Float32 __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf64 (char *__dest, size_t __size, const char * __format,
         _Float64 __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf128 (char *__dest, size_t __size, const char * __format,
   _Float128 __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf32x (char *__dest, size_t __size, const char * __format,
   _Float32x __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));



extern int strfromf64x (char *__dest, size_t __size, const char * __format,
   _Float64x __f)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3)));
# 272 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/bits/types/locale_t.h" 1 3 4
# 22 "/usr/include/bits/types/locale_t.h" 3 4
# 1 "/usr/include/bits/types/__locale_t.h" 1 3 4
# 28 "/usr/include/bits/types/__locale_t.h" 3 4
struct __locale_struct
{

  struct __locale_data *__locales[13];


  const unsigned short int *__ctype_b;
  const int *__ctype_tolower;
  const int *__ctype_toupper;


  const char *__names[13];
};

typedef struct __locale_struct *__locale_t;
# 23 "/usr/include/bits/types/locale_t.h" 2 3 4

typedef __locale_t locale_t;
# 273 "/usr/include/stdlib.h" 2 3 4

extern long int strtol_l (const char *__restrict __nptr,
     char **__restrict __endptr, int __base,
     locale_t __loc) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

extern unsigned long int strtoul_l (const char *__restrict __nptr,
        char **__restrict __endptr,
        int __base, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

__extension__
extern long long int strtoll_l (const char *__restrict __nptr,
    char **__restrict __endptr, int __base,
    locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

__extension__
extern unsigned long long int strtoull_l (const char *__restrict __nptr,
       char **__restrict __endptr,
       int __base, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 4)));

extern double strtod_l (const char *__restrict __nptr,
   char **__restrict __endptr, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));

extern float strtof_l (const char *__restrict __nptr,
         char **__restrict __endptr, locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));

extern long double strtold_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));
# 316 "/usr/include/stdlib.h" 3 4
extern _Float32 strtof32_l (const char *__restrict __nptr,
       char **__restrict __endptr,
       locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float64 strtof64_l (const char *__restrict __nptr,
       char **__restrict __endptr,
       locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float128 strtof128_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float32x strtof32x_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));



extern _Float64x strtof64x_l (const char *__restrict __nptr,
         char **__restrict __endptr,
         locale_t __loc)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3)));
# 385 "/usr/include/stdlib.h" 3 4
extern char *l64a (long int __n) __attribute__ ((__nothrow__ , __leaf__)) ;


extern long int a64l (const char *__s)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__pure__)) __attribute__ ((__nonnull__ (1))) ;




# 1 "/usr/include/sys/types.h" 1 3 4
# 27 "/usr/include/sys/types.h" 3 4


# 1 "/usr/include/bits/types.h" 1 3 4
# 27 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 28 "/usr/include/bits/types.h" 2 3 4
# 1 "/usr/include/bits/timesize.h" 1 3 4
# 29 "/usr/include/bits/types.h" 2 3 4


typedef unsigned char __u_char;
typedef unsigned short int __u_short;
typedef unsigned int __u_int;
typedef unsigned long int __u_long;


typedef signed char __int8_t;
typedef unsigned char __uint8_t;
typedef signed short int __int16_t;
typedef unsigned short int __uint16_t;
typedef signed int __int32_t;
typedef unsigned int __uint32_t;

typedef signed long int __int64_t;
typedef unsigned long int __uint64_t;






typedef __int8_t __int_least8_t;
typedef __uint8_t __uint_least8_t;
typedef __int16_t __int_least16_t;
typedef __uint16_t __uint_least16_t;
typedef __int32_t __int_least32_t;
typedef __uint32_t __uint_least32_t;
typedef __int64_t __int_least64_t;
typedef __uint64_t __uint_least64_t;



typedef long int __quad_t;
typedef unsigned long int __u_quad_t;







typedef long int __intmax_t;
typedef unsigned long int __uintmax_t;
# 141 "/usr/include/bits/types.h" 3 4
# 1 "/usr/include/bits/typesizes.h" 1 3 4
# 142 "/usr/include/bits/types.h" 2 3 4
# 1 "/usr/include/bits/time64.h" 1 3 4
# 143 "/usr/include/bits/types.h" 2 3 4


typedef unsigned long int __dev_t;
typedef unsigned int __uid_t;
typedef unsigned int __gid_t;
typedef unsigned long int __ino_t;
typedef unsigned long int __ino64_t;
typedef unsigned int __mode_t;
typedef unsigned long int __nlink_t;
typedef long int __off_t;
typedef long int __off64_t;
typedef int __pid_t;
typedef struct { int __val[2]; } __fsid_t;
typedef long int __clock_t;
typedef unsigned long int __rlim_t;
typedef unsigned long int __rlim64_t;
typedef unsigned int __id_t;
typedef long int __time_t;
typedef unsigned int __useconds_t;
typedef long int __suseconds_t;
typedef long int __suseconds64_t;

typedef int __daddr_t;
typedef int __key_t;


typedef int __clockid_t;


typedef void * __timer_t;


typedef long int __blksize_t;




typedef long int __blkcnt_t;
typedef long int __blkcnt64_t;


typedef unsigned long int __fsblkcnt_t;
typedef unsigned long int __fsblkcnt64_t;


typedef unsigned long int __fsfilcnt_t;
typedef unsigned long int __fsfilcnt64_t;


typedef long int __fsword_t;

typedef long int __ssize_t;


typedef long int __syscall_slong_t;

typedef unsigned long int __syscall_ulong_t;



typedef __off64_t __loff_t;
typedef char *__caddr_t;


typedef long int __intptr_t;


typedef unsigned int __socklen_t;




typedef int __sig_atomic_t;
# 30 "/usr/include/sys/types.h" 2 3 4



typedef __u_char u_char;
typedef __u_short u_short;
typedef __u_int u_int;
typedef __u_long u_long;
typedef __quad_t quad_t;
typedef __u_quad_t u_quad_t;
typedef __fsid_t fsid_t;


typedef __loff_t loff_t;






typedef __ino64_t ino_t;




typedef __ino64_t ino64_t;




typedef __dev_t dev_t;




typedef __gid_t gid_t;




typedef __mode_t mode_t;




typedef __nlink_t nlink_t;




typedef __uid_t uid_t;







typedef __off64_t off_t;




typedef __off64_t off64_t;




typedef __pid_t pid_t;





typedef __id_t id_t;




typedef __ssize_t ssize_t;





typedef __daddr_t daddr_t;
typedef __caddr_t caddr_t;





typedef __key_t key_t;




# 1 "/usr/include/bits/types/clock_t.h" 1 3 4






typedef __clock_t clock_t;
# 127 "/usr/include/sys/types.h" 2 3 4

# 1 "/usr/include/bits/types/clockid_t.h" 1 3 4






typedef __clockid_t clockid_t;
# 129 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/bits/types/time_t.h" 1 3 4






typedef __time_t time_t;
# 130 "/usr/include/sys/types.h" 2 3 4
# 1 "/usr/include/bits/types/timer_t.h" 1 3 4






typedef __timer_t timer_t;
# 131 "/usr/include/sys/types.h" 2 3 4



typedef __useconds_t useconds_t;



typedef __suseconds_t suseconds_t;





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 145 "/usr/include/sys/types.h" 2 3 4



typedef unsigned long int ulong;
typedef unsigned short int ushort;
typedef unsigned int uint;




# 1 "/usr/include/bits/stdint-intn.h" 1 3 4
# 24 "/usr/include/bits/stdint-intn.h" 3 4
typedef __int8_t int8_t;
typedef __int16_t int16_t;
typedef __int32_t int32_t;
typedef __int64_t int64_t;
# 156 "/usr/include/sys/types.h" 2 3 4


typedef __uint8_t u_int8_t;
typedef __uint16_t u_int16_t;
typedef __uint32_t u_int32_t;
typedef __uint64_t u_int64_t;


typedef int register_t __attribute__ ((__mode__ (__word__)));
# 176 "/usr/include/sys/types.h" 3 4
# 1 "/usr/include/endian.h" 1 3 4
# 24 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/endian.h" 1 3 4
# 35 "/usr/include/bits/endian.h" 3 4
# 1 "/usr/include/bits/endianness.h" 1 3 4
# 36 "/usr/include/bits/endian.h" 2 3 4
# 25 "/usr/include/endian.h" 2 3 4
# 35 "/usr/include/endian.h" 3 4
# 1 "/usr/include/bits/byteswap.h" 1 3 4
# 33 "/usr/include/bits/byteswap.h" 3 4
static __inline __uint16_t
__bswap_16 (__uint16_t __bsx)
{

  return __builtin_bswap16 (__bsx);



}






static __inline __uint32_t
__bswap_32 (__uint32_t __bsx)
{

  return __builtin_bswap32 (__bsx);



}
# 69 "/usr/include/bits/byteswap.h" 3 4
__extension__ static __inline __uint64_t
__bswap_64 (__uint64_t __bsx)
{

  return __builtin_bswap64 (__bsx);



}
# 36 "/usr/include/endian.h" 2 3 4
# 1 "/usr/include/bits/uintn-identity.h" 1 3 4
# 32 "/usr/include/bits/uintn-identity.h" 3 4
static __inline __uint16_t
__uint16_identity (__uint16_t __x)
{
  return __x;
}

static __inline __uint32_t
__uint32_identity (__uint32_t __x)
{
  return __x;
}

static __inline __uint64_t
__uint64_identity (__uint64_t __x)
{
  return __x;
}
# 37 "/usr/include/endian.h" 2 3 4
# 177 "/usr/include/sys/types.h" 2 3 4


# 1 "/usr/include/sys/select.h" 1 3 4
# 30 "/usr/include/sys/select.h" 3 4
# 1 "/usr/include/bits/select.h" 1 3 4
# 31 "/usr/include/sys/select.h" 2 3 4


# 1 "/usr/include/bits/types/sigset_t.h" 1 3 4



# 1 "/usr/include/bits/types/__sigset_t.h" 1 3 4




typedef struct
{
  unsigned long int __val[(1024 / (8 * sizeof (unsigned long int)))];
} __sigset_t;
# 5 "/usr/include/bits/types/sigset_t.h" 2 3 4


typedef __sigset_t sigset_t;
# 34 "/usr/include/sys/select.h" 2 3 4



# 1 "/usr/include/bits/types/struct_timeval.h" 1 3 4







struct timeval
{
  __time_t tv_sec;
  __suseconds_t tv_usec;
};
# 38 "/usr/include/sys/select.h" 2 3 4

# 1 "/usr/include/bits/types/struct_timespec.h" 1 3 4
# 10 "/usr/include/bits/types/struct_timespec.h" 3 4
struct timespec
{
  __time_t tv_sec;



  __syscall_slong_t tv_nsec;
# 26 "/usr/include/bits/types/struct_timespec.h" 3 4
};
# 40 "/usr/include/sys/select.h" 2 3 4
# 49 "/usr/include/sys/select.h" 3 4
typedef long int __fd_mask;
# 59 "/usr/include/sys/select.h" 3 4
typedef struct
  {



    __fd_mask fds_bits[1024 / (8 * (int) sizeof (__fd_mask))];





  } fd_set;






typedef __fd_mask fd_mask;
# 91 "/usr/include/sys/select.h" 3 4

# 101 "/usr/include/sys/select.h" 3 4
extern int select (int __nfds, fd_set *__restrict __readfds,
     fd_set *__restrict __writefds,
     fd_set *__restrict __exceptfds,
     struct timeval *__restrict __timeout);
# 113 "/usr/include/sys/select.h" 3 4
extern int pselect (int __nfds, fd_set *__restrict __readfds,
      fd_set *__restrict __writefds,
      fd_set *__restrict __exceptfds,
      const struct timespec *__restrict __timeout,
      const __sigset_t *__restrict __sigmask);
# 126 "/usr/include/sys/select.h" 3 4

# 180 "/usr/include/sys/types.h" 2 3 4





typedef __blksize_t blksize_t;
# 205 "/usr/include/sys/types.h" 3 4
typedef __blkcnt64_t blkcnt_t;



typedef __fsblkcnt64_t fsblkcnt_t;



typedef __fsfilcnt64_t fsfilcnt_t;





typedef __blkcnt64_t blkcnt64_t;
typedef __fsblkcnt64_t fsblkcnt64_t;
typedef __fsfilcnt64_t fsfilcnt64_t;





# 1 "/usr/include/bits/pthreadtypes.h" 1 3 4
# 23 "/usr/include/bits/pthreadtypes.h" 3 4
# 1 "/usr/include/bits/thread-shared-types.h" 1 3 4
# 44 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/pthreadtypes-arch.h" 1 3 4
# 21 "/usr/include/bits/pthreadtypes-arch.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 22 "/usr/include/bits/pthreadtypes-arch.h" 2 3 4
# 45 "/usr/include/bits/thread-shared-types.h" 2 3 4




typedef struct __pthread_internal_list
{
  struct __pthread_internal_list *__prev;
  struct __pthread_internal_list *__next;
} __pthread_list_t;

typedef struct __pthread_internal_slist
{
  struct __pthread_internal_slist *__next;
} __pthread_slist_t;
# 74 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/struct_mutex.h" 1 3 4
# 22 "/usr/include/bits/struct_mutex.h" 3 4
struct __pthread_mutex_s
{
  int __lock;
  unsigned int __count;
  int __owner;

  unsigned int __nusers;



  int __kind;

  short __spins;
  short __elision;
  __pthread_list_t __list;
# 53 "/usr/include/bits/struct_mutex.h" 3 4
};
# 75 "/usr/include/bits/thread-shared-types.h" 2 3 4
# 87 "/usr/include/bits/thread-shared-types.h" 3 4
# 1 "/usr/include/bits/struct_rwlock.h" 1 3 4
# 23 "/usr/include/bits/struct_rwlock.h" 3 4
struct __pthread_rwlock_arch_t
{
  unsigned int __readers;
  unsigned int __writers;
  unsigned int __wrphase_futex;
  unsigned int __writers_futex;
  unsigned int __pad3;
  unsigned int __pad4;

  int __cur_writer;
  int __shared;
  signed char __rwelision;




  unsigned char __pad1[7];


  unsigned long int __pad2;


  unsigned int __flags;
# 55 "/usr/include/bits/struct_rwlock.h" 3 4
};
# 88 "/usr/include/bits/thread-shared-types.h" 2 3 4




struct __pthread_cond_s
{
  __extension__ union
  {
    __extension__ unsigned long long int __wseq;
    struct
    {
      unsigned int __low;
      unsigned int __high;
    } __wseq32;
  };
  __extension__ union
  {
    __extension__ unsigned long long int __g1_start;
    struct
    {
      unsigned int __low;
      unsigned int __high;
    } __g1_start32;
  };
  unsigned int __g_refs[2] ;
  unsigned int __g_size[2];
  unsigned int __g1_orig_size;
  unsigned int __wrefs;
  unsigned int __g_signals[2];
};

typedef unsigned int __tss_t;
typedef unsigned long int __thrd_t;

typedef struct
{
  int __data ;
} __once_flag;
# 24 "/usr/include/bits/pthreadtypes.h" 2 3 4



typedef unsigned long int pthread_t;




typedef union
{
  char __size[4];
  int __align;
} pthread_mutexattr_t;




typedef union
{
  char __size[4];
  int __align;
} pthread_condattr_t;



typedef unsigned int pthread_key_t;



typedef int pthread_once_t;


union pthread_attr_t
{
  char __size[56];
  long int __align;
};

typedef union pthread_attr_t pthread_attr_t;




typedef union
{
  struct __pthread_mutex_s __data;
  char __size[40];
  long int __align;
} pthread_mutex_t;


typedef union
{
  struct __pthread_cond_s __data;
  char __size[48];
  __extension__ long long int __align;
} pthread_cond_t;





typedef union
{
  struct __pthread_rwlock_arch_t __data;
  char __size[56];
  long int __align;
} pthread_rwlock_t;

typedef union
{
  char __size[8];
  long int __align;
} pthread_rwlockattr_t;





typedef volatile int pthread_spinlock_t;




typedef union
{
  char __size[32];
  long int __align;
} pthread_barrier_t;

typedef union
{
  char __size[4];
  int __align;
} pthread_barrierattr_t;
# 228 "/usr/include/sys/types.h" 2 3 4



# 395 "/usr/include/stdlib.h" 2 3 4






extern long int random (void) __attribute__ ((__nothrow__ , __leaf__));


extern void srandom (unsigned int __seed) __attribute__ ((__nothrow__ , __leaf__));





extern char *initstate (unsigned int __seed, char *__statebuf,
   size_t __statelen) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



extern char *setstate (char *__statebuf) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







struct random_data
  {
    int32_t *fptr;
    int32_t *rptr;
    int32_t *state;
    int rand_type;
    int rand_deg;
    int rand_sep;
    int32_t *end_ptr;
  };

extern int random_r (struct random_data *__restrict __buf,
       int32_t *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern int srandom_r (unsigned int __seed, struct random_data *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

extern int initstate_r (unsigned int __seed, char *__restrict __statebuf,
   size_t __statelen,
   struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4)));

extern int setstate_r (char *__restrict __statebuf,
         struct random_data *__restrict __buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern int rand (void) __attribute__ ((__nothrow__ , __leaf__));

extern void srand (unsigned int __seed) __attribute__ ((__nothrow__ , __leaf__));



extern int rand_r (unsigned int *__seed) __attribute__ ((__nothrow__ , __leaf__));







extern double drand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern double erand48 (unsigned short int __xsubi[3]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int lrand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern long int nrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int mrand48 (void) __attribute__ ((__nothrow__ , __leaf__));
extern long int jrand48 (unsigned short int __xsubi[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern void srand48 (long int __seedval) __attribute__ ((__nothrow__ , __leaf__));
extern unsigned short int *seed48 (unsigned short int __seed16v[3])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
extern void lcong48 (unsigned short int __param[7]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





struct drand48_data
  {
    unsigned short int __x[3];
    unsigned short int __old_x[3];
    unsigned short int __c;
    unsigned short int __init;
    __extension__ unsigned long long int __a;

  };


extern int drand48_r (struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int erand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        double *__restrict __result) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int lrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int nrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int mrand48_r (struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));
extern int jrand48_r (unsigned short int __xsubi[3],
        struct drand48_data *__restrict __buffer,
        long int *__restrict __result)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));


extern int srand48_r (long int __seedval, struct drand48_data *__buffer)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));

extern int seed48_r (unsigned short int __seed16v[3],
       struct drand48_data *__buffer) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));

extern int lcong48_r (unsigned short int __param[7],
        struct drand48_data *__buffer)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern void *malloc (size_t __size) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__))
     __attribute__ ((__alloc_size__ (1))) ;

extern void *calloc (size_t __nmemb, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__alloc_size__ (1, 2))) ;






extern void *realloc (void *__ptr, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__warn_unused_result__)) __attribute__ ((__alloc_size__ (2)));







extern void *reallocarray (void *__ptr, size_t __nmemb, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__warn_unused_result__))
     __attribute__ ((__alloc_size__ (2, 3)));



extern void free (void *__ptr) __attribute__ ((__nothrow__ , __leaf__));


# 1 "/usr/include/alloca.h" 1 3 4
# 24 "/usr/include/alloca.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 25 "/usr/include/alloca.h" 2 3 4







extern void *alloca (size_t __size) __attribute__ ((__nothrow__ , __leaf__));






# 569 "/usr/include/stdlib.h" 2 3 4





extern void *valloc (size_t __size) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__))
     __attribute__ ((__alloc_size__ (1))) ;




extern int posix_memalign (void **__memptr, size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;




extern void *aligned_alloc (size_t __alignment, size_t __size)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) __attribute__ ((__alloc_size__ (2))) ;



extern void abort (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));



extern int atexit (void (*__func) (void)) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







extern int at_quick_exit (void (*__func) (void)) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int on_exit (void (*__func) (int __status, void *__arg), void *__arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern void exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));





extern void quick_exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));





extern void _Exit (int __status) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__noreturn__));




extern char *getenv (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;




extern char *secure_getenv (const char *__name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;






extern int putenv (char *__string) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int setenv (const char *__name, const char *__value, int __replace)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));


extern int unsetenv (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int clearenv (void) __attribute__ ((__nothrow__ , __leaf__));
# 675 "/usr/include/stdlib.h" 3 4
extern char *mktemp (char *__template) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 691 "/usr/include/stdlib.h" 3 4
extern int mkstemp (char *__template) __asm__ ("" "mkstemp64")
     __attribute__ ((__nonnull__ (1))) ;





extern int mkstemp64 (char *__template) __attribute__ ((__nonnull__ (1))) ;
# 713 "/usr/include/stdlib.h" 3 4
extern int mkstemps (char *__template, int __suffixlen) __asm__ ("" "mkstemps64")
                     __attribute__ ((__nonnull__ (1))) ;





extern int mkstemps64 (char *__template, int __suffixlen)
     __attribute__ ((__nonnull__ (1))) ;
# 731 "/usr/include/stdlib.h" 3 4
extern char *mkdtemp (char *__template) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 745 "/usr/include/stdlib.h" 3 4
extern int mkostemp (char *__template, int __flags) __asm__ ("" "mkostemp64")
     __attribute__ ((__nonnull__ (1))) ;





extern int mkostemp64 (char *__template, int __flags) __attribute__ ((__nonnull__ (1))) ;
# 766 "/usr/include/stdlib.h" 3 4
extern int mkostemps (char *__template, int __suffixlen, int __flags) __asm__ ("" "mkostemps64")

     __attribute__ ((__nonnull__ (1))) ;





extern int mkostemps64 (char *__template, int __suffixlen, int __flags)
     __attribute__ ((__nonnull__ (1))) ;
# 784 "/usr/include/stdlib.h" 3 4
extern int system (const char *__command) ;





extern char *canonicalize_file_name (const char *__name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 800 "/usr/include/stdlib.h" 3 4
extern char *realpath (const char *__restrict __name,
         char *__restrict __resolved) __attribute__ ((__nothrow__ , __leaf__)) ;






typedef int (*__compar_fn_t) (const void *, const void *);


typedef __compar_fn_t comparison_fn_t;



typedef int (*__compar_d_fn_t) (const void *, const void *, void *);




extern void *bsearch (const void *__key, const void *__base,
        size_t __nmemb, size_t __size, __compar_fn_t __compar)
     __attribute__ ((__nonnull__ (1, 2, 5))) ;







extern void qsort (void *__base, size_t __nmemb, size_t __size,
     __compar_fn_t __compar) __attribute__ ((__nonnull__ (1, 4)));

extern void qsort_r (void *__base, size_t __nmemb, size_t __size,
       __compar_d_fn_t __compar, void *__arg)
  __attribute__ ((__nonnull__ (1, 4)));




extern int abs (int __x) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
extern long int labs (long int __x) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;


__extension__ extern long long int llabs (long long int __x)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;






extern div_t div (int __numer, int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
extern ldiv_t ldiv (long int __numer, long int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;


__extension__ extern lldiv_t lldiv (long long int __numer,
        long long int __denom)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__)) ;
# 872 "/usr/include/stdlib.h" 3 4
extern char *ecvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *fcvt (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;




extern char *gcvt (double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3))) ;




extern char *qecvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qfcvt (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4))) ;
extern char *qgcvt (long double __value, int __ndigit, char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3))) ;




extern int ecvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int fcvt_r (double __value, int __ndigit, int *__restrict __decpt,
     int *__restrict __sign, char *__restrict __buf,
     size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));

extern int qecvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));
extern int qfcvt_r (long double __value, int __ndigit,
      int *__restrict __decpt, int *__restrict __sign,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (3, 4, 5)));





extern int mblen (const char *__s, size_t __n) __attribute__ ((__nothrow__ , __leaf__));


extern int mbtowc (wchar_t *__restrict __pwc,
     const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__ , __leaf__));


extern int wctomb (char *__s, wchar_t __wchar) __attribute__ ((__nothrow__ , __leaf__));



extern size_t mbstowcs (wchar_t *__restrict __pwcs,
   const char *__restrict __s, size_t __n) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__read_only__, 2)));

extern size_t wcstombs (char *__restrict __s,
   const wchar_t *__restrict __pwcs, size_t __n)
     __attribute__ ((__nothrow__ , __leaf__))
  __attribute__ ((__access__ (__write_only__, 1, 3))) __attribute__ ((__access__ (__read_only__, 2)));






extern int rpmatch (const char *__response) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 958 "/usr/include/stdlib.h" 3 4
extern int getsubopt (char **__restrict __optionp,
        char *const *__restrict __tokens,
        char **__restrict __valuep)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2, 3))) ;







extern int posix_openpt (int __oflag) ;







extern int grantpt (int __fd) __attribute__ ((__nothrow__ , __leaf__));



extern int unlockpt (int __fd) __attribute__ ((__nothrow__ , __leaf__));




extern char *ptsname (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int ptsname_r (int __fd, char *__buf, size_t __buflen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 2, 3)));


extern int getpt (void);






extern int getloadavg (double __loadavg[], int __nelem)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));
# 1014 "/usr/include/stdlib.h" 3 4
# 1 "/usr/include/bits/stdlib-float.h" 1 3 4
# 1015 "/usr/include/stdlib.h" 2 3 4
# 1026 "/usr/include/stdlib.h" 3 4

# 23 "./include/grub/util/misc.h" 2
# 1 "/usr/include/stdio.h" 1 3 4
# 27 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/libc-header-start.h" 1 3 4
# 28 "/usr/include/stdio.h" 2 3 4





# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 34 "/usr/include/stdio.h" 2 3 4


# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 1 3 4
# 40 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 3 4
typedef __builtin_va_list __gnuc_va_list;
# 37 "/usr/include/stdio.h" 2 3 4


# 1 "/usr/include/bits/types/__fpos_t.h" 1 3 4




# 1 "/usr/include/bits/types/__mbstate_t.h" 1 3 4
# 13 "/usr/include/bits/types/__mbstate_t.h" 3 4
typedef struct
{
  int __count;
  union
  {
    unsigned int __wch;
    char __wchb[4];
  } __value;
} __mbstate_t;
# 6 "/usr/include/bits/types/__fpos_t.h" 2 3 4




typedef struct _G_fpos_t
{
  __off_t __pos;
  __mbstate_t __state;
} __fpos_t;
# 40 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/__fpos64_t.h" 1 3 4
# 10 "/usr/include/bits/types/__fpos64_t.h" 3 4
typedef struct _G_fpos64_t
{
  __off64_t __pos;
  __mbstate_t __state;
} __fpos64_t;
# 41 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/__FILE.h" 1 3 4



struct _IO_FILE;
typedef struct _IO_FILE __FILE;
# 42 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/FILE.h" 1 3 4



struct _IO_FILE;


typedef struct _IO_FILE FILE;
# 43 "/usr/include/stdio.h" 2 3 4
# 1 "/usr/include/bits/types/struct_FILE.h" 1 3 4
# 35 "/usr/include/bits/types/struct_FILE.h" 3 4
struct _IO_FILE;
struct _IO_marker;
struct _IO_codecvt;
struct _IO_wide_data;




typedef void _IO_lock_t;





struct _IO_FILE
{
  int _flags;


  char *_IO_read_ptr;
  char *_IO_read_end;
  char *_IO_read_base;
  char *_IO_write_base;
  char *_IO_write_ptr;
  char *_IO_write_end;
  char *_IO_buf_base;
  char *_IO_buf_end;


  char *_IO_save_base;
  char *_IO_backup_base;
  char *_IO_save_end;

  struct _IO_marker *_markers;

  struct _IO_FILE *_chain;

  int _fileno;
  int _flags2;
  __off_t _old_offset;


  unsigned short _cur_column;
  signed char _vtable_offset;
  char _shortbuf[1];

  _IO_lock_t *_lock;







  __off64_t _offset;

  struct _IO_codecvt *_codecvt;
  struct _IO_wide_data *_wide_data;
  struct _IO_FILE *_freeres_list;
  void *_freeres_buf;
  size_t __pad5;
  int _mode;

  char _unused2[15 * sizeof (int) - 4 * sizeof (void *) - sizeof (size_t)];
};
# 44 "/usr/include/stdio.h" 2 3 4


# 1 "/usr/include/bits/types/cookie_io_functions_t.h" 1 3 4
# 27 "/usr/include/bits/types/cookie_io_functions_t.h" 3 4
typedef __ssize_t cookie_read_function_t (void *__cookie, char *__buf,
                                          size_t __nbytes);







typedef __ssize_t cookie_write_function_t (void *__cookie, const char *__buf,
                                           size_t __nbytes);







typedef int cookie_seek_function_t (void *__cookie, __off64_t *__pos, int __w);


typedef int cookie_close_function_t (void *__cookie);






typedef struct _IO_cookie_io_functions_t
{
  cookie_read_function_t *read;
  cookie_write_function_t *write;
  cookie_seek_function_t *seek;
  cookie_close_function_t *close;
} cookie_io_functions_t;
# 47 "/usr/include/stdio.h" 2 3 4





typedef __gnuc_va_list va_list;
# 86 "/usr/include/stdio.h" 3 4
typedef __fpos64_t fpos_t;


typedef __fpos64_t fpos64_t;
# 133 "/usr/include/stdio.h" 3 4
# 1 "/usr/include/bits/stdio_lim.h" 1 3 4
# 134 "/usr/include/stdio.h" 2 3 4



extern FILE *stdin;
extern FILE *stdout;
extern FILE *stderr;






extern int remove (const char *__filename) __attribute__ ((__nothrow__ , __leaf__));

extern int rename (const char *__old, const char *__new) __attribute__ ((__nothrow__ , __leaf__));



extern int renameat (int __oldfd, const char *__old, int __newfd,
       const char *__new) __attribute__ ((__nothrow__ , __leaf__));
# 164 "/usr/include/stdio.h" 3 4
extern int renameat2 (int __oldfd, const char *__old, int __newfd,
        const char *__new, unsigned int __flags) __attribute__ ((__nothrow__ , __leaf__));
# 176 "/usr/include/stdio.h" 3 4
extern FILE *tmpfile (void) __asm__ ("" "tmpfile64") ;






extern FILE *tmpfile64 (void) ;



extern char *tmpnam (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;




extern char *tmpnam_r (char *__s) __attribute__ ((__nothrow__ , __leaf__)) ;
# 204 "/usr/include/stdio.h" 3 4
extern char *tempnam (const char *__dir, const char *__pfx)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__malloc__)) ;







extern int fclose (FILE *__stream);




extern int fflush (FILE *__stream);
# 227 "/usr/include/stdio.h" 3 4
extern int fflush_unlocked (FILE *__stream);
# 237 "/usr/include/stdio.h" 3 4
extern int fcloseall (void);
# 257 "/usr/include/stdio.h" 3 4
extern FILE *fopen (const char *__restrict __filename, const char *__restrict __modes) __asm__ ("" "fopen64")

  ;
extern FILE *freopen (const char *__restrict __filename, const char *__restrict __modes, FILE *__restrict __stream) __asm__ ("" "freopen64")


  ;






extern FILE *fopen64 (const char *__restrict __filename,
        const char *__restrict __modes) ;
extern FILE *freopen64 (const char *__restrict __filename,
   const char *__restrict __modes,
   FILE *__restrict __stream) ;




extern FILE *fdopen (int __fd, const char *__modes) __attribute__ ((__nothrow__ , __leaf__)) ;





extern FILE *fopencookie (void *__restrict __magic_cookie,
     const char *__restrict __modes,
     cookie_io_functions_t __io_funcs) __attribute__ ((__nothrow__ , __leaf__)) ;




extern FILE *fmemopen (void *__s, size_t __len, const char *__modes)
  __attribute__ ((__nothrow__ , __leaf__)) ;




extern FILE *open_memstream (char **__bufloc, size_t *__sizeloc) __attribute__ ((__nothrow__ , __leaf__)) ;





extern void setbuf (FILE *__restrict __stream, char *__restrict __buf) __attribute__ ((__nothrow__ , __leaf__));



extern int setvbuf (FILE *__restrict __stream, char *__restrict __buf,
      int __modes, size_t __n) __attribute__ ((__nothrow__ , __leaf__));




extern void setbuffer (FILE *__restrict __stream, char *__restrict __buf,
         size_t __size) __attribute__ ((__nothrow__ , __leaf__));


extern void setlinebuf (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));







extern int fprintf (FILE *__restrict __stream,
      const char *__restrict __format, ...);




extern int printf (const char *__restrict __format, ...);

extern int sprintf (char *__restrict __s,
      const char *__restrict __format, ...) __attribute__ ((__nothrow__));





extern int vfprintf (FILE *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg);




extern int vprintf (const char *__restrict __format, __gnuc_va_list __arg);

extern int vsprintf (char *__restrict __s, const char *__restrict __format,
       __gnuc_va_list __arg) __attribute__ ((__nothrow__));



extern int snprintf (char *__restrict __s, size_t __maxlen,
       const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 4)));

extern int vsnprintf (char *__restrict __s, size_t __maxlen,
        const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 3, 0)));





extern int vasprintf (char **__restrict __ptr, const char *__restrict __f,
        __gnuc_va_list __arg)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 0))) ;
extern int __asprintf (char **__restrict __ptr,
         const char *__restrict __fmt, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3))) ;
extern int asprintf (char **__restrict __ptr,
       const char *__restrict __fmt, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3))) ;




extern int vdprintf (int __fd, const char *__restrict __fmt,
       __gnuc_va_list __arg)
     __attribute__ ((__format__ (__printf__, 2, 0)));
extern int dprintf (int __fd, const char *__restrict __fmt, ...)
     __attribute__ ((__format__ (__printf__, 2, 3)));







extern int fscanf (FILE *__restrict __stream,
     const char *__restrict __format, ...) ;




extern int scanf (const char *__restrict __format, ...) ;

extern int sscanf (const char *__restrict __s,
     const char *__restrict __format, ...) __attribute__ ((__nothrow__ , __leaf__));
# 410 "/usr/include/stdio.h" 3 4
extern int fscanf (FILE *__restrict __stream, const char *__restrict __format, ...) __asm__ ("" "__isoc99_fscanf")

                               ;
extern int scanf (const char *__restrict __format, ...) __asm__ ("" "__isoc99_scanf")
                              ;
extern int sscanf (const char *__restrict __s, const char *__restrict __format, ...) __asm__ ("" "__isoc99_sscanf") __attribute__ ((__nothrow__ , __leaf__))

                      ;
# 435 "/usr/include/stdio.h" 3 4
extern int vfscanf (FILE *__restrict __s, const char *__restrict __format,
      __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 2, 0))) ;





extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__format__ (__scanf__, 1, 0))) ;


extern int vsscanf (const char *__restrict __s,
      const char *__restrict __format, __gnuc_va_list __arg)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format__ (__scanf__, 2, 0)));





extern int vfscanf (FILE *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vfscanf")



     __attribute__ ((__format__ (__scanf__, 2, 0))) ;
extern int vscanf (const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vscanf")

     __attribute__ ((__format__ (__scanf__, 1, 0))) ;
extern int vsscanf (const char *__restrict __s, const char *__restrict __format, __gnuc_va_list __arg) __asm__ ("" "__isoc99_vsscanf") __attribute__ ((__nothrow__ , __leaf__))



     __attribute__ ((__format__ (__scanf__, 2, 0)));
# 489 "/usr/include/stdio.h" 3 4
extern int fgetc (FILE *__stream);
extern int getc (FILE *__stream);





extern int getchar (void);






extern int getc_unlocked (FILE *__stream);
extern int getchar_unlocked (void);
# 514 "/usr/include/stdio.h" 3 4
extern int fgetc_unlocked (FILE *__stream);
# 525 "/usr/include/stdio.h" 3 4
extern int fputc (int __c, FILE *__stream);
extern int putc (int __c, FILE *__stream);





extern int putchar (int __c);
# 541 "/usr/include/stdio.h" 3 4
extern int fputc_unlocked (int __c, FILE *__stream);







extern int putc_unlocked (int __c, FILE *__stream);
extern int putchar_unlocked (int __c);






extern int getw (FILE *__stream);


extern int putw (int __w, FILE *__stream);







extern char *fgets (char *__restrict __s, int __n, FILE *__restrict __stream)
     __attribute__ ((__access__ (__write_only__, 1, 2)));
# 591 "/usr/include/stdio.h" 3 4
extern char *fgets_unlocked (char *__restrict __s, int __n,
        FILE *__restrict __stream)
    __attribute__ ((__access__ (__write_only__, 1, 2)));
# 608 "/usr/include/stdio.h" 3 4
extern __ssize_t __getdelim (char **__restrict __lineptr,
                             size_t *__restrict __n, int __delimiter,
                             FILE *__restrict __stream) ;
extern __ssize_t getdelim (char **__restrict __lineptr,
                           size_t *__restrict __n, int __delimiter,
                           FILE *__restrict __stream) ;







extern __ssize_t getline (char **__restrict __lineptr,
                          size_t *__restrict __n,
                          FILE *__restrict __stream) ;







extern int fputs (const char *__restrict __s, FILE *__restrict __stream);





extern int puts (const char *__s);






extern int ungetc (int __c, FILE *__stream);






extern size_t fread (void *__restrict __ptr, size_t __size,
       size_t __n, FILE *__restrict __stream) ;




extern size_t fwrite (const void *__restrict __ptr, size_t __size,
        size_t __n, FILE *__restrict __s);
# 667 "/usr/include/stdio.h" 3 4
extern int fputs_unlocked (const char *__restrict __s,
      FILE *__restrict __stream);
# 678 "/usr/include/stdio.h" 3 4
extern size_t fread_unlocked (void *__restrict __ptr, size_t __size,
         size_t __n, FILE *__restrict __stream) ;
extern size_t fwrite_unlocked (const void *__restrict __ptr, size_t __size,
          size_t __n, FILE *__restrict __stream);







extern int fseek (FILE *__stream, long int __off, int __whence);




extern long int ftell (FILE *__stream) ;




extern void rewind (FILE *__stream);
# 720 "/usr/include/stdio.h" 3 4
extern int fseeko (FILE *__stream, __off64_t __off, int __whence) __asm__ ("" "fseeko64")

                  ;
extern __off64_t ftello (FILE *__stream) __asm__ ("" "ftello64");
# 744 "/usr/include/stdio.h" 3 4
extern int fgetpos (FILE *__restrict __stream, fpos_t *__restrict __pos) __asm__ ("" "fgetpos64")
                                          ;
extern int fsetpos (FILE *__stream, const fpos_t *__pos) __asm__ ("" "fsetpos64")
                                                          ;







extern int fseeko64 (FILE *__stream, __off64_t __off, int __whence);
extern __off64_t ftello64 (FILE *__stream) ;
extern int fgetpos64 (FILE *__restrict __stream, fpos64_t *__restrict __pos);
extern int fsetpos64 (FILE *__stream, const fpos64_t *__pos);



extern void clearerr (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));

extern int feof (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;

extern int ferror (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;



extern void clearerr_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
extern int feof_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
extern int ferror_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;







extern void perror (const char *__s);




extern int fileno (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int fileno_unlocked (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;
# 799 "/usr/include/stdio.h" 3 4
extern FILE *popen (const char *__command, const char *__modes) ;





extern int pclose (FILE *__stream);





extern char *ctermid (char *__s) __attribute__ ((__nothrow__ , __leaf__));





extern char *cuserid (char *__s);




struct obstack;


extern int obstack_printf (struct obstack *__restrict __obstack,
      const char *__restrict __format, ...)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 3)));
extern int obstack_vprintf (struct obstack *__restrict __obstack,
       const char *__restrict __format,
       __gnuc_va_list __args)
     __attribute__ ((__nothrow__)) __attribute__ ((__format__ (__printf__, 2, 0)));







extern void flockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));



extern int ftrylockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__)) ;


extern void funlockfile (FILE *__stream) __attribute__ ((__nothrow__ , __leaf__));
# 857 "/usr/include/stdio.h" 3 4
extern int __uflow (FILE *);
extern int __overflow (FILE *, int);
# 874 "/usr/include/stdio.h" 3 4

# 24 "./include/grub/util/misc.h" 2
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stdarg.h" 1 3 4
# 25 "./include/grub/util/misc.h" 2
# 1 "/usr/include/setjmp.h" 1 3 4
# 27 "/usr/include/setjmp.h" 3 4


# 1 "/usr/include/bits/setjmp.h" 1 3 4
# 26 "/usr/include/bits/setjmp.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 27 "/usr/include/bits/setjmp.h" 2 3 4




typedef long int __jmp_buf[8];
# 30 "/usr/include/setjmp.h" 2 3 4



struct __jmp_buf_tag
  {




    __jmp_buf __jmpbuf;
    int __mask_was_saved;
    __sigset_t __saved_mask;
  };


typedef struct __jmp_buf_tag jmp_buf[1];



extern int setjmp (jmp_buf __env) __attribute__ ((__nothrow__));




extern int __sigsetjmp (struct __jmp_buf_tag __env[1], int __savemask) __attribute__ ((__nothrow__));



extern int _setjmp (struct __jmp_buf_tag __env[1]) __attribute__ ((__nothrow__));
# 67 "/usr/include/setjmp.h" 3 4
extern void longjmp (struct __jmp_buf_tag __env[1], int __val)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));





extern void _longjmp (struct __jmp_buf_tag __env[1], int __val)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));







typedef struct __jmp_buf_tag sigjmp_buf[1];
# 93 "/usr/include/setjmp.h" 3 4
extern void siglongjmp (sigjmp_buf __env, int __val)
     __attribute__ ((__nothrow__)) __attribute__ ((__noreturn__));
# 103 "/usr/include/setjmp.h" 3 4

# 26 "./include/grub/util/misc.h" 2
# 1 "/usr/include/unistd.h" 1 3 4
# 27 "/usr/include/unistd.h" 3 4

# 202 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/posix_opt.h" 1 3 4
# 203 "/usr/include/unistd.h" 2 3 4



# 1 "/usr/include/bits/environments.h" 1 3 4
# 22 "/usr/include/bits/environments.h" 3 4
# 1 "/usr/include/bits/wordsize.h" 1 3 4
# 23 "/usr/include/bits/environments.h" 2 3 4
# 207 "/usr/include/unistd.h" 2 3 4
# 226 "/usr/include/unistd.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 227 "/usr/include/unistd.h" 2 3 4
# 267 "/usr/include/unistd.h" 3 4
typedef __intptr_t intptr_t;






typedef __socklen_t socklen_t;
# 287 "/usr/include/unistd.h" 3 4
extern int access (const char *__name, int __type) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));




extern int euidaccess (const char *__name, int __type)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern int eaccess (const char *__name, int __type)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));






extern int faccessat (int __fd, const char *__file, int __type, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;
# 337 "/usr/include/unistd.h" 3 4
extern __off64_t lseek (int __fd, __off64_t __offset, int __whence) __asm__ ("" "lseek64") __attribute__ ((__nothrow__ , __leaf__))

             ;





extern __off64_t lseek64 (int __fd, __off64_t __offset, int __whence)
     __attribute__ ((__nothrow__ , __leaf__));






extern int close (int __fd);






extern ssize_t read (int __fd, void *__buf, size_t __nbytes)
    __attribute__ ((__access__ (__write_only__, 2, 3)));





extern ssize_t write (int __fd, const void *__buf, size_t __n)
    __attribute__ ((__access__ (__read_only__, 2, 3)));
# 393 "/usr/include/unistd.h" 3 4
extern ssize_t pread (int __fd, void *__buf, size_t __nbytes, __off64_t __offset) __asm__ ("" "pread64")


    __attribute__ ((__access__ (__write_only__, 2, 3)));
extern ssize_t pwrite (int __fd, const void *__buf, size_t __nbytes, __off64_t __offset) __asm__ ("" "pwrite64")


    __attribute__ ((__access__ (__read_only__, 2, 3)));
# 411 "/usr/include/unistd.h" 3 4
extern ssize_t pread64 (int __fd, void *__buf, size_t __nbytes,
   __off64_t __offset)
    __attribute__ ((__access__ (__write_only__, 2, 3)));


extern ssize_t pwrite64 (int __fd, const void *__buf, size_t __n,
    __off64_t __offset)
    __attribute__ ((__access__ (__read_only__, 2, 3)));







extern int pipe (int __pipedes[2]) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int pipe2 (int __pipedes[2], int __flags) __attribute__ ((__nothrow__ , __leaf__)) ;
# 441 "/usr/include/unistd.h" 3 4
extern unsigned int alarm (unsigned int __seconds) __attribute__ ((__nothrow__ , __leaf__));
# 453 "/usr/include/unistd.h" 3 4
extern unsigned int sleep (unsigned int __seconds);







extern __useconds_t ualarm (__useconds_t __value, __useconds_t __interval)
     __attribute__ ((__nothrow__ , __leaf__));






extern int usleep (__useconds_t __useconds);
# 478 "/usr/include/unistd.h" 3 4
extern int pause (void);



extern int chown (const char *__file, __uid_t __owner, __gid_t __group)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern int fchown (int __fd, __uid_t __owner, __gid_t __group) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int lchown (const char *__file, __uid_t __owner, __gid_t __group)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;






extern int fchownat (int __fd, const char *__file, __uid_t __owner,
       __gid_t __group, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) ;



extern int chdir (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern int fchdir (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;
# 520 "/usr/include/unistd.h" 3 4
extern char *getcwd (char *__buf, size_t __size) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 1, 2)));





extern char *get_current_dir_name (void) __attribute__ ((__nothrow__ , __leaf__));







extern char *getwd (char *__buf)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__deprecated__))
    __attribute__ ((__access__ (__write_only__, 1)));




extern int dup (int __fd) __attribute__ ((__nothrow__ , __leaf__)) ;


extern int dup2 (int __fd, int __fd2) __attribute__ ((__nothrow__ , __leaf__));




extern int dup3 (int __fd, int __fd2, int __flags) __attribute__ ((__nothrow__ , __leaf__));



extern char **__environ;

extern char **environ;





extern int execve (const char *__path, char *const __argv[],
     char *const __envp[]) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int fexecve (int __fd, char *const __argv[], char *const __envp[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));




extern int execv (const char *__path, char *const __argv[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execle (const char *__path, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execl (const char *__path, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));



extern int execvp (const char *__file, char *const __argv[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int execlp (const char *__file, const char *__arg, ...)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));




extern int execvpe (const char *__file, char *const __argv[],
      char *const __envp[])
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));





extern int nice (int __inc) __attribute__ ((__nothrow__ , __leaf__)) ;




extern void _exit (int __status) __attribute__ ((__noreturn__));





# 1 "/usr/include/bits/confname.h" 1 3 4
# 24 "/usr/include/bits/confname.h" 3 4
enum
  {
    _PC_LINK_MAX,

    _PC_MAX_CANON,

    _PC_MAX_INPUT,

    _PC_NAME_MAX,

    _PC_PATH_MAX,

    _PC_PIPE_BUF,

    _PC_CHOWN_RESTRICTED,

    _PC_NO_TRUNC,

    _PC_VDISABLE,

    _PC_SYNC_IO,

    _PC_ASYNC_IO,

    _PC_PRIO_IO,

    _PC_SOCK_MAXBUF,

    _PC_FILESIZEBITS,

    _PC_REC_INCR_XFER_SIZE,

    _PC_REC_MAX_XFER_SIZE,

    _PC_REC_MIN_XFER_SIZE,

    _PC_REC_XFER_ALIGN,

    _PC_ALLOC_SIZE_MIN,

    _PC_SYMLINK_MAX,

    _PC_2_SYMLINKS

  };


enum
  {
    _SC_ARG_MAX,

    _SC_CHILD_MAX,

    _SC_CLK_TCK,

    _SC_NGROUPS_MAX,

    _SC_OPEN_MAX,

    _SC_STREAM_MAX,

    _SC_TZNAME_MAX,

    _SC_JOB_CONTROL,

    _SC_SAVED_IDS,

    _SC_REALTIME_SIGNALS,

    _SC_PRIORITY_SCHEDULING,

    _SC_TIMERS,

    _SC_ASYNCHRONOUS_IO,

    _SC_PRIORITIZED_IO,

    _SC_SYNCHRONIZED_IO,

    _SC_FSYNC,

    _SC_MAPPED_FILES,

    _SC_MEMLOCK,

    _SC_MEMLOCK_RANGE,

    _SC_MEMORY_PROTECTION,

    _SC_MESSAGE_PASSING,

    _SC_SEMAPHORES,

    _SC_SHARED_MEMORY_OBJECTS,

    _SC_AIO_LISTIO_MAX,

    _SC_AIO_MAX,

    _SC_AIO_PRIO_DELTA_MAX,

    _SC_DELAYTIMER_MAX,

    _SC_MQ_OPEN_MAX,

    _SC_MQ_PRIO_MAX,

    _SC_VERSION,

    _SC_PAGESIZE,


    _SC_RTSIG_MAX,

    _SC_SEM_NSEMS_MAX,

    _SC_SEM_VALUE_MAX,

    _SC_SIGQUEUE_MAX,

    _SC_TIMER_MAX,




    _SC_BC_BASE_MAX,

    _SC_BC_DIM_MAX,

    _SC_BC_SCALE_MAX,

    _SC_BC_STRING_MAX,

    _SC_COLL_WEIGHTS_MAX,

    _SC_EQUIV_CLASS_MAX,

    _SC_EXPR_NEST_MAX,

    _SC_LINE_MAX,

    _SC_RE_DUP_MAX,

    _SC_CHARCLASS_NAME_MAX,


    _SC_2_VERSION,

    _SC_2_C_BIND,

    _SC_2_C_DEV,

    _SC_2_FORT_DEV,

    _SC_2_FORT_RUN,

    _SC_2_SW_DEV,

    _SC_2_LOCALEDEF,


    _SC_PII,

    _SC_PII_XTI,

    _SC_PII_SOCKET,

    _SC_PII_INTERNET,

    _SC_PII_OSI,

    _SC_POLL,

    _SC_SELECT,

    _SC_UIO_MAXIOV,

    _SC_IOV_MAX = _SC_UIO_MAXIOV,

    _SC_PII_INTERNET_STREAM,

    _SC_PII_INTERNET_DGRAM,

    _SC_PII_OSI_COTS,

    _SC_PII_OSI_CLTS,

    _SC_PII_OSI_M,

    _SC_T_IOV_MAX,



    _SC_THREADS,

    _SC_THREAD_SAFE_FUNCTIONS,

    _SC_GETGR_R_SIZE_MAX,

    _SC_GETPW_R_SIZE_MAX,

    _SC_LOGIN_NAME_MAX,

    _SC_TTY_NAME_MAX,

    _SC_THREAD_DESTRUCTOR_ITERATIONS,

    _SC_THREAD_KEYS_MAX,

    _SC_THREAD_STACK_MIN,

    _SC_THREAD_THREADS_MAX,

    _SC_THREAD_ATTR_STACKADDR,

    _SC_THREAD_ATTR_STACKSIZE,

    _SC_THREAD_PRIORITY_SCHEDULING,

    _SC_THREAD_PRIO_INHERIT,

    _SC_THREAD_PRIO_PROTECT,

    _SC_THREAD_PROCESS_SHARED,


    _SC_NPROCESSORS_CONF,

    _SC_NPROCESSORS_ONLN,

    _SC_PHYS_PAGES,

    _SC_AVPHYS_PAGES,

    _SC_ATEXIT_MAX,

    _SC_PASS_MAX,


    _SC_XOPEN_VERSION,

    _SC_XOPEN_XCU_VERSION,

    _SC_XOPEN_UNIX,

    _SC_XOPEN_CRYPT,

    _SC_XOPEN_ENH_I18N,

    _SC_XOPEN_SHM,


    _SC_2_CHAR_TERM,

    _SC_2_C_VERSION,

    _SC_2_UPE,


    _SC_XOPEN_XPG2,

    _SC_XOPEN_XPG3,

    _SC_XOPEN_XPG4,


    _SC_CHAR_BIT,

    _SC_CHAR_MAX,

    _SC_CHAR_MIN,

    _SC_INT_MAX,

    _SC_INT_MIN,

    _SC_LONG_BIT,

    _SC_WORD_BIT,

    _SC_MB_LEN_MAX,

    _SC_NZERO,

    _SC_SSIZE_MAX,

    _SC_SCHAR_MAX,

    _SC_SCHAR_MIN,

    _SC_SHRT_MAX,

    _SC_SHRT_MIN,

    _SC_UCHAR_MAX,

    _SC_UINT_MAX,

    _SC_ULONG_MAX,

    _SC_USHRT_MAX,


    _SC_NL_ARGMAX,

    _SC_NL_LANGMAX,

    _SC_NL_MSGMAX,

    _SC_NL_NMAX,

    _SC_NL_SETMAX,

    _SC_NL_TEXTMAX,


    _SC_XBS5_ILP32_OFF32,

    _SC_XBS5_ILP32_OFFBIG,

    _SC_XBS5_LP64_OFF64,

    _SC_XBS5_LPBIG_OFFBIG,


    _SC_XOPEN_LEGACY,

    _SC_XOPEN_REALTIME,

    _SC_XOPEN_REALTIME_THREADS,


    _SC_ADVISORY_INFO,

    _SC_BARRIERS,

    _SC_BASE,

    _SC_C_LANG_SUPPORT,

    _SC_C_LANG_SUPPORT_R,

    _SC_CLOCK_SELECTION,

    _SC_CPUTIME,

    _SC_THREAD_CPUTIME,

    _SC_DEVICE_IO,

    _SC_DEVICE_SPECIFIC,

    _SC_DEVICE_SPECIFIC_R,

    _SC_FD_MGMT,

    _SC_FIFO,

    _SC_PIPE,

    _SC_FILE_ATTRIBUTES,

    _SC_FILE_LOCKING,

    _SC_FILE_SYSTEM,

    _SC_MONOTONIC_CLOCK,

    _SC_MULTI_PROCESS,

    _SC_SINGLE_PROCESS,

    _SC_NETWORKING,

    _SC_READER_WRITER_LOCKS,

    _SC_SPIN_LOCKS,

    _SC_REGEXP,

    _SC_REGEX_VERSION,

    _SC_SHELL,

    _SC_SIGNALS,

    _SC_SPAWN,

    _SC_SPORADIC_SERVER,

    _SC_THREAD_SPORADIC_SERVER,

    _SC_SYSTEM_DATABASE,

    _SC_SYSTEM_DATABASE_R,

    _SC_TIMEOUTS,

    _SC_TYPED_MEMORY_OBJECTS,

    _SC_USER_GROUPS,

    _SC_USER_GROUPS_R,

    _SC_2_PBS,

    _SC_2_PBS_ACCOUNTING,

    _SC_2_PBS_LOCATE,

    _SC_2_PBS_MESSAGE,

    _SC_2_PBS_TRACK,

    _SC_SYMLOOP_MAX,

    _SC_STREAMS,

    _SC_2_PBS_CHECKPOINT,


    _SC_V6_ILP32_OFF32,

    _SC_V6_ILP32_OFFBIG,

    _SC_V6_LP64_OFF64,

    _SC_V6_LPBIG_OFFBIG,


    _SC_HOST_NAME_MAX,

    _SC_TRACE,

    _SC_TRACE_EVENT_FILTER,

    _SC_TRACE_INHERIT,

    _SC_TRACE_LOG,


    _SC_LEVEL1_ICACHE_SIZE,

    _SC_LEVEL1_ICACHE_ASSOC,

    _SC_LEVEL1_ICACHE_LINESIZE,

    _SC_LEVEL1_DCACHE_SIZE,

    _SC_LEVEL1_DCACHE_ASSOC,

    _SC_LEVEL1_DCACHE_LINESIZE,

    _SC_LEVEL2_CACHE_SIZE,

    _SC_LEVEL2_CACHE_ASSOC,

    _SC_LEVEL2_CACHE_LINESIZE,

    _SC_LEVEL3_CACHE_SIZE,

    _SC_LEVEL3_CACHE_ASSOC,

    _SC_LEVEL3_CACHE_LINESIZE,

    _SC_LEVEL4_CACHE_SIZE,

    _SC_LEVEL4_CACHE_ASSOC,

    _SC_LEVEL4_CACHE_LINESIZE,



    _SC_IPV6 = _SC_LEVEL1_ICACHE_SIZE + 50,

    _SC_RAW_SOCKETS,


    _SC_V7_ILP32_OFF32,

    _SC_V7_ILP32_OFFBIG,

    _SC_V7_LP64_OFF64,

    _SC_V7_LPBIG_OFFBIG,


    _SC_SS_REPL_MAX,


    _SC_TRACE_EVENT_NAME_MAX,

    _SC_TRACE_NAME_MAX,

    _SC_TRACE_SYS_MAX,

    _SC_TRACE_USER_EVENT_MAX,


    _SC_XOPEN_STREAMS,


    _SC_THREAD_ROBUST_PRIO_INHERIT,

    _SC_THREAD_ROBUST_PRIO_PROTECT

  };


enum
  {
    _CS_PATH,


    _CS_V6_WIDTH_RESTRICTED_ENVS,



    _CS_GNU_LIBC_VERSION,

    _CS_GNU_LIBPTHREAD_VERSION,


    _CS_V5_WIDTH_RESTRICTED_ENVS,



    _CS_V7_WIDTH_RESTRICTED_ENVS,



    _CS_LFS_CFLAGS = 1000,

    _CS_LFS_LDFLAGS,

    _CS_LFS_LIBS,

    _CS_LFS_LINTFLAGS,

    _CS_LFS64_CFLAGS,

    _CS_LFS64_LDFLAGS,

    _CS_LFS64_LIBS,

    _CS_LFS64_LINTFLAGS,


    _CS_XBS5_ILP32_OFF32_CFLAGS = 1100,

    _CS_XBS5_ILP32_OFF32_LDFLAGS,

    _CS_XBS5_ILP32_OFF32_LIBS,

    _CS_XBS5_ILP32_OFF32_LINTFLAGS,

    _CS_XBS5_ILP32_OFFBIG_CFLAGS,

    _CS_XBS5_ILP32_OFFBIG_LDFLAGS,

    _CS_XBS5_ILP32_OFFBIG_LIBS,

    _CS_XBS5_ILP32_OFFBIG_LINTFLAGS,

    _CS_XBS5_LP64_OFF64_CFLAGS,

    _CS_XBS5_LP64_OFF64_LDFLAGS,

    _CS_XBS5_LP64_OFF64_LIBS,

    _CS_XBS5_LP64_OFF64_LINTFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_CFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_LDFLAGS,

    _CS_XBS5_LPBIG_OFFBIG_LIBS,

    _CS_XBS5_LPBIG_OFFBIG_LINTFLAGS,


    _CS_POSIX_V6_ILP32_OFF32_CFLAGS,

    _CS_POSIX_V6_ILP32_OFF32_LDFLAGS,

    _CS_POSIX_V6_ILP32_OFF32_LIBS,

    _CS_POSIX_V6_ILP32_OFF32_LINTFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_CFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_LDFLAGS,

    _CS_POSIX_V6_ILP32_OFFBIG_LIBS,

    _CS_POSIX_V6_ILP32_OFFBIG_LINTFLAGS,

    _CS_POSIX_V6_LP64_OFF64_CFLAGS,

    _CS_POSIX_V6_LP64_OFF64_LDFLAGS,

    _CS_POSIX_V6_LP64_OFF64_LIBS,

    _CS_POSIX_V6_LP64_OFF64_LINTFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_CFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LDFLAGS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LIBS,

    _CS_POSIX_V6_LPBIG_OFFBIG_LINTFLAGS,


    _CS_POSIX_V7_ILP32_OFF32_CFLAGS,

    _CS_POSIX_V7_ILP32_OFF32_LDFLAGS,

    _CS_POSIX_V7_ILP32_OFF32_LIBS,

    _CS_POSIX_V7_ILP32_OFF32_LINTFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_CFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_LDFLAGS,

    _CS_POSIX_V7_ILP32_OFFBIG_LIBS,

    _CS_POSIX_V7_ILP32_OFFBIG_LINTFLAGS,

    _CS_POSIX_V7_LP64_OFF64_CFLAGS,

    _CS_POSIX_V7_LP64_OFF64_LDFLAGS,

    _CS_POSIX_V7_LP64_OFF64_LIBS,

    _CS_POSIX_V7_LP64_OFF64_LINTFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_CFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LDFLAGS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LIBS,

    _CS_POSIX_V7_LPBIG_OFFBIG_LINTFLAGS,


    _CS_V6_ENV,

    _CS_V7_ENV

  };
# 621 "/usr/include/unistd.h" 2 3 4


extern long int pathconf (const char *__path, int __name)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));


extern long int fpathconf (int __fd, int __name) __attribute__ ((__nothrow__ , __leaf__));


extern long int sysconf (int __name) __attribute__ ((__nothrow__ , __leaf__));



extern size_t confstr (int __name, char *__buf, size_t __len) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 2, 3)));




extern __pid_t getpid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t getppid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t getpgrp (void) __attribute__ ((__nothrow__ , __leaf__));


extern __pid_t __getpgid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));

extern __pid_t getpgid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));






extern int setpgid (__pid_t __pid, __pid_t __pgid) __attribute__ ((__nothrow__ , __leaf__));
# 672 "/usr/include/unistd.h" 3 4
extern int setpgrp (void) __attribute__ ((__nothrow__ , __leaf__));






extern __pid_t setsid (void) __attribute__ ((__nothrow__ , __leaf__));



extern __pid_t getsid (__pid_t __pid) __attribute__ ((__nothrow__ , __leaf__));



extern __uid_t getuid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __uid_t geteuid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __gid_t getgid (void) __attribute__ ((__nothrow__ , __leaf__));


extern __gid_t getegid (void) __attribute__ ((__nothrow__ , __leaf__));




extern int getgroups (int __size, __gid_t __list[]) __attribute__ ((__nothrow__ , __leaf__))
    __attribute__ ((__access__ (__write_only__, 2, 1)));


extern int group_member (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__));






extern int setuid (__uid_t __uid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setreuid (__uid_t __ruid, __uid_t __euid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int seteuid (__uid_t __uid) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int setgid (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setregid (__gid_t __rgid, __gid_t __egid) __attribute__ ((__nothrow__ , __leaf__)) ;




extern int setegid (__gid_t __gid) __attribute__ ((__nothrow__ , __leaf__)) ;





extern int getresuid (__uid_t *__ruid, __uid_t *__euid, __uid_t *__suid)
     __attribute__ ((__nothrow__ , __leaf__));



extern int getresgid (__gid_t *__rgid, __gid_t *__egid, __gid_t *__sgid)
     __attribute__ ((__nothrow__ , __leaf__));



extern int setresuid (__uid_t __ruid, __uid_t __euid, __uid_t __suid)
     __attribute__ ((__nothrow__ , __leaf__)) ;



extern int setresgid (__gid_t __rgid, __gid_t __egid, __gid_t __sgid)
     __attribute__ ((__nothrow__ , __leaf__)) ;






extern __pid_t fork (void) __attribute__ ((__nothrow__));







extern __pid_t vfork (void) __attribute__ ((__nothrow__ , __leaf__));





extern char *ttyname (int __fd) __attribute__ ((__nothrow__ , __leaf__));



extern int ttyname_r (int __fd, char *__buf, size_t __buflen)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2))) __attribute__ ((__access__ (__write_only__, 2, 3)));



extern int isatty (int __fd) __attribute__ ((__nothrow__ , __leaf__));




extern int ttyslot (void) __attribute__ ((__nothrow__ , __leaf__));




extern int link (const char *__from, const char *__to)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) ;




extern int linkat (int __fromfd, const char *__from, int __tofd,
     const char *__to, int __flags)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 4))) ;




extern int symlink (const char *__from, const char *__to)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) ;




extern ssize_t readlink (const char *__restrict __path,
    char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2))) __attribute__ ((__access__ (__write_only__, 2, 3)));





extern int symlinkat (const char *__from, int __tofd,
        const char *__to) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 3))) ;


extern ssize_t readlinkat (int __fd, const char *__restrict __path,
      char *__restrict __buf, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3))) __attribute__ ((__access__ (__read_only__, 3, 4)));



extern int unlink (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern int unlinkat (int __fd, const char *__name, int __flag)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2)));



extern int rmdir (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));



extern __pid_t tcgetpgrp (int __fd) __attribute__ ((__nothrow__ , __leaf__));


extern int tcsetpgrp (int __fd, __pid_t __pgrp_id) __attribute__ ((__nothrow__ , __leaf__));






extern char *getlogin (void);







extern int getlogin_r (char *__name, size_t __name_len) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));




extern int setlogin (const char *__name) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));







# 1 "/usr/include/bits/getopt_posix.h" 1 3 4
# 27 "/usr/include/bits/getopt_posix.h" 3 4
# 1 "/usr/include/bits/getopt_core.h" 1 3 4
# 28 "/usr/include/bits/getopt_core.h" 3 4








extern char *optarg;
# 50 "/usr/include/bits/getopt_core.h" 3 4
extern int optind;




extern int opterr;



extern int optopt;
# 91 "/usr/include/bits/getopt_core.h" 3 4
extern int getopt (int ___argc, char *const *___argv, const char *__shortopts)
       __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (2, 3)));


# 28 "/usr/include/bits/getopt_posix.h" 2 3 4


# 49 "/usr/include/bits/getopt_posix.h" 3 4

# 884 "/usr/include/unistd.h" 2 3 4







extern int gethostname (char *__name, size_t __len) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)))
    __attribute__ ((__access__ (__write_only__, 1, 2)));






extern int sethostname (const char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__read_only__, 1, 2)));



extern int sethostid (long int __id) __attribute__ ((__nothrow__ , __leaf__)) ;





extern int getdomainname (char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__write_only__, 1, 2)));
extern int setdomainname (const char *__name, size_t __len)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) __attribute__ ((__access__ (__read_only__, 1, 2)));




extern int vhangup (void) __attribute__ ((__nothrow__ , __leaf__));


extern int revoke (const char *__file) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;







extern int profil (unsigned short int *__sample_buffer, size_t __size,
     size_t __offset, unsigned int __scale)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1)));





extern int acct (const char *__name) __attribute__ ((__nothrow__ , __leaf__));



extern char *getusershell (void) __attribute__ ((__nothrow__ , __leaf__));
extern void endusershell (void) __attribute__ ((__nothrow__ , __leaf__));
extern void setusershell (void) __attribute__ ((__nothrow__ , __leaf__));





extern int daemon (int __nochdir, int __noclose) __attribute__ ((__nothrow__ , __leaf__)) ;






extern int chroot (const char *__path) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;



extern char *getpass (const char *__prompt) __attribute__ ((__nonnull__ (1)));







extern int fsync (int __fd);





extern int syncfs (int __fd) __attribute__ ((__nothrow__ , __leaf__));






extern long int gethostid (void);


extern void sync (void) __attribute__ ((__nothrow__ , __leaf__));





extern int getpagesize (void) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__const__));




extern int getdtablesize (void) __attribute__ ((__nothrow__ , __leaf__));
# 1009 "/usr/include/unistd.h" 3 4
extern int truncate (const char *__file, __off64_t __length) __asm__ ("" "truncate64") __attribute__ ((__nothrow__ , __leaf__))

                  __attribute__ ((__nonnull__ (1))) ;





extern int truncate64 (const char *__file, __off64_t __length)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1))) ;
# 1031 "/usr/include/unistd.h" 3 4
extern int ftruncate (int __fd, __off64_t __length) __asm__ ("" "ftruncate64") __attribute__ ((__nothrow__ , __leaf__))
                        ;





extern int ftruncate64 (int __fd, __off64_t __length) __attribute__ ((__nothrow__ , __leaf__)) ;
# 1049 "/usr/include/unistd.h" 3 4
extern int brk (void *__addr) __attribute__ ((__nothrow__ , __leaf__)) ;





extern void *sbrk (intptr_t __delta) __attribute__ ((__nothrow__ , __leaf__));
# 1070 "/usr/include/unistd.h" 3 4
extern long int syscall (long int __sysno, ...) __attribute__ ((__nothrow__ , __leaf__));
# 1096 "/usr/include/unistd.h" 3 4
extern int lockf (int __fd, int __cmd, __off64_t __len) __asm__ ("" "lockf64")
                       ;





extern int lockf64 (int __fd, int __cmd, __off64_t __len) ;
# 1121 "/usr/include/unistd.h" 3 4
ssize_t copy_file_range (int __infd, __off64_t *__pinoff,
    int __outfd, __off64_t *__poutoff,
    size_t __length, unsigned int __flags);





extern int fdatasync (int __fildes);
# 1138 "/usr/include/unistd.h" 3 4
extern char *crypt (const char *__key, const char *__salt)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)));







extern void swab (const void *__restrict __from, void *__restrict __to,
    ssize_t __n) __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__nonnull__ (1, 2)))
    __attribute__ ((__access__ (__read_only__, 1, 3)))
    __attribute__ ((__access__ (__write_only__, 2, 3)));
# 1177 "/usr/include/unistd.h" 3 4
int getentropy (void *__buffer, size_t __length)
    __attribute__ ((__access__ (__write_only__, 1, 2)));
# 1187 "/usr/include/unistd.h" 3 4
# 1 "/usr/include/bits/unistd_ext.h" 1 3 4
# 34 "/usr/include/bits/unistd_ext.h" 3 4
extern __pid_t gettid (void) __attribute__ ((__nothrow__ , __leaf__));
# 1188 "/usr/include/unistd.h" 2 3 4


# 27 "./include/grub/util/misc.h" 2

# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 29 "./include/grub/util/misc.h" 2
# 1 "./include/grub/types.h" 1
# 22 "./include/grub/types.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/types.h" 2
# 76 "./include/grub/types.h"

# 76 "./include/grub/types.h"
typedef signed char grub_int8_t;
typedef short grub_int16_t;
typedef int grub_int32_t;

typedef long grub_int64_t;




typedef unsigned char grub_uint8_t;
typedef unsigned short grub_uint16_t;
typedef unsigned grub_uint32_t;



typedef unsigned long grub_uint64_t;
# 103 "./include/grub/types.h"
typedef grub_uint64_t grub_addr_t;
typedef grub_uint64_t grub_size_t;
typedef grub_int64_t grub_ssize_t;
# 154 "./include/grub/types.h"
typedef grub_uint64_t grub_properly_aligned_t;




typedef grub_uint64_t grub_off_t;


typedef grub_uint64_t grub_disk_addr_t;


static inline grub_uint16_t grub_swap_bytes16(grub_uint16_t _x)
{
   return (grub_uint16_t) ((_x << 8) | (_x >> 8));
}
# 186 "./include/grub/types.h"
static inline grub_uint32_t grub_swap_bytes32(grub_uint32_t x)
{
 return __builtin_bswap32(x);
}

static inline grub_uint64_t grub_swap_bytes64(grub_uint64_t x)
{
 return __builtin_bswap64(x);
}
# 260 "./include/grub/types.h"
struct grub_unaligned_uint16
{
  grub_uint16_t val;
} __attribute__ ((packed));
struct grub_unaligned_uint32
{
  grub_uint32_t val;
} __attribute__ ((packed));
struct grub_unaligned_uint64
{
  grub_uint64_t val;
} __attribute__ ((packed));

typedef struct grub_unaligned_uint16 grub_unaligned_uint16_t;
typedef struct grub_unaligned_uint32 grub_unaligned_uint32_t;
typedef struct grub_unaligned_uint64 grub_unaligned_uint64_t;

static inline grub_uint16_t grub_get_unaligned16 (const void *ptr)
{
  const struct grub_unaligned_uint16 *dd
    = (const struct grub_unaligned_uint16 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned16 (void *ptr, grub_uint16_t val)
{
  struct grub_unaligned_uint16 *dd = (struct grub_unaligned_uint16 *) ptr;
  dd->val = val;
}

static inline grub_uint32_t grub_get_unaligned32 (const void *ptr)
{
  const struct grub_unaligned_uint32 *dd
    = (const struct grub_unaligned_uint32 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned32 (void *ptr, grub_uint32_t val)
{
  struct grub_unaligned_uint32 *dd = (struct grub_unaligned_uint32 *) ptr;
  dd->val = val;
}

static inline grub_uint64_t grub_get_unaligned64 (const void *ptr)
{
  const struct grub_unaligned_uint64 *dd
    = (const struct grub_unaligned_uint64 *) ptr;
  return dd->val;
}

static inline void grub_set_unaligned64 (void *ptr, grub_uint64_t val)
{
  struct grub_unaligned_uint64_t
  {
    grub_uint64_t d;
  } __attribute__ ((packed));
  struct grub_unaligned_uint64_t *dd = (struct grub_unaligned_uint64_t *) ptr;
  dd->d = val;
}
# 30 "./include/grub/util/misc.h" 2
# 1 "./include/grub/symbol.h" 1
# 22 "./include/grub/symbol.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/symbol.h" 2
# 31 "./include/grub/util/misc.h" 2
# 1 "./include/grub/emu/misc.h" 1
# 22 "./include/grub/emu/misc.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/emu/misc.h" 2




# 1 "./include/grub/compiler.h" 1
# 28 "./include/grub/emu/misc.h" 2


# 1 "./include/grub/misc.h" 1
# 26 "./include/grub/misc.h"
# 1 "./include/grub/err.h" 1
# 28 "./include/grub/err.h"
typedef enum
  {
    GRUB_ERR_NONE = 0,
    GRUB_ERR_TEST_FAILURE,
    GRUB_ERR_BAD_MODULE,
    GRUB_ERR_OUT_OF_MEMORY,
    GRUB_ERR_BAD_FILE_TYPE,
    GRUB_ERR_FILE_NOT_FOUND,
    GRUB_ERR_FILE_READ_ERROR,
    GRUB_ERR_BAD_FILENAME,
    GRUB_ERR_UNKNOWN_FS,
    GRUB_ERR_BAD_FS,
    GRUB_ERR_BAD_NUMBER,
    GRUB_ERR_OUT_OF_RANGE,
    GRUB_ERR_UNKNOWN_DEVICE,
    GRUB_ERR_BAD_DEVICE,
    GRUB_ERR_READ_ERROR,
    GRUB_ERR_WRITE_ERROR,
    GRUB_ERR_UNKNOWN_COMMAND,
    GRUB_ERR_INVALID_COMMAND,
    GRUB_ERR_BAD_ARGUMENT,
    GRUB_ERR_BAD_PART_TABLE,
    GRUB_ERR_UNKNOWN_OS,
    GRUB_ERR_BAD_OS,
    GRUB_ERR_NO_KERNEL,
    GRUB_ERR_BAD_FONT,
    GRUB_ERR_NOT_IMPLEMENTED_YET,
    GRUB_ERR_SYMLINK_LOOP,
    GRUB_ERR_BAD_COMPRESSED_DATA,
    GRUB_ERR_MENU,
    GRUB_ERR_TIMEOUT,
    GRUB_ERR_IO,
    GRUB_ERR_ACCESS_DENIED,
    GRUB_ERR_EXTRACTOR,
    GRUB_ERR_NET_BAD_ADDRESS,
    GRUB_ERR_NET_ROUTE_LOOP,
    GRUB_ERR_NET_NO_ROUTE,
    GRUB_ERR_NET_NO_ANSWER,
    GRUB_ERR_NET_NO_CARD,
    GRUB_ERR_WAIT,
    GRUB_ERR_BUG,
    GRUB_ERR_NET_PORT_CLOSED,
    GRUB_ERR_NET_INVALID_RESPONSE,
    GRUB_ERR_NET_UNKNOWN_ERROR,
    GRUB_ERR_NET_PACKET_TOO_BIG,
    GRUB_ERR_NET_NO_DOMAIN,
    GRUB_ERR_EOF,
    GRUB_ERR_BAD_SIGNATURE
  }
grub_err_t;

struct grub_error_saved
{
  grub_err_t grub_errno;
  char errmsg[256];
};

extern grub_err_t grub_errno;
extern char grub_errmsg[256];

grub_err_t grub_error (grub_err_t n, const char *fmt, ...);
void grub_fatal (const char *fmt, ...) __attribute__ ((noreturn));
void grub_error_push (void);
int grub_error_pop (void);
void grub_print_error (void);
extern int grub_err_printed_errors;
int grub_err_printf (const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 1, 2)));
# 27 "./include/grub/misc.h" 2
# 1 "./include/grub/i18n.h" 1
# 22 "./include/grub/i18n.h"
# 1 "./config.h" 1
# 38 "./config.h"
# 1 "./config-util.h" 1
# 39 "./config.h" 2
# 23 "./include/grub/i18n.h" 2





extern const char *(*grub_gettext) (const char *s) __attribute__ ((format_arg (1)));



# 1 "/usr/include/locale.h" 1 3 4
# 28 "/usr/include/locale.h" 3 4
# 1 "/usr/lib/gcc/x86_64-pc-linux-gnu/10.2.0/include/stddef.h" 1 3 4
# 29 "/usr/include/locale.h" 2 3 4
# 1 "/usr/include/bits/locale.h" 1 3 4
# 30 "/usr/include/locale.h" 2 3 4


# 51 "/usr/include/locale.h" 3 4

# 51 "/usr/include/locale.h" 3 4
struct lconv
{


  char *decimal_point;
  char *thousands_sep;





  char *grouping;





  char *int_curr_symbol;
  char *currency_symbol;
  char *mon_decimal_point;
  char *mon_thousands_sep;
  char *mon_grouping;
  char *positive_sign;
  char *negative_sign;
  char int_frac_digits;
  char frac_digits;

  char p_cs_precedes;

  char p_sep_by_space;

  char n_cs_precedes;

  char n_sep_by_space;






  char p_sign_posn;
  char n_sign_posn;


  char int_p_cs_precedes;

  char int_p_sep_by_space;

  char int_n_cs_precedes;

  char int_n_sep_by_space;






  char int_p_sign_posn;
  char int_n_sign_posn;
# 118 "/usr/include/locale.h" 3 4
};



extern char *setlocale (int __category, const char *__locale) __attribute__ ((__nothrow__ , __leaf__));


extern struct lconv *localeconv (void) __attribute__ ((__nothrow__ , __leaf__));
# 141 "/usr/include/locale.h" 3 4
extern locale_t newlocale (int __category_mask, const char *__locale,
      locale_t __base) __attribute__ ((__nothrow__ , __leaf__));
# 176 "/usr/include/locale.h" 3 4
extern locale_t duplocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));



extern void freelocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));






extern locale_t uselocale (locale_t __dataset) __attribute__ ((__nothrow__ , __leaf__));








# 33 "./include/grub/i18n.h" 2
# 1 "/usr/include/libintl.h" 1 3 4
# 34 "/usr/include/libintl.h" 3 4





extern char *gettext (const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (1)));



extern char *dgettext (const char *__domainname, const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));
extern char *__dgettext (const char *__domainname, const char *__msgid)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));



extern char *dcgettext (const char *__domainname,
   const char *__msgid, int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));
extern char *__dcgettext (const char *__domainname,
     const char *__msgid, int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2)));




extern char *ngettext (const char *__msgid1, const char *__msgid2,
         unsigned long int __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (1))) __attribute__ ((__format_arg__ (2)));



extern char *dngettext (const char *__domainname, const char *__msgid1,
   const char *__msgid2, unsigned long int __n)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2))) __attribute__ ((__format_arg__ (3)));



extern char *dcngettext (const char *__domainname, const char *__msgid1,
    const char *__msgid2, unsigned long int __n,
    int __category)
     __attribute__ ((__nothrow__ , __leaf__)) __attribute__ ((__format_arg__ (2))) __attribute__ ((__format_arg__ (3)));





extern char *textdomain (const char *__domainname) __attribute__ ((__nothrow__ , __leaf__));



extern char *bindtextdomain (const char *__domainname,
        const char *__dirname) __attribute__ ((__nothrow__ , __leaf__));



extern char *bind_textdomain_codeset (const char *__domainname,
          const char *__codeset) __attribute__ ((__nothrow__ , __leaf__));
# 121 "/usr/include/libintl.h" 3 4

# 34 "./include/grub/i18n.h" 2
# 53 "./include/grub/i18n.h"

# 53 "./include/grub/i18n.h"
static inline const char * __attribute__ ((always_inline,format_arg (1)))
_ (const char *str)
{
  return gettext(str);
}
# 28 "./include/grub/misc.h" 2
# 40 "./include/grub/misc.h"
void *grub_memmove (void *dest, const void *src, grub_size_t n);
char *grub_strcpy (char *dest, const char *src);

static inline char *
grub_strncpy (char *dest, const char *src, int c)
{
  char *p = dest;

  while ((*p++ = *src++) != '\0' && --c)
    ;

  return dest;
}

static inline char *
grub_stpcpy (char *dest, const char *src)
{
  char *d = dest;
  const char *s = src;

  do
    *d++ = *s;
  while (*s++ != '\0');

  return d - 1;
}


static inline void *
grub_memcpy (void *dest, const void *src, grub_size_t n)
{
  return grub_memmove (dest, src, n);
}
# 82 "./include/grub/misc.h"
int grub_memcmp (const void *s1, const void *s2, grub_size_t n);
int grub_strcmp (const char *s1, const char *s2);
int grub_strncmp (const char *s1, const char *s2, grub_size_t n);

char *grub_strchr (const char *s, int c);
char *grub_strrchr (const char *s, int c);
int grub_strword (const char *s, const char *w);



static inline char *
grub_strstr (const char *haystack, const char *needle)
{





  if (*needle != '\0')
    {


      char b = *needle++;

      for (;; haystack++)
 {
   if (*haystack == '\0')

     return 0;
   if (*haystack == b)

     {
       const char *rhaystack = haystack + 1;
       const char *rneedle = needle;

       for (;; rhaystack++, rneedle++)
  {
    if (*rneedle == '\0')

      return (char *) haystack;
    if (*rhaystack == '\0')

      return 0;
    if (*rhaystack != *rneedle)

      break;
  }
     }
 }
    }
  else
    return (char *) haystack;
}

int grub_isspace (int c);

static inline int
grub_isprint (int c)
{
  return (c >= ' ' && c <= '~');
}

static inline int
grub_iscntrl (int c)
{
  return (c >= 0x00 && c <= 0x1F) || c == 0x7F;
}

static inline int
grub_isalpha (int c)
{
  return (c >= 'a' && c <= 'z') || (c >= 'A' && c <= 'Z');
}

static inline int
grub_islower (int c)
{
  return (c >= 'a' && c <= 'z');
}

static inline int
grub_isupper (int c)
{
  return (c >= 'A' && c <= 'Z');
}

static inline int
grub_isgraph (int c)
{
  return (c >= '!' && c <= '~');
}

static inline int
grub_isdigit (int c)
{
  return (c >= '0' && c <= '9');
}

static inline int
grub_isxdigit (int c)
{
  return (c >= '0' && c <= '9') || (c >= 'a' && c <= 'f') || (c >= 'A' && c <= 'F');
}

static inline int
grub_isalnum (int c)
{
  return grub_isalpha (c) || grub_isdigit (c);
}

static inline int
grub_tolower (int c)
{
  if (c >= 'A' && c <= 'Z')
    return c - 'A' + 'a';

  return c;
}

static inline int
grub_toupper (int c)
{
  if (c >= 'a' && c <= 'z')
    return c - 'a' + 'A';

  return c;
}

static inline int
grub_strcasecmp (const char *s1, const char *s2)
{
  while (*s1 && *s2)
    {
      if (grub_tolower ((grub_uint8_t) *s1)
   != grub_tolower ((grub_uint8_t) *s2))
 break;

      s1++;
      s2++;
    }

  return (int) grub_tolower ((grub_uint8_t) *s1)
    - (int) grub_tolower ((grub_uint8_t) *s2);
}

static inline int
grub_strncasecmp (const char *s1, const char *s2, grub_size_t n)
{
  if (n == 0)
    return 0;

  while (*s1 && *s2 && --n)
    {
      if (grub_tolower (*s1) != grub_tolower (*s2))
 break;

      s1++;
      s2++;
    }

  return (int) grub_tolower ((grub_uint8_t) *s1)
    - (int) grub_tolower ((grub_uint8_t) *s2);
}
# 264 "./include/grub/misc.h"
unsigned long grub_strtoul (const char * __restrict str, const char ** const __restrict end, int base);
unsigned long long grub_strtoull (const char * __restrict str, const char ** const __restrict end, int base);

static inline long
grub_strtol (const char * __restrict str, const char ** const __restrict end, int base)
{
  int negative = 0;
  unsigned long long magnitude;

  while (*str && grub_isspace (*str))
    str++;

  if (*str == '-')
    {
      negative = 1;
      str++;
    }

  magnitude = grub_strtoull (str, end, base);
  if (negative)
    {
      if (magnitude > (unsigned long) 9223372036854775807L + 1)
        {
          grub_error (GRUB_ERR_OUT_OF_RANGE, "overflow is detected");
          return (-9223372036854775807L - 1);
        }
      return -((long) magnitude);
    }
  else
    {
      if (magnitude > 9223372036854775807L)
        {
          grub_error (GRUB_ERR_OUT_OF_RANGE, "overflow is detected");
          return 9223372036854775807L;
        }
      return (long) magnitude;
    }
}

char *grub_strdup (const char *s) __attribute__ ((warn_unused_result));
char *grub_strndup (const char *s, grub_size_t n) __attribute__ ((warn_unused_result));
void *grub_memset (void *s, int c, grub_size_t n);
grub_size_t grub_strlen (const char *s) __attribute__ ((warn_unused_result));
int grub_printf (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));
int grub_printf_ (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));



static inline char *
grub_strchrsub (char *output, const char *input, char ch, const char *with)
{
  while (*input)
    {
      if (*input == ch)
 {
   grub_strcpy (output, with);
   output += grub_strlen (with);
   input++;
   continue;
 }
      *output++ = *input++;
    }
  *output = '\0';
  return output;
}

extern void (*grub_xputs) (const char *str);

static inline int
grub_puts (const char *s)
{
  const char nl[2] = "\n";
  grub_xputs (s);
  grub_xputs (nl);

  return 1;
}

int grub_puts_ (const char *s);
int grub_debug_enabled (const char *condition);
void grub_real_dprintf (const char *file,
                                     const int line,
                                     const char *condition,
                                     const char *fmt, ...) __attribute__ ((format (gnu_printf, 4, 5)));
int grub_vprintf (const char *fmt, va_list args);
int grub_snprintf (char *str, grub_size_t n, const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 3, 4)));
int grub_vsnprintf (char *str, grub_size_t n, const char *fmt,
     va_list args);
char *grub_xasprintf (const char *fmt, ...)
     __attribute__ ((format (gnu_printf, 1, 2))) __attribute__ ((warn_unused_result));
char *grub_xvasprintf (const char *fmt, va_list args) __attribute__ ((warn_unused_result));
void grub_exit (void) __attribute__ ((noreturn));
grub_uint64_t grub_divmod64 (grub_uint64_t n,
       grub_uint64_t d,
       grub_uint64_t *r);
# 378 "./include/grub/misc.h"
grub_int64_t
grub_divmod64s (grub_int64_t n,
     grub_int64_t d,
     grub_int64_t *r);

grub_uint32_t
grub_divmod32 (grub_uint32_t n,
     grub_uint32_t d,
     grub_uint32_t *r);

grub_int32_t
grub_divmod32s (grub_int32_t n,
      grub_int32_t d,
      grub_int32_t *r);



static inline char *
grub_memchr (const void *p, int c, grub_size_t len)
{
  const char *s = (const char *) p;
  const char *e = s + len;

  for (; s < e; s++)
    if (*s == c)
      return (char *) s;

  return 0;
}


static inline unsigned int
grub_abs (int x)
{
  if (x < 0)
    return (unsigned int) (-x);
  else
    return (unsigned int) x;
}






void grub_reboot (void) __attribute__ ((noreturn));
# 437 "./include/grub/misc.h"
void grub_halt (void) __attribute__ ((noreturn));
# 447 "./include/grub/misc.h"
static inline void
grub_error_save (struct grub_error_saved *save)
{
  grub_memcpy (save->errmsg, grub_errmsg, sizeof (save->errmsg));
  save->grub_errno = grub_errno;
  grub_errno = GRUB_ERR_NONE;
}

static inline void
grub_error_load (const struct grub_error_saved *save)
{
  grub_memcpy (grub_errmsg, save->errmsg, sizeof (grub_errmsg));
  grub_errno = save->grub_errno;
}
# 31 "./include/grub/emu/misc.h" 2
# 1 "./include/grub/util/misc.h" 1
# 32 "./include/grub/emu/misc.h" 2

extern int verbosity;
extern const char *program_name;

void grub_init_all (void);
void grub_fini_all (void);

void grub_find_zpool_from_dir (const char *dir,
          char **poolname, char **poolfs);

char *grub_make_system_path_relative_to_its_root (const char *path)
 __attribute__ ((warn_unused_result));
int
grub_util_device_is_mapped (const char *dev);




void * xcalloc (grub_size_t nmemb, grub_size_t size) __attribute__ ((warn_unused_result));
void * xmalloc (grub_size_t size) __attribute__ ((warn_unused_result));
void * xrealloc (void *ptr, grub_size_t size) __attribute__ ((warn_unused_result));
char * xstrdup (const char *str) __attribute__ ((warn_unused_result));
char * xasprintf (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2))) __attribute__ ((warn_unused_result));

void grub_util_warn (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));
void grub_util_info (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2)));
void grub_util_error (const char *fmt, ...) __attribute__ ((format (gnu_printf, 1, 2), noreturn));

grub_uint64_t grub_util_get_cpu_time_ms (void);


int grub_device_mapper_supported (void);





FILE *
grub_util_fopen (const char *path, const char *mode);


int grub_util_file_sync (FILE *f);
# 32 "./include/grub/util/misc.h" 2

char *grub_util_get_path (const char *dir, const char *file);
size_t grub_util_get_image_size (const char *path);
char *grub_util_read_image (const char *path);
void grub_util_load_image (const char *path, char *buf);
void grub_util_write_image (const char *img, size_t size, FILE *out,
       const char *name);
void grub_util_write_image_at (const void *img, size_t size, off_t offset,
          FILE *out, const char *name);

char *make_system_path_relative_to_its_root (const char *path);

char *grub_canonicalize_file_name (const char *path);

void grub_util_init_nls (void);

void grub_util_host_init (int *argc, char ***argv);

int grub_qsort_strcmp (const void *, const void *);
# 23 "grub-core/osdep/basic/init.c" 2


# 1 "./grub-core/lib/gnulib/progname.h" 1
# 32 "./grub-core/lib/gnulib/progname.h"
extern const char *program_name;




extern void set_program_name (const char *argv0);
# 26 "grub-core/osdep/basic/init.c" 2

void
grub_util_host_init (int *argc __attribute__ ((unused)),
       char ***argv)
{
  set_program_name ((*argv)[0]);


  setlocale (
# 34 "grub-core/osdep/basic/init.c" 3 4
            6
# 34 "grub-core/osdep/basic/init.c"
                  , "");
  bindtextdomain ("grub", "/usr/local/share/locale");
  textdomain ("grub");

}
# 5 "grub-core/osdep/init.c" 2
