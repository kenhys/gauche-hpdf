;;;
;;; hpdf
;;;

(define-module hpdf.compat
  (extend hpdf)
  (export-all)
  )
(select-module hpdf.compat)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;

(define-method draw-image ((self <hpdf-page>)
			   (image <hpdf-image>)
			   x y width height)
  (hpdf-page-draw-image self image x y width height))

(define-method circle ((self <hpdf-page>) x y ray)
  (hpdf-page-circle self x y ray))

(define-method ellipse ((self <hpdf-page>) x y xray yray)
  (hpdf-page-ellipse self x y xray yray))

(define-method arc ((self <hpdf-page>) x y ray ang1 ang2)
  (hpdf-page-arc self x y ray ang1 ang2))

(define-method text-out ((self <hpdf-page>) xpos ypos text)
  (hpdf-page-text-out self xpos ypos text))

(define-method text-rect ((self <hpdf-page>)
			  left top right bottom
			  text align)
  (hpdf-page-text-rect self left top right bottom text align))

;; Epilogue
(provide "hpdf/compat")
