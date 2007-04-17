;;;
;;; Test hpdf
;;;

(use gauche.test)

(test-start "hpdf")
(use hpdf)
(test-module 'hpdf)

(test-section "hpdf document")
(let* ((doc (hpdf-new)))
  (hpdf-savetofile doc "page_0.pdf"))

(let* ((doc (hpdf-new))
       (page_1 (hpdf-addpage doc)))
  (hpdf-savetofile doc "page_1.pdf"))

(let* ((doc (hpdf-new))
       (page_1 (hpdf-addpage doc))
       (page_1 (hpdf-addpage doc)))
  (hpdf-savetofile doc "page_2.pdf"))

(let* ((doc (hpdf-new))
       (page_1 (hpdf-addpage doc))
       (dummy (hpdf-savetofile doc "page1_1.pdf"))
       (page_1 (hpdf-addpage doc))
       (dummy (hpdf-savetofile doc "page1_2.pdf"))
       )
  (hpdf-savetofile doc "page1.pdf"))

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





