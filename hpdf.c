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
