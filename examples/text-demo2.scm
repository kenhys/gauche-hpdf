;; -*- mode:scheme; coding: utf-8 -*-

(add-load-path ".")
(add-load-path "./examples")

(use gauche.sequence)
(use gauche.interactive)
(use gauche.parameter)
(use hpdf)

(load "grid-sheet.scm")


(define no (make-parameter 0))

(define (print-text page)
  (let* ([pos (current-text-pos page)])
    (no (+ (no) 1))
    (show-text page (format #f ".[~D]~D ~D" (no) (~ pos 'x) (~ pos 'y)))))

(define SAMP_TXT "The quick brown fox jumps over the lazy dog.")

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [prefix (if (rxmatch #/.*examples\/.*\.scm$/ *program-name*) "examples" ".")]
	 [filename (format #f "~a/text-demo2.pdf" prefix)]
	 [page (add-page pdf)]
	 [page_height 0] [page_width 0]
	 [font 0]
	 [rect (make-rect 0 0 0 0)])

    (size! page HPDF_PAGE_SIZE_A5 HPDF_PAGE_PORTRAIT)

    (print-grid pdf page)
    
    (set! page_height (height page))
    
    (set! font (hpdf-get-font pdf "Helvetica" #f))

    (map
     (^ (entry)
       (let* ([align (~ entry 0)]
	      [desc (~ entry 1)]
	      [left (~ entry 2)]
	      [top (~ entry 3)]
	      [right (~ entry 4)]
	      [bottom (- top 40)])
	 (slot-set! rect 'left left)
	 (slot-set! rect 'top top)
	 (slot-set! rect 'right right)
	 (slot-set! rect 'bottom bottom)

	 (rectangle page left bottom (- right left) (- top bottom))
	 (stroke page)
	 
	 (begin-text page)
	 (font-and-size! page font 10)
	 (text-out page left (+ top 3) desc)

	 (font-and-size! page font 13)
	 (text-rect page left top right bottom SAMP_TXT align)
	 (end-text page)))
     `(;; align desc left top right
       (,HPDF_TALIGN_LEFT "HPDF_TALIGN_LEFT" 25 545 200)
       (,HPDF_TALIGN_RIGHT "HPDF_TALIGN_RIGHT" 220 545 395)
       (,HPDF_TALIGN_CENTER "HPDF_TALIGN_CENTER" 25 475 200)
       (,HPDF_TALIGN_JUSTIFY "HPDF_TALIGN_JUSTIFY" 220 475 395))
     )
    
    ;; Skewed coordinate system
    (gsave page)
    
    (map-with-index
     (^ (idx entry)
       (let* ([angle1 5]
	      [angle2 10]
	      [rad1 (* (/ angle1 180) 3.141592)]
	      [rad2 (* (/ angle2 180) 3.141592)]
	      [align (~ entry 0)]
	      [desc (~ entry 1)]
	      [left (~ entry 2)]
	      [top (~ entry 3)]
	      [right (~ entry 4)]
	      [bottom (~ entry 5)])
	 (gsave page)
	 (cond ([= idx 0]
		;; Skewed
		(concat page 1 (tan rad1) (tan rad2) 1 25 350))
	       (else
		;; Rotated
		(concat page (cos rad1) (sin rad1) (* (sin rad1) -1) (cos rad1)
			220 350)
		))
	 (rectangle page left bottom (- right left) (- top bottom))
	 (stroke page)

	 (begin-text page)
	 (font-and-size! page font 10)
	 (text-out page left (+ top 3) desc)

	 (font-and-size! page font 13)
	 (text-rect page left top right bottom SAMP_TXT align)
	 (end-text page)
	 (grestore page)))
     `((,HPDF_TALIGN_LEFT "Skewed coordinate system" 0 40 175 0)
       (,HPDF_TALIGN_LEFT "Rotated coordinate system" 0 40 175 0)
       ))

    ;; text along a circle.
    (gray-stroke! page 0)
    (circle page 210 190 145)
    (circle page 210 190 113)
    (stroke page)

    (let* ([angle1 (/ 360 (string-length SAMP_TXT))]
	   [angle2 180]
	   [font (hpdf-get-font pdf "Courier-Bold" #f)])
      (begin-text page)
      (font-and-size! page font 30)
      
      (let* ([i 0] [x 0] [y 0] [rad1 0] [rad2 0])
	(while (< i (string-length SAMP_TXT))
	  (set! rad1 (* (/ (- angle2 90) 180) 3.141592))
	  (set! rad2 (* (/ angle2 180) 3.141592))
	  (set! x (+ 210 (* (cos rad2) 122)))
	  (set! y (+ 190 (* (sin rad2) 122)))
	  (text-matrix! page (cos rad1) (sin rad1) (* -1 (sin rad1)) (cos rad1) x y)
	  (show-text page (format #f "~a" (~ SAMP_TXT i)))
	  (set! angle2 (- angle2 angle1))
	  (set! i (+ i 1))))
       (end-text page))

    (save-to-file pdf filename)
    (free pdf)))

