

(use gauche.sequence)
(use gauche.collection)
(use gauche.interactive)
(use hpdf)


(define (draw-line page x y label)
  (let* ()
    (begin-text page)
    (move-text-pos page x (- y 10))
    (show-text page label)
    (end-text page)

    (moveto page x (- y 15))
    (lineto page (+ x 220) (- y 15))
    (stroke page)))

(define (draw-line2 page x y label)
  (let* ()
    (begin-text page)
    (move-text-pos page x y)
    (show-text page label)
    (end-text page)

    (moveto page (+ x 30) (- y 25))
    (lineto page (+ x 160) (- y 25))
    (stroke page)))

(define (draw-rect page x y label)
  (let* ()
    (begin-text page)
    (move-text-pos page x (- y 10))
    (show-text page label)
    (end-text page)

    (rectangle page x (- y 40) 220 25)))

(define page-title "Line Example")

(define DASH_MODE1 '(3))
(define DASH_MODE2 '(3 7))
(define DASH_MODE3 '(8 7 2 7))

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (add-page pdf)]
	 [x 0]
	 [y 0]
	 [x1 0]
	 [y1 0]
	 [x2 0]
	 [y2 0]
	 [x3 0]
	 [y3 0]
	 [font (hpdf-get-font pdf "Helvetica" "")]
	 [tw 0]
	 [filename (if (rxmatch #/.*test\/.*\.scm$/ *program-name*)
		       "test/line-demo.pdf" "line-demo.pdf")])
    
    (line-width! page 1)
    (rectangle page 50 50 (- (width page) 100)
			 (- (height page) 110))
    (stroke page)

    ;; print the title of the page (with positioning center). 
    (font-and-size! page font 24)
    (set! tw (text-width page page-title))
    (begin-text page)
    (move-text-pos page (/ (- (width page) tw) 2)
			   (- (height page)  50))
    (show-text page page-title)
    (end-text page)

    (font-and-size! page font 10)

    ;; draw verious widths of lines. 
    (line-width! page 0)
    (draw-line page 60 770 "line width = 0")

    (line-width! page 1.0)
    (draw-line page 60 740 "line width = 1.0")

    (line-width! page 2.0)
    (draw-line page 60 710 "line width = 2.0")

    ;; Line dash pattern 
    (line-width! page 1.0)

    (dash! page DASH_MODE1 1)
    (draw-line page 60 680 "dash-ptn=[3] phase=1 -- 2 on 3 off 3 on...")

    (dash! page DASH_MODE2 2)
    (draw-line page 60 650 "dash-ptn=[7 3] phase=2 -- 5 on 3 off 7 on...")

    (dash! page DASH_MODE3 0)
    (draw-line page 60 620 "dash-ptn=[8 7 2 7] phase=0")

    (dash! page '() 0)

    (line-width! page 30)
    (rgb-stroke! page 0.0 0.5 0.0)

    ;; line cap style
    (line-cap! page HPDF_BUTT_END)
    (draw-line2 page 60 570 "PDF_BUTT_END")

    (line-cap! page HPDF_ROUND_END)
    (draw-line2 page 60 505 "PDF_ROUND_END")

    (line-cap! page HPDF_PROJECTING_SCUARE_END)
    (draw-line2 page 60 440 "pdf-projecting-scuare-end")

    ;; Line join style 
    (line-width! page 30)
    (rgb-stroke! page 0.0 0.0 0.5)

    (line-join! page HPDF_MITER_JOIN)
    (moveto page 120 300)
    (lineto page 160 340)
    (lineto page 200 300)
    (stroke page)

    (begin-text page)
    (move-text-pos page 60 360)
    (show-text page "PDF_MITER_JOIN")
    (end-text page)

    (line-join! page HPDF_ROUND_JOIN)
    (moveto page 120 195)
    (lineto page 160 235)
    (lineto page 200 195)
    (stroke page)

    (begin-text page)
    (move-text-pos page 60 255)
    (show-text page "PDF_ROUND_JOIN")
    (end-text page)

    (line-join! page HPDF_BEVEL_JOIN)
    (moveto page 120 90)
    (lineto page 160 130)
    (lineto page 200 90)
    (stroke page)

    (begin-text page)
    (move-text-pos page 60 150)
    (show-text page "PDF_BEVEL_JOIN")
    (end-text page)

    ;; draw rectangle 
    (line-width! page 2)
    (rgb-stroke! page 0 0 0)
    (rgb-fill! page 0.75 0.0 0.0)

    (draw-rect page 300 770 "stroke")
    (stroke page)

    (draw-rect page 300 720 "fill")
    (fill page)

    (draw-rect page 300 670 "fill then stroke")
    (fill-stroke page)

    ;; clip rect 
    (gsave page)  ;; save the current graphic state 
    (draw-rect page 300 620 "clip rectangle")
    (clip page)
    (stroke page)
    (font-and-size! page font 13)

    (begin-text page)
    (move-text-pos page 290 600)
    (text-leading! page 12)
    (show-text page
	       "clip clip clip clip clip clipi clip clip clip")
    (show-text-next-line page
			 "clip clip clip clip clip clip clip clip clip")
    (show-text-next-line page
			 "clip clip clip clip clip clip clip clip clip")
    (end-text page)
    (grestore page)

;;     /* curve example(curveto2) */
;;     x = 330;
;;     y = 440;
;;     x1 = 430;
;;     y1 = 530;
;;     x2 = 480;
;;     y2 = 470;
;;     x3 = 480;
;;     y3 = 90;

;;     (rgb-fill! page 0 0 0)

;;     begin-text page)
;;     (move-text-pos page 300 540)
;;     (show-text page "curveto2(x1 y1 x2. y2)")
;;     (end-text page)

;;     begin-text page)
;;     (move-text-pos page x + 5 y - 5)
;;     (show-text page "current point")
;;     (move-text-pos page x1 - x y1 - y)
;;     (show-text page "(x1 y1)")
;;     (move-text-pos page x2 - x1 y2 - y1)
;;     (show-text page "(x2 y2)")
;;     (end-text page)

;;     (dash! page dash-mode1 1 0)

;;     (line-width! page 0.5)
;;     (moveto page x1 y1)
;;     (lineto page x2 y2)
;;     stroke page)

