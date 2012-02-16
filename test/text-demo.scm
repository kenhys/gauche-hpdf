;;;
;;; -*- mode: scheme; coding: utf-8 -*-
;;;

(add-load-path ".")
(add-load-path "./test")

(use gauche.sequence)
(use file.util)
(use hpdf)

(load "grid-sheet.scm")

(define (show-stripe-pattern page x y)
  (let* ([iy 0])
    (while (< iy 50)
      (hpdf-page-set-rgb-stroke page 0.0 0.0 0.5)
      (hpdf-page-set-line-width page 1)
      (hpdf-page-moveto page x (+ y iy))
      (hpdf-page-lineto page
			(+ x (hpdf-page-text-width page "ABCabc123")) 
			(+ y iy))
      (hpdf-page-stroke page)
      (set! iy (+ iy 3)))
    (hpdf-page-set-line-width page 2.5)
    ))

(define (show-description page x y text)
  (let* ([fsize (hpdf-page-get-current-font-size page)]
	 [font (hpdf-page-get-current-font page)]
	 [c (hpdf-page-get-rgb-fill page)])
    (hpdf-page-begin-text page)
    (hpdf-page-set-rgb-fill page 0 0 0)
    (hpdf-page-set-text-rendering-mode page HPDF_FILL)
    (hpdf-page-set-font-and-size page font 10)
    (hpdf-page-text-out page x (- y 12) text)
    (hpdf-page-end-text page)

    (hpdf-page-set-font-and-size page font fsize)
    (hpdf-page-set-rgb-fill page (~ c 'r) (~ c 'g) (~ c 'b))
    ))

(define (main args)
  (let* ([page_title "Text Demo"]
	 [samp_text "abcdefgABCDEFG123!#$%&+-@?"]
	 [samp_text2 "The quick brown fox jumps over the lazy dog."]
	 [tw 0]
	 [fsize 0]
	 [pdf (hpdf-new)]
	 [page (hpdf-add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" "")])
    (hpdf-set-compression-mode pdf HPDF_COMP_ALL)
    
    (print-grid pdf page)

    ;; print the title of the page (with positioning center). 
    (hpdf-page-set-font-and-size page font 24)
    (set! tw (hpdf-page-text-width page page-title))
    (hpdf-page-begin-text page)
    (hpdf-page-text-out
     page (/ (- (hpdf-page-get-width page) tw) 2)
     (- (hpdf-page-get-height page) 50) page_title)
    (hpdf-page-end-text page)

    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page 60 (- (hpdf-page-get-height page) 60))


    ))