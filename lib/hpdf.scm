;;;
;;; hpdf
;;;

(define-module hpdf
  (extend
   hpdf.annotation
   hpdf.compat
   hpdf.destination
   hpdf.doc
   hpdf.encoder
   hpdf.graphics
   hpdf.gstate
   hpdf.image
   hpdf.outline
   hpdf.page
   hpdf.font
   hpdf.text
   hpdf.u3d)
  (export-all)
  )
(select-module hpdf)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;

(define (test-subsection msg)
  ;;(format #t "~79,,,'.,,@a\n" (format #f "[~a]" msg)))
  (format #t "~79,,,' ,,@a\n" (format #f "[~a]" msg)))
(define (test-subsubsection msg)
  (format #t "#=> ~75,,,'.,,a \n" (format #f "~a " msg)))

(define-method attach-file ((self <hpdf-doc>) file)
  (hpdf-attach-file self file))

(define-method password! ((self <hpdf-doc>) owner user)
  (hpdf-set-password self owner user))

(define-method permission! ((self <hpdf-doc>) permission)
  (hpdf-set-permission self permission))

(define-method encryption-mode! ((self <hpdf-doc>) mode len)
  (hpdf-set-encryption-mode self mode len))

(define-method compression-mode! ((self <hpdf-doc>) mode)
  (hpdf-set-compression-mode self mode))

(define-method execute-xobject ((self <hpdf-page>) obj)
  (hpdf-page-execute-xobject self obj))


;; Epilogue
(provide "hpdf")


