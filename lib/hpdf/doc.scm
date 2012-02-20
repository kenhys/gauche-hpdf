;;;
;;; hpdf
;;;

(define-module hpdf.doc
  (extend hpdf)
  (use gauche.interactive)
  (export-all)
  )
(select-module hpdf.doc)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;

(define-method get-version ()
  (hpdf-get-version))

;; TODO
;;(define-method new-ex ()
;;  ())

;; TODO
;;(define-method error-handler! ()
;;  ())

(define-method free ((self <hpdf-doc>))
  (hpdf-free self))

(define-method new-doc ((self <hpdf-doc>))
  (hpdf-new-doc self))

(define-method free-doc ((self <hpdf-doc>))
  (hpdf-free-doc self))

(define-method has-doc ((self <hpdf-doc>))
  (hpdf-has-doc self))

(define-method free-doc-all ((self <hpdf-doc>))
  (hpdf-free-doc-all self))

(define-method save-to-stream ((self <hpdf-doc>))
  (hpdf-save-to-stream self))

;; TODO
;; hpdf-get-contents

(define-method stream-size ((self <hpdf-doc>))
  (hpdf-get-stream-size self))

(define-method save-to-file ((self <hpdf-doc>) filename)
  (hpdf-save-to-file self filename))

;; Epilogue
(provide "hpdf/doc")


