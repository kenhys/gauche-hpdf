;;;
;;; -*- mode: scheme; coding: utf-8 -*-
;;; Test hpdf
;;;

(use gauche.test)
(use gauche.charconv)
(use binary.pack)
(use file.util)
(use hpdf)

(test-record-file "test.record")

(test-start "hpdf")
(test-module 'hpdf)

(define (test-subsection msg)
  (format #t "~a()\n" msg))

(define (test-subsubsection msg)
  (format #t "#=> ~a\n" msg))


(test-section "hpdf image")
(test-subsection "hpdf-load-png-image-from-file")
(define (test-hpdf-load-png-image-from-file filename)
  (let* ((pdf (hpdf-new)))
    (hpdf-load-png-image-from-file pdf filename)))

(test-subsubsection "Basic format test files (non-interlaced)")
(test-section "")
(test-subsection "hpdf-page-draw-image")

(define (test-hpdf-page-draw-image filename)
  (let* ((pdf (hpdf-new))
         (image (hpdf-load-png-image-from-file pdf filename))
         (page (hpdf-add-page pdf))
         (w (hpdf-page-get-width page))
         (h (hpdf-page-get-height page))
         (iw (hpdf-image-get-width image))
         (ih (hpdf-image-get-height image))
         (st (hpdf-page-draw-image page image 0 (- h ih) iw ih))
         )
    (hpdf-save-to-file pdf "data/sample.pdf")))

(test* "" HPDF_OK (test-hpdf-page-draw-image "image/PngSuite/TP1N3P08.PNG"))

;; epilogue
(test-end)
