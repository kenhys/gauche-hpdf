;;;
;;; -*- mode: scheme; coding: utf-8 -*-
;;; Test hpdf
;;;

(use gauche.test)
(use gauche.charconv)
(use binary.pack)
(use file.util)

(test-start "hpdf")
(use hpdf)
(test-module 'hpdf)

(test-section "hpdf font")

(define (test-subsection msg)
  (format #t "~a()\n" msg))
(define (test-subsubsection msg)
  (format #t "#=> ~a\n" msg))

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
(test-subsection "hpdf-load-ttf-font-from-file2")
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

(test-section "IPA fonts")
(test-subsection "hpdf-load-ttf-font-from-file")
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

(test-section "M+IPA fonts")
(test-subsection "hpdf-load-ttf-font-from-file")
(test* "M+IP+IPAG.ttf embed" "M+1P+IPAG-Regular,regular" (test-hpdf-load-ttf-font-from-file "font/M+1P+IPAG.ttf" #t))
(test* "M+1P+IPAG-circle.ttf embed" "M+1P+IPAG-circle-Regular,regular" (test-hpdf-load-ttf-font-from-file "font/M+1P+IPAG-circle.ttf" #t))
(test* "M+1VM+IPAG-circle.ttf embed" "M+1VM+IPAG-circle-Regular,regular" (test-hpdf-load-ttf-font-from-file "font/M+1VM+IPAG-circle.ttf" #t))
(test* "M+2P+IPAG.ttf non-embed" "M+2P+IPAG-Regular,regular" (test-hpdf-load-ttf-font-from-file "font/M+2P+IPAG.ttf" #t))
(test* "M+2P+IPAG-circle.ttf non-embed" "M+2P+IPAG-circle-Regular,regular" (test-hpdf-load-ttf-font-from-file "font/M+2P+IPAG-circle.ttf" #t))
(test* "M+2VM+IPAG-circle.ttf non-embed" "M+2VM+IPAG-circle-Regular,regular" (test-hpdf-load-ttf-font-from-file "font/M+2VM+IPAG-circle.ttf" #t))


(test-section "M+ fonts")
(test-subsection "hpdf-load-ttf-font-from-file")
(test* "mplus-1c-black.ttf embed" "mplus-1c-black,black" (test-hpdf-load-ttf-font-from-file "font/mplus-1c-black.ttf" #t))
(test* "mplus-1c-bold.ttf embed" "mplus-1c-bold,bold" (test-hpdf-load-ttf-font-from-file "font/mplus-1c-bold.ttf" #t))
(test* "mplus-1c-heavy.ttf embed" "mplus-1c-heavy,heavy" (test-hpdf-load-ttf-font-from-file "font/mplus-1c-heavy.ttf" #t))
(test* "mplus-1c-light.ttf embed" "mplus-1c-light,light" (test-hpdf-load-ttf-font-from-file "font/mplus-1c-light.ttf" #t))
(test* "mplus-1c-medium.ttf embed" "mplus-1c-medium,medium" (test-hpdf-load-ttf-font-from-file "font/mplus-1c-medium.ttf" #t))
(test* "mplus-1c-regular.ttf embed" "mplus-1c-regular,regular" (test-hpdf-load-ttf-font-from-file "font/mplus-1c-regular.ttf" #t))
(test* "mplus-1c-thin.ttf embed" "mplus-1c-thin,thin" (test-hpdf-load-ttf-font-from-file "font/mplus-1c-thin.ttf" #t))
(test* "mplus-1m-bold.ttf embed" "mplus-1m-bold,bold" (test-hpdf-load-ttf-font-from-file "font/mplus-1m-bold.ttf" #t))
(test* "mplus-1m-light.ttf embed" "mplus-1m-light,light" (test-hpdf-load-ttf-font-from-file "font/mplus-1m-light.ttf" #t))
(test* "mplus-1m-medium.ttf embed" "mplus-1m-medium,medium" (test-hpdf-load-ttf-font-from-file "font/mplus-1m-medium.ttf" #t))
(test* "mplus-1m-regular.ttf embed" "mplus-1m-regular,regular" (test-hpdf-load-ttf-font-from-file "font/mplus-1m-regular.ttf" #t))
(test* "mplus-1m-thin.ttf embed" "mplus-1m-thin,thin" (test-hpdf-load-ttf-font-from-file "font/mplus-1m-thin.ttf" #t))
(test* "mplus-1mn-bold.ttf embed" "mplus-1mn-bold,bold" (test-hpdf-load-ttf-font-from-file "font/mplus-1mn-bold.ttf" #t))
(test* "mplus-1mn-light.ttf embed" "mplus-1mn-light,light" (test-hpdf-load-ttf-font-from-file "font/mplus-1mn-light.ttf" #t))
(test* "mplus-1mn-medium.ttf embed" "mplus-1mn-medium,medium" (test-hpdf-load-ttf-font-from-file "font/mplus-1mn-medium.ttf" #t))
(test* "mplus-1mn-regular.ttf embed" "mplus-1mn-regular,regular" (test-hpdf-load-ttf-font-from-file "font/mplus-1mn-regular.ttf" #t))
(test* "mplus-1mn-thin.ttf embed" "mplus-1mn-thin,thin" (test-hpdf-load-ttf-font-from-file "font/mplus-1mn-thin.ttf" #t))
(test* "mplus-1p-bold.ttf embed" "mplus-1p-bold,bold" (test-hpdf-load-ttf-font-from-file "font/mplus-1p-bold.ttf" #t))
(test* "mplus-1p-light.ttf embed" "mplus-1p-light,light" (test-hpdf-load-ttf-font-from-file "font/mplus-1p-light.ttf" #t))
(test* "mplus-1p-medium.ttf embed" "mplus-1p-medium,medium" (test-hpdf-load-ttf-font-from-file "font/mplus-1p-medium.ttf" #t))
(test* "mplus-1p-regular.ttf embed" "mplus-1p-regular,regular" (test-hpdf-load-ttf-font-from-file "font/mplus-1p-regular.ttf" #t))
(test* "mplus-1p-thin.ttf embed" "mplus-1p-thin,thin" (test-hpdf-load-ttf-font-from-file "font/mplus-1p-thin.ttf" #t))
(test* "mplus-2c-bold.ttf embed" "mplus-2c-bold,bold" (test-hpdf-load-ttf-font-from-file "font/mplus-2c-bold.ttf" #t))
(test* "mplus-2c-light.ttf embed" "mplus-2c-light,light" (test-hpdf-load-ttf-font-from-file "font/mplus-2c-light.ttf" #t))
(test* "mplus-2c-medium.ttf embed" "mplus-2c-medium,medium" (test-hpdf-load-ttf-font-from-file "font/mplus-2c-medium.ttf" #t))
(test* "mplus-2c-regular.ttf embed" "mplus-2c-regular,regular" (test-hpdf-load-ttf-font-from-file "font/mplus-2c-regular.ttf" #t))
(test* "mplus-2c-thin.ttf embed" "mplus-2c-thin,thin" (test-hpdf-load-ttf-font-from-file "font/mplus-2c-thin.ttf" #t))
(test* "mplus-2m-bold.ttf embed" "mplus-2m-bold,bold" (test-hpdf-load-ttf-font-from-file "font/mplus-2m-bold.ttf" #t))
(test* "mplus-2m-light.ttf embed" "mplus-2m-light,light" (test-hpdf-load-ttf-font-from-file "font/mplus-2m-light.ttf" #t))
(test* "mplus-2m-medium.ttf embed" "mplus-2m-medium,medium" (test-hpdf-load-ttf-font-from-file "font/mplus-2m-medium.ttf" #t))
(test* "mplus-2m-regular.ttf embed" "mplus-2m-regular,regular" (test-hpdf-load-ttf-font-from-file "font/mplus-2m-regular.ttf" #t))
(test* "mplus-2m-thin.ttf embed" "mplus-2m-thin,thin" (test-hpdf-load-ttf-font-from-file "font/mplus-2m-thin.ttf" #t))
(test* "mplus-2p-bold.ttf embed" "mplus-2p-bold,bold" (test-hpdf-load-ttf-font-from-file "font/mplus-2p-bold.ttf" #t))
(test* "mplus-2p-light.ttf embed" "mplus-2p-light,light" (test-hpdf-load-ttf-font-from-file "font/mplus-2p-light.ttf" #t))
(test* "mplus-2p-medium.ttf embed" "mplus-2p-medium,medium" (test-hpdf-load-ttf-font-from-file "font/mplus-2p-medium.ttf" #t))
(test* "mplus-2p-regular.ttf embed" "mplus-2p-regular,regular" (test-hpdf-load-ttf-font-from-file "font/mplus-2p-regular.ttf" #t))
(test* "mplus-2p-thin.ttf embed" "mplus-2p-thin,thin" (test-hpdf-load-ttf-font-from-file "font/mplus-2p-thin.ttf" #t))


(test-section "mikachan fonts")
(test-subsection "hpdf-load-ttf-font-from-file2")
(test* "mikachanALL.ttc index 0 embed" "mikachan" (test-hpdf-load-ttf-font-from-file2 "font/mikachanALL.ttc" 0 #t))
(test* "mikachanALL.ttc index 1 embed" "mikachan-P" (test-hpdf-load-ttf-font-from-file2 "font/mikachanALL.ttc" 1 #t))
(test* "mikachanALL.ttc index 2 embed" "mikachan-PB" (test-hpdf-load-ttf-font-from-file2 "font/mikachanALL.ttc" 2 #t))
(test* "mikachanALL.ttc index 3 embed" "mikachan-PS" (test-hpdf-load-ttf-font-from-file2 "font/mikachanALL.ttc" 3 #t))

(test* "mikachan_puchi.ttc index 0 embed" "mikachan-puchi" (test-hpdf-load-ttf-font-from-file2 "font/mikachan_puchi.ttc" 0 #t))
(test* "mikachan_puchi.ttc index 1 embed" "mikachan-puchiB" (test-hpdf-load-ttf-font-from-file2 "font/mikachan_puchi.ttc" 1 #t))

(test-section "konatu fonts")
(test-subsection "hpdf-load-ttf-font-from-file")
(test* "Konatu.ttf embed" "Konatu" (test-hpdf-load-ttf-font-from-file "font/Konatu.ttf" #t))
(test* "KonatuTohaba.ttf embed" "KonatuTohaba" (test-hpdf-load-ttf-font-from-file "font/KonatuTohaba.ttf" #t))


(test-section "type-lab fonts")
(test-subsection "hpdf-load-ttf-font-from-file")
(test* "Anito L proportional embed" "Anito-L-kyohkan" (test-hpdf-load-ttf-font-from-file "font/AnitoLP.TTF" #t))
(test* "Arare monospace embed" "Aralet-Mono-Kyohkan,Mono-Kyohkan" (test-hpdf-load-ttf-font-from-file "font/ArareM.TTF" #t))
(test* "Capanito L proportional embed" "Capanito-L-kyohkan" (test-hpdf-load-ttf-font-from-file "font/CapaLP.ttf" #t))
;; (test* "September L proportional embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/SeptemberLP.TTF" #t))
;; (test* "September L monospace embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/SeptemberL.TTF" #t))
;; (test* "September M proportional embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/SeptemberMP.TTF" #t))
;; (test* "September M monospace embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/SeptemberM.TTF" #t))
;; (test* "Anito Inline embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/AnitoInline.TTF" #t))
;; (test* "Anito Relief embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/AnitoRelief.TTF" #t))
;; (test* "Anito L monospace embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/AnitoL.TTF" #t))
;; (test* "Anito M proportional embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/AnitoMP.TTF" #t))
;; (test* "Anito M monospace embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/AnitoM.TTF" #t))
;; (test* "Arare proportional embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/ArareP.TTF" #t))
;; (test* "Capanito L monospace embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/CapaL.ttf" #t))
;; (test* "Capanito M monospace embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/CapaM.ttf" #t))
;; (test* "Capanito M proportional embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/CapaMP.ttf" #t))
;; (test* "Capanito M monospace(Propriety) embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/CapaMMO.TTF" #t))
;; (test* "Capanito M proportional(Propriety) embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/CapanitoM.TTF" #t))
(test* "Elegant w3 embed" "ElgseionW3.TTF" (test-hpdf-load-ttf-font-from-file "font/ElgseionW3.TTF" #t))
(test* "Elegant w5 embed" "ElgseionW5.TTF" (test-hpdf-load-ttf-font-from-file "font/ElgseionW5.TTF" #t))
(test* "Elegant w7 embed" "ElgseionW7.TTF" (test-hpdf-load-ttf-font-from-file "font/ElgseionW7.TTF" #t))
(test* "Elegant w9 embed" "ElgseionW9.TTF" (test-hpdf-load-ttf-font-from-file "font/ElgseionW9.TTF" #t))

(test-section "Aqua fonts")
(test* "hpdf-load-ttf-font-from-file aquafont embed" "aquafont" (test-hpdf-load-ttf-font-from-file "font/aquafont.ttf" #t))
(test* "hpdf-load-ttf-font-from-file aqua_pfont embed" "aqua_pfont" (test-hpdf-load-ttf-font-from-file "font/aqua_pfont.ttf" #t))

(test-section "Sana fonts")
(test* "SNsanafon embed" "SanaFon" (test-hpdf-load-ttf-font-from-file "font/SNsanafon.ttf" #t))
(test* "SNsanafonGyou embed" "SanafonGyou" (test-hpdf-load-ttf-font-from-file "font/SNsanafonGyou.TTF" #t))
(test* "SNsanafonKazari embed" "SanafonKazari" (test-hpdf-load-ttf-font-from-file "font/SNsanafonKazari.ttf" #t))
(test* "SNsanafonMugi embed" "SanafonMugi" (test-hpdf-load-ttf-font-from-file "font/SNsanafonMugi.TTF" #t))
(test* "SNsanafonObi embed" "SNsanafonObi" (test-hpdf-load-ttf-font-from-file "font/SNsanafonObi.ttf" #t))
(test* "SNsanafonkaku embed" "SanaFonKaku" (test-hpdf-load-ttf-font-from-file "font/SNsanafonkaku.ttf" #t))
(test* "SNsanafonkakuP embed" "SanafonkakuP" (test-hpdf-load-ttf-font-from-file "font/SNsanafonkakuP.ttf" #t))
(test* "SNsanafonmaru embed" "SanaFonMaru" (test-hpdf-load-ttf-font-from-file "font/SNsanafonmaru.ttf" #t))
(test* "SNsanafonmaruP embed" "SanafonMaruP" (test-hpdf-load-ttf-font-from-file "font/SNsanafonmaruP.ttf" #t))
(test* "SNsanafonYu embed" "SanafonYu" (test-hpdf-load-ttf-font-from-file "font/SNsanafonyu.ttf" #t))

(test-section "XANO fonts")
;; (test* "Kandata embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/Kandata.ttf" #t))
;; (test* "Oradano embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/Oradano.ttf" #t))
;; (test* "QANO mincho embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/QANO-mincho.ttf" #t))
;; (test* "QuiMi mincho embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/QuiMi-mincho.ttf" #t))
;; (test* "XANO-mincho embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/XANO-mincho.ttf" #t))
(test* "XANO-mincho-U32 embed" "XANO-mincho-U32" (test-hpdf-load-ttf-font-from-file "font/XANO-mincho-U32.ttf" #t))

(test-section "S2G fonts")
(test* "umi.ttf embed" "seafont" (test-hpdf-load-ttf-font-from-file "font/umi.ttf" #t))
(test* "sea.ttf embed" "Sea-font" (test-hpdf-load-ttf-font-from-file "font/sea.ttf" #t))
(test* "seap.ttf embed" "Sea-font-pro" (test-hpdf-load-ttf-font-from-file "font/seap.ttf" #t))
(test* "uni.ttf embed" "uni-font" (test-hpdf-load-ttf-font-from-file "font/uni.ttf" #t))
(test* "unip.ttf embed" "uni-font-PRO" (test-hpdf-load-ttf-font-from-file "font/unip.ttf" #t))
(test* "tsuki.ttf embed" "moon-font" (test-hpdf-load-ttf-font-from-file "font/tsuki.ttf" #t))
(test* "tsukip.ttf embed" "moon-font-PRO" (test-hpdf-load-ttf-font-from-file "font/tsukip.ttf" #t))
(test* "naguri.ttf embed" "nagurigaki" (test-hpdf-load-ttf-font-from-file "font/naguri.ttf" #t))
(test* "nagurip.ttf embed" "nagurigaki-P" (test-hpdf-load-ttf-font-from-file "font/nagurip.ttf" #t))
(test* "memo.ttf embed" "S2Gmemo" (test-hpdf-load-ttf-font-from-file "font/memo.ttf" #t))
(test* "love.ttf embed" "S2G-love" (test-hpdf-load-ttf-font-from-file "font/love.ttf" #t))

(test-section "Other fonts")
;; (test* "akubin embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/AKUBIN.TTF" #t))
;; (test* "japonesque embed" "unsupported" (test-hpdf-load-ttf-font-from-file "font/Japonesque1.45.TTF" #t))
(test* "cinecaption embed" "cinecaption" (test-hpdf-load-ttf-font-from-file "font/cinecaption226.ttf" #t))
(test* "elmer monospace embed" "ElmerFont" (test-hpdf-load-ttf-font-from-file "font/elmer.ttf" #t))
(test* "elmer proportional embed" "ElmerPFont" (test-hpdf-load-ttf-font-from-file "font/elmerp.ttf" #t))
(test* "dameji proportional embed" "dameji" (test-hpdf-load-ttf-font-from-file "font/dameji.ttf" #t))
(test* "habadasa embed" "HabaDasa" (test-hpdf-load-ttf-font-from-file "font/habadasa.ttf" #t))
(test* "Dosei embed" "DOSEI SAN (Mr.Saturn)" (test-hpdf-load-ttf-font-from-file "font/Dosei.ttf" #t))
(test* "TA Bimyou embed" "TAbimyou_Add" (test-hpdf-load-ttf-font-from-file "font/tabimyou_add.TTF" #t))
(test* "TA Bimyou proportional embed" "TAbimyou_Add_p" (test-hpdf-load-ttf-font-from-file "font/tabimyou_add_p.TTF" #t))
(test* "dejima-mincho embed" "dejima-mincho,mincho" (test-hpdf-load-ttf-font-from-file "font/dejima-mincho-r21.ttf" #t))

(test* "Osaka embed" "Osaka" (test-hpdf-load-ttf-font-from-file2 "font/Osaka.ttc" 0 #t))
(test* "Osaka embed" "Osaka-Mono" (test-hpdf-load-ttf-font-from-file2 "font/Osaka.ttc" 1 #t))
(test* "Osaka embed" "Osaka-UI" (test-hpdf-load-ttf-font-from-file2 "font/Osaka.ttc" 2 #t))
(test* "SH G30 embed" "GK-M" (test-hpdf-load-ttf-font-from-file2 "font/SH G30.ttc" 0 #t))
(test* "SH G30 embed" "GK-P" (test-hpdf-load-ttf-font-from-file2 "font/SH G30.ttc" 1 #t))

(test-section "Zetuei fonts")
(test* "Zetsuei mincho embed" "ZeueiMinchoSample" (test-hpdf-load-ttf-font-from-file "font/ZEUEMS__.TTF" #t))
(test* "Zetsuei mincho HIR embed" "ZetueiMinchoHIR,HIR" (test-hpdf-load-ttf-font-from-file "font/ZETUMH__.TTF" #t))
(test* "Zestuei HRKT rev embed" "HRKTKAI" (test-hpdf-load-ttf-font-from-file "font/HRKT-KAI.TTF" #t))

(test-section "hpdf text")

;;
(define (port->string-list2 iport lst)
  (let* ((s (read-line iport #t))
         )
    (if (eof-object? s)
        lst
        (append (list s) (port->string-list2 iport lst))
        )))

(define (show-test-text page file)
  (let* ((buf (port->string-list2 (open-input-file file) '()))
         (s (list-ref buf 0))
         )
    (begin0
     (hpdf-page-show-text page s)
     (hpdf-page-show-text-next-line page (list-ref buf 1))
     (hpdf-page-show-text-next-line page (list-ref buf 2))
     (hpdf-page-show-text-next-line page (list-ref buf 3))
     (hpdf-page-show-text-next-line page (list-ref buf 4))
     (hpdf-page-show-text-next-line page (list-ref buf 5))
     (hpdf-page-show-text-next-line page (list-ref buf 6))
     (hpdf-page-show-text-next-line page (list-ref buf 7))
     (hpdf-page-show-text-next-line page (list-ref buf 8))
     (hpdf-page-show-text-next-line page (list-ref buf 9))
     (hpdf-page-show-text-next-line page (list-ref buf 10))
     (hpdf-page-show-text-next-line page (list-ref buf 11))
     (hpdf-page-show-text-next-line page (list-ref buf 12))
     (hpdf-page-show-text-next-line page (list-ref buf 13))
     ;;(show-test-text2 page (list-tail buf 1))
    )))

(define (show-test-text2 page buf)
  (let* ((s (list-ref buf 0))
         )
    (if (> (length buf) 1)
        (begin0
         (hpdf-page-show-text-next-line page s)
         ;;(show-test-text2 page (list-tail buf 1))
         )
        (show-test-text2 page s)
        )
    ))
        
(define font-list
  (list
   '("data/msgothic_0.pdf"
     ("font/msgothic.ttc" 0 #t))
   '("data/msgothic_1.pdf"
     ("font/msgothic.ttc" 1 #t))
   '("data/msgothic_2.pdf"
     ("font/msgothic.ttc" 2 #t))
   '("data/msmincho_0.pdf"
     ("font/msmincho.ttc" 0 #t))
   '("data/msmincho_1.pdf"
     ("font/msmincho.ttc" 1 #t))
   '("data/mikachanALL_0.pdf"
     ("font/mikachanALL.ttc" 0 #t))
   '("data/mikachanALL_1.pdf"
     ("font/mikachanALL.ttc" 1 #t))
   '("data/mikachanALL_2.pdf"
     ("font/mikachanALL.ttc" 2 #t))
   '("data/mikachanALL_3.pdf"
     ("font/mikachanALL.ttc" 3 #t))
   '("data/mikachan_puchi_0.pdf"
     ("font/mikachan_puchi.ttc" 0 #t))
   '("data/mikachan_puchi_1.pdf"
     ("font/mikachan_puchi.ttc" 1 #t))
   '("data/Konatu.pdf"
     ("font/Konatu.ttf" #t))
   '("data/KonatuTohaba.pdf"
     ("font/KonatuTohaba.ttf" #t))
   '("data/aquafont.pdf"
     ("font/aquafont.ttf" #t))
   '("data/aqua_pfont.pdf"
     ("font/aqua_pfont.ttf" #t))
   '("data/SNsanafon.pdf"
     ("font/SNsanafon.ttf" #t))
   '("data/SNsanafonGyou.pdf"
     ("font/SNsanafonGyou.TTF" #t))
   '("data/SNsanafonKazari.pdf"
     ("font/SNsanafonKazari.ttf" #t))
  '("data/SNsanafonMugi.pdf"
    ("font/SNsanafonMugi.TTF" #t))
  '("data/SNsanafonObi.pdf"
    ("font/SNsanafonObi.ttf" #t))
  '("data/SNsanafonkaku.pdf"
    ("font/SNsanafonkaku.ttf" #t))
  '("data/SNsanafonkakuP.pdf"
    ("font/SNsanafonkakuP.ttf" #t))
  '("data/SNsanafonmaru.pdf"
    ("font/SNsanafonmaru.ttf" #t))
  '("data/SNsanafonmaruP.pdf"
    ("font/SNsanafonmaruP.ttf" #t))
  '("data/SNsanafonYu.pdf"
    ("font/SNsanafonyu.ttf" #t))
  '("data/cinecaption226.pdf"
    ("font/cinecaption226.ttf" #t))
  '("data/dameji.pdf"
    ("font/dameji.ttf" #t))
  '("data/habadasa.pdf"
    ("font/habadasa.ttf" #t))
  '("data/Dosei.pdf"
    ("font/Dosei.ttf" #t))
  '("data/umi.pdf"
    ("font/umi.ttf" #t))
  '("data/sea.pdf"
    ("font/sea.ttf" #t))
  '("data/seap.pdf"
    ("font/seap.ttf" #t))
  '("data/uni.pdf"
    ("font/uni.ttf" #t))
  '("data/unip.pdf"
    ("font/unip.ttf" #t))
  '("data/tsuki.pdf"
    ("font/tsuki.ttf" #t))
  '("data/tsukip.pdf"
    ("font/tsukip.ttf" #t))
  '("data/naguri.pdf"
    ("font/naguri.ttf" #t))
  '("data/nagurip.pdf"
    ("font/nagurip.ttf" #t))
  '("data/memo.pdf"
    ("font/memo.ttf" #t))
  '("data/love.pdf"
    ("font/love.ttf" #t))
  '("data/elmer.pdf"
    ("font/elmer.ttf" #t))
  '("data/elmerp.pdf"
    ("font/elmerp.ttf" #t))
  '("data/TABimyou.pdf"
    ("font/tabimyou_add.TTF" #t))
  '("data/TABimyouP.pdf"
    ("font/tabimyou_add_p.TTF" #t))
  '("data/SHG30_0.pdf"
    ("font/SH G30.ttc" 0 #t))
  '("data/SHG30_1.pdf"
    ("font/SH G30.ttc" 1 #t))
  ))

(define (test-jpfonts-embed-loop arg index)
  (let* ((len (length arg))
         (null (write index))
         (null (write len))
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
         (font (if (= (length (list-ref f 1)) 3)
                   ;; ttc
                   (hpdf-get-font pdf (hpdf-load-ttf-font-from-file2 pdf fontfile ttcindex #t) "90ms-RKSJ-H")
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
(test-jpfonts-embed-loop font-list 0)

;; epilogue
(test-end)

