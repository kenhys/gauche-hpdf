;;; hpdf
;;;

(define-module hpdf.outline
  (extend hpdf)
  (export-all)
  )
(select-module hpdf.outline)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;
(define-method create-outline ((self <hpdf-doc>)
			       parent
			       title
			       encoder)
  (hpdf-create-outline self parent title encoder))

(define-method create-outline ((self <hpdf-doc>)
			       title)
  (hpdf-create-outline self #f title #f))


(define-method outline-opened! ((self <hpdf-outline>)
				opened)
  (hpdf-outline-set-opened self opened))

(define-method outline-destination! ((self <hpdf-outline>)
				     (dst <hpdf-destination>))
  (hpdf-outline-set-destination self dst))

  

;; Epilogue
(provide "hpdf/outline")


