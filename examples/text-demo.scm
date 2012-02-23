;;;
;;; -*- mode: scheme; coding: utf-8 -*-
;;;

(add-load-path ".")
(add-load-path "./examples")

(use gauche.sequence)
(use gauche.interactive)
(use file.util)
(use hpdf)

(load "grid-sheet.scm")

(define (show-stripe-pattern page x y)
  (let* ([iy 0])
    (while (< iy 50)
      (rgb-stroke! page 0.0 0.0 0.5)
      (line-width! page 1)
      (moveto page x (+ y iy))
      (lineto page
	      (+ x (text-width page "ABCabc123")) 
	      (+ y iy))
      (stroke page)
      (set! iy (+ iy 3)))
    (line-width! page 2.5)
    ))

(define (show-description page x y text)
  (let* ([fsize (current-font-size page)]
	 [font (current-font page)]
	 [c (rgb-fill page)])
    (begin-text page)
    (rgb-fill! page 0 0 0)
    (text-rendering-mode! page HPDF_FILL)
    (font-and-size! page font 10)
    (text-out page x (- y 12) text)
    (end-text page)

    (font-and-size! page font fsize)
    (rgb-fill! page (~ c 'r) (~ c 'g) (~ c 'b))
    ))

(define renderings
  `((,HPDF_FILL "RenderingMode=PDF_FILL" 0)
    (,HPDF_STROKE "RenderingMode=PDF_STROKE" 50)
    (,HPDF_FILL_THEN_STROKE "RenderingMode=PDF_FILL_THEN_STROKE" 100)
    (,HPDF_FILL_CLIPPING "RenderingMode=PDF_FILL_CLIPPING" 150)
    (,HPDF_STROKE_CLIPPING "RenderingMode=PDF_STROKE_CLIPPING" 200)
    (,HPDF_FILL_STROKE_CLIPPING "RenderingMode=PDF_FILL_STROKE_CLIPPING" 250)))


(define (main args)
  (let* ([page_title "Text Demo"]
	 [samp_text "abcdefgABCDEFG123!#$%&+-@?"]
	 [samp_text2 "The quick brown fox jumps over the lazy dog."]
	 [tw 0]
	 [fsize 0]
	 [pdf (hpdf-new)]
	 [page (add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" #f)]
	 [len 0]
	 [ypos 0]
	 [filename (if (rxmatch #/.*examples\/.*\.scm$/ *program-name*)
		       "examples/text-demo.pdf" "text-demo.pdf")])
    (compression-mode! pdf HPDF_COMP_ALL)
    
    (print-grid pdf page)

    ;; print the title of the page (with positioning center). 
    (font-and-size! page font 24)
    (set! tw (text-width page page_title))
    (begin-text page)
    (text-out page
	      (/ (- (width page) tw) 2)
	      (- (height page) 50) page_title)
    (end-text page)

    (begin-text page)
    (move-text-pos page 60 (- (height page) 60))

    ;; font size
    (set! fsize 8)
    (while (< fsize 60)
      (font-and-size! page font fsize)
      
      (move-text-pos page 0 (- -5 fsize))

      (set! len (measure-text page samp_text
			      (- (width page) 120) HPDF_FALSE))
      (show-text page (substring samp_text 0 len))
      
      (move-text-pos page 0 -10)
      (font-and-size! page font 8)
      (show-text page (format #f "Fontsize=~D" (floor fsize)))
      (set! fsize (* fsize 1.5)))

    ;; font color
    (font-and-size! page font 8)
    (move-text-pos page 0 -30)
    (show-text page "Font color")

    (font-and-size! page font 18)
    (move-text-pos page 0 -20)
    (let* ([i 0] [len (string-length samp_text)] [r 0] [g 0])
      (while (< i len)
	(set! r (/ i len))
	(set! g (- 1 (/ i len)))
	(rgb-fill! page r g 0.0)
	(show-text page (substring samp_text i (+ i 1)))
	(set! i (+ i 1))))
    (move-text-pos page 0 -25)

    (let* ([i 0] [r 0] [b 0] [len (string-length samp_text)])
      (while (< i len)
	(set! r (/ i len))
	(set! b (- 1 (/ i len)))
	(rgb-fill! page r 0.0 b)
	(show-text page (substring samp_text i (+ i 1)))
	(set! i (+ i 1))))
    (move-text-pos page 0 -25)

    (let* ([i 0] [b 0] [g 0] [len (string-length samp_text)])
      (while (< i len)
	(set! b (/ i len))
	(set! g (- 1 (/ i len)))
	(rgb-fill! page 0.0 g b)
	(show-text page (substring samp_text i (+ i 1)))
	(set! i (+ i 1))))
    (end-text page)

    (set! ypos 450)

    ;; font rendering mode
    (font-and-size! page font 32)
    (rgb-fill! page 0.5 0.5 0.0)
    (line-width! page 1.5)

    ;; PDF_FILL
    ;; PDF_STROKE
    ;; PDF_FILL_THEN_STROKE
    (map (^ (entry)
	   (let* ([xpos 60]
		  [mode (~ entry 0)]
		  [text (~ entry 1)]
		  [ystep (~ entry 2)])
	     (if (or (eq? mode HPDF_FILL_CLIPPING)
		     (eq? mode HPDF_STROKE_CLIPPING)
		     (eq? mode HPDF_FILL_STROKE_CLIPPING))
		 (gsave page))
	     (show-description page xpos (- ypos ystep) text)
	     (text-rendering-mode! page mode)
	     (begin-text page)
	     (text-out page xpos (- ypos ystep) "ABCabc123")
	     (end-text page)

	     (if (or (eq? mode HPDF_FILL_CLIPPING)
		     (eq? mode HPDF_STROKE_CLIPPING)
		     (eq? mode HPDF_FILL_STROKE_CLIPPING))
		 (begin
		   (show-stripe-pattern page 60 (- ypos ystep))
		   (grestore page)))
	     )) renderings)
    ;; Reset text attributes
    (text-rendering-mode! page HPDF_FILL)
    (rgb-fill! page 0 0 0)
    (font-and-size! page font 30)

    ;; Rotating text
    (let* ([angle1 30]
	   [rad1 (* (/ angle1 180) 3.141592)])
      (show-description page 320 (- ypos 60) "Rotating text")
      (begin-text page)
      (text-matrix! page (cos rad1) (sin rad1) (* -1 (sin rad1))
		   (cos rad1) 330 (- ypos 60))
      (show-text page "ABCabc123")
      (end-text page))

    ;; Skewing text.
    (show-description page 320 (- ypos 120) "Skewing text")
    (begin-text page)
    (let* ([angle1 10]
	   [angle2 20]
	   [rad1 (* (/ angle1 180) 3.141592)]
	   [rad2 (* (/ angle2 180) 3.141592)])
      (text-matrix! page 1 (tan rad1) (tan rad2) 1 320 (- ypos 120))
      (show-text page "ABCabc123")
      (end-text page))

    ;; scaling text (X direction)
    (show-description page 320 (- ypos 175) "Scaling text (X direction)")
    (begin-text page)
    (text-matrix! page 1.5 0 0 1 320 (- ypos 175))
    (show-text page "ABCabc123")
    (end-text page)

    ;; scaling text (Y direction)
    (show-description page 320 (- ypos 250) "Scaling text (Y direction)")
    (begin-text page)
    (text-matrix! page 1 0 0 2 320 (- ypos 250))
    (show-text page "ABCabc123")
    (end-text page)

    ;; char spacing, word spacing
    (show-description page 60 140 "char-spacing 0")
    (show-description page 60 100 "char-spacing 1.5")
    (show-description page 60 60 "char-spacing 1.5, word-spacing 2.5")

    (font-and-size! page font 20)
    (rgb-fill! page 0.1 0.3 0.1)

    ;; char-spacing 0
    (begin-text page)
    (text-out page 60 140 samp_text2)
    (end-text page)
    
    ;; char-spacing 1.5
    (char-space! page 1.5)
    (begin-text page)
    (text-out page 60 100 samp_text2)
    (end-text page)
    
    ;; char-spacing 1.5, word-spacing 2.5
    (word-space! page 2.5)
    (begin-text page)
    (text-out page 60 60 samp_text2)
    (end-text page)

    (save-to-file pdf filename)
    (free pdf)))
