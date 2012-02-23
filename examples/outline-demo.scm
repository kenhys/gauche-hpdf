;; -*- mode:scheme; coding:utf-8 -*-


(use gauche.sequence)
(use gauche.interactive)
(use hpdf)



(define (print-page page page_num)
  (let* ()
    (width! page 800)
    (height! page 800)

    (begin-text page)
    (move-text-pos page 30 740)
    
    (show-text page (format #f "Page:~D" page_num))
    (end-text page)))

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [font (font pdf "Helvetica" #f)]
	 [pages (make-vector 3)]
	 [prefix (if (rxmatch #/.*examples\/.*\.scm$/ *program-name*) "examples" ".")]
	 [filename (format #f "~a/outline-demo.pdf" prefix)])
    (page-mode! pdf HPDF_PAGE_MODE_USE_OUTLINE)

    (map-with-index
     (^ (idx size)
       (vector-set! pages idx (add-page pdf))
       (font-and-size! (~ pages idx) font size)
       (print-page (~ pages idx) (+ idx 1)))
     '(30 30 30))

    ;; create outline root.
    (let* ([root (create-outline pdf #f "OutlineRoot" #f)]
	   [outlines (make-vector 3)]
	   )
      (outline-opened! root HPDF_TRUE)

      (map-with-index
       (^ (idx text)
	 (if (< idx 2)
	     (vector-set! outlines idx (create-outline pdf root text))
	     (vector-set! outlines idx
			  (create-outline pdf root text
					  (encoder pdf "ISO8859-2")))))
       '("page1" "page2" "ISO8859-2 text ﾓﾔﾕﾖﾗﾘﾙ"))

      ;; create destination objects on each pages 
      ;; and link it to outline items.
      (map-with-index
       (^ (idx dummy)
	 (let* ([dst 0])
	   (set! dst (create-destination (~ pages idx)))
	   (destination-xyz! dst 0 (height (~ pages idx)) 1)
	   (destination! (~ outlines idx) dst)))
       '(this is demo))
      )
      
    (save-to-file pdf filename)
    (free pdf)))

		      