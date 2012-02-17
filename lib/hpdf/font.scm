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

;; Epilogue
(provide "hpdf/font")


