;;;
;;; hpdf
;;;

(define-module hpdf.destination
  (extend hpdf)
  (use gauche.interactive)
  (export-all)
  )
(select-module hpdf.destination)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;


(define-method create-destination ((self <hpdf-page>))
  (hpdf-page-create-destination self))

(define-method destination-xyz! ((self <hpdf-destination>)
				 left top zoom)
  (hpdf-destination-set-xyz self left top zoom))

(define-method destination-fit! ((self <hpdf-destination>))
  (hpdf-destination-set-fit self))

(define-method destination-fith! ((self <hpdf-destination>)
				  top)
  (hpdf-destination-set-fith self top))

(define-method destination-fitv! ((self <hpdf-destination>)
				  left)
  (hpdf-destination-set-fitv self left))

(define-method destination-fitr! ((self <hpdf-destination>)
				  left bottom right top)
  (hpdf-destination-set-fitr self left bottom right top))

(define-method destination-fitb! ((self <hpdf-destination>))
  (hpdf-destination-set-fitb self))

(define-method destination-fitbh! ((self <hpdf-destination>) top)
  (hpdf-destination-set-fitbh self top))

(define-method destination-fitbv! ((self <hpdf-destination>) left)
  (hpdf-destination-set-fitbv self left))

;; Epilogue
(provide "hpdf/destination")

