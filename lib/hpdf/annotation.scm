;;;
;;; hpdf
;;;

(define-module hpdf.annotation
  (extend hpdf)
  (export-all)
  )
(select-module hpdf.annotation)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;

(define-method create-3d-annot
  ((self <hpdf-page>)
   (rect <hpdf-rect>)
   u3d)
  (hpdf-page-create-3d-annot self rect u3d))

(define-method create-text-annot
  ((self <hpdf-page>)
   (rect <hpdf-rect>)
   text
   :optional (encoder <hpdf-encoder>?))
  (hpdf-page-create-text-annot self rect text encoder))

(define-method create-free-text-annot
  ((self <hpdf-page>)
   (rect <hpdf-rect>)
   text
   (encoder <hpdf-encoder>))
  (hpdf-page-create-free-text-annot self rect text encoder))

(define-method create-line-annot
  ((self <hpdf-page>)
   text
   (encoder <hpdf-encoder>))
  (hpdf-page-create-line-annot self text encoder))

(define-method create-link-annot
  ((self <hpdf-page>)
   (rect <hpdf-rect>)
   (dst <hpdf-destination>))
  (hpdf-page-create-link-annot self rect dst))

(define-method create-uri-link-annot
  ((self <hpdf-page>)
   (rect <hpdf-rect>) uri)
  (hpdf-page-create-uri-link-annot self rect uri))

(define-method create-text-markup-annot
  ((self <hpdf-page>)
   (rect <hpdf-rect>)
   text (encoder <hpdf-encoder>) subType)
  (hpdf-page-create-text-markup-annot self rect text encoder subType))

(define-method create-highlight-annot
  ((self <hpdf-page>)
   (rect <hpdf-rect>)
   text (encoder <hpdf-encoder>))
  (hpdf-page-create-highlight-annot self rect text encoder))

(define-method create-underline-annot
  ((self <hpdf-page>)
   (rect <hpdf-rect>)
   text (encoder <hpdf-encoder>))
  (hpdf-page-create-underline-annot self rect text encoder))



(define-method text-annot-icon!
  ((self <hpdf-annotation>) icon)
  (hpdf-text-annot-set-icon self icon))

(define-method text-annot-opened!
  ((self <hpdf-annotation>) opened)
  (hpdf-text-annot-set-opened self opened))

;; Epilogue
(provide "hpdf/annotation")


