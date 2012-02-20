;;;
;;; hpdf
;;;

(define-module hpdf.graphics
  (extend hpdf)
  (export-all)
  )
(select-module hpdf.graphics)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;

(define-method line-width! ((self <hpdf-page>) line_width)
  (hpdf-page-set-line-width self line_width))

(define-method line-cap! ((self <hpdf-page>) line_cap)
  (hpdf-page-set-line-cap self line_cap))

(define-method line-join! ((self <hpdf-page>) line_join)
  (hpdf-page-set-line-join self line_join))

(define-method miter-limit! ((self <hpdf-page>) miter_limit)
  (hpdf-page-set-miter-limit self miter_limit))

;;(define-method dash! ((self <hpdf-page>) array num phase)
;;  (hpdf-page-set-dash self array num phase))

(define-method flat! ((self <hpdf-page>) flatness)
  (hpdf-page-set-flat self flatness))

(define-method ext-gstate! ((self <hpdf-page>) ext_gstate)
  (hpdf-page-set-ext-gstate self ext_gstate))

(define-method gsave ((self <hpdf-page>))
  (hpdf-page-gsave self))

(define-method grestore ((self <hpdf-page>))
  (hpdf-page-grestore self))

(define-method concat ((self <hpdf-page>) a b c d x y)
  (hpdf-page-concat self a b c d x y))

;; Path construction operator
(define-method moveto ((self <hpdf-page>) x y)
  (hpdf-page-moveto self x y))

(define-method lineto ((self <hpdf-page>) x y)
  (hpdf-page-lineto self x y))

(define-method curveto ((self <hpdf-page>) x1 y1 x2 y2 x3 y3)
  (hpdf-page-curveto self x1 y1 x2 y2 x3 y3))

(define-method curveto2 ((self <hpdf-page>) x2 y2 x3 y3)
  (hpdf-page-curveto self x2 y2 x3 y3))

(define-method curveto3 ((self <hpdf-page>) x1 y1 x3 y3)
  (hpdf-page-curveto self x1 y1 x3 y3))

(define-method close-path ((self <hpdf-page>))
  (hpdf-page-close-path self))

(define-method rectangle ((self <hpdf-page>)
			  x y width height)
  (hpdf-page-rectangle self x y width height))

;; path painting operator
(define-method stroke ((self <hpdf-page>))
  (hpdf-page-stroke self))

(define-method fill ((self <hpdf-page>))
  (hpdf-page-fill self))

(define-method fill-stroke ((self <hpdf-page>))
  (hpdf-page-fill-stroke self))

;; color showing
(define-method gray-fill! ((self <hpdf-page>) gray)
  (hpdf-page-set-gray-fill self gray))

(define-method gray-stroke! ((self <hpdf-page>) gray)
  (hpdf-page-set-gray-stroke self gray))

(define-method rgb-fill! ((self <hpdf-page>) r g b)
  (hpdf-page-set-rgb-fill self r g b))

(define-method rgb-stroke! ((self <hpdf-page>) r g b)
  (hpdf-page-set-rgb-stroke self r g b))

(define-method cmyk-fill! ((self <hpdf-page>) c m y k)
  (hpdf-page-set-cmyk-fill self c m y k))

(define-method cmyk-stroke! ((self <hpdf-page>) c m y k)
  (hpdf-page-set-cmyk-stroke self c m y k))

;; Epilogue
(provide "hpdf/graphics")


