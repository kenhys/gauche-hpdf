

(define-module hpdf.text
  (extend hpdf)
  (export-all))

(select-module hpdf.text)

(dynamic-load "gauche--hpdf")


(define-method begin-text ((self <hpdf-page>))
  (hpdf-page-begin-text self))

(define-method end-text ((self <hpdf-page>))
  (hpdf-page-end-text self))

(define-method font-and-size! ((self <hpdf-page>)
			       (font <hpdf-font>)
			       (size <real>))
  (hpdf-page-set-font-and-size self font size))

(define-method move-text-pos ((self <hpdf-page>)
			      (x <real>)
			      (y <real>))
  (hpdf-page-move-text-pos self x y))

(define-method show-text ((self <hpdf-page>)
			  text)
  (hpdf-page-show-text self text))

(provide "hpdf/text")