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
        Scm_Error("error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_DOC_ENCRYPTDICT_NOT_FOUND:
        Scm_Error("HPDF_DOC_ENCRYPTDICT_NOT_FOUND error_no:0x%x detail_no:%d HPDF_SetPermission() or HPDF_SetEncryptMode() was called before a password is set.\n", error_no, detail_no);
        break;
    case HPDF_DOC_INVALID_OBJECT:
    case HPDF_DUPLICATE_REGISTRATION:
    case HPDF_EXCEED_JWW_CODE_NUM_LIMIT:
        Scm_Error("error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_ENCRYPT_INVALID_PASSWORD:
        Scm_Error("HPDF_ENCRYPT_INVALID_PASSWORD error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
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
        Scm_Error("HPDF_FONT_INVALID_WIDTHS_TABLE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_AFM_HEADER:
        Scm_Error("HPDF_INVALID_AFM_HEADER error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_ANNOTATION:
        Scm_Error("HPDF_INVALID_ANNOTATION error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_BIT_PER_COMPONENT:
        Scm_Error("HPDF_INVALID_BIT_PER_COMPONENT error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_CHAR_MATRICS_DATA:
        Scm_Error("HPDF_INVALID_CHAR_MATRICS_DATA error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_COLOR_SPACE:
        Scm_Error("HPDF_INVALID_COLOR_SPACE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_COMPRESSION_MODE:
        Scm_Error("HPDF_INVALID_COMPRESSION_MODE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_DATE_TIME:
        Scm_Error("HPDF_INVALID_DATE_TIME error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_DESTINATION:
        Scm_Error("HPDF_INVALID_DESTINATION error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_DOCUMENT:
        Scm_Error("HPDF_INVALID_DOCUMENT error_no:0x%x detail_no:%d An invalid document handle is set.\n",
                  error_no, detail_no);
        break;
    case HPDF_INVALID_DOCUMENT_STATE:
        Scm_Error("HPDF_INVALID_DOCUMENT_STATE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_ENCODER:
        Scm_Error("HPDF_INVALID_ENCODER error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_ENCODER_TYPE:
        Scm_Error("HPDF_INVALID_ENCODER_TYPE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_ENCODING_NAME:
        Scm_Error("HPDF_INVALID_ENCODING_NAME error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_ENCRYPT_KEY_LEN:
        Scm_Error("HPDF_INVALID_ENCRYPT_KEY_LEN error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_FONTDEF_DATA:
        Scm_Error("HPDF_INVALID_FONTDEF_DATA error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_FONTDEF_TYPE:
        Scm_Error("HPDF_INVALID_FONTDEF_TYPE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_FONT_NAME:
        Scm_Error("HPDF_INVALID_FONT_NAME error_no:0x%x detail_no:%d A font which has the specified name is not found.\n",
                  error_no, detail_no);
        break;
    case HPDF_INVALID_IMAGE:
        Scm_Error("HPDF_INVALID_IMAGE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_JPEG_DATA:
        Scm_Error("HPDF_INVALID_JPEG_DATA error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_N_DATA:
        Scm_Error("HPDF_INVALID_N_DATA error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_OBJECT:
        Scm_Error("HPDF_INVALID_OBJECT error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_OBJ_ID:
        Scm_Error("HPDF_INVALID_OBJ_ID error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_OPERATION:
        Scm_Error("HPDF_INVALID_OPERATION error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_OUTLINE:
        Scm_Error("HPDF_INVALID_OUTLINE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_PAGE:
        Scm_Error("HPDF_INVALID_PAGE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_PAGES:
        Scm_Error("HPDF_INVALID_PAGES error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_PARAMETER:
        Scm_Error("HPDF_INVALID_PARAMETER error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_PNG_IMAGE:
        Scm_Error("HPDF_INVALID_PNG_IMAGE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_STREAM:
        Scm_Error("HPDF_INVALID_STREAM error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_MISSING_FILE_NAME_ENTRY:
        Scm_Error("HPDF_MISSING_FILE_NAME_ENTRY error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_TTC_FILE:
        Scm_Error("HPDF_INVALID_TTC_FILE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_TTC_INDEX:
        Scm_Error("HPDF_INVALID_TTC_INDEX error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_INVALID_WX_DATA:
        Scm_Error("HPDF_INVALID_WX_DATA error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_ITEM_NOT_FOUND:
        Scm_Error("HPDF_ITEM_NOT_FOUND error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_LIBPNG_ERROR:
        Scm_Error("HPDF_LIBPNG_ERROR error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_NAME_INVALID_VALUE:
        Scm_Error("HPDF_NAME_INVALID_VALUE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_NAME_OUT_OF_RANGE:
        Scm_Error("HPDF_NAME_OUT_OF_RANGE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_INVALID_PARAM_COUNT:
        Scm_Error("HPDF_PAGE_INVALID_PARAM_COUNT error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGES_MISSING_KIDS_ENTRY:
        Scm_Error("HPDF_PAGES_MISSING_KIDS_ENTRY error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_CANNOT_FIND_OBJECT:
        Scm_Error("HPDF_PAGE_CANNOT_FIND_OBJECT error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_CANNOT_GET_ROOT_PAGES:
        Scm_Error("HPDF_PAGE_CANNOT_GET_ROOT_PAGES error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_CANNOT_RESTORE_GSTATE:
        Scm_Error("HPDF_PAGE_CANNOT_RESTORE_GSTATE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_CANNOT_SET_PARENT:
        Scm_Error("HPDF_PAGE_CANNOT_SET_PARENT error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_FONT_NOT_FOUND:
        Scm_Error("HPDF_PAGE_FONT_NOT_FOUND error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_INVALID_FONT:
        Scm_Error("HPDF_PAGE_INVALID_FONT error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_INVALID_FONT_SIZE:
        Scm_Error("HPDF_PAGE_INVALID_FONT_SIZE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_INVALID_GMODE:
        Scm_Error("HPDF_PAGE_INVALID_GMODE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_INVALID_INDEX:
        Scm_Error("HPDF_PAGE_INVALID_INDEX error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_INVALID_ROTATE_VALUE:
        Scm_Error("HPDF_PAGE_INVALID_ROTATE_VALUE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_INVALID_SIZE:
        Scm_Error("HPDF_PAGE_INVALID_SIZE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_INVALID_XOBJECT:
        Scm_Error("HPDF_PAGE_INVALID_XOBJECT error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_PAGE_OUT_OF_RANGE:
        Scm_Error("HPDF_PAGE_OUT_OF_RANGE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_REAL_OUT_OF_RANGE:
        Scm_Error("HPDF_REAL_OUT_OF_RANGE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_STREAM_EOF:
        Scm_Error("HPDF_STREAM_EOF error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_STREAM_READLN_CONTINUE:
        Scm_Error("HPDF_STREAM_READLN_CONTINUE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_STRING_OUT_OF_RANGE:
        Scm_Error("HPDF_STRING_OUT_OF_RANGE error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_THIS_FUNC_WAS_SKIPPED:
        Scm_Error("HPDF_THIS_FUNC_WAS_SKIPPED error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_TTF_CANNOT_EMBEDDING_FONT:
        Scm_Error("HPDF_TTF_CANNOT_EMBEDDING_FONT error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_TTF_INVALID_CMAP:
        Scm_Error("HPDF_TTF_INVALID_CMAP error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_TTF_INVALID_FOMAT:
        Scm_Error("HPDF_TTF_INVALID_FOMAT error_no:0x%x detail_no:%d\n", error_no, detail_no);
        break;
    case HPDF_TTF_MISSING_TABLE:
        Scm_Error("HPDF_TTF_MISSING_TABLE error_no:0x%x detail_no:%d Unsupported ttf format. "
                  "(cannot find a necessary table)\n", error_no, detail_no);
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
extern void Scm_Init_hpdf_types(ScmModule*);
extern void Scm_Init_hpdf_page(ScmModule*);
extern void Scm_Init_hpdf_image(ScmModule*);
extern void Scm_Init_hpdf_text(ScmModule*);
extern void Scm_Init_hpdf_u3d(ScmModule*);


ScmObj Scm_Init_gauche__hpdf(void)
{
    ScmModule *mod;

    /* Register this DSO to Gauche */
    SCM_INIT_EXTENSION(hpdf);

    /* Create the module if it doesn't exist yet. */
    mod = SCM_MODULE(SCM_FIND_MODULE("hpdf", TRUE));

    /* Register stub-generated procedures */
    Scm_Init_hpdflib(mod);

    Scm_Init_hpdf_types(mod);
    Scm_Init_hpdf_u3d(mod);
    Scm_Init_hpdf_page(mod);
    Scm_Init_hpdf_image(mod);
    Scm_Init_hpdf_text(mod);
}
