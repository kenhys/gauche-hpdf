;;;
;;; -*- mode: scheme; coding: utf-8 -*-
;;;

(add-load-path ".")
(add-load-path "./test")

(use gauche.sequence)
(use gauche.interactive)
(use file.util)
(use hpdf)

(load "grid-sheet.scm")

(define (draw-image pdf name x y text)
  (let* ([filename (cond [(file-is-readable?
			   (format #f "test/pngsuite/~a.png" name))
			  (format #f "test/pngsuite/~a.png" name)]
			 [(file-is-readable? 
			   (format #f "test/PngSuite-2011apr25/~a.png" name))
			  (format #f "test/PngSuite-2011apr25/~a.png" name)]
			 [else #f])]
	 [page (hpdf-get-current-page pdf)]
	 [dispname (format #f "~a.png" name)]
	 [image 0])
    (if (and filename (file-is-readable? filename))
	(set! image (hpdf-load-png-image-from-file pdf filename))
	(error "not <hpdf-image>"))
    (hpdf-page-draw-image page image x y 
			  (hpdf-image-get-width image)
			  (hpdf-image-get-height image))
    (hpdf-page-begin-text page)
    (hpdf-page-set-text-leading page 16)
    (hpdf-page-move-text-pos page x y)
    (hpdf-page-show-text-next-line page dispname)
    (hpdf-page-show-text-next-line page text)
    (hpdf-page-end-text page)))

(define imgs
  '(("basn0g01" 100 -150 "1bit grayscale.")
    ("basn0g02" 200 -150 "2bit grayscale.")
    ("basn0g04" 300 -150 "4bit grayscale.")
    ("basn0g08" 400 -150 "8bit grayscale.")
    ("basn2c08" 100 -250 "8bit color.")
    ("basn2c16" 200 -250 "16bit color.")
    ("basn3p01" 100 -350 "1bit pallet.")
    ("basn3p02" 200 -350 "2bit pallet.")
    ("basn3p04" 300 -350 "4bit pallet.")
    ("basn3p08" 400 -350 "8bit pallet.")
    ("basn4a08" 100 -450 "8bit alpha.")
    ("basn4a16" 200 -450 "16bit alpha.")
    ("basn6a08" 100 -550 "8bit alpha.")
    ("basn6a16" 200 -550 "16bit alpha.")))


(define (main args)
  (let* ([page_title "Text Demo"]
	 [samp_text "abcdefgABCDEFG123!#$%&+-@?"]
	 [samp_text2 "The quick brown fox jumps over the lazy dog."]
	 [pdf (hpdf-new)]
	 [page (hpdf-add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" "")]
	 [tw 0]
	 [fsize 0]
	 [dst 0] [image 0])
    (hpdf-set-compression-mode pdf HPDF_COMP_ALL)
    
    (hpdf-page-set-width page 550)
    (hpdf-page-set-height page 650)

    (set! dst (hpdf-page-create-destination page))
    (hpdf-destination-set-xyz dst 0 (hpdf-page-get-height page) 1)
    (hpdf-set-open-action pdf dst)

    (hpdf-page-begin-text page)
    (hpdf-page-set-font-and-size page font 20)
    (hpdf-page-move-text-pos page 220 (- (hpdf-page-get-height page) 70))
    (hpdf-page-show-text page "PngDemo")
    (hpdf-page-end-text page)

    (hpdf-page-set-font-and-size page font 12)

    (map (^ (entry)
	   (draw-image pdf (~ entry 0) (~ entry 1)
		       (+ (hpdf-page-get-height page) (~ entry 2))
		       (~ entry 3))) imgs)
    
    (hpdf-save-to-file pdf "test/png-demo.pdf")

    (hpdf-free pdf)
    ))