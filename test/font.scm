;;;
;;; -*- mode: scheme; coding: utf-8 -*-
;;; Test hpdf
;;;

(use gauche.test)
(use binary.pack)
(use file.util)

(test-start "hpdf")
(use hpdf)
(test-module 'hpdf)

(test-section "hpdf font")

(define (test-hpdf-load-ttf-font-from-file file flag)
  (let ((pdf (hpdf-new)))
    (if (file-is-readable? file)
        (hpdf-load-ttf-font-from-file pdf file flag)
        #f)))

;; test for non hpdf-use-jp-fonts
(define (test-hpdf-load-ttf-font-from-file2 file index flag)
  (let* ((pdf (hpdf-new))
         (null (hpdf-use-jp-encodings pdf)))
    (if (file-is-readable? file)
        (hpdf-load-ttf-font-from-file2 pdf file index flag)
        #f)))

(test* "ipag.ttf embed" "IPAGothic" (test-hpdf-load-ttf-font-from-file "font/ipag.ttf" #t))
(test* "ipag.ttf non-embed" "IPAGothic" (test-hpdf-load-ttf-font-from-file "font/ipag.ttf" #f))
(test* "ipagp.ttf embed" "IPAPGothic" (test-hpdf-load-ttf-font-from-file "font/ipagp.ttf" #t))
(test* "ipagp.ttf non-embed" "IPAPGothic" (test-hpdf-load-ttf-font-from-file "font/ipagp.ttf" #f))
(test* "ipagui.ttf embed" "IPAUIGothic" (test-hpdf-load-ttf-font-from-file "font/ipagui.ttf" #t))
(test* "ipagui.ttf non-embed" "IPAUIGothic" (test-hpdf-load-ttf-font-from-file "font/ipagui.ttf" #f))
(test* "ipam.ttf embed" "IPAMincho" (test-hpdf-load-ttf-font-from-file "font/ipam.ttf" #t))
(test* "ipam.ttf non-embed" "IPAMincho" (test-hpdf-load-ttf-font-from-file "font/ipam.ttf" #f))
(test* "ipamp.ttf embed" "IPAPMincho" (test-hpdf-load-ttf-font-from-file "font/ipamp.ttf" #t))
(test* "ipamp.ttf non-embed" "IPAPMincho" (test-hpdf-load-ttf-font-from-file "font/ipamp.ttf" #f))


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

(test-section "MS- fonts")
(test* "msgothic.ttc non-embed" "MS-Gothic" (test-hpdf-load-ttf-font-from-file2 "font/msgothic.ttc" 0 #f))
(test* "msgothic.ttc non-embed" "MS-PGothic" (test-hpdf-load-ttf-font-from-file2 "font/msgothic.ttc" 1 #f))
(test* "msgothic.ttc non-embed" "MS-UIGothic" (test-hpdf-load-ttf-font-from-file2 "font/msgothic.ttc" 2 #f))
(test* "msgoth04.ttc(JIS2004) non-embed" "MS-Gothic" (test-hpdf-load-ttf-font-from-file2 "font/msgoth04.ttc" 0 #f))
(test* "msgoth04.ttc(JIS2004) non-embed" "MS-PGothic" (test-hpdf-load-ttf-font-from-file2 "font/msgoth04.ttc" 1 #f))
(test* "msgoth04.ttc(JIS2004) non-embed" "MS-UIGothic" (test-hpdf-load-ttf-font-from-file2 "font/msgoth04.ttc" 2 #f))

(test* "msmincho.ttc index 0 non-embed" "MS-Mincho" (test-hpdf-load-ttf-font-from-file2 "font/msmincho.ttc" 0 #f))
(test* "msmincho.ttc index 1 non-embed" "MS-PMincho" (test-hpdf-load-ttf-font-from-file2 "font/msmincho.ttc" 1 #f))
(test* "msgoth04.ttc(JIS2004) index 0 non-embed" "MS-Mincho" (test-hpdf-load-ttf-font-from-file2 "font/msmin04.ttc" 0 #f))
(test* "msgoth04.ttc(JIS2004) index 1 non-embed" "MS-PMincho" (test-hpdf-load-ttf-font-from-file2 "font/msmin04.ttc" 1 #f))

(test-section "mikachan fonts")
(test* "mikachanALL.ttc index 0 embed" "mikachan" (test-hpdf-load-ttf-font-from-file2 "font/mikachanALL.ttc" 0 #t))
(test* "mikachanALL.ttc index 1 embed" "mikachan-P" (test-hpdf-load-ttf-font-from-file2 "font/mikachanALL.ttc" 1 #t))
(test* "mikachanALL.ttc index 2 embed" "mikachan-PB" (test-hpdf-load-ttf-font-from-file2 "font/mikachanALL.ttc" 2 #t))
(test* "mikachanALL.ttc index 3 embed" "mikachan-PS" (test-hpdf-load-ttf-font-from-file2 "font/mikachanALL.ttc" 3 #t))

(test* "mikachan_puchi.ttc index 0 embed" "mikachan-puchi" (test-hpdf-load-ttf-font-from-file2 "font/mikachan_puchi.ttc" 0 #t))
(test* "mikachan_puchi.ttc index 1 embed" "mikachan-puchiB" (test-hpdf-load-ttf-font-from-file2 "font/mikachan_puchi.ttc" 1 #t))

(test-section "konatu fonts")
(test* "konatu.ttf embed" "Konatu" (test-hpdf-load-ttf-font-from-file "font/Konatu.ttf" #t))
(test* "konatu.ttf embed" "KonatuTohaba" (test-hpdf-load-ttf-font-from-file "font/KonatuTohaba.ttf" #t))

(test-section "hpdf text")

(let* ((pdf (hpdf-new))
       (s (hpdf-set-compression-mode pdf HPDF_COMP_ALL))
       (s (hpdf-use-jp-encodings pdf))
       (s (hpdf-use-jp-fonts pdf))
       ;;(font_name (hpdf-load-ttf-font-from-file2 pdf "font/msgothic.ttc" 2 #f))
       ;;(font_name (hpdf-load-ttf-font-from-file pdf "font/ipagui.ttf" #f))
       ;;(font_name (hpdf-load-ttf-font-from-file2 pdf "font/msgothic.ttc" 2 #t))
       ;;(font_name (hpdf-load-ttf-font-from-file pdf "font/VL-Gothic-Regular.ttf" #t))
       ;;(font_name (hpdf-load-ttf-font-from-file pdf "font/VL-PGothic-Regular.ttf" #t))
       ;;(font_name (hpdf-load-ttf-font-from-file pdf "font/Konatu.ttf" #t))
       ;;(font_name (hpdf-load-ttf-font-from-file pdf "font/KonatuTohaba.ttf" #t))
       ;;(font_name (hpdf-load-ttf-font-from-file2 pdf "font/mikachanALL.ttc" 0 #t))
       ;;(font_name (hpdf-load-ttf-font-from-file2 pdf "font/mikachanALL.ttc" 1 #t))
       ;;(font_name (hpdf-load-ttf-font-from-file2 pdf "font/mikachanALL.ttc" 2 #t))
       (font_name (hpdf-load-ttf-font-from-file2 pdf "font/mikachanALL.ttc" 3 #t))
       ;;(font_name (hpdf-load-ttf-font-from-file pdf "font/CapaMMO.TTF" #f))
       ;;(font (hpdf-get-font pdf font_name "90ms-RKSJ-H"))
       ;;(font (hpdf-get-font pdf "MS-UIGothic" "90ms-RKSJ-H"))
       (font (hpdf-get-font pdf font_name "90ms-RKSJ-H"))
       (null (hpdf-set-page-mode pdf HPDF_PAGE_MODE_USE_OUTLINE))

       (page_1 (hpdf-add-page pdf))

       (root (hpdf-create-outline pdf #f "JP font demo" #f))
       (null (hpdf-outline-set-opened root #t))
       (outline (hpdf-create-outline pdf root "MS-UIGothic" #f))
       (dst (hpdf-page-create-destination page_1))
       (null (hpdf-outline-set-destination outline dst))

       (font (hpdf-page-set-font-and-size page_1 font 14))
       (st (hpdf-page-begin-text page_1))
       (s (read-line (open-input-file "data/sjis.txt") #t))
       (dummy (hpdf-page-show-text page_1 s))
       (dummy (hpdf-page-end-text page_1))
       )
  (hpdf-save-to-file pdf "data/budori.pdf"))

;; epilogue
(test-end)

