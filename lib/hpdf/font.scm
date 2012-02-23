;;;
;;; hpdf
;;;

(define-module hpdf.font
  (extend hpdf)
  (export-all)
  )
(select-module hpdf.font)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;

(define-method font-name ((self <hpdf-font>))
  (hpdf-font-get-font-name self))

(define-method encoding-name ((self <hpdf-font>))
  (hpdf-font-get-encoding-name self))

(define-method unicode-width ((self <hpdf-font>) code)
  (hpdf-font-get-unicode-width self code))

(define-method bbox ((self <hpdf-font>))
  (hpdf-font-get-bbox self))

(define-method ascent ((self <hpdf-font>))
  (hpdf-font-get-ascent self))

(define-method descent ((self <hpdf-font>))
  (hpdf-font-get-descent self))

(define-method xheight ((self <hpdf-font>))
  (hpdf-font-get-xheight self))

(define-method cap-height ((self <hpdf-font>))
  (hpdf-font-get-cap-height self))

;; font handling

(define-method font ((self <hpdf-doc>)
		     font_name :optional encoding_name)
  (if encoding_name
      (hpdf-get-font self font_name encoding_name)
      (hpdf-get-font self font_name #f)))

(define-method load-type1-font-from-file ((self <hpdf-doc>)
					  afm data)
  (hpdf-load-type1-font-from-file self afm data))

(define-method ttfont-def-from-file ((self <hpdf-doc>)
				     filename embed)
  (hpdf-ttfont-def-from-file self filename embed))

(define-method use-jp-fonts ((self <hpdf-doc>))
  (hpdf-use-jp-fonts self))

(define-method use-kr-fonts ((self <hpdf-doc>))
  (hpdf-use-kr-fonts self))

(define-method use-cns-fonts ((self <hpdf-doc>))
  (hpdf-use-cns-fonts self))

(define-method use-cnt-fonts ((self <hpdf-doc>))
  (hpdf-use-cnt-fonts self))


;; Epilogue
(provide "hpdf/font")


