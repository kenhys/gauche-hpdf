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

;; test for non hpdf-use-jp-fonts
(define (test-hpdf-load-ttf-font-from-file2 file index flag)
  (let* ((pdf (hpdf-new))
         (null (hpdf-use-jp-encodings pdf)))
    (hpdf-load-ttf-font-from-file2 pdf file index flag)))

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


(test-section "hpdf fonts")
(test* "jp fonts" HPDF_OK (hpdf-use-jp-fonts (hpdf-new)))
(test* "kr fonts" HPDF_OK (hpdf-use-kr-fonts (hpdf-new)))
(test* "cns fonts" HPDF_OK (hpdf-use-cns-fonts (hpdf-new)))
(test* "cnt fonts" HPDF_OK (hpdf-use-cnt-fonts (hpdf-new)))

(test-section "hpdf encodings")
(test* "jp encodings" HPDF_OK (hpdf-use-jp-encodings (hpdf-new)))
(test* "kr encodings" HPDF_OK (hpdf-use-kr-encodings (hpdf-new)))
(test* "cnt encodings" HPDF_OK (hpdf-use-cnt-encodings (hpdf-new)))
(test* "cns encodings" HPDF_OK (hpdf-use-cns-encodings (hpdf-new)))

(test-section "hpdf MS- fonts")
(test* "msgothic.ttc non-embed" "MS-Gothic" (test-hpdf-load-ttf-font-from-file2 "msgothic.ttc" 0 HPDF_FALSE))
(test* "msgothic.ttc non-embed" "MS-PGothic" (test-hpdf-load-ttf-font-from-file2 "msgothic.ttc" 1 HPDF_FALSE))
(test* "msgothic.ttc non-embed" "MS-UIGothic" (test-hpdf-load-ttf-font-from-file2 "msgothic.ttc" 2 HPDF_FALSE))
(test* "msgoth04.ttc(JIS2004) non-embed" "MS-Gothic" (test-hpdf-load-ttf-font-from-file2 "msgoth04.ttc" 0 HPDF_FALSE))
(test* "msgoth04.ttc(JIS2004) non-embed" "MS-PGothic" (test-hpdf-load-ttf-font-from-file2 "msgoth04.ttc" 1 HPDF_FALSE))
(test* "msgoth04.ttc(JIS2004) non-embed" "MS-UIGothic" (test-hpdf-load-ttf-font-from-file2 "msgoth04.ttc" 2 HPDF_FALSE))

(test* "msmincho.ttc index 0 non-embed" "MS-Mincho" (test-hpdf-load-ttf-font-from-file2 "msmincho.ttc" 0 HPDF_FALSE))
(test* "msmincho.ttc index 1 non-embed" "MS-PMincho" (test-hpdf-load-ttf-font-from-file2 "msmincho.ttc" 1 HPDF_FALSE))
(test* "msgoth04.ttc(JIS2004) index 0 non-embed" "MS-Mincho" (test-hpdf-load-ttf-font-from-file2 "msmin04.ttc" 0 HPDF_FALSE))
(test* "msgoth04.ttc(JIS2004) index 1 non-embed" "MS-PMincho" (test-hpdf-load-ttf-font-from-file2 "msmin04.ttc" 1 HPDF_FALSE))

(test-section "hpdf text")

(let* ((pdf (hpdf-new))
       ;;(null (hpdf-use-jp-fonts pdf))
       (null (hpdf-use-jp-encodings pdf))
       (font_name (hpdf-load-ttf-font-from-file2 pdf "msgothic.ttc" 2 HPDF_FALSE))
       (null (hpdf-set-page-mode pdf HPDF_PAGE_MODE_USE_OUTLINE))
       (font (hpdf-get-font pdf "MS-UIGothic" "90ms-RKSJ-H"))
       (page_1 (hpdf-add-page pdf))

       (root (hpdf-create-outline pdf #f "JP font demo" #f))
       (null (hpdf-outline-set-opened root #t))
       (outline (hpdf-create-outline pdf root "MS-UIGothic" #f))
       (dst (hpdf-page-create-destination page_1))
       (null (hpdf-outline-set-destination outline dst))

       (font (hpdf-page-set-font-and-size page_1 font 14))
       (s (hpdf-page-begin-text page_1))
       (s (port->string (open-input-file "sjis.txt")))
       (null (print s))
       (dummy (hpdf-page-show-text page_1 s))
       (dummy (hpdf-page-end-text page_1))
       )
  (hpdf-save-to-file pdf "budori.pdf"))

;; epilogue
(test-end)

