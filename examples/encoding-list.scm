;; -*- mode:scheme; coding:utf-8 -*-


(use gauche.interactive)
(use srfi-14)
(use hpdf)

(define PAGE_WIDTH 420)
(define PAGE_HEIGHT 400)
(define CELL_WIDTH 20)
(define CELL_HEIGHT 20)
(define CELL_HEADER 10)

(define (draw-graph page)
  (let* ()
    (line-width! page 0.5)
    
    ;; Draw vertical lines.
    (let* ([i 0] [x 0])
      (while (<= i 17)
	(begin
	  (set! x (+ (* i CELL_WIDTH) 40))
	  
	  (moveto page x (- PAGE_HEIGHT 60))
	  (lineto page x 40)
	  (stroke page)
	  
	  (if (and (> i 0) (<= i 16))
	      (begin 
		(begin-text page)
		(move-text-pos page (+ x 5) (- PAGE_HEIGHT 75))
		(show-text page (format #f "~X" (- i 1)))
		(end-text page)))
	  (set! i (+ i 1)))))

    ;; Draw horizontal lines.
    (let* ([i 0] [y 0])
      (while (<= i 15)
	(begin
	  (set! y (+ (* i CELL_HEIGHT) 40))
	  
	  (moveto page 40 y)
	  (lineto page (- PAGE_WIDTH 40) y)
	  (stroke page)

	  (if (< i 14)
	      (begin 
		(begin-text page)
		(move-text-pos page 45 (+ y 5))
		(show-text page (format #f "~X" (- 15 i)))
		(end-text page)))
	  (set! i (+ i 1)))))))
    
(define (draw-fonts page)
  (let* ([i 0] [j 0])
    (begin-text page)
    
    (let* ([i 1] [c 0])
      (while (< i 17)
	(let* ([j 1] [x 0] [y 0])
	  (while (< j 17)
	    (set! y (- (- PAGE_HEIGHT 55) (* (- i 1) CELL_HEIGHT)))
	    (set! x (+ (* j CELL_WIDTH) 50))
	    
	    (set! c (+ (* (- i 1) 16) (- j 1)))
	    (if (>= c 32)
		(begin
		  (set! x (- x (/ (text-width page (format #f "~a" (ucs->char c))) 2)))
		  ;;(if (>= i 16)
		  ;;(d (format #f "~X ~X |~D ~X ~a|" (- i 1)
		  ;;(- j 1) c c (ucs->char c))))
		  (text-out page x y (string (ucs->char c)))))
	    (set! j (+ j 1)))
	  (set! i (+ i 1)))))
    (end-text page)))

(define encodings
  '("StandardEncoding"
    "MacRomanEncoding"
    "WinAnsiEncoding"
    "ISO8859-2"
    "ISO8859-3"
    "ISO8859-4"
    "ISO8859-5"
    "ISO8859-9"
    "ISO8859-10"
    "ISO8859-13"
    "ISO8859-14"
    "ISO8859-15"
    "ISO8859-16"
    "CP1250"
    "CP1251"
    "CP1252"
    "CP1254"
    "CP1257"
    "KOI8-R"
    "Symbol-Set"
    "ZapfDingbats-Set"))

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (add-page pdf)]
	 [prefix (if (rxmatch #/.*examples\/.*\.scm$/ *program-name*) "examples" ".")]
	 [filename (format #f "~a/encoding-list.pdf" prefix)]
	 [font (hpdf-get-font pdf "Helvetica" #f)]
	 [root 0]
	 [afm  (format #f "~a/type1/a010013l.afm" prefix)]
	 [pfb  (format #f "~a/type1/a010013l.pfb" prefix)]
	 [font_name 0])
    (compression-mode! pdf HPDF_COMP_ALL)

    (page-mode! pdf HPDF_PAGE_MODE_USE_OUTLINE)
    
    (set! font_name
	  (load-type1-font-from-file pdf afm pfb))

    (set! root (create-outline pdf #f "Encoding list" #f))
    (outline-opened! root HPDF_TRUE)

    (map (^ (enc)
	   (let* ([page (add-page pdf)]
		  [outline 0]
		  [dst 0]
		  [font2 0]
		  )
	     (width! page PAGE_WIDTH)
	     (height! page PAGE_HEIGHT)
	     
	     (set! outline (create-outline pdf root enc ""))
	     (set! dst (create-destination page))
	     (destination-xyz! dst 0 (height page) 1)
	     (outline-destination! outline dst)

	     (font-and-size! page font 15)
	     (draw-graph page)

	     (begin-text page)
	     (font-and-size! page font 20)
	     (move-text-pos page 40 (- PAGE_HEIGHT 50))
	     (show-text page enc)
	     (show-text page " Encoding")
	     (end-text page)
	     
	     (cond ([string=? enc "Symbol-Set"]
		    (set! font2 (hpdf-get-font pdf "Symbol" #f)))
		   ([string=? enc "ZapfDingbats-Set"]
		    (set! font2 (hpdf-get-font pdf "ZapfDingbats" #f)))
		   (else
		    (set! font2 (hpdf-get-font pdf font_name enc))))

	     (font-and-size! page font2 14)
	     (draw-fonts page))) encodings)

    (save-to-file pdf filename)

    (free pdf)))
