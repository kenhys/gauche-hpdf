;;;
;;; hpdf
;;;

(define-module hpdf.page
  (extend hpdf)
  (use gauche.interactive)
  (export-all)
  )
(select-module hpdf.page)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;

(define-method page-layout ((self <hpdf-doc>))
  (hpdf-get-page-layout self))

(define-method page-layout! ((self <hpdf-doc>) layout)
  (hpdf-set-page-layout self layout))

(define-method page-mode ((self <hpdf-doc>))
  (hpdf-get-page-mode self))

(define-method page-mode! ((self <hpdf-doc>) mode)
  (hpdf-set-page-mode self layout))

(define-method viewer-preference ((self <hpdf-doc>))
  (hpdf-get-viewer-preference self))

(define-method viewer-preference! ((self <hpdf-doc>) pref)
  (hpdf-set-viewer-preference self pref))

(define-method open-action! ((self <hpdf-doc>)
			     (action <hpdf-destination>))
  (hpdf-set-open-action self action))

(define-method current-page ((self <hpdf-doc>))
  (hpdf-get-current-page self))

(define-method add-page ((self <hpdf-doc>))
  (hpdf-add-page self))

(define-method insert-page ((self <hpdf-doc>)
			    (page <hpdf-page>))
  (hpdf-insert-page self page))

(define-method width! ((self <hpdf-page>) width)
  (hpdf-page-set-width self width))

(define-method height! ((self <hpdf-page>) height)
  (hpdf-page-set-height self height))

(define-method size! ((self <hpdf-page>) size direction)
  (hpdf-page-set-size self size direction))

;; Epilogue
(provide "hpdf/page")


