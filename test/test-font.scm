;;;
;;; -*- mode: scheme; coding: utf-8 -*-
;;; Test hpdf
;;;

(use gauche.test)
(use gauche.charconv)
(use gauche.collection)
(use gauche.sequence)
(use gauche.interactive)
(use binary.pack)
(use file.util)
(use hpdf)

(test-record-file "test.record")

(test-module 'hpdf)

(test-start "font")

(test-section "hpdf font")

(define (test-subsection msg)
  (format #t "~a()\n" msg))
(define (test-subsubsection msg)
  (format #t "#=> ~a\n" msg))

(define (mktest-proc expect name desc)
  (let* ([pdf (hpdf-new)]
	 [filename (cond [(file-is-readable?
			   (format #f "test/pngsuite/~a.png" name))
			  (format #f "test/pngsuite/~a.png" name)]
			 [(file-is-readable? 
			   (format #f "test/PngSuite-2011apr25/~a.png" name))
			  (format #f "test/PngSuite-2011apr25/~a.png" name)]
			 [else #f])])
    (if (and filename (file-is-readable? filename))
	(test* (format #f "~a(~a) ~a"
		       'hpdf-load-ttf-font-from-file filename desc)
	       expect
	       (class-of (hpdf-load-png-image-from-file pdf filename))))))

(define (mktest arg)
  (map-with-index
   (^ (index arg) (mktest-proc <hpdf-image> (car arg) (cadr arg))) arg))


(define (test-hpdf-load-ttf-font-from-file file flag)
  (let ((pdf (hpdf-new)))
    (if (file-is-readable? file)
        (hpdf-load-ttf-font-from-file pdf file flag)
        #f)))

;; test for no hpdf-use-jp-fonts
(define (test-hpdf-load-ttf-font-from-file2 file index flag)
  (let* ((pdf (hpdf-new))
         (null (hpdf-use-jp-encodings pdf)))
    (if (file-is-readable? file)
        (hpdf-load-ttf-font-from-file2 pdf file index flag)
        #f)))

(define (test-hpdf-load-type1-font-from-file afm pfb)
  (let* ((pdf (hpdf-new))
         (null (hpdf-use-jp-encodings pdf)))
    (hpdf-load-type1-font-from-file pdf afm pfb)))


(define (mktest proc desc)
  (test* desc HPDF_OK (proc (hpdf-new))))


(define ipa-fonts
  '(("IPAGothic" "ipag.ttf")
    ("IPAPGothic" "ipagp.ttf")
    ("IPAUIGothic" "ipagui.ttf")
    ("IPAMincho" "ipam.ttf")
    ("IPAPMincho" "ipamp.ttf")))

(define ms-fonts
  '(("MS-Gothic" "msgothic.ttc" 0)
    ("MS-PGothic" "msgothic.ttc" 1)
    ("MS-UIGothic" "msgothic.ttc" 2)

    ("MS-Gothic" "msgoth04.ttc" 0)
    ("MS-PGothic" "msgoth04.ttc" 1)
    ("MS-UIGothic" "msgoth04.ttc" 2)

    ("MS-Mincho"  "msmincho.ttc" 0)
    ("MS-PMincho"  "msmincho.ttc" 1)
    ("MS-Mincho"  "msmin04.ttc" 0)
    ("MS-PMincho"  "msmin04.ttc" 1)))

(define migmix-fonts
  '(("MigMix-1M-Bold,Bold" "migmix-1m-bold.ttf")
    ("MigMix-1M-Regular" "migmix-1m-regular.ttf")
    ("MigMix-1P-Bold,Bold" "migmix-1p-bold.ttf")
    ("MigMix-1P-Regular" "migmix-1p-regular.ttf")
    ("MigMix-2M-Bold,Bold" "migmix-2m-bold.ttf")
    ("MigMix-2M-Regular" "migmix-2m-regular.ttf")
    ("MigMix-2P-Bold,Bold" "migmix-2p-bold.ttf")
    ("MigMix-2P-Regular" "migmix-2p-regular.ttf")))

;;
;; hpdf-use-*-fonts
;;
(test-section "hpdf-use-*-fonts")

(mktest hpdf-use-jp-fonts "jp fonts")
(mktest hpdf-use-kr-fonts "kr fonts")
(mktest hpdf-use-cnt-fonts "cnt fonts")
(mktest hpdf-use-cns-fonts "cns fonts")

;;
;; hpdf-use-*-encodings
;;
(test-section "hpdf-use-*-encodings")

(mktest hpdf-use-jp-encodings "jp encodings")
(mktest hpdf-use-kr-encodings "kr encodings")
(mktest hpdf-use-cnt-encodings "cnt encodings")
(mktest hpdf-use-cns-encodings "cns encodings")

(define (mktest-proc expect proc desc font index)
  (let* ([filename (cond [(file-is-readable?
			   (format #f "test/font/~a" font))
			  (format #f "test/font/~a" font)]
			 [else #f])]
	 [pdf (hpdf-new)]
         [null (hpdf-use-jp-encodings pdf)])
    (if (and filename (file-is-readable? filename))
	(if (>= index 0)
	    (begin ;; support .ttc
	      (test* (format #f "~a embed" font) expect
		     (proc pdf filename index #t)))
	    ;; suport .ttf
	    (test* (format #f "~a embed" font) expect
		   (proc pdf filename #t)))
	;; NOTE: if font file was already registered,
	;; load font file returns HPDF_FONT_EXISTS
	;; (test* (format #f "~a non-embed" font) expect
	;; 	 (proc pdf filename index #f)))
        #f)))

(test-section "hpdf-load-ttf-font-from-file2")

(define (mktest arg)
  (map-with-index
   (^ (index entry)
     (mktest-proc
	     (~ entry 0) ;; expect
	     hpdf-load-ttf-font-from-file2 ;; proc
	     (~ entry 1) ;; desc
	     (~ entry 1) ;; font
	     (~ entry 2) ;; index
	     )) arg))
   

;; MS fonts
(test-subsection "MS fonts")
(mktest ms-fonts)

(test-subsection "mikachan fonts")
;; (mktest "mikachanALL.ttc index 0 embed" "mikachan"  "mikachanALL.ttc" 0 #t))
;; (mktest "mikachanALL.ttc index 1 embed" "mikachan-P"  "mikachanALL.ttc" 1 #t))
;; (mktest "mikachanALL.ttc index 2 embed" "mikachan-PB"  "mikachanALL.ttc" 2 #t))
;; (mktest "mikachanALL.ttc index 3 embed" "mikachan-PS"  "mikachanALL.ttc" 3 #t))

;; (mktest "mikachan_puchi.ttc index 0 embed" "mikachan-puchi"  "mikachan_puchi.ttc" 0 #t))
;; (mktest "mikachan_puchi.ttc index 1 embed" "mikachan-puchiB"  "mikachan_puchi.ttc" 1 #t))


;;
;; hpdf-load-ttf-font-from-file
;;
(test-section "hpdf-load-ttf-font-from-file")

(define (mktest arg)
  (map-with-index
   (^ (index entry)
     (begin
       (mktest-proc
	(~ entry 0) ;; expect
	hpdf-load-ttf-font-from-file ;; proc
	(~ entry 1) ;; desc
	(~ entry 1) ;; font
	-1))) arg))

(test-subsection "IPA fonts")
(mktest ipa-fonts)

(test-subsection "migmix fonts")
(mktest migmix-fonts)

    
(define mplus-circle-fonts
  '(("M+1P+IPAG-Regular,regular" "M+1P+IPAG.ttf")
    ("M+1P+IPAG-circle-Regular,regular" "M+1P+IPAG-circle.ttf")
    ("M+1VM+IPAG-circle-Regular,regular" "M+1VM+IPAG-circle.ttf")
    ("M+2P+IPAG-Regular,regular" "M+2P+IPAG.ttf")
    ("M+2P+IPAG-circle-Regular,regular" "M+2P+IPAG-circle.ttf")
    ("M+2VM+IPAG-circle-Regular,regular" "M+2VM+IPAG-circle.ttf")))

(define ipa-mona-fonts
  '(("IPAMonaGothic,Book" "ipag-mona.ttf")
    ("IPAMonaPGothic" "ipagp-mona.ttf")
    ("IPAMonaUIGothic,Book" "ipagui-mona.ttf")
    ("IPAMonaMincho,Book" "ipam-mona.ttf")
    ("IPAMonaPMincho" "ipamp-mona.ttf")))

(define vl-fonts
  '(("VL-Gothic-Regular,regular" "VL-Gothic-Regular.ttf")
    ("VL-PGothic-Regular,regular" "VL-PGothic-Regular.ttf")))

(test-subsection "M+IPAG fonts")
(mktest mplus-circle-fonts)

(test-subsection "IPA Mona fonts")
(mktest ipa-mona-fonts)


(test-subsection "VL fonts")
(mktest vl-fonts)

(test-subsection "M+ fonts")

(define mplus-fonts
  '(("mplus-1c-black,Bold" "mplus-1c-black.ttf")
    ("mplus-1c-bold,Bold" "mplus-1c-bold.ttf")
    ("mplus-1c-heavy,Bold" "mplus-1c-heavy.ttf")
    ("mplus-1c-light" "mplus-1c-light.ttf")
    ("mplus-1c-medium" "mplus-1c-medium.ttf")
    ("mplus-1c-regular" "mplus-1c-regular.ttf")
    ("mplus-1c-thin" "mplus-1c-thin.ttf")
    ("mplus-1m-bold,Bold" "mplus-1m-bold.ttf")
    ("mplus-1m-light" "mplus-1m-light.ttf")
    ("mplus-1m-medium" "mplus-1m-medium.ttf")
    ("mplus-1m-regular" "mplus-1m-regular.ttf")
    ("mplus-1m-thin" "mplus-1m-thin.ttf")
    ("mplus-1mn-bold,Bold" "mplus-1mn-bold.ttf")
    ("mplus-1mn-light" "mplus-1mn-light.ttf")
    ("mplus-1mn-medium" "mplus-1mn-medium.ttf")
    ("mplus-1mn-regular" "mplus-1mn-regular.ttf")
    ("mplus-1mn-thin" "mplus-1mn-thin.ttf")
    ("mplus-1p-bold,Bold" "mplus-1p-bold.ttf" )
    ("mplus-1p-light" "mplus-1p-light.ttf" )
    ("mplus-1p-medium" "mplus-1p-medium.ttf" )
    ("mplus-1p-regular" "mplus-1p-regular.ttf" )
    ("mplus-1p-thin" "mplus-1p-thin.ttf" )
    ("mplus-2c-bold,Bold" "mplus-2c-bold.ttf" )
    ("mplus-2c-light" "mplus-2c-light.ttf" )
    ("mplus-2c-medium" "mplus-2c-medium.ttf" )
    ("mplus-2c-regular" "mplus-2c-regular.ttf" )
    ("mplus-2c-thin" "mplus-2c-thin.ttf" )
    ("mplus-2m-bold,Bold" "mplus-2m-bold.ttf" )
    ("mplus-2m-light" "mplus-2m-light.ttf" )
    ("mplus-2m-medium" "mplus-2m-medium.ttf" )
    ("mplus-2m-regular" "mplus-2m-regular.ttf" )
    ("mplus-2m-thin" "mplus-2m-thin.ttf" )
    ("mplus-2p-bold,Bold" "mplus-2p-bold.ttf" )
    ("mplus-2p-light" "mplus-2p-light.ttf" )
    ("mplus-2p-medium" "mplus-2p-medium.ttf" )
    ("mplus-2p-regular" "mplus-2p-regular.ttf" )
    ("mplus-2p-thin" "mplus-2p-thin.ttf" )))

(mktest mplus-fonts)


;; (test-section "konatu fonts")
;; (test-subsection "hpdf-load-ttf-font-from-file")
;; (mktest "Konatu.ttf embed" "Konatu" "Konatu.ttf" #t))
;; (mktest "KonatuTohaba.ttf embed" "KonatuTohaba" "KonatuTohaba.ttf" #t))


;; (test-section "type-lab fonts")
;; (test-subsection "hpdf-load-ttf-font-from-file")
;; (mktest "Anito L proportional embed" "Anito-L-kyohkan" "AnitoLP.TTF" #t))
;; (mktest "Arare monospace embed" "Aralet-Mono-Kyohkan,Mono-Kyohkan" "ArareM.TTF" #t))
;; (mktest "Capanito L proportional embed" "Capanito-L-kyohkan" "CapaLP.ttf" #t))
;; (mktest "September L proportional embed" *test-error* "SeptemberLP.TTF" #t))
;; (mktest "September L monospace embed" *test-error* "SeptemberL.TTF" #t))
;; (mktest "September M proportional embed" *test-error* "SeptemberMP.TTF" #t))
;; (mktest "September M monospace embed" *test-error* "SeptemberM.TTF" #t))
;; (mktest "Anito Inline embed" *test-error* "AnitoInline.TTF" #t))
;; (mktest "Anito Relief embed" *test-error* "AnitoRelief.TTF" #t))
;; (mktest "Anito L monospace embed" *test-error* "AnitoL.TTF" #t))
;; (mktest "Anito M proportional embed" *test-error* "AnitoMP.TTF" #t))
;; (mktest "Anito M monospace embed" *test-error* "AnitoM.TTF" #t))
;; (mktest "Arare proportional embed" *test-error* "ArareP.TTF" #t))
;; (mktest "Capanito L monospace embed" *test-error* "CapaL.ttf" #t))
;; (mktest "Capanito M monospace embed" *test-error* "CapaM.ttf" #t))
;; (mktest "Capanito M proportional embed" *test-error* "CapaMP.ttf" #t))
;; (mktest "Capanito M monospace(Propriety) embed" *test-error* "CapaMMO.TTF" #t))
;; (mktest "Capanito M proportional(Propriety) embed" *test-error* "CapanitoM.TTF" #t))
;; (mktest "Elegant w3 embed" "ElgseionW3.TTF" "ElgseionW3.TTF" #t))
;; (mktest "Elegant w5 embed" "ElgseionW5.TTF" "ElgseionW5.TTF" #t))
;; (mktest "Elegant w7 embed" "ElgseionW7.TTF" "ElgseionW7.TTF" #t))
;; (mktest "Elegant w9 embed" "ElgseionW9.TTF" "ElgseionW9.TTF" #t))

;; (test-section "Aqua fonts")
;; (mktest "hpdf-load-ttf-font-from-file aquafont embed" "aquafont" "aquafont.ttf" #t))
;; (mktest "hpdf-load-ttf-font-from-file aqua_pfont embed" "aqua_pfont" "aqua_pfont.ttf" #t))

;; (test-section "Sana fonts")
;; (mktest "SNsanafon embed" "SanaFon" "SNsanafon.ttf" #t))
;; (mktest "SNsanafonGyou embed" "SanafonGyou" "SNsanafonGyou.TTF" #t))
;; (mktest "SNsanafonKazari embed" "SanafonKazari" "SNsanafonKazari.ttf" #t))
;; (mktest "SNsanafonMugi embed" "SanafonMugi" "SNsanafonMugi.TTF" #t))
;; (mktest "SNsanafonObi embed" "SNsanafonObi" "SNsanafonObi.ttf" #t))
;; (mktest "SNsanafonkaku embed" "SanaFonKaku" "SNsanafonkaku.ttf" #t))
;; (mktest "SNsanafonkakuP embed" "SanafonkakuP" "SNsanafonkakuP.ttf" #t))
;; (mktest "SNsanafonmaru embed" "SanaFonMaru" "SNsanafonmaru.ttf" #t))
;; (mktest "SNsanafonmaruP embed" "SanafonMaruP" "SNsanafonmaruP.ttf" #t))
;; (mktest "SNsanafonYu embed" "SanafonYu" "SNsanafonyu.ttf" #t))

;; (test-section "XANO fonts")
;; (mktest "Kandata embed" *test-error* "Kandata.ttf" #t))
;; (mktest "Oradano embed" *test-error* "Oradano.ttf" #t))
;; (mktest "QANO mincho embed" *test-error* "QANO-mincho.ttf" #t))
;; (mktest "QuiMi mincho embed" *test-error* "QuiMi-mincho.ttf" #t))
;; (mktest "XANO-mincho embed" *test-error* "XANO-mincho.ttf" #t))
;; (mktest "XANO-mincho-U32 embed" "XANO-mincho-U32" "XANO-mincho-U32.ttf" #t))

;; (test-section "S2G fonts")
;; (mktest "umi.ttf embed" "seafont" "umi.ttf" #t))
;; (mktest "sea.ttf embed" "Sea-font" "sea.ttf" #t))
;; (mktest "seap.ttf embed" "Sea-font-pro" "seap.ttf" #t))
;; (mktest "uni.ttf embed" "uni-font" "uni.ttf" #t))
;; (mktest "unip.ttf embed" "uni-font-PRO" "unip.ttf" #t))
;; (mktest "tsuki.ttf embed" "moon-font" "tsuki.ttf" #t))
;; (mktest "tsukip.ttf embed" "moon-font-PRO" "tsukip.ttf" #t))
;; (mktest "naguri.ttf embed" "nagurigaki" "naguri.ttf" #t))
;; (mktest "nagurip.ttf embed" "nagurigaki-P" "nagurip.ttf" #t))
;; (mktest "memo.ttf embed" "S2Gmemo" "memo.ttf" #t))
;; (mktest "love.ttf embed" "S2G-love" "love.ttf" #t))

;; (test-section "S2G fonts")
;; (mktest "Sazanami-Gothic-Regular embed" "Sazanami-Gothic-Regular,Gothic-Regular" "sazanami-gothic.ttf" #t))
;; (mktest "Sazanami-Mincho-Regular embed" "Sazanami-Mincho-Regular,Mincho-Regular" "sazanami-mincho.ttf" #t))

;; (test-section "Other fonts")
;; (mktest "akubin embed" *test-error* "AKUBIN.TTF" #t))
;; ;; (mktest "japonesque embed" "unsupported" "Japonesque1.45.TTF" #t))
;; (mktest "cinecaption embed" "cinecaption" "cinecaption226.ttf" #t))
;; (mktest "elmer monospace embed" "ElmerFont" "elmer.ttf" #t))
;; (mktest "elmer proportional embed" "ElmerPFont" "elmerp.ttf" #t))
;; (mktest "dameji proportional embed" "dameji" "dameji.ttf" #t))
;; (mktest "habadasa embed" "HabaDasa" "habadasa.ttf" #t))
;; (mktest "Dosei embed" "DOSEI SAN (Mr.Saturn)" "Dosei.ttf" #t))
;; (mktest "TA Bimyou embed" "TAbimyou_Add" "tabimyou_add.TTF" #t))
;; (mktest "TA Bimyou proportional embed" "TAbimyou_Add_p" "tabimyou_add_p.TTF" #t))
;; (mktest "dejima-mincho embed" "dejima-mincho,mincho" "dejima-mincho-r21.ttf" #t))
;; (mktest "hogehoge-gothic embed" "Hogehoge-Gothic-Regular,Gothic-Regular" "hogehoge-gothic.ttf" #t))

;; (mktest "tsuitiku embed" "Tsuitiku-Kana-Regular" "tsuitiku.ttf" #t))
;; (mktest "tsuitiku-modern embed" "Tsuitiku-Kana-Modern,Modern" "tsuitiku-modern.ttf" #t))
;; (mktest "tsuitiku proportional embed" "Tsuitiku-Kana-P-Regular,P-Regular" "p-tsuitiku.ttf" #t))

;; (mktest "Osaka embed" "Osaka"  "Osaka.ttc" 0 #t))
;; (mktest "Osaka embed" "Osaka-Mono"  "Osaka.ttc" 1 #t))
;; (mktest "Osaka embed" "Osaka-UI"  "Osaka.ttc" 2 #t))
;; (mktest "SH G30 embed" "GK-M"  "SH G30.ttc" 0 #t))
;; (mktest "SH G30 embed" "GK-P"  "SH G30.ttc" 1 #t))

;; (test-section "Zetuei fonts")
;; (mktest "Zetsuei mincho embed" "ZeueiMinchoSample" "ZEUEMS__.TTF" #t))
;; (mktest "Zetsuei mincho HIR embed" "ZetueiMinchoHIR,HIR" "ZETUMH__.TTF" #t))
;; (mktest "Zestuei HRKT rev embed" "HRKTKAI" "HRKT-KAI.TTF" #t))

(test-section "hpdf text")

;; ;;
;; (define (port->string-list2 iport lst)
;;   (let* ((s (read-line iport #t))
;;          )
;;     (if (eof-object? s)
;;         lst
;;         (append (list s) (port->string-list2 iport lst))
;;         )))

;; (define (show-test-text page file)
;;   (let* ((buf (port->string-list2 (open-input-file file) '()))
;;          (s (list-ref buf 0))
;;          )
;;     (begin0
;;      (hpdf-page-show-text page s)
;;      (hpdf-page-show-text-next-line page (list-ref buf 1))
;;      (hpdf-page-show-text-next-line page (list-ref buf 2))
;;      (hpdf-page-show-text-next-line page (list-ref buf 3))
;;      (hpdf-page-show-text-next-line page (list-ref buf 4))
;;      (hpdf-page-show-text-next-line page (list-ref buf 5))
;;      (hpdf-page-show-text-next-line page (list-ref buf 6))
;;      (hpdf-page-show-text-next-line page (list-ref buf 7))
;;      (hpdf-page-show-text-next-line page (list-ref buf 8))
;;      (hpdf-page-show-text-next-line page (list-ref buf 9))
;;      (hpdf-page-show-text-next-line page (list-ref buf 10))
;;      (hpdf-page-show-text-next-line page (list-ref buf 11))
;;      (hpdf-page-show-text-next-line page (list-ref buf 12))
;;      (hpdf-page-show-text-next-line page (list-ref buf 13))
;;      ;;(show-test-text2 page (list-tail buf 1))
;;     )))

;; (define (show-test-text2 page buf)
;;   (let* ((s (list-ref buf 0))
;;          )
;;     (if (> (length buf) 1)
;;         (begin0
;;          (hpdf-page-show-text-next-line page s)
;;          ;;(show-test-text2 page (list-tail buf 1))
;;          )
;;         (show-test-text2 page s)
;;         )
;;     ))
        
;; (define font-list
;;   (list
;;    '("data/msgothic_0.pdf" ("msgothic.ttc" 0 #t))
;;    '("data/msgothic_1.pdf" ("msgothic.ttc" 1 #t))
;;    '("data/msgothic_2.pdf" ("msgothic.ttc" 2 #t))
;;    '("data/msmincho_0.pdf" ("msmincho.ttc" 0 #t))
;;    '("data/msmincho_1.pdf" ("msmincho.ttc" 1 #t))
;;    '("data/mikachanALL_0.pdf" ("mikachanALL.ttc" 0 #t))
;;    '("data/mikachanALL_1.pdf" ("mikachanALL.ttc" 1 #t))
;;    '("data/mikachanALL_2.pdf" ("mikachanALL.ttc" 2 #t))
;;    '("data/mikachanALL_3.pdf" ("mikachanALL.ttc" 3 #t))
;;    '("data/mikachan_puchi_0.pdf" ("mikachan_puchi.ttc" 0 #t))
;;    '("data/mikachan_puchi_1.pdf" ("mikachan_puchi.ttc" 1 #t))
;;    '("data/Konatu.pdf" ("Konatu.ttf" #t))
;;    '("data/KonatuTohaba.pdf" ("KonatuTohaba.ttf" #t))
;;    '("data/aquafont.pdf" ("aquafont.ttf" #t))
;;    '("data/aqua_pfont.pdf" ("aqua_pfont.ttf" #t))
;;    '("data/SNsanafon.pdf" ("SNsanafon.ttf" #t))
;;    '("data/SNsanafonGyou.pdf" ("SNsanafonGyou.TTF" #t))
;;    '("data/SNsanafonKazari.pdf" ("SNsanafonKazari.ttf" #t))
;;   '("data/SNsanafonMugi.pdf" ("SNsanafonMugi.TTF" #t))
;;   '("data/SNsanafonObi.pdf" ("SNsanafonObi.ttf" #t))
;;   '("data/SNsanafonkaku.pdf" ("SNsanafonkaku.ttf" #t))
;;   '("data/SNsanafonkakuP.pdf" ("SNsanafonkakuP.ttf" #t))
;;   '("data/SNsanafonmaru.pdf" ("SNsanafonmaru.ttf" #t))
;;   '("data/SNsanafonmaruP.pdf" ("SNsanafonmaruP.ttf" #t))
;;   '("data/SNsanafonYu.pdf" ("SNsanafonyu.ttf" #t))
;;   '("data/cinecaption226.pdf" ("cinecaption226.ttf" #t))
;;   '("data/dameji.pdf" ("dameji.ttf" #t))
;;   '("data/habadasa.pdf" ("habadasa.ttf" #t))
;;   '("data/Dosei.pdf" ("Dosei.ttf" #t))
;;   '("data/umi.pdf" ("umi.ttf" #t))
;;   '("data/sea.pdf" ("sea.ttf" #t))
;;   '("data/seap.pdf" ("seap.ttf" #t))
;;   '("data/uni.pdf" ("uni.ttf" #t))
;;   '("data/unip.pdf" ("unip.ttf" #t))
;;   '("data/tsuki.pdf" ("tsuki.ttf" #t))
;;   '("data/tsukip.pdf" ("tsukip.ttf" #t))
;;   '("data/naguri.pdf" ("naguri.ttf" #t))
;;   '("data/nagurip.pdf" ("nagurip.ttf" #t))
;;   '("data/memo.pdf" ("memo.ttf" #t))
;;   '("data/love.pdf" ("love.ttf" #t))
;;   '("data/elmer.pdf" ("elmer.ttf" #t))
;;   '("data/elmerp.pdf" ("elmerp.ttf" #t))
;;   '("data/TABimyou.pdf" ("tabimyou_add.TTF" #t))
;;   '("data/TABimyouP.pdf" ("tabimyou_add_p.TTF" #t))
;;   '("data/SHG30_0.pdf" ("SH G30.ttc" 0 #t))
;;   '("data/SHG30_1.pdf" ("SH G30.ttc" 1 #t))
;;   '("data/Osaka_0.pdf" ("Osaka.ttc" 0 #f))
;;   '("data/Osaka_1.pdf" ("Osaka.ttc" 1 #f))
;;   '("data/Osaka_2.pdf" ("Osaka.ttc" 2 #f))
;;   '("data/tsuitiku.pdf" ("tsuitiku.ttf" #t))
;;   '("data/tsuitiku-modern.pdf" ("tsuitiku-modern.ttf" #t))
;;   '("data/p-tsuitiku.pdf" ("p-tsuitiku.ttf" #t))
;;   '("data/ipag-mona.pdf" ("ipag-mona.ttf" #t))
;;   '("data/zeueimincho.pdf" ("ZEUEMS__.TTF" #t))
;;   '("data/zetueiminchohir.pdf" ("ZETUMH__.TTF" #t))
;;   '("data/zetueihrkt.pdf" ("HRKT-KAI.TTF" #t))
;;    '("data/VL-Gothic.pdf" ("VL-Gothic-Regular.ttf" #f))
;;    '("data/VL-PGothic.pdf" ("VL-PGothic-Regular.ttf" #f))
;;   '("data/hogehoge-gothic.pdf" ("hogehoge-gothic.ttf" #t))
;;   '("data/dejima-mincho-r21.pdf" ("dejima-mincho-r21.ttf" #f))
;;   '("data/sazanami-gothic.pdf" ("sazanami-gothic.ttf" #f))
;;   '("data/sazanami-mincho.pdf" ("sazanami-mincho.ttf" #f))
  

(define (test-jpfonts-embed-loop arg index)
  (let* ((len (length arg))
         )
    (if (< index len)
        (begin0
         (test-jpfonts-embed arg index)
         (test-jpfonts-embed-loop arg (+ index 1)))
        #f)))
        

(define (test-jpfonts-embed arg index)
  (let* ((pdf (hpdf-new))
         ;;(s (hpdf-set-compression-mode pdf HPDF_COMP_ALL))
         (s (hpdf-use-jp-encodings pdf))
         (f (list-ref arg index))
         (outfile (list-ref f 0))
         (fontfile (list-ref (list-ref f 1) 0))
         (ttcindex (list-ref (list-ref f 1) 1))
         (embed (if (= (length (list-ref f 1)) 3)
                    (list-ref (list-ref f 1) 2)
                    (list-ref (list-ref f 1) 1)))
         (font (if (= (length (list-ref f 1)) 3)
                   ;; ttc
                   (hpdf-get-font pdf (hpdf-load-ttf-font-from-file2 pdf fontfile ttcindex embed) "90ms-RKSJ-H")
                   ;;; ttf
                   (hpdf-get-font pdf (hpdf-load-ttf-font-from-file pdf fontfile #t) "90ms-RKSJ-H")
                   ))
         (page_1 (hpdf-add-page pdf))
         (st (hpdf-page-set-font-and-size page_1 font 14))
         (st (hpdf-page-begin-text page_1))
         (w (hpdf-page-get-width page_1))
         (h (hpdf-page-get-height page_1))
         (st (hpdf-page-move-text-pos page_1 28 (- h 28)))
         (null (hpdf-page-set-text-leading page_1 14))
         (null (show-test-text page_1 "data/sjis.txt"))
         (dummy (hpdf-page-end-text page_1))
         )
    (hpdf-save-to-file pdf outfile)))

(test-subsection "embeded font test")
;;(test-jpfonts-embed-loop font-list 0)

(test-subsection "text measure test")
(test-subsubsection "hpdf-font-measure-text")

(define (test-hpdf-measure-text outfile params)
  (let* ((pdf (hpdf-new))
         (s (hpdf-use-jp-encodings pdf))
         (fontfile (list-ref params 0))
         (ttcindex (if (= (length params) 3)
                       (list-ref params 1)
                       #f))
         (point (if (= (length params) 3)
                    (list-ref params 2)
                    (list-ref params 1)))
         ;; ttc
         (font (if ttcindex
                   (hpdf-get-font pdf (hpdf-load-ttf-font-from-file2 pdf fontfile ttcindex embed) "90ms-RKSJ-H")
                   ;;; ttf
                   (hpdf-get-font pdf (hpdf-load-ttf-font-from-file pdf fontfile #t) "90ms-RKSJ-H")
                   ))
         (page_1 (hpdf-add-page pdf))
         (st (hpdf-page-begin-text page_1))
         (st (hpdf-page-set-font-and-size page_1 font point))
         (width (hpdf-page-get-width page_1))
         (height (hpdf-page-get-height page_1))
         (st (hpdf-page-move-text-pos page_1 0 (- height point)))
         (null (hpdf-page-set-text-leading page_1 point))
         (text (read-line (open-input-file "data/sjis.txt") #t))
         (null (hpdf-page-show-text page_1 (read-line (open-input-file "data/sjis.txt") #t)))
         (len 1)
         (real (hpdf-font-measure-text font text len width point 0 0 HPDF_FALSE))
         (dummy (hpdf-page-end-text page_1))
         (null (hpdf-save-to-file pdf outfile))
         )
    real))

(mktest "" 36.0 (floor (test-hpdf-measure-text "data/hpdf-font-measure-text-konatu.pdf" '("Konatu.ttf" 96))))

(define (test-hpdf-font-text-width outfile params)
  (let* ((pdf (hpdf-new))
         (s (hpdf-use-jp-encodings pdf))
         (fontfile (list-ref params 0))
         (ttcindex (if (= (length params) 3)
                       (list-ref params 1)
                       #f))
         (point (if (= (length params) 3)
                    (list-ref params 2)
                    (list-ref params 1)))
         ;; ttc
         (font (if ttcindex
                   (hpdf-get-font pdf (hpdf-load-ttf-font-from-file2 pdf fontfile ttcindex embed) "90ms-RKSJ-H")
                   ;;; ttf
                   (hpdf-get-font pdf (hpdf-load-ttf-font-from-file pdf fontfile #t) "90ms-RKSJ-H")
                   ))
         (page_1 (hpdf-add-page pdf))
         (st (hpdf-page-begin-text page_1))
         (st (hpdf-page-set-font-and-size page_1 font point))
         (width (hpdf-page-get-width page_1))
         (height (hpdf-page-get-height page_1))
         (st (hpdf-page-move-text-pos page_1 0 (- height point)))
         (null (hpdf-page-set-text-leading page_1 point))
         (text (read-line (open-input-file "data/sjis.txt") #t))
         (null (hpdf-page-show-text page_1 (read-line (open-input-file "data/sjis.txt") #t)))
         (len 36)
         (text-width (hpdf-font-text-width font text len))
         (tlist (hpdf-font-text-width-as-list text-width))
         (null (display width))
         (null (display tlist))
         (dummy (hpdf-page-end-text page_1))
         (null (hpdf-save-to-file pdf outfile))
         (null (display width))
         (null (display (* point (/ (list-ref tlist 1) 1000))))
         )
    (list-ref tlist 1)))

(mktest "" 36.0 (floor (test-hpdf-font-text-width "data/hpdf-font-text-width-konatu.pdf" '("Konatu.ttf" 36))))
;; epilogue
(test-end)