;;     (dash! page null 0 0)

;;     (line-width! page 1.5)

;;     (moveto page x y)
;;     curveto2 page x1 y1 x2 y2)
;;     stroke page)

;; ;; curve example(curveto3) 
;;     y -= 150;
;;     y1 -= 150;
;;     y2 -= 150;

;;     begin-text page)
;;     (move-text-pos page 300 390)
;;     (show-text page "curveto3(x1 y1 x2. y2)")
;;     (end-text page)

;;     begin-text page)
;;     (move-text-pos page x + 5 y - 5)
;;     (show-text page "current point")
;;     (move-text-pos page x1 - x y1 - y)
;;     (show-text page "(x1 y1)")
;;     (move-text-pos page x2 - x1 y2 - y1)
;;     (show-text page "(x2 y2)")
;;     (end-text page)

;;     (dash! page dash-mode1 1 0)

;;     (line-width! page 0.5)
;;     (moveto page x y)
;;     (lineto page x1 y1)
;;     stroke page)

;;     (dash! page null 0 0)

;;     (line-width! page 1.5)
;;     (moveto page x y)
;;     curveto3 page x1 y1 x2 y2)
;;     stroke page)

;; ;; curve example(curveto) 
;; (set! y (- y 150))
;; (set! y1 (- y1 160))
;; (set! y2 (- y2 130))
;; (set! x2 (+ x2 10))

;;     begin-text page)
;;     (move-text-pos page 300 240)
;;     (show-text page "curveto(x1 y1 x2. y2 x3 y3)")
;;     (end-text page)

;;     begin-text page)
;;     (move-text-pos page x + 5 y - 5)
;;     (show-text page "current point")
;;     (move-text-pos page x1 - x y1 - y)
;;     (show-text page "(x1 y1)")
;;     (move-text-pos page x2 - x1 y2 - y1)
;;     (show-text page "(x2 y2)")
;;     (move-text-pos page x3 - x2 y3 - y2)
;;     (show-text page "(x3 y3)")
;;     (end-text page)

;;     (dash! page dash-mode1 1 0)

;;     (line-width! page 0.5)
;;     (moveto page x y)
;;     (lineto page x1 y1)
;;     stroke page)
;;     (moveto page x2 y2)
;;     (lineto page x3 y3)
;;     stroke page)

;;     (dash! page null 0 0)

;;     (line-width! page 1.5)
;;     (moveto page x y)
;;     curveto page x1 y1 x2 y2 x3 y3)
;;     stroke page)

    ;; save the document to a file 
    (save-to-file pdf filename)

    ;; clean up 
    (free pdf)))
    

