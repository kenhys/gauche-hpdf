

(define-module hpdf.text
  (extend hpdf)
  (export-all))

(select-module hpdf.text)

(dynamic-load "gauche--hpdf")


;; (define-syntax with-text
;;   (syntax-rules ()
;;     ((_ x ...) (begin 
;; 		 (begin-text x) ... (end-text x)))))

(define-method begin-text ((self <hpdf-page>))
  (hpdf-page-begin-text self))

(define-method end-text ((self <hpdf-page>))
  (hpdf-page-end-text self))

;; Text state

(define-method char-space! ((self <hpdf-page>)
			    (value <real>))
  (hpdf-page-set-char-space self value))

(define-method word-space! ((self <hpdf-page>)
			    (value <real>))
  (hpdf-page-set-word-space self value))

(define-method horizontal-scalling! ((self <hpdf-page>)
				     (value <real>))
  (hpdf-page-set-horizontal-scalling self value))

(define-method text-leading! ((self <hpdf-page>) value)
  (hpdf-page-set-text-leading self value))

(define-method font-and-size! ((self <hpdf-page>)
			       (font <hpdf-font>)
			       (size <real>))
  (hpdf-page-set-font-and-size self font size))

(define-method text-rendering-mode! ((self <hpdf-page>) mode)
  (hpdf-page-set-text-rendering-mode self mode))

(define-method text-rise! ((self <hpdf-page>) 
			   (value <real>))
  (hpdf-page-set-text-rise self value))

(define-method text-raise! ((self <hpdf-page>) 
			    (value <real>))
  (hpdf-page-set-text-raise self value))

;; Text positioning
(define-method move-text-pos ((self <hpdf-page>)
			      (x <real>)
			      (y <real>))
  (hpdf-page-move-text-pos self x y))

(define-method text-matrix! ((self <hpdf-page>)
			     (a <real>)
			     (b <real>)
			     (c <real>)
			     (d <real>)
			     (x <real>)
			     (y <real>))
  (hpdf-page-set-text-matrix self a b c d x y))


;; Text showing
(define-method show-text ((self <hpdf-page>) text)
  (hpdf-page-show-text self text))

(define-method show-text-next-line ((self <hpdf-page>) text)
  (hpdf-page-show-text-next-line self text))

(define-method show-text-next-lineex ((self <hpdf-page>) word char text)
  (hpdf-page-show-text-next-line self word char text))

(provide "hpdf/text")