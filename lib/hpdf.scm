;;;
;;; hpdf
;;;

(define-module hpdf
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


;; Epilogue
(provide "hpdf")


