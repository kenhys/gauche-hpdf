;;;
;;; Test hpdf
;;;

(use gauche.test)

(test-start "hpdf")
(use hpdf)
(test-module 'hpdf)

(test-section "hpdf font")

;; expect hpdf-new and hpdf-add-page suceeds
(define test-page (hpdf-add-page (hpdf-new)))

(test* "hpdf-page-set-size(portrait) HPDF_PAGE_SIZE_LETTER" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_LETTER HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size(portrait) HPDF_PAGE_SIZE_LEGAL" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_LEGAL HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size(portrait) HPDF_PAGE_SIZE_A3" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_A3 HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size(portrait) HPDF_PAGE_SIZE_A4" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_A4 HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size HPDF_PAGE_SIZE_A5" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_A5 HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size HPDF_PAGE_SIZE_B4" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_B4 HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size HPDF_PAGE_SIZE_B5" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_B5 HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size HPDF_PAGE_SIZE_EXECUTIVE" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_EXECUTIVE HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size HPDF_PAGE_SIZE_US4x6" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_US4x6 HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size HPDF_PAGE_SIZE_US4x8" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_US4x8 HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size HPDF_PAGE_SIZE_US5x7" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_US5x7 HPDF_PAGE_PORTRAIT))
(test* "hpdf-page-set-size HPDF_PAGE_SIZE_COMM10" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_COMM10 HPDF_PAGE_PORTRAIT))

;; error
;;(test* "check HPDF_PAGE_SIZE_COMM10" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) -1 HPDF_PAGE_PORTRAIT))
;;(test* "check HPDF_PAGE_SIZE_COMM10" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_EOF HPDF_PAGE_PORTRAIT))

;; epilogue
(test-end)





