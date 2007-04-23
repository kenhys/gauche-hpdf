/*
 * hpdf.h $Id$

 Copyright (c) 2007, HAYASHI Kentaro <kenhys@gigo-ice.org> All rights reserved.

 Redistribution and use in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:

    * Redistributions of source code must retain the above copyright notice,
    this list of conditions and the following disclaimer.
    * Redistributions in binary form must reproduce the above copyright notice,
    this list of conditions and the following disclaimer in the documentation and/or
    other materials provided with the distribution.
    * Neither the name of the GIGO-ICE.ORG nor the names of its contributors
    may be used to endorse or promote products derived from this software
    without specific prior written permission.

 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
 A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
 EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
 PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
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
#define GAUCHE_HPDF_WARN(msg) Scm_Printf(SCM_CURERR, "Warning: %s\n", msg)
#define GAUCHE_HPDF_STR(key, value) Scm_Printf(SCM_CURERR, "%s => %s\n", (key), (value))
#define GAUCHE_HPDF_INT(key, value) Scm_Printf(SCM_CURERR, "%s => %d\n", (key), (value))
#define GAUCHE_HPDF_HEX(key, value) Scm_Printf(SCM_CURERR, "%s => %x\n", (key), (value))
#define GAUCHE_HPDF_PTR(key, value) Scm_Printf(SCM_CURERR, "%s => %p\n", (key), (value))
#else
#define GAUCHE_HPDF_FUNC(func)
#define GAUCHE_HPDF_WARN(msg)
#define GAUCHE_HPDF_STR(key, value)
#define GAUCHE_HPDF_INT(key, value)
#define GAUCHE_HPDF_HEX(key, value)
#define GAUCHE_HPDF_PTR(key, value)
#endif

#define LETTER HPDF_PAGE_SIZE_LETTER
#define LEGAL HPDF_PAGE_SIZE_LEGAL
#define A3 HPDF_PAGE_SIZE_A3
#define A4 HPDF_PAGE_SIZE_A4
#define A5 HPDF_PAGE_SIZE_A5
#define B4 HPDF_PAGE_SIZE_B4
#define B5 HPDF_PAGE_SIZE_B5
#define EXECUTIVE HPDF_PAGE_SIZE_EXECUTIVE
#define US4x6 HPDF_PAGE_SIZE_US4x6
#define US4x8 HPDF_PAGE_SIZE_US4x8
#define US5x7 HPDF_PAGE_SIZE_US5x7
#define COMM10 HPDF_PAGE_SIZE_COMM10

#define CREATION_DATE HPDF_INFO_CREATION_DATE
#define MOD_DATE HPDF_INFO_MOD_DATE
#define AUTHOR HPDF_INFO_AUTHOR
#define CREATOR HPDF_INFO_CREATOR
#define PRODUCER HPDF_INFO_PRODUCER
#define TITLE HPDF_INFO_TITLE
#define SUBJECT HPDF_INFO_SUBJECT
#define KEYWORDS HPDF_INFO_KEYWORDS

/* Epilogue */
SCM_DECL_END

#endif  /* GAUCHE_HPDF_H */
