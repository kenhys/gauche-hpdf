/*
 * hpdf.c
 */

#include "gauche-hpdf.h"
#include <hpdf.h>
/*
 * The following function is a dummy one; replace it for
 * your C function definitions.
 */

ScmObj test_hpdf(void)
{
    return SCM_MAKE_STR("hpdf is working");
}

void hpdf_error_handler(HPDF_STATUS   error_no,
                        HPDF_STATUS   detail_no,
                        void         *user_data)
{
    switch (error_no) {
    case HPDF_ARRAY_COUNT_ERR:
    case HPDF_ARRAY_ITEM_NOT_FOUND:
    case HPDF_ARRAY_ITEM_UNEXPECTED_TYPE:
    case HPDF_BINARY_LENGTH_ERR:
    case HPDF_CANNOT_GET_PALLET:
    case HPDF_DICT_COUNT_ERR:
    case HPDF_DICT_ITEM_NOT_FOUND:
    case HPDF_DICT_ITEM_UNEXPECTED_TYPE:
    case HPDF_DICT_STREAM_LENGTH_NOT_FOUND:
    case HPDF_DOC_ENCRYPTDICT_NOT_FOUND:
    case HPDF_DOC_INVALID_OBJECT:
    case HPDF_DUPLICATE_REGISTRATION:
    case HPDF_EXCEED_JWW_CODE_NUM_LIMIT:
    case HPDF_ENCRYPT_INVALID_PASSWORD:
    case HPDF_ERR_UNKNOWN_CLASS:
    case HPDF_EXCEED_GSTATE_LIMIT:
    case HPDF_FAILD_TO_ALLOC_MEM:
    case HPDF_FILE_IO_ERROR:
        Scm_Error("error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_FILE_OPEN_ERROR:
        Scm_Error("HPDF_FILE_OPEN_ERROR error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_FONT_EXISTS:
        Scm_Error("HPDF_FONT_EXISTS error_no:0x%x detail_no:%d Tried to load a font that has been registered.\n", error_no, detail_no);
        break;
        
    case HPDF_FONT_INVALID_WIDTHS_TABLE:
    case HPDF_INVALID_AFM_HEADER:
    case HPDF_INVALID_ANNOTATION:
    case HPDF_INVALID_BIT_PER_COMPONENT:
    case HPDF_INVALID_CHAR_MATRICS_DATA:
    case HPDF_INVALID_COLOR_SPACE:
    case HPDF_INVALID_COMPRESSION_MODE:
    case HPDF_INVALID_DATE_TIME:
    case HPDF_INVALID_DESTINATION:
        Scm_Error("HPDF_INVALID_DESTINATION error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_DOCUMENT:
        Scm_Error("HPDF_INVALID_DOCUMENT error_no:0x%x detail_no:%d An invalid document handle is set.\n", error_no, detail_no);
        break;
    case HPDF_INVALID_DOCUMENT_STATE:
    case HPDF_INVALID_ENCODER:
    case HPDF_INVALID_ENCODER_TYPE:
    case HPDF_INVALID_ENCODING_NAME:
    case HPDF_INVALID_ENCRYPT_KEY_LEN:
    case HPDF_INVALID_FONTDEF_DATA:
    case HPDF_INVALID_FONTDEF_TYPE:
        Scm_Error("error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_FONT_NAME:
        Scm_Error("HPDF_INVALID_FONT_NAME error_no:0x%x detail_no:%d A font which has the specified name is not found.\n", error_no, detail_no);
        break;
    case HPDF_INVALID_IMAGE:
    case HPDF_INVALID_JPEG_DATA:
    case HPDF_INVALID_N_DATA:
    case HPDF_INVALID_OBJECT:
    case HPDF_INVALID_OBJ_ID:
    case HPDF_INVALID_OPERATION:
    case HPDF_INVALID_OUTLINE:
    case HPDF_INVALID_PAGE:
    case HPDF_INVALID_PAGES:
    case HPDF_INVALID_PARAMETER:
    case HPDF_INVALID_PNG_IMAGE:
    case HPDF_INVALID_STREAM:
    case HPDF_MISSING_FILE_NAME_ENTRY:
    case HPDF_INVALID_TTC_FILE:
    case HPDF_INVALID_TTC_INDEX:
    case HPDF_INVALID_WX_DATA:
    case HPDF_ITEM_NOT_FOUND:
    case HPDF_LIBPNG_ERROR:
    case HPDF_NAME_INVALID_VALUE:
    case HPDF_NAME_OUT_OF_RANGE:
    case HPDF_PAGE_INVALID_PARAM_COUNT:
    case HPDF_PAGES_MISSING_KIDS_ENTRY:
    case HPDF_PAGE_CANNOT_FIND_OBJECT:
    case HPDF_PAGE_CANNOT_GET_ROOT_PAGES:
    case HPDF_PAGE_CANNOT_RESTORE_GSTATE:
    case HPDF_PAGE_CANNOT_SET_PARENT:
    case HPDF_PAGE_FONT_NOT_FOUND:
    case HPDF_PAGE_INVALID_FONT:
    case HPDF_PAGE_INVALID_FONT_SIZE:
    case HPDF_PAGE_INVALID_GMODE:
    case HPDF_PAGE_INVALID_INDEX:
    case HPDF_PAGE_INVALID_ROTATE_VALUE:
    case HPDF_PAGE_INVALID_SIZE:
    case HPDF_PAGE_INVALID_XOBJECT:
    case HPDF_PAGE_OUT_OF_RANGE:
    case HPDF_REAL_OUT_OF_RANGE:
    case HPDF_STREAM_EOF:
    case HPDF_STREAM_READLN_CONTINUE:
    case HPDF_STRING_OUT_OF_RANGE:
    case HPDF_THIS_FUNC_WAS_SKIPPED:
    case HPDF_TTF_CANNOT_EMBEDDING_FONT:
    case HPDF_TTF_INVALID_CMAP:
    case HPDF_TTF_INVALID_FOMAT:
        Scm_Error("error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_TTF_MISSING_TABLE:
        Scm_Error("error_no:0x%x detail_no:%d Unsupported ttf format. (cannot find a necessary table)\n", error_no, detail_no);
        break;
    case HPDF_UNSUPPORTED_FONT_TYPE:
    case HPDF_UNSUPPORTED_FUNC:
    case HPDF_UNSUPPORTED_JPEG_FORMAT:
    case HPDF_UNSUPPORTED_TYPE1_FONT:
    case HPDF_XREF_COUNT_ERR:
    case HPDF_ZLIB_ERROR:
    case HPDF_INVALID_PAGE_INDEX:
    case HPDF_INVALID_URI:
    case HPDF_PAGE_LAYOUT_OUT_OF_RANGE:
    case HPDF_PAGE_MODE_OUT_OF_RANGE:
    case HPDF_PAGE_NUM_STYLE_OUT_OF_RANGE:
    case HPDF_ANNOT_INVALID_ICON:
    case HPDF_ANNOT_INVALID_BORDER_STYLE:
    case HPDF_PAGE_INVALID_DIRECTION:
    case HPDF_INVALID_FONT:
    case HPDF_PAGE_INSUFFICIENT_SPACE:
    case HPDF_PAGE_INVALID_DISPLAY_TIME:
    case HPDF_PAGE_INVALID_TRANSITION_TIME:
    case HPDF_INVALID_PAGE_SLIDESHOW_TYPE:
    case HPDF_EXT_GSTATE_OUT_OF_RANGE:
    case HPDF_INVALID_EXT_GSTATE:
    case HPDF_EXT_GSTATE_READ_ONLY:
    default:
        Scm_Error("error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    }
}

/*
 * Module initialization function.
 */
extern void Scm_Init_hpdflib(ScmModule*);

ScmObj Scm_Init_hpdf(void)
{
    ScmModule *mod;

    /* Register this DSO to Gauche */
    SCM_INIT_EXTENSION(hpdf);

    /* Create the module if it doesn't exist yet. */
    mod = SCM_MODULE(SCM_FIND_MODULE("hpdf", TRUE));

    /* Register stub-generated procedures */
    Scm_Init_hpdflib(mod);
}
