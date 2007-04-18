;;;
;;; Test hpdf
;;;

(use gauche.test)

(test-start "hpdf")
(use hpdf)
(test-module 'hpdf)

(test-section "hpdf document")
(let* ((doc (hpdf-new)))
  (hpdf-save-to-file doc "page_0.pdf"))

(let* ((doc (hpdf-new))
       (page_1 (hpdf-add-page doc)))
  (hpdf-save-to-file doc "page_1.pdf"))

(let* ((doc (hpdf-new))
       (page_1 (hpdf-add-page doc))
       (page_1 (hpdf-add-page doc)))
  (hpdf-save-to-file doc "page_2.pdf"))

(let* ((doc (hpdf-new))
       (page_1 (hpdf-add-page doc))
       (dummy (hpdf-save-to-file doc "page1_1.pdf"))
       (page_1 (hpdf-add-page doc))
       (dummy (hpdf-save-to-file doc "page1_2.pdf"))
       )
  (hpdf-save-to-file doc "page1.pdf"))

(let* ((doc (hpdf-new))
       (font (hpdf-get-font doc "Helvetica" ""))
       (page_1 (hpdf-add-page doc))
       (font (hpdf-page-set-font-and-size page_1 font 14))
       (s (hpdf-page-begin-text page_1))
       (null (print s))
       (dummy (hpdf-page-show-text page_1 "Hello, World"))
       (dummy (hpdf-page-end-text page_1))
       )
  (hpdf-save-to-file doc "hpdf_showtext.pdf"))

(let* ((doc (hpdf-new))
       ;;(font-name (hpdf-load-ttf-font-from-file doc
       ;; "/work/khayashi/Project/Gauche-hpdf/Gauche-hpdf/trunk/src/CapaMMO.ttf" HPDF_FALSE))
       (null (hpdf-use-jp-fonts doc))
       (null (hpdf-use-jp-encodings doc))
       (font-name
        (hpdf-load-ttf-font-from-file
         doc
         "ipag.ttf" HPDF_FALSE))
       ;;VL-Gothic-Regular.ttf
       (font (hpdf-get-font doc font-name "90ms-RKSJ-H"))
       (page_1 (hpdf-add-page doc))
       (font (hpdf-page-set-font-and-size page_1 font 14))
       (s (hpdf-page-begin-text page_1))
       (null (print s))
       (dummy (hpdf-page-show-text page_1 "Hello, World0O"))
       (dummy (hpdf-page-end-text page_1))
       )
  (hpdf-save-to-file doc "hpdf_showtext.pdf"))

;; epilogue
(test-end)





