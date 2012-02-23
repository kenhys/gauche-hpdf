/*
 * hpdf.h $Id$

 Copyright (c) 2007-2012, HAYASHI Kentaro <kenhys@gmail.com> All rights reserved.

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
#include <gauche/class.h>
#include <hpdf.h>

SCM_DECL_BEGIN

/*
 * The following entry is a dummy one.
 * Replace it for your declarations.
 */

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

#define READ HPDF_ENABLE_READ
#define PRINT HPDF_ENABLE_PRINT
#define EDIT_ALL HPDF_ENABLE_EDIT_ALL
#define COPY HPDF_ENABLE_COPY
#define EDIT HPDF_ENABLE_EDIT

#define ALIGN_LEFT HPDF_TALIGN_LEFT
#define ALIGN_RIGHT HPDF_TALIGN_RIGHT
#define ALIGN_CENTER HPDF_TALIGN_CENTER
#define ALIGN_JUSTIFY HPDF_TALIGN_JUSTIFY

/* enum HPDF_AnnotIcon */
#define ICON_COMMENT HPDF_ANNOT_ICON_COMMENT
#define ICON_KEY HPDF_ANNOT_ICON_KEY
#define ICON_NOTE HPDF_ANNOT_ICON_NOTE
#define ICON_HELP HPDF_ANNOT_ICON_HELP
#define ICON_NEW_PARAGRAPH HPDF_ANNOT_ICON_NEW_PARAGRAPH
#define ICON_PARAGRAPH HPDF_ANNOT_ICON_PARAGRAPH
#define ICON_INSERT HPDF_ANNOT_ICON_INSERT

SCM_CLASS_DECL(Scm_HpdfStatusClass);
 #define SCM_CLASS_HPDFSTATUS (&Scm_HpdfStatusClass)
 #define SCM_HPDF_STATUS(obj) ((HPDF_STATUS)(obj))
 #define SCM_HPDF_STATUS_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDFSTATUS))

/* HPDF_REAL */
SCM_CLASS_DECL(Scm_HpdfRealClass);
 #define SCM_CLASS_HPDFREAL (&Scm_HpdfRealClass)
 #define SCM_HPDF_REAL(obj) ((HPDF_REAL)(obj))
 #define SCM_HPDF_REAL_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDFREAL))





typedef struct ScmHpdfDocRec {
SCM_HEADER;
HPDF_Doc h;
} ScmHpdfDoc;

SCM_CLASS_DECL(Scm_HpdfDocClass);
 #define SCM_CLASS_HPDF_DOC (&Scm_HpdfDocClass)
 #define SCM_HPDF_DOC(obj) ((ScmHpdfDoc*)(obj))
 #define SCM_HPDF_DOC_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_DOC))

typedef struct ScmHpdfPageRec {
SCM_HEADER;
HPDF_Page h;
} ScmHpdfPage;

SCM_CLASS_DECL(Scm_HpdfPageClass);
 #define SCM_CLASS_HPDF_PAGE (&Scm_HpdfPageClass)
 #define SCM_HPDF_PAGE(obj) ((ScmHpdfPage*)(obj))
 #define SCM_HPDF_PAGE_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_PAGE))

typedef struct ScmHpdfPagesRec {
SCM_HEADER;
HPDF_Pages h;
} ScmHpdfPages;

SCM_CLASS_DECL(Scm_HpdfPagesClass);
 #define SCM_CLASS_HPDF_PAGES (&Scm_HpdfPagesClass)
 #define SCM_HPDF_PAGES(obj) ((ScmHPages*)(obj))
 #define SCM_HPDF_PAGES_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_PAGES))

typedef struct ScmHpdfStreamRec {
SCM_HEADER;
HPDF_Stream h;
} ScmHpdfStream;

SCM_CLASS_DECL(Scm_HpdfStreamClass);
 #define SCM_CLASS_HPDF_STREAM (&Scm_HpdfStreamClass)
 #define SCM_HPDF_STREAM(obj) ((ScmHpdfStream*)(obj))
 #define SCM_HPDF_STREAM_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_STREAM))

typedef struct ScmHpdfImageRec {
SCM_HEADER;
HPDF_Image h;
} ScmHpdfImage;

SCM_CLASS_DECL(Scm_HpdfImageClass);
 #define SCM_CLASS_HPDF_IMAGE (&Scm_HpdfImageClass)
 #define SCM_HPDF_IMAGE(obj) ((ScmHpdfImage*)(obj))
 #define SCM_HPDF_IMAGE_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_IMAGE))

typedef struct ScmHpdfFontRec {
SCM_HEADER;
HPDF_Font h;
} ScmHpdfFont;

SCM_CLASS_DECL(Scm_HpdfFontClass);
 #define SCM_CLASS_HPDF_FONT (&Scm_HpdfFontClass)
 #define SCM_HPDF_FONT(obj) ((ScmHpdfFont*)(obj))
 #define SCM_HPDF_FONTP(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_FONT))
 #define SCM_HPDF_FONT_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_FONT))

typedef struct ScmHpdfOutlineRec {
SCM_HEADER;
HPDF_Outline h;
} ScmHpdfOutline;

SCM_CLASS_DECL(Scm_HpdfOutlineClass);
 #define SCM_CLASS_HPDF_OUTLINE (&Scm_HpdfOutlineClass)
 #define SCM_HPDF_OUTLINE(obj) ((ScmHpdfOutline*)(obj))
 #define SCM_HPDF_OUTLINE_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_OUTLINE))

typedef struct ScmHpdfEncoderRec {
SCM_HEADER;
HPDF_Encoder h;
} ScmHpdfEncoder;

SCM_CLASS_DECL(Scm_HpdfEncoderClass);
 #define SCM_CLASS_HPDF_ENCODER (&Scm_HpdfEncoderClass)
 #define SCM_HPDF_ENCODER(obj) ((ScmHpdfEncoder*)(obj))
 #define SCM_HPDF_ENCODER_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_ENCODER))

typedef struct ScmHpdfDestinationRec {
SCM_HEADER;
HPDF_Destination h;
} ScmHpdfDestination;

SCM_CLASS_DECL(Scm_HpdfDestinationClass);
 #define SCM_CLASS_HPDF_DESTINATION (&Scm_HpdfDestinationClass)
 #define SCM_HPDF_DESTINATION(obj) ((ScmHpdfDestination*)(obj))
 #define SCM_HPDF_DESTINATION_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_DESTINATION))

typedef struct ScmHpdfXObjectRec {
SCM_HEADER;
HPDF_XObject h;
} ScmHpdfXObject;

SCM_CLASS_DECL(Scm_HpdfXObjectClass);
 #define SCM_CLASS_HPDF_XOBJECT (&Scm_HpdfXObjectClass)
 #define SCM_HPDF_XOBJECT(obj) ((ScmHpdfXObject*)(obj))
 #define SCM_HPDF_XOBJECT_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_XOBJECT))

typedef struct ScmHpdfAnnotationRec {
SCM_HEADER;
HPDF_Annotation h;
} ScmHpdfAnnotation;

SCM_CLASS_DECL(Scm_HpdfAnnotationClass);
 #define SCM_CLASS_HPDF_ANNOTATION (&Scm_HpdfAnnotationClass)
 #define SCM_HPDF_ANNOTATION(obj) ((ScmHpdfAnnotation*)(obj))
 #define SCM_HPDF_ANNOTATION_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_ANNOTATION))

typedef struct ScmHpdfExtGStateRec {
SCM_HEADER;
HPDF_ExtGState h;
} ScmHpdfExtGState;

SCM_CLASS_DECL(Scm_HpdfExtGStateClass);
 #define SCM_CLASS_HPDF_EXTGSTATE (&Scm_HpdfExtGStateClass)
 #define SCM_HPDF_EXTGSTATE(obj) ((ScmHpdfExtGState*)(obj))
 #define SCM_HPDF_EXTGSTATE_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_EXTGSTATE))

typedef struct ScmHpdfPointRec {
SCM_HEADER;
HPDF_Point h;
} ScmHpdfPoint;

SCM_CLASS_DECL(Scm_HpdfPointClass);
 #define SCM_CLASS_HPDF_POINT (&Scm_HpdfPointClass)
 #define SCM_HPDF_POINT(obj) ((ScmHpdfPoint*)(obj))
 #define SCM_HPDF_POINT_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_POINT))

typedef struct ScmHpdfPoint3DRec {
SCM_HEADER;
HPDF_Point3D h;
} ScmHpdfPoint3D;

SCM_CLASS_DECL(Scm_HpdfPoint3DClass);
 #define SCM_CLASS_HPDF_POINT3D (&Scm_HpdfPoint3DClass)
 #define SCM_HPDF_POINT3D(obj) ((ScmHpdfPoint3D*)(obj))
 #define SCM_HPDF_POINT3D_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_POINT3D))

typedef struct ScmHpdfRectRec {
SCM_HEADER;
HPDF_Rect h;
} ScmHpdfRect;

SCM_CLASS_DECL(Scm_HpdfRectClass);
 #define SCM_CLASS_HPDF_RECT (&Scm_HpdfRectClass)
 #define SCM_HPDF_RECT(obj) ((ScmHpdfRect*)(obj))
 #define SCM_HPDF_RECT_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_RECT))

typedef struct ScmHpdfBoxRec {
SCM_HEADER;
HPDF_Rect h;
} ScmHpdfBox;

SCM_CLASS_DECL(Scm_HpdfBoxClass);
 #define SCM_CLASS_HPDF_BOX (&Scm_HpdfBoxClass)
 #define SCM_HPDF_BOX(obj) ((ScmHpdfBox*)(obj))
 #define SCM_HPDF_BOX_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_BOX))

typedef struct ScmHpdfTransMatrixRec {
SCM_HEADER;
HPDF_TransMatrix h;
} ScmHpdfTransMatrix;

SCM_CLASS_DECL(Scm_HpdfTransMatrixClass);
 #define SCM_CLASS_HPDF_TRANSMATRIX (&Scm_HpdfTransMatrixClass)
 #define SCM_HPDF_TRANSMATRIX(obj) ((ScmHpdfTransMatrix*)(obj))
 #define SCM_HPDF_TRANSMATRIX_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_TRANSMATRIX))

typedef struct ScmHpdfRGBColorRec {
SCM_HEADER;
HPDF_RGBColor h;
} ScmHpdfRGBColor;

SCM_CLASS_DECL(Scm_HpdfRGBColorClass);
 #define SCM_CLASS_HPDF_RGBCOLOR (&Scm_HpdfRGBColorClass)
 #define SCM_HPDF_RGBCOLOR(obj) ((ScmHpdfRGBColor*)(obj))
 #define SCM_HPDF_RGBCOLOR_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_RGBCOLOR))

typedef struct ScmHpdfCMYKColorRec {
SCM_HEADER;
HPDF_CMYKColor h;
} ScmHpdfCMYKColor;

SCM_CLASS_DECL(Scm_HpdfCMYKColorClass);
 #define SCM_CLASS_HPDF_CMYKCOLOR (&Scm_HpdfCMYKColorClass)
 #define SCM_HPDF_CMYKCOLOR(obj) ((ScmHpdfCMYKColor*)(obj))
 #define SCM_HPDF_CMYKCOLOR_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_CMYKCOLOR))

typedef struct ScmHpdfLineCapRec {
SCM_HEADER;
HPDF_LineCap h;
} ScmHpdfLineCap;

SCM_CLASS_DECL(Scm_HpdfLineCapClass);
 #define SCM_CLASS_HPDF_LINECAP (&Scm_HpdfLineCapClass)
 #define SCM_HPDF_LINECAP(obj) ((ScmHpdfLineCap*)(obj))
 #define SCM_HPDF_LINECAP_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_LINECAP))

typedef struct ScmHpdfLineJoinRec {
SCM_HEADER;
HPDF_LineJoin h;
} ScmHpdfLineJoin;

SCM_CLASS_DECL(Scm_HpdfLineJoinClass);
 #define SCM_CLASS_HPDF_LINEJOIN (&Scm_HpdfLineJoinClass)
 #define SCM_HPDF_LINEJOIN(obj) ((ScmHpdfLineJoin*)(obj))
 #define SCM_HPDF_LINEJOIN_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDFLINEJOIN))

typedef struct ScmHpdfDashModeRec {
SCM_HEADER;
HPDF_DashMode h;
} ScmHpdfDashMode;

SCM_CLASS_DECL(Scm_HpdfDashModeClass);
 #define SCM_CLASS_HPDF_DASHMODE (&Scm_HpdfDashModeClass)
 #define SCM_HPDF_DASHMODE(obj) ((ScmHpdfDashMode*)(obj))
 #define SCM_HPDF_DASHMODE_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_DASHMODE))

typedef struct ScmHpdfDateRec {
SCM_HEADER;
HPDF_Date h;
} ScmHpdfDate;

SCM_CLASS_DECL(Scm_HpdfDateClass);
 #define SCM_CLASS_HPDF_DATE (&Scm_HpdfDateClass)
 #define SCM_HPDF_DATE(obj) ((ScmHpdfDate*)(obj))
 #define SCM_HPDF_DATE_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_DATE))

typedef struct ScmHpdfDictRec {
SCM_HEADER;
HPDF_Dict h;
} ScmHpdfDict;

SCM_CLASS_DECL(Scm_HpdfDictClass);
 #define SCM_CLASS_HPDF_DICT (&Scm_HpdfDictClass)
 #define SCM_HPDF_DICT(obj) ((ScmHpdfDict*)(obj))
 #define SCM_HPDF_DICT_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF_DICT))

typedef struct ScmHpdfTextWidthRec {
SCM_HEADER;
HPDF_TextWidth h;
} ScmHpdfTextWidth;

SCM_CLASS_DECL(Scm_HpdfTextWidthClass);
 #define SCM_CLASS_HPDFTEXTWIDTH (&Scm_HpdfTextWidthClass)
 #define SCM_HPDF_TEXTWIDTH(obj) ((ScmHpdfTextWidth*)(obj))
 #define SCM_HPDF_TEXTWIDTH_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDFTEXTWIDTH))

typedef struct ScmHpdfEmbeddedFileRec {
SCM_HEADER;
HPDF_EmbeddedFile h;
} ScmHpdfEmbeddedFile;

SCM_CLASS_DECL(Scm_HpdfEmbeddedFileClass);
 #define SCM_CLASS_HPDFEMBEDDEDFILE (&Scm_HpdfEmbeddedFileClass)
 #define SCM_HPDF_EMBEDDEDFILE(obj) ((ScmHpdfEmbeddedFile*)(obj))
 #define SCM_HPDF_EMBEDDEDFILE_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDEMBEDDEDFILE))

typedef struct ScmHpdfU3DRec {
SCM_HEADER;
HPDF_U3D h;
} ScmHpdfU3D;

SCM_CLASS_DECL(Scm_HpdfU3DClass);
 #define SCM_CLASS_HPDFU3D (&Scm_HpdfU3DClass)
 #define SCM_HPDF_U3D(obj) ((ScmHpdfU3D*)(obj))
 #define SCM_HPDF_U3D_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDFU3D))


typedef struct ScmHpdf3DMeasureRec {
SCM_HEADER;
HPDF_Dict h;
} ScmHpdf3DMeasure;

SCM_CLASS_DECL(Scm_Hpdf3DMeasureClass);
 #define SCM_CLASS_HPDF3DMEASURE (&Scm_Hpdf3DMeasureClass)
 #define SCM_HPDF_3D_MEASURE(obj) ((ScmHpdf3DMeasure*)(obj))
 #define SCM_HPDF_3D_MEASURE_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDF3DMEASURE))

typedef struct ScmHpdfExDataRec {
SCM_HEADER;
HPDF_Dict h;
} ScmHpdfExData;

SCM_CLASS_DECL(Scm_HpdfExDataClass);
 #define SCM_CLASS_HPDFEXDATA (&Scm_HpdfExDataClass)
 #define SCM_HPDF_EXDATA(obj) ((ScmHpdfExData*)(obj))
 #define SCM_HPDF_EXDATA_P(obj) (SCM_XTYPEP(obj, SCM_CLASS_HPDFEXDATA))

extern void hpdf_error_handler(HPDF_STATUS   error_no,
                        HPDF_STATUS   detail_no,
                        void         *user_data);

/* Epilogue */
SCM_DECL_END

#endif  /* GAUCHE_HPDF_H */
