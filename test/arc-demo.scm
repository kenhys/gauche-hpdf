
(use gauche.sequence)
(use gauche.interactive)
(use gauche.collection)
(use hpdf)

(define (print-grid pdf page)
  (let* ([height (hpdf-page-get-height page)]
	 [width (hpdf-page-get-width page)]
	 [font (hpdf-get-font pdf "Helvetica" "")]
	 [x 0]
	 [y 0])
    
    (hpdf-page-set-font-and-size page font 5)
    (hpdf-page-set-gray-fill page 0.5)
    (hpdf-page-set-gray-stroke page 0.8)

    ;; Draw horizontal lines 
    (while (< y height) 
      (begin
	(if (= (modulo y 10) 0)
	    (hpdf-page-set-line-width page 0.5)
	    (if (not (eq? (hpdf-page-get-line-width page) 0.25))
		(hpdf-page-set-line-width page 0.25)))
	
	(hpdf-page-moveto page 0 y)
	(hpdf-page-lineto page width y)
	(hpdf-page-stroke page)

	(if (and (= (modulo y 10) 0) (> y 0))
	    (begin
	      (hpdf-page-set-gray-stroke page 0.5)

	      (hpdf-page-moveto page 0 y)
	      (hpdf-page-lineto page 5 y)
	      (hpdf-page-stroke page)

	      (hpdf-page-set-gray-stroke page 0.8)
	      ))
	(set! y (+ y 5))
	))


    ;; Draw virtical lines
    (while (< x  width) 
      (begin

	(if (= (modulo x 10) 0)
	    (hpdf-page-set-line-width page 0.5)
	    (if (not (eq? (hpdf-page-get-line-width page) 0.25))
		(hpdf-page-set-line-width page 0.25)))
	
	(hpdf-page-moveto page x 0)
	(hpdf-page-lineto page x height)
	(hpdf-page-stroke page)

	(if (and (= (modulo x 50) 0) (> x  0))
	    (begin
	      
	      (hpdf-page-set-gray-stroke page 0.5)
	    
	    (hpdf-page-moveto page x 0)
	    (hpdf-page-lineto page x 5)
	    (hpdf-page-stroke page)
	    
	    (hpdf-page-moveto page x height)
	    (hpdf-page-lineto page x (- height 5))
	    (hpdf-page-stroke page)

	    (hpdf-page-set-gray-stroke page 0.8)
	    ))
	(set! x (+ x 5))
	))

    ;; Draw horizontal text
    (set! y 0)
    (while (< y height) 
      (begin
	(if (and (= (modulo y 10) 0) (> y  0))
	    (begin
	      (hpdf-page-begin-text page)
	      (hpdf-page-move-text-pos page 5 (- y 2))
	      
	      (hpdf-page-show-text page (format #f "~d" y))
	      (hpdf-page-end-text page)
	      ))
        (set! y (+ y 5))))


    ;; Draw virtical text 
    (set! x 0)
    (while (< x width)
      (begin
	(if (and (= (modulo x 50) 0) (> x 0))
            (begin
	      
	      (hpdf-page-begin-text page)
	      (hpdf-page-move-text-pos page x 5)

	      (hpdf-page-show-text page (format #f "~D" x))
	      (hpdf-page-end-text page)

	      (hpdf-page-begin-text page)
	      (hpdf-page-move-text-pos page x (- height 10))
	      (hpdf-page-show-text page (format #f "~D" x))
	      (hpdf-page-end-text page)
	      ))
	(set! x (+ x 5)))
      )

    (hpdf-page-set-gray-fill page 0)
    (hpdf-page-set-gray-stroke page 0)
    ))

(let* ([pdf (hpdf-new)]
       [page (hpdf-add-page pdf)]
       [s (hpdf-page-set-height page 220)]
       [s (hpdf-page-set-width page 220)]
       [pos 0])
  (print-grid pdf page)

  ;; A 
  (hpdf-page-set-rgb-fill page 1.0 0 0)
  (hpdf-page-moveto page 100 100)
  (hpdf-page-lineto page 100 180)
  (hpdf-page-arc page 100 100 80 0 (* 360 0.45))
  (set! pos (hpdf-page-get-current-pos page))
  (hpdf-page-lineto page 100 100)
  (hpdf-page-fill page)

  ;; B 
  (hpdf-page-set-rgb-fill page 0 0 1.0)
  (hpdf-page-moveto page 100 100)
  ;;(hpdf-page-lineto page pos.x pos.y)
  (hpdf-page-arc page 100 100 80 (* 360  0.45) (* 360  0.7))
  (set! pos  (hpdf-page-get-current-pos page))
  (hpdf-page-lineto page 100 100)
  (hpdf-page-fill page)
    
  ;; C
  (hpdf-page-set-rgb-fill page 0 1.0 0)
  (hpdf-page-moveto page 100 100)
  ;;(hpdf-page-lineto (page pos.x pos.y))
  (hpdf-page-arc page 100 100 80 (* 360 0.7) (* 360 0.85))
  (set! pos (hpdf-page-get-current-pos page))
  (hpdf-page-lineto page 100 100)
  (hpdf-page-fill page)

  ;; D
  (hpdf-page-set-rgb-fill page 1.0 1.0 0)
  (hpdf-page-moveto page 100 100)
  ;;(hpdf-page-lineto page pos.x pos.y)
  (hpdf-page-arc page 100 100 80 (* 360 0.85) 360)
  (set! pos (hpdf-page-get-current-pos page))
  (hpdf-page-lineto page 100 100)
  (hpdf-page-fill page)

  ;; draw center circle 
  (hpdf-page-set-gray-stroke page 0)
  (hpdf-page-set-gray-fill page 1)
  (hpdf-page-circle page 100 100 30)
  (hpdf-page-fill page)

  ;; save the document to a file 
  (hpdf-save-to-file pdf "test/arc-demo.pdf")

  ;; clean up 
  (hpdf-free pdf)
  )

