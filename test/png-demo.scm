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

(define (draw-image-proc pdf name x y text)
  (let* ([prefix (if (rxmatch #/.*test\/.*\.scm/ *program-name*)
		     "test" ".")]
	 [name1 (format #f "~a/pngsuite/~a.png" prefix name)]
	 [name2 (format #f "~a/PngSuite-2011apr25/~a.png" prefix name)]
	 [filename (cond [(file-is-readable? name1) name1]
			 [(file-is-readable? name2) name2]
			 [else #f])]
	 [page (hpdf-get-current-page pdf)]
	 [dispname (format #f "~a.png" name)]
	 [image 0])
    (if (and filename (file-is-readable? filename))
	(set! image (hpdf-load-png-image-from-file pdf filename))
	(error "not <hpdf-image>"))
    (draw-image page image x y 
			  (hpdf-image-get-width image)
			  (hpdf-image-get-height image))
    (begin-text page)
    (text-leading! page 16)
    (move-text-pos page x y)
    (show-text-next-line page dispname)
    (show-text-next-line page text)
    (end-text page)))

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
	 [dst 0] [image 0]
	 [filename (if (rxmatch #/.*test\/.*\.scm$/ *program-name*)
		       "test/png-demo.pdf" "png-demo.pdf")])
    (compression-mode! pdf HPDF_COMP_ALL)
    
    (width! page 550)
    (height! page 650)

    (set! dst (create-destination page))
    (destination-xyz! dst 0 (height page) 1)
    (open-action! pdf dst)

    (begin-text page)
    (font-and-size! page font 20)
    (move-text-pos page 220 (- (height page) 70))
    (show-text page "PngDemo")
    (end-text page)

    (font-and-size! page font 12)

    (map (^ (entry)
	   (draw-image-proc pdf (~ entry 0) (~ entry 1)
		       (+ (height page) (~ entry 2))
		       (~ entry 3))) imgs)
    
    (hpdf-save-to-file pdf filename)

    (free pdf)))
