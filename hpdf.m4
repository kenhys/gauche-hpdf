dnl
dnl Configure hpdf
dnl This file is included by the toplevel configure.ac
dnl

dnl
dnl process with-hpdf
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
         HPDF_LDFLAGS="-L$with_hpdf/lib";;
  esac
 ])

dnl
dnl Check hpdf.h
dnl
echo $CPPFLAGS
echo $HPDF_CPPFLAGS
if test "$ac_cv_use_hpdf" != no; then
  save_cppflags=$CPPFLAGS
  CPPFLAGS="$CPPFLAGS $HPDF_CPPFLAGS"
  AC_CHECK_HEADER([hpdf.h],
     AC_DEFINE(HAVE_HPDF_H,1,[Define if you have hpdf.h and want to use it]),
     [AC_MSG_WARN("Can't find hpdf.h so I turned off using hpdf; you may want to use --with-hpdf=PATH.")
      ac_cv_use_hpdf=no])
  CPPFLAGS=$save_cppflags
fi

dnl
dnl Check libhpdf.
dnl

if test "$ac_cv_use_hpdf" = yes; then
  save_cflags="$CFLAGS"
  save_ldflags="$LDFLAGS"
  save_libs="$LIBS"
  CFLAGS="$CFLAGS $HPDF_CPPFLAGS"
  LDFLAGS="$LDFLAGS $HPDF_LDFLAGS"
  LIBS="$LIBS -lhpdf"
  AC_LINK_IFELSE(
    [AC_LANG_PROGRAM([#include <hpdf.h>],
                     [[HPDF_GetVersion();]])],
    [HPDF_LIB="-lhpdf"],
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




dnl Local variables:
dnl mode: autoconf
dnl end:
