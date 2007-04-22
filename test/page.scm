;;;
;;; Test hpdf
;;;

(use gauche.test)

(test-start "hpdf")
(use hpdf)
(test-module 'hpdf)

(define (test-subsection msg)
  (format #t "~a()\n" msg))

(test-section "hpdf font")

;; expect hpdf-new and hpdf-add-page suceeds
(define test-page (hpdf-add-page (hpdf-new)))

;; portrait
(test-subsection "HPDF_PAGE_PORTRAIT hpdf-page-set-size")
(test* "HPDF_PAGE_SIZE_LETTER" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_LETTER HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_LEGAL" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_LEGAL HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_A3" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_A3 HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_A4" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_A4 HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_A5" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_A5 HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_B4" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_B4 HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_B5" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_B5 HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_EXECUTIVE" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_EXECUTIVE HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_US4x6" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_US4x6 HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_US4x8" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_US4x8 HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_US5x7" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_US5x7 HPDF_PAGE_PORTRAIT))
(test* "HPDF_PAGE_SIZE_COMM10" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_COMM10 HPDF_PAGE_PORTRAIT))

;; landscape
(test-subsection "HPDF_PAGE_LANDSPAPE hpdf-page-set-size")
(test* "HPDF_PAGE_SIZE_LETTER" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_LETTER HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_LEGAL" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_LEGAL HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_A3" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_A3 HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_A4" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_A4 HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_A5" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_A5 HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_B4" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_B4 HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_B5" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_B5 HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_EXECUTIVE" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_EXECUTIVE HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_US4x6" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_US4x6 HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_US4x8" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_US4x8 HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_US5x7" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_US5x7 HPDF_PAGE_LANDSCAPE))
(test* "HPDF_PAGE_SIZE_COMM10" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_COMM10 HPDF_PAGE_LANDSCAPE))

(define (test-hpdf-page-get-size page_style page_direction width height)
  (let* ((page (hpdf-add-page (hpdf-new)))
         (s (hpdf-page-set-size page page_style page_direction))
         (w (hpdf-page-get-width page))
         (h (hpdf-page-get-height page))
         )
    (if (and (= width w) (= height h))
        #t
        #f)))

(test-subsection "HPDF_PAGE_PORTRAIT hpdf-page-get-width/height")
(test* "HPDF_PAGE_SIZE_LETTER" #t (test-hpdf-page-get-size LETTER HPDF_PAGE_PORTRAIT 612 792))
(test* "HPDF_PAGE_SIZE_LEGAL" #t (test-hpdf-page-get-size LEGAL HPDF_PAGE_PORTRAIT 612 1008))
(test* "HPDF_PAGE_SIZE_A3" #t (test-hpdf-page-get-size A3 HPDF_PAGE_PORTRAIT 841.8900146484375 1199.551025390625))
(test* "HPDF_PAGE_SIZE_A4" #t (test-hpdf-page-get-size A4 HPDF_PAGE_PORTRAIT 595.2760009765625 841.8900146484375))
(test* "HPDF_PAGE_SIZE_A5" #t (test-hpdf-page-get-size A5 HPDF_PAGE_PORTRAIT 419.52801513671875 595.2760009765625))
(test* "HPDF_PAGE_SIZE_B4" #t (test-hpdf-page-get-size B4 HPDF_PAGE_PORTRAIT 708.6610107421875 1000.6300048828125))
(test* "HPDF_PAGE_SIZE_B5" #t (test-hpdf-page-get-size B5 HPDF_PAGE_PORTRAIT 498.89801025390625 708.6610107421875))
(test* "HPDF_PAGE_SIZE_EXECUTIVE" #t (test-hpdf-page-get-size EXECUTIVE HPDF_PAGE_PORTRAIT 522 756))
(test* "HPDF_PAGE_SIZE_US4x6" #t (test-hpdf-page-get-size US4x6 HPDF_PAGE_PORTRAIT 288 432))
(test* "HPDF_PAGE_SIZE_US4x8" #t (test-hpdf-page-get-size US4x8 HPDF_PAGE_PORTRAIT 288 576))
(test* "HPDF_PAGE_SIZE_US5x7" #t (test-hpdf-page-get-size US5x7 HPDF_PAGE_PORTRAIT 360 504))
(test* "HPDF_PAGE_SIZE_COMM10" #t (test-hpdf-page-get-size COMM10 HPDF_PAGE_PORTRAIT 297 684))

(test-subsection "HPDF_PAGE_LANDSPAPE hpdf-page-get-width/height")
(test* "HPDF_PAGE_SIZE_LETTER" #t (test-hpdf-page-get-size LETTER HPDF_PAGE_LANDSCAPE 792 612))
(test* "HPDF_PAGE_SIZE_LEGAL" #t (test-hpdf-page-get-size LEGAL HPDF_PAGE_LANDSCAPE 1008 612))
(test* "HPDF_PAGE_SIZE_A3" #t (test-hpdf-page-get-size A3 HPDF_PAGE_LANDSCAPE 1199.551025390625 841.8900146484375))
(test* "HPDF_PAGE_SIZE_A4" #t (test-hpdf-page-get-size A4 HPDF_PAGE_LANDSCAPE 841.8900146484375 595.2760009765625))
(test* "HPDF_PAGE_SIZE_A5" #t (test-hpdf-page-get-size A5 HPDF_PAGE_LANDSCAPE 595.2760009765625 419.52801513671875))
(test* "HPDF_PAGE_SIZE_B4" #t (test-hpdf-page-get-size B4 HPDF_PAGE_LANDSCAPE 1000.6300048828125 708.6610107421875))
(test* "HPDF_PAGE_SIZE_B5" #t (test-hpdf-page-get-size B5 HPDF_PAGE_LANDSCAPE 708.6610107421875 498.89801025390625))
(test* "HPDF_PAGE_SIZE_EXECUTIVE" #t (test-hpdf-page-get-size EXECUTIVE HPDF_PAGE_LANDSCAPE 756 522))
(test* "HPDF_PAGE_SIZE_US4x6" #t (test-hpdf-page-get-size US4x6 HPDF_PAGE_LANDSCAPE 432 288))
(test* "HPDF_PAGE_SIZE_US4x8" #t (test-hpdf-page-get-size US4x8 HPDF_PAGE_LANDSCAPE 576 288))
(test* "HPDF_PAGE_SIZE_US5x7" #t (test-hpdf-page-get-size US5x7 HPDF_PAGE_LANDSCAPE 504 360))
(test* "HPDF_PAGE_SIZE_COMM10" #t (test-hpdf-page-get-size COMM10 HPDF_PAGE_LANDSCAPE 684 297))

;; error
;;(test* "check HPDF_PAGE_SIZE_COMM10" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) -1 HPDF_PAGE_PORTRAIT))
;;(test* "check HPDF_PAGE_SIZE_COMM10" HPDF_OK (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_EOF HPDF_PAGE_PORTRAIT))

;; epilogue
(test-end)





