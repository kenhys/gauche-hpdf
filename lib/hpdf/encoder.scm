;;;
;;; hpdf
;;;

(define-module hpdf.encoder
  (extend hpdf)
  (export-all)
  )
(select-module hpdf.encoder)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here

(define-method encoder ((self <hpdf-doc>) enc)
  (hpdf-get-encoder self enc))

(define-method current-encoder ((self <hpdf-doc>))
  (hpdf-get-current-encoder self))

(define-method current-encoder! ((self <hpdf-doc>) enc)
  (hpdf-set-current-encoder self enc))

(define-method encoder-type ((self <hpdf-encoder>))
  (hpdf-encoder-get-type self))

(define-method use-jp-encodings ((self <hpdf-doc>))
  (hpdf-use-jp-encodings self))

(define-method use-kr-encodings ((self <hpdf-doc>))
  (hpdf-use-kr-encodings self))

(define-method use-cnt-encodings ((self <hpdf-doc>))
  (hpdf-use-cnt-encodings self))

(define-method use-cns-encodings ((self <hpdf-doc>))
  (hpdf-use-cns-encodings self))


;;
;; Epilogue
(provide "hpdf/encoder")

