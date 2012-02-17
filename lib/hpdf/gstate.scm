;;;
;;; hpdf
;;;

(define-module hpdf.gstate
  (extend hpdf)
  (export-all)
  )
(select-module hpdf.gstate)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;


(define-method text-width
  ((self <hpdf-page>)
   text)
  (hpdf-page-text-width self text))

(define-method width ((self <hpdf-page>))
  (hpdf-page-get-width self))

(define-method height ((self <hpdf-page>))
  (hpdf-page-get-height self))

;; Epilogue
(provide "hpdf/gstate")


