;;;
;;; Test hpdf
;;;

(use gauche.test)

(test-start "hpdf")
(use hpdf)
(test-module 'hpdf)

(test-section "hpdf font")

(let* ((doc (hpdf-new))
       (font (hpdf-get-font doc "Helvetica" ""))
       (page_1 (hpdf-addpage doc))
       (font (hpdf-page-set-font-and-size page_1 font 14))
       (s (hpdf-page-begin-text page_1))
       (null (print s))
       (dummy (hpdf-page-show-text page_1 "Hello, World"))
       (dummy (hpdf-page-end-text page_1))
       )
  (hpdf-savetofile doc "hpdf_showtext.pdf"))

;; epilogue
(test-end)





