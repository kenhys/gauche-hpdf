;; -*- mode:scheme; coding:utf-8 -*-


(use gauche.sequence)
(use gauche.parseopt)
(use gauche.interactive)
(use hpdf)

(define (main args)
  (let-args (cdr args)
      ((embed "E|embed") . restargs)
    (let* ([pdf (hpdf-new)]
	   [prefix (if (rxmatch #/.*test\/.*\.scm$/ *program-name*) "test" ".")]
	   [filename (format #f "~a/ttfont-demo.pdf" prefix)]
	   [page (add-page pdf)]
	   [detail_font_name 0]
	   [detail_font 0])
      (d "embed")
      (d embed)
      (d restargs)
      (detail_font_name (load-ttfont-from-name pdf (car restargs) embed))
      
      (detail_font (hpdf-get-font pdf detail_font_name #f))
      
      (font-and-size! page title_font 10)
      
      (begin-text page)
      
      ;; Move the position of the text to top of the page.
      (move-text-pos page 10 190)
      (show-text page detail_font_name)

      (if embed
	  (show-text page "(Embedded Subset)"))

      (font-and-size! page detail_font 15)
      (move-text-pos page 10 -20)
      
      (map (^ (entry)
	     (let* ([x (~ entry 0)]
		    [y (~ entry 1)]
		    [text (~ entry 2)])
	       (show-text page text)
	       (move-text-pos page x y)))
	   '((0 -20 "abcdefghijklmnopqrstuvwxyz")
	     (0 -20 "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
	     (0 -20 "1234567890")))
	     
      
      (save-to-file pdf)
      
      (free pdf))))
