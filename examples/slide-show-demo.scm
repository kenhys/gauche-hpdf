;; -*- mode:scheme; coding: utf-8 -*-


(use gauche.sequence)
(use gauche.interactive)
(use srfi-27)
(use hpdf)

(define (print-page page caption font style prev next)
  (let* ([r (random-real)]
	 [g (random-real)]
	 [b (random-real)]
	 [rect (make-rect 0 0 0 0)]
	 [dst 0] [annot 0])
    (width! page 800)
    (height! page 600)

    (rgb-fill! page r g b)

    (rectangle page 0 0 800 600)
    (fill page)

    (rgb-fill! page (- 1.0 r) (- 1.0 g) (- 1.0 b))

    (font-and-size! page font 30)

    (begin-text page)
    (text-matrix! page 0.8 0.0 0.0 1.0 0.0 0.0)
    (text-out page 50 530 caption)

    (text-matrix! page 1.0 0.0 0.0 1.0 0.0 0.0)
    (font-and-size! page font 20)
    (text-out page
	      55 300 "Type Ctrl+L in order to return from full screen mode")
    (end-text page)

    (slide-show! page style 5.0 1.0)

    (font-and-size! page font 20)

    (if next
	(begin
	  (begin-text page)
	  (text-out page 680 50 "Next=>")
	  (end-text page)
	  ))

    (if next
	(begin
	  (begin-text page)
	  (text-out page 50 50 "<=Prev")
	  (end-text page)
	  ))))



(define (main args)
  (let* ([pdf (hpdf-new)]
	 [font (hpdf-get-font pdf "Courier" #f)]
	 [pages (make-vector 17)]
	 [prefix (if (rxmatch #/.*examples\/.*\.scm$/ *program-name*) "examples" ".")]
	 [filename (format #f "~a/slide-show-demo.pdf" prefix)])

    (let* ([i 0])
      (while (<= i 16)
	(vector-set! pages i (add-page pdf))
	(set! i (+ i 1))))

    (map-with-index
     (^ (idx entry)
       (let* ([caption (~ entry 1)]
	      [effect (~ entry 0)])
	 (cond ([= idx 0]
		;; next only
		(print-page (~ pages idx) caption font effect
			    #f
			    (~ pages (+ idx 1))))
	       ([= idx 16]
		;; prev only
		(print-page (~ pages idx) caption font effect
			    (~ pages (- idx 1))
			    #f))
	       (else
		;; prev next
		(print-page (~ pages idx) caption font effect
			    (~ pages (- idx 1))
			    (~ pages (+ idx 1)))))))
     `((,HPDF_TS_WIPE_RIGHT "HPDF_TS_WIPE_RIGHT")
       (,HPDF_TS_WIPE_UP "HPDF_TS_WIPE_UP")
       (,HPDF_TS_WIPE_LEFT "HPDF_TS_WIPE_LEFT")
       (,HPDF_TS_WIPE_DOWN "HPDF_TS_WIPE_DOWN")
       (,HPDF_TS_BARN_DOORS_HORIZONTAL_OUT "HPDF_TS_BARN_DOORS_HORIZONTAL_OUT")
       (,HPDF_TS_BARN_DOORS_HORIZONTAL_IN "HPDF_TS_BARN_DOORS_HORIZONTAL_IN")
       (,HPDF_TS_BARN_DOORS_VERTICAL_OUT "HPDF_TS_BARN_DOORS_VERTICAL_OUT")
       (,HPDF_TS_BARN_DOORS_VERTICAL_IN "HPDF_TS_BARN_DOORS_VERTICAL_IN")
       (,HPDF_TS_BOX_OUT "HPDF_TS_BOX_OUT")
       (,HPDF_TS_BOX_IN "HPDF_TS_BOX_IN")
       (,HPDF_TS_BLINDS_HORIZONTAL "HPDF_TS_BLINDS_HORIZONTAL")
       (,HPDF_TS_BLINDS_VERTICAL "HPDF_TS_BLINDS_VERTICAL")
       (,HPDF_TS_DISSOLVE "HPDF_TS_DISSOLVE")
       (,HPDF_TS_GLITTER_DOWN "HPDF_TS_GLITTER_DOWN")
       (,HPDF_TS_GLITTER_RIGHT "HPDF_TS_GLITTER_RIGHT")
       (,HPDF_TS_GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT "HPDF_TS_GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT")
       (,HPDF_TS_REPLACE "HPDF_TS_REPLACE")))

    (page-mode! pdf HPDF_PAGE_MODE_FULL_SCREEN)

    (save-to-file pdf filename)

    (free pdf)))