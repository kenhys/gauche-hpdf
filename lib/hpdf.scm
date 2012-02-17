;;;
;;; hpdf
;;;

(define-module hpdf
  (extend
   hpdf.annotation
   hpdf.gstate
   hpdf.page
   hpdf.font
   hpdf.text)
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

(define-method add-page ((self <hpdf-doc>))
  (hpdf-add-page self))

;; Epilogue
(provide "hpdf")


