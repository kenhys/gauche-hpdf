
(use gauche.interactive)
(use gauche.sequence)
(use hpdf)

(define (print-page page font page_num)
  (let* ()
    (hpdf-page-set-width page 200)
    (hpdf-page-set-height page 200)
    
    (hpdf-page-set-font-and-size page font 20)
    
    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page 50 150)

    (hpdf-page-show-text page (format #f "Page:~D" page_num))
    (hpdf-page-end-text page)
    ))


(define uri "http://libharu.org")

(define pages_num 7)
(define pages (make-vector pages_num))



(define (main args)
  (let* ([pdf (hpdf-new)]
	 [index_page (hpdf-add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" #f)]
	 [filename (if (rxmatch #/.*examples\/.*\.scm$/ *program-name*)
		       "examples/link-annotation.pdf" "link-annotation.pdf")])

    (define (page-highlight index_page index mode desc)
      (let* ([tp (make <hpdf-point>)]
	     [rect (make <hpdf-rect>)]
	     [dst (make <hpdf-annotation>)]
	     [annot (make <hpdf-annotation>)])
	(set! tp (hpdf-page-get-current-text-pos index_page))
	(hpdf-page-show-text index_page
	 (format #f "Jump to Page~D (HilightMode=~a)" (+ index 1) desc))
	(slot-set! rect 'left (- (~ tp 'x) 4))
	(slot-set! rect 'bottom (- (~ tp 'y) 4))
	(slot-set! rect 'right (+ (~ (hpdf-page-get-current-text-pos index_page) 'x) 4))
	(slot-set! rect 'top (+ (~ tp 'y) 10))

	(hpdf-page-move-to-nextline index_page)

	(set! dst (hpdf-page-create-destination (~ pages index)))

	(set! annot (hpdf-page-create-link-annot index_page rect dst))

	(hpdf-link-annot-set-highlight-mode annot mode)))

    (define (page-borderstyle index_page index desc a b c)
      (let* ([tp (make <hpdf-point>)]
	     [rect (make <hpdf-rect>)]
	     [dst (make <hpdf-annotation>)]
	     [annot (make <hpdf-annotation>)])
	(set! tp (hpdf-page-get-current-text-pos index_page))
	(hpdf-page-show-text index_page
			     (format #f "Jump to Page~D ~a" (+ index 1) desc))
	(slot-set! rect 'left (- (~ tp 'x) 4))
	(slot-set! rect 'bottom (- (~ tp 'y) 4))
	(slot-set! rect 'right (+ (~ (hpdf-page-get-current-text-pos index_page) 'x) 4))
	(slot-set! rect 'top (+ (~ tp 'y) 10))

	(hpdf-page-move-to-nextline index_page)

	(set! dst (hpdf-page-create-destination (~ pages index)))

	(set! annot (hpdf-page-create-link-annot index_page rect dst))

	(hpdf-link-annot-set-border-style annot a b c)))

    (define (page-link index_page index desc uri)
      (let* ([tp (make <hpdf-point>)]
	     [rect (make <hpdf-rect>)]
	     [dst (make <hpdf-annotation>)]
	     [annot (make <hpdf-annotation>)])
	(set! tp (hpdf-page-get-current-text-pos index_page))
	(hpdf-page-show-text index_page
			     (format #f "URI (~a)" desc))
	(slot-set! rect 'left (- (~ tp 'x) 4))
	(slot-set! rect 'bottom (- (~ tp 'y) 4))
	(slot-set! rect 'right (+ (~ (hpdf-page-get-current-text-pos index_page) 'x) 4))
	(slot-set! rect 'top (+ (~ tp 'y) 10))

	(set! annot (hpdf-page-create-uri-link-annot index_page rect uri))))

    (hpdf-page-set-width index_page 300)
    (hpdf-page-set-height index_page 220)

    (dotimes (i pages_num)
      (vector-set! pages i (hpdf-add-page pdf))
      (print-page (~ pages i) font (+ i 1)))
    
    (hpdf-page-begin-text index_page)
    (hpdf-page-set-font-and-size index_page font 10)
    (hpdf-page-move-text-pos index_page 15 200)
    (hpdf-page-show-text index_page "Link Annotation Demo")
    (hpdf-page-end-text index_page)
    
    ;; Create Link-Annotation object on index page.
    (hpdf-page-begin-text index_page)
    (hpdf-page-set-font-and-size index_page font 8)
    (hpdf-page-move-text-pos index_page 20 180)
    (hpdf-page-set-text-leading index_page 23)

      
    ;; page1 (HPDF_ANNOT_NO_HIGHTLIGHT)
    ;; page2 (HPDF_ANNOT_INVERT_BOX)
    ;; page3 (HPDF_ANNOT_INVERT_BORDER)
    (map-with-index (^ (index entry)
		      (page-highlight index_page index (~ entry 0) (~ entry 1)))
		    `((,HPDF_ANNOT_NO_HIGHTLIGHT "HPDF_ANNOT_NO_HIGHTLIGHT")
		      (,HPDF_ANNOT_INVERT_BOX "HPDF_ANNOT_INVERT_BOX")
		      (,HPDF_ANNOT_INVERT_BORDER "HPDF_ANNOT_INVERT_BORDER")
		      (,HPDF_ANNOT_DOWN_APPEARANCE "HPDF_ANNOT_DOWN_APPEARANCE")))

    (map-with-index (^ (index entry)
		      (page-borderstyle index_page (+ index 4) (~ entry 0) 
					(~ entry 1)
					(~ entry 2)
					(~ entry 3)))
		    `(("(dash border)" 1 3 2)
		      ("(no border)" 0 0 0)
		      ("(bold border)" 2 0 0)))
    
    (page-link index_page 6 uri uri)

    (hpdf-page-end-text index_page)

    (hpdf-save-to-file pdf filename)
    
    (hpdf-free pdf)))