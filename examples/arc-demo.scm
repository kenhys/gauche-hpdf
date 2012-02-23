
(use gauche.sequence)
(use gauche.interactive)
(use gauche.collection)
(use hpdf)

(define (print-grid pdf page)
  (let* ([height (height page)]
	 [width (width page)]
	 [font (hpdf-get-font pdf "Helvetica" #f)]
	 [x 0]
	 [y 0])
    
    (font-and-size! page font 5)
    (gray-fill! page 0.5)
    (gray-stroke! page 0.8)

    ;; Draw horizontal lines 
    (while (< y height) 
      (begin
	(if (= (modulo y 10) 0)
	    (line-width! page 0.5)
	    (if (not (eq? (line-width page) 0.25))
		(line-width! page 0.25)))
	
	(moveto page 0 y)
	(lineto page width y)
	(stroke page)

	(if (and (= (modulo y 10) 0) (> y 0))
	    (begin
	      (gray-stroke! page 0.5)

	      (moveto page 0 y)
	      (lineto page 5 y)
	      (stroke page)

	      (gray-stroke! page 0.8)
	      ))
	(set! y (+ y 5))
	))


    ;; Draw virtical lines
    (while (< x  width) 
      (begin

	(if (= (modulo x 10) 0)
	    (line-width! page 0.5)
	    (if (not (eq? (line-width page) 0.25))
		(line-width! page 0.25)))
	
	(moveto page x 0)
	(lineto page x height)
	(stroke page)

	(if (and (= (modulo x 50) 0) (> x  0))
	    (begin
	      
	      (gray-stroke! page 0.5)
	    
	      (moveto page x 0)
	    (lineto page x 5)
	    (stroke page)
	    
	    (moveto page x height)
	    (lineto page x (- height 5))
	    (stroke page)

	    (gray-stroke! page 0.8)
	    ))
	(set! x (+ x 5))
	))

    ;; Draw horizontal text
    (set! y 0)
    (while (< y height) 
      (begin
	(if (and (= (modulo y 10) 0) (> y  0))
	    (begin
	      (begin-text page)
	      (move-text-pos page 5 (- y 2))
	      
	      (show-text page (format #f "~d" y))
	      (end-text page)
	      ))
        (set! y (+ y 5))))


    ;; Draw virtical text 
    (set! x 0)
    (while (< x width)
      (begin
	(if (and (= (modulo x 50) 0) (> x 0))
            (begin
	      
	      (begin-text page)
	      (move-text-pos page x 5)

	      (show-text page (format #f "~D" x))
	      (end-text page)

	      (begin-text page)
	      (move-text-pos page x (- height 10))
	      (show-text page (format #f "~D" x))
	      (end-text page)
	      ))
	(set! x (+ x 5)))
      )

    (gray-fill! page 0)
    (gray-stroke! page 0)
    ))

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (add-page pdf)]
	 [s (height! page 220)]
	 [s (width! page 220)]
	 [pos 0]
	 [filename (if (rxmatch #/.*examples\/.*\.scm$/ *program-name*)
		       "examples/arc-demo.pdf" "arc-demo.pdf")])
    (print-grid pdf page)


    ;; A 
    (rgb-fill! page 1.0 0 0)
    (moveto page 100 100)
    (lineto page 100 180)
    (arc page 100 100 80 0 (* 360 0.45))
    (set! pos (hpdf-page-get-current-pos page))
    (lineto page 100 100)
    (fill page)

    ;; B 
    (rgb-fill! page 0 0 1.0)
    (moveto page 100 100)
    (lineto page (~ pos 'x) (~ pos 'y))
    (arc page 100 100 80 (* 360  0.45) (* 360  0.7))
    (set! pos  (hpdf-page-get-current-pos page))
    (lineto page 100 100)
    (fill page)
    
    ;; C
    (rgb-fill! page 0 1.0 0)
    (moveto page 100 100)
    (lineto page (~ pos 'x) (~ pos 'y))
    (arc page 100 100 80 (* 360 0.7) (* 360 0.85))
    (set! pos (hpdf-page-get-current-pos page))
    (lineto page 100 100)
    (fill page)

    ;; D
    (rgb-fill! page 1.0 1.0 0)
    (moveto page 100 100)
    (lineto page (~ pos 'x) (~ pos 'y))
    (arc page 100 100 80 (* 360 0.85) 360)
    (set! pos (hpdf-page-get-current-pos page))
    (lineto page 100 100)
    (fill page)

    ;; draw center circle 
    (gray-stroke! page 0)
    (gray-fill! page 1)
    (circle page 100 100 30)
    (fill page)

    ;; save the document to a file 
    (save-to-file pdf filename)

    ;; clean up 
    (free pdf)
    ))

