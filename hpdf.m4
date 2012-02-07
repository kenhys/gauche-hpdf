dnl
dnl Configure hpdf
dnl This file is included by the toplevel configure.ac
dnl

dnl
dnl process with-hpdf
dnl

AC_ARG_WITH(libdir,
  [AS_HELP_STRING([--with-libdir=PATH],[look for libraries in .../NAME rather than .../lib])
  ],
  [LIBDIR=$with_libdir],
  [LIBDIR=lib]
)


dnl --with-zlib
AC_ARG_WITH(zlib,
  [AS_HELP_STRING([--with-zlib=PATH],[specify zlib install prefix])
  ],
  [ ],
  [with_zlib=yes]
)

if test "x$with_zlib" = "xno"; then
  AC_DEFINE([HAVE_NOZLIB], [], [zlib is not available])
else
  AC_MSG_CHECKING([zlib install prefix])

  if test "x$with_zlib" = "xyes"; then
    for i in `echo "$STANDARD_PREFIXES"`; do
      if test -f "$i/include/zlib.h"; then
        ZLIB_DIR="$i"
        break;
      fi
    done
  else
    if test -f "$with_zlib/include/zlib.h"; then
      ZLIB_DIR="$with_zlib"
      break;
    else
      AC_MSG_ERROR([Can't find zlib headers under $with_zlib directory]);
    fi
  fi

  if test "x$ZLIB_DIR" = "x"; then
    AC_MSG_ERROR([Unable to locate zlib headers, please use --with-zlib=<DIR>]);
  fi

  AC_MSG_RESULT([$ZLIB_DIR])
  LDFLAGS="$LDFLAGS -L$ZLIB_DIR/$LIBDIR"
  CFLAGS="$CFLAGS -I$ZLIB_DIR/include"
  LIBS="$LIBS -lz"

  AC_CHECK_LIB([z], [deflate], [], [
    AC_MSG_ERROR([deflate() is missing, check config.log for more details])
  ])

  HAVE_ZLIB=yes
fi
dnl 

dnl --with-png
AC_ARG_WITH(png,
  [AS_HELP_STRING([--with-png=PATH],[specify libpng install prefix])
  ],
  [ ],
  [with_png=yes]
)

if test "x$with_png" = "xno"; then
  AC_DEFINE([HAVE_NOPNGLIB], [], [libpng is not available])
else

  if test "x$HAVE_ZLIB" != "xyes"; then
    AC_MSG_ERROR([PNG support requires zlib, but it's not enabled. Either enable zlib or disable PNG support.]);
  fi

  AC_MSG_CHECKING([libpng install prefix])

  if test "x$with_png" = "xyes"; then
    for i in `echo "$STANDARD_PREFIXES"`; do
      if test -f "$i/include/png.h"; then
        LIBPNG_DIR="$i"
        break;
      fi
    done
  else
    if test -f "$with_png/include/png.h"; then
      LIBPNG_DIR="$with_png"
      break;
    else
      AC_MSG_ERROR([Can't find libpng headers under $with_png directory]);
    fi
  fi

  if test "x$LIBPNG_DIR" = "x"; then
    AC_MSG_ERROR([Unable to locate libpng headers, please use --with-png=<DIR>]);
  fi

  AC_MSG_RESULT([$LIBPNG_DIR])
  save_ldflags=$LDFLAGS
  save_cflags=$CFLAGS
  save_libs=$LIBS
  LDFLAGS="$LDFLAGS -L$LIBPNG_DIR/$LIBDIR"
  CFLAGS="$CFLAGS -I$LIBPNG_DIR/include"
  LIBS="$LIBS -lpng"

  AC_CHECK_LIB([png], [png_init_io], [], [
    with_png="no"
  ])

  if test "x$with_png" = "xno"; then
    LDFLAGS="$save_ldflags -L$LIBPNG_DIR/$LIBDIR"
    CFLAGS="$save_cflags -I$LIBPNG_DIR/include"
    LIBS="$save_libs -lpng14"
    AC_CHECK_LIB([png14], [png_init_io], [
      with_png="yes"
      PNG_LDFLAGS="$save_ldflags -L$LIBPNG_DIR/$LIBDIR -lpng14"
      PNG_CFLAGS="$save_cflags -I$LIBPNG_DIR/include"
     ], [
      with_png="no"
      LDFLAGS=$save_ldflags
      CFLAGS=$save_cflags
      LIBS=$save_libs
    ])		      
  fi

  if test "x$with_png" = "xno"; then
    LDFLAGS="$save_ldflags -L$LIBPNG_DIR/$LIBDIR"
    CFLAGS="$save_cflags -I$LIBPNG_DIR/include"
    LIBS="$save_libs -lpng15"
    AC_CHECK_LIB([png15], [png_init_io], [with_png="yes"], [
      with_png="no"
      LDFLAGS=$save_ldflags
      CFLAGS=$save_cflags
      LIBS=$save_libs
    ])		      
  fi

  if test "x$with_png" = "xno"; then
    AC_MSG_ERROR([png_init_io() is missing, check config.log for more details])
  else
    HAVE_PNG=yes
  fi
fi
AC_SUBST(LIBPNG_DIR)
AC_SUBST(PNG_CPPFLAGS)
AC_SUBST(PNG_LDFLAGS)
dnl

dnl Use hpdf unless explicitly specified otherwise
ac_cv_use_hpdf=yes
HPDF_CPPFLAGS=
HPDF_LDFLAGS=

AC_ARG_WITH(hpdf,
  AC_HELP_STRING([--with-hpdf=PATH],
                 [Use hpdf library installed under PATH.
The hpdf module uses hpdf if it is available.  If your system has hpdf
library in non-trivial location, specify this option.
The include file is looked for in PATH/include,
and the library file is looked for in PATH/lib.
If you don't want to use hpdf for some reason, say --without-hpdf. ]),
  [
  case $with_hpdf in
    no)  ac_cv_use_hpdf=no;;
    yes) ;;
    *)   HPDF_CPPFLAGS="-I$with_hpdf/include";
         HPDF_LDFLAGS="-L$with_hpdf/lib";
	 HPDF_DIR=$with_hpdf;;

  esac
 ])

dnl
dnl Check hpdf.h
dnl
if test "$ac_cv_use_hpdf" != no; then
  save_cppflags=$CPPFLAGS
  CPPFLAGS="$CPPFLAGS $HPDF_CPPFLAGS"
  AC_CHECK_HEADER([hpdf.h],
     AC_DEFINE(HAVE_HPDF_H,1,[Define if you have hpdf.h and want to use it]),
     [AC_MSG_WARN("Can't find hpdf.h so I turned off using hpdf; you may want to use --with-hpdf=PATH.")
      ac_cv_use_hpdf=no])
  CPPFLAGS=$save_cppflags
fi
AC_SUBST(HPDF_DIR)

dnl
dnl Check libhpdf.
dnl

if test "$ac_cv_use_hpdf" = yes; then
  save_cflags="$CFLAGS"
  save_ldflags="$LDFLAGS"
  save_libs="$LIBS"
  CFLAGS="$CFLAGS $HPDF_CPPFLAGS"
  LDFLAGS="$LDFLAGS $HPDF_LDFLAGS"
  LIBS="$LIBS -lhpdf -lz"
  AC_LINK_IFELSE(
    [AC_LANG_PROGRAM([#include <hpdf.h>],
                     [[HPDF_GetVersion();]])],
    [HPDF_LIBS="$HPDF_LDFLAGS -lhpdf"],
    [AC_MSG_WARN("Can't find libhpdf so I turned off using hpdf; you may want to use --with-hpdf=PATH")
      ac_cv_use_hpdf=no])
  CFLAGS="$save_cflags"
  LDFLAGS="$save_ldflags"
  LIBS="$save_libs"
fi

if test "$ac_cv_use_hpdf" = yes; then
  AC_DEFINE(USE_HPDF)
  HPDF_ARCHFILES=hpdf.$SHLIB_SO_SUFFIX
  AC_SUBST(HPDF_ARCHFILES)
  hpdf_SCMFILES=hpdf.scm
  AC_SUBST(HPDF_SCMFILES)
fi
AC_SUBST(HPDF_CPPFLAGS)
AC_SUBST(HPDF_LDFLAGS)
AC_SUBST(HPDF_LIBS)




dnl Local variables:
dnl mode: autoconf
dnl end:
