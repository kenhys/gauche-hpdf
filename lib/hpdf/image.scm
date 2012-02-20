;;;
;;; hpdf
;;;

(define-module hpdf.image
  (extend hpdf)
  (use gauche.interactive)
  (export-all)
  )
(select-module hpdf.image)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;

(define-method size ((self <hpdf-image>))
  (hpdf-image-get-size self))

;;(define-method size2 ((self <hpdf-image>) size)
;;  (hpdf-image-get-size2 self))

(define-method width ((self <hpdf-image>))
  (hpdf-image-get-width self))

(define-method height ((self <hpdf-image>))
  (hpdf-image-get-height self))

(define-method bits-per-component ((self <hpdf-image>))
  (hpdf-image-get-bits-per-component self))

(define-method color-space ((self <hpdf-image>))
  (hpdf-image-get-color-space self))

(define-method color-mask! ((self <hpdf-image>) rmin rmax gmin gmax bmin bmax)
  (hpdf-image-set-color-mask self rmin rmax gmin gmax bmin bmax))

(define-method mask-image! ((self <hpdf-image>) (image <hpdf-image>))
  (hpdf-image-set-mask-image self image))

;; Epilogue
(provide "hpdf/image")


