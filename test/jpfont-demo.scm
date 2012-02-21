;; -*- mode:scheme; coding: utf-8 -*-



(use gauche.interactive)
(use gauche.collection)
(use gauche.sequence)
(use hpdf)

(define fonts
  '(("MS-Mincyo" "90ms-RKSJ-H")
    ("MS-Mincyo,Bold" "90ms-RKSJ-H")
    ("MS-Mincyo,Italic" "90ms-RKSJ-H")
    ("MS-Mincyo,BoldItalic" "90ms-RKSJ-H")
    ("MS-PMincyo" "90ms-RKSJ-H")
    ("MS-PMincyo,Bold" "90ms-RKSJ-H")
    ("MS-PMincyo,Italic" "90ms-RKSJ-H")
    ("MS-PMincyo,BoldItalic" "90ms-RKSJ-H")
    ("MS-Gothic" "90ms-RKSJ-H")
    ("MS-Gothic,Bold" "90ms-RKSJ-H")
    ("MS-Gothic,Italic" "90ms-RKSJ-H")
    ("MS-Gothic,BoldItalic" "90ms-RKSJ-H")
    ("MS-PGothic" "90ms-RKSJ-H")
    ("MS-PGothic,Bold" "90ms-RKSJ-H")
    ("MS-PGothic,Italic" "90ms-RKSJ-H")
    ("MS-PGothic,BoldItalic" "90ms-RKSJ-H")))
    
(define PAGE_HEIGHT 210)

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [prefix (if 
		  (rxmatch #/.*test\/.*\.scm$/ *program-name*) "test" ".")]
	 [filename (format #f "~a/jpfont-demo.pdf" prefix)]
	 [sjisfile (format #f "~a/mbtext/sjis.txt" prefix)]
	 [samp_text (call-with-input-file sjisfile port->string)]
	 [root 0])

    (compression-mode! pdf HPDF_COMP_ALL)
    
    (use-jp-encodings pdf)
    (use-jp-fonts pdf)
    
    (page-mode! pdf HPDF_PAGE_MODE_USE_OUTLINE)

    (set! root (create-outline pdf #f "JP font demo" #f))
    (outline-opened! root HPDF_TRUE)
    
    (map-with-index (^ (idx entry)
	   (let* ([face (~ entry 0)]
		  [enc (~ entry 1)]
		  [page (add-page pdf)]
		  [ol 0]
		  [dst 0]
		  [xpos 0] 
		  [point 0]
		  [j 0]
		  [title_font 0]
		  [font (hpdf-get-font pdf face enc)])

	     (d idx)
	     (set! ol (create-outline pdf root face #f))
	     (set! dst (create-destination page))

	     (outline-destination! ol dst)

	     (set! title_font (hpdf-get-font pdf "Helvetica" ""))
	     (font-and-size! page title_font 10)

	     (begin-text page)
	     
	     ;; move the position of the text to top of the page.
	     (move-text-pos page 10 190)
	     (show-text page face)
	     
	     (font-and-size! page font 15)
	     (move-text-pos page 10 -20)
	     (show-text page "abcdefghijklmnopqrstuvwxyz")
	     (move-text-pos page 0 -20)
	     (show-text page "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
	     (move-text-pos page 0 -20)
	     (show-text page "1234567890")
	     (move-text-pos page 0 -20)

	     (map (^ (entry)
		    (let* ([size (~ entry 0)]
			   [y (~ entry 1)])
		      (font-and-size! page font size)
		      (show-text page samp_text)
		      (move-text-pos page 0 y)))
		  '((10 -18)
		    (16 -27)
		    (23 -36)
		    (30 0)))
	     (set! point (current-text-pos page))
	     (d point)
	     ;; finish to print text.
	     (end-text page)

	     (line-width! page 0.5)

	     (set! xpos 20)
	     (while (<= j (/ (string-length samp_text) 2))
	       (moveto page xpos (- (~ point 'y) 10))
	       (lineto page xpos (- (~ point 'y) 12))
	       (stroke page)
	       (set! xpos (+ xpos 30))
	       (set! j (+ j 1)))

	     (width! page (+ (~ point 'x) 20))
	     (height! page PAGE_HEIGHT)

	     (moveto page 10 (- PAGE_HEIGHT 25))
	     (lineto page (+ (~ point 'x) 10) (- PAGE_HEIGHT 25))
	     (stroke page)

	     (moveto page 10 (- PAGE_HEIGHT 85))
	     (lineto page (+ (~ point 'x) 10) (- PAGE_HEIGHT 85))
	     (stroke page)

	     (moveto page 10 (- PAGE_HEIGHT 12))
	     (lineto page (+ (~ point 'x) 10) (- PAGE_HEIGHT 12))
	     (stroke page)

	     )) fonts)
    
    (save-to-file pdf filename)
    
    (free pdf)))
    
    

