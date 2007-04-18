/*
 * hpdf.h
 */

/* Prologue */
#ifndef GAUCHE_HPDF_H
#define GAUCHE_HPDF_H

#include <gauche.h>
#include <gauche/extend.h>

SCM_DECL_BEGIN

/*
 * The following entry is a dummy one.
 * Replace it for your declarations.
 */

extern ScmObj test_hpdf(void);

#ifdef GAUCHE_HPDF_DEBUG
#define GAUCHE_HPDF_FUNC(func) Scm_Printf(SCM_CURERR, "#=> %s()\n", func)
#define GAUCHE_HPDF_STR(key, value) Scm_Printf(SCM_CURERR, "%s => %s\n", (key), (value))
#define GAUCHE_HPDF_INT(key, value) Scm_Printf(SCM_CURERR, "%s => %d\n", (key), (value))
#define GAUCHE_HPDF_HEX(key, value) Scm_Printf(SCM_CURERR, "%s => %x\n", (key), (value))
#else
#define GAUCHE_HPDF_FUNC(func)
#define GAUCHE_HPDF_STR(key, value)
#define GAUCHE_HPDF_INT(key, value)
#define GAUCHE_HPDF_HEX(key, value)
#endif

/* Epilogue */
SCM_DECL_END

#endif  /* GAUCHE_HPDF_H */
