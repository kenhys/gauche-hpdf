;;;
;;; Test hpdf
;;;

(use gauche.test)

(test-start "hpdf")
(use hpdf)
(test-module 'hpdf)

(test-section "hpdf font")

(define (test-hpdf-load-ttf-font-from-file file flag)
  (let ((pdf (hpdf-new)))
    (hpdf-load-ttf-font-from-file pdf file flag)))

(test* "ipag.ttf embed" "IPAGothic" (test-hpdf-load-ttf-font-from-file "ipag.ttf" HPDF_TRUE))
(test* "ipag.ttf non-embed" "IPAGothic" (test-hpdf-load-ttf-font-from-file "ipag.ttf" HPDF_FALSE))
(test* "ipagp.ttf embed" "IPAPGothic" (test-hpdf-load-ttf-font-from-file "ipagp.ttf" HPDF_TRUE))
(test* "ipagp.ttf non-embed" "IPAPGothic" (test-hpdf-load-ttf-font-from-file "ipagp.ttf" HPDF_FALSE))
(test* "ipagui.ttf embed" "IPAUIGothic" (test-hpdf-load-ttf-font-from-file "ipagui.ttf" HPDF_TRUE))
(test* "ipagui.ttf non-embed" "IPAUIGothic" (test-hpdf-load-ttf-font-from-file "ipagui.ttf" HPDF_FALSE))
(test* "ipam.ttf embed" "IPAMincho" (test-hpdf-load-ttf-font-from-file "ipam.ttf" HPDF_TRUE))
(test* "ipam.ttf non-embed" "IPAMincho" (test-hpdf-load-ttf-font-from-file "ipam.ttf" HPDF_FALSE))
(test* "ipamp.ttf embed" "IPAPMincho" (test-hpdf-load-ttf-font-from-file "ipamp.ttf" HPDF_TRUE))
(test* "ipamp.ttf non-embed" "IPAPMincho" (test-hpdf-load-ttf-font-from-file "ipamp.ttf" HPDF_FALSE))

;; epilogue
(test-end)





