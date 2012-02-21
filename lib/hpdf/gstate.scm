;;;
;;; hpdf
;;;

(define-module hpdf.gstate
  (extend hpdf)
  (use gauche.interactive)
  (export-all)
  )
(select-module hpdf.gstate)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;

(define-method create-ext-gstate ((self <hpdf-doc>))
  (hpdf-create-ext-gstate self))

(define-method ext-gstate-alpha-stroke! ((self <hpdf-extgstate>)
					 value)
  (hpdf-ext-gstate-set-alpha-stroke self value))

(define-method ext-gstate-alpha-fill! ((self <hpdf-extgstate>)
				       value)
  (hpdf-ext-gstate-set-alpha-fill self value))

(define-method ext-gstate-blend-mode! ((self <hpdf-extgstate>)
				       mode)
  (hpdf-ext-gstate-set-blend-mode self mode))

(define-method text-width
  ((self <hpdf-page>)
   text)
  (hpdf-page-text-width self text))

(define-method measure-text ((self <hpdf-page>) text
			     width wordwrap . args)
  (let* ()
    (if (not (null? args))
      (hpdf-page-measure-text self text width wordwrap args)
      (hpdf-page-measure-text self text width wordwrap))))

(define-method width ((self <hpdf-page>))
  (hpdf-page-get-width self))

(define-method height ((self <hpdf-page>))
  (hpdf-page-get-height self))

(define-method gmode ((self <hpdf-page>))
  (hpdf-page-get-gmode self))

;;(define-method current-pos ((self <hpdf-page>) pos)
;;  (hpdf-page-get-current-font self))

(define-method current-text-pos ((self <hpdf-page>))
  (hpdf-page-get-current-text-pos self))


(define-method current-font ((self <hpdf-page>))
  (hpdf-page-get-current-font self))

(define-method current-font-size ((self <hpdf-page>))
  (hpdf-page-get-current-font-size self))



(define-method line-width ((self <hpdf-page>))
  (hpdf-page-get-line-width self))

(define-method line-cap ((self <hpdf-page>))
  (hpdf-page-get-line-cap self))

(define-method line-join ((self <hpdf-page>))
  (hpdf-page-get-line-join self))

(define-method dash ((self <hpdf-page>))
  (hpdf-page-get-dash self))

(define-method flat ((self <hpdf-page>))
  (hpdf-page-get-flat self))

(define-method char-space ((self <hpdf-page>))
  (hpdf-page-get-char-space self))

(define-method word-space ((self <hpdf-page>))
  (hpdf-page-get-word-space self))

(define-method horizontal-scaling ((self <hpdf-page>))
  (hpdf-page-get-horizontal-scaling self))

(define-method text-leading ((self <hpdf-page>))
  (hpdf-page-get-text-leading self))

(define-method text-rendering-mode ((self <hpdf-page>))
  (hpdf-page-get-text-rendering-mode self))

;; obsolete. use text-rise
(define-method text-raise ((self <hpdf-page>))
  (hpdf-page-get-text-raise self))

(define-method text-rise ((self <hpdf-page>))
  (hpdf-page-get-text-rise self))

(define-method rgb-fill ((self <hpdf-page>))
  (hpdf-page-get-rgb-fill self))

(define-method rgb-stroke ((self <hpdf-page>))
  (hpdf-page-get-rgb-stroke self))

(define-method cmyk-fill ((self <hpdf-page>))
  (hpdf-page-get-cmyk-fill self))

(define-method cmyk-stroke ((self <hpdf-page>))
  (hpdf-page-get-cmyk-stroke self))

(define-method gray-fill ((self <hpdf-page>))
  (hpdf-page-get-gray-fill self))

(define-method gray-stroke ((self <hpdf-page>))
  (hpdf-page-get-gray-stroke self))


;; Epilogue
(provide "hpdf/gstate")


