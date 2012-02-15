

(use gauche.sequence)
(use gauche.collection)
(use gauche.interactive)
(use hpdf)


(define (draw-line page x y label)
  (let* ()
    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page x (- y 10))
    (hpdf-page-show-text page label)
    (hpdf-page-end-text page)

    (hpdf-page-moveto page x (- y 15))
    (hpdf-page-lineto page (+ x 220) (- y 15))
    (hpdf-page-stroke page)))

(define (draw-line2 page x y label)
  (let* ()
    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page x y)
    (hpdf-page-show-text page label)
    (hpdf-page-end-text page)

    (hpdf-page-moveto page (+ x 30) (- y 25))
    (hpdf-page-lineto page (+ x 160) (- y 25))
    (hpdf-page-stroke page)))

(define (draw-rect page x y label)
  (let* ()
    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page x (- y 10))
    (hpdf-page-show-text page label)
    (hpdf-page-end-text page)

    (hpdf-page-rectangle page x (- y 40) 220 25)))

(define page-title "Line Example")

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (hpdf-add-page pdf)]
	 [x 0]
	 [y 0]
	 [x1 0]
	 [y1 0]
	 [x2 0]
	 [y2 0]
	 [x3 0]
	 [y3 0]
	 [font (hpdf-get-font pdf "Helvetica" "")]
	 [tw 0])
    
    (hpdf-page-set-line-width page 1)
    (hpdf-page-rectangle page 50 50 (- (hpdf-page-get-width page) 100)
			 (- (hpdf-page-get-height page) 110))
    (hpdf-page-stroke page)

    ;; print the title of the page (with positioning center). 
    (hpdf-page-set-font-and-size page font 24)
    (set! tw (hpdf-page-text-width page page-title))
    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page (/ (- (hpdf-page-get-width page) tw) 2)
			   (- (hpdf-page-get-height page)  50))
    (hpdf-page-show-text page page-title)
    (hpdf-page-end-text page)

    (hpdf-page-set-font-and-size page font 10)

    ;; draw verious widths of lines. 
    (hpdf-page-set-line-width page 0)
    (draw-line page 60 770 "line width = 0")

    (hpdf-page-set-line-width page 1.0)
    (draw-line page 60 740 "line width = 1.0")

    (hpdf-page-set-line-width page 2.0)
    (draw-line page 60 710 "line width = 2.0")

    ;; line dash pattern 
    (hpdf-page-set-line-width page 1.0)

    (hpdf-page-set-dash page DASH_MODE1 1 1)
    (draw-line page 60 680 "dash-ptn=[3] phase=1 -- "
                "2 on 3 off 3 on...")

    (hpdf-page-set-dash page DASH_MODE2 2 2)
    (draw-line page 60 650 "dash-ptn=[7 3] phase=2 -- "
                "5 on 3 off 7 on...")

    (hpdf-page-set-dash page dash-mode3 4 0)
    (draw-line page 60 620 "dash-ptn=[8 7 2 7] phase=0")

    (hpdf-page-set-dash page null 0 0)

    (hpdf-page-set-line-width page 30)
    (hpdf-page-setrgbstroke page 0.0 0.5 0.0)

    ;; line cap style
    (hpdf-page-setlinecap page HPDF_BUTT_END)
    (draw-line2 page 60 570 "PDF_BUTT_END")

    (hpdf-page-setlinecap page HPDF_ROUND_END)
    (draw-line2 page 60 505 "PDF_ROUND_END")

    (hpdf-page-setlinecap page HPDF_PROJECTING_SCUARE_END)
    (draw-line2 page 60 440 "pdf-projecting-scuare-end")

    ;; line join style 
    (hpdf-page-set-line-width page 30)
    (hpdf-page-setrgbstroke page 0.0 0.0 0.5)

    (hpdf-page-setlinejoin page HPDF_MITER_JOIN)
    (hpdf-page-moveto page 120 300)
    (hpdf-page-lineto page 160 340)
    (hpdf-page-lineto page 200 300)
    (hpdf-page-stroke page)

    (hpdf-page-begin-text page)
    (hpdf-page-movetextpos page 60 360)
    (hpdf-page-showtext page "PDF-MITER-JOIN")
    (hpdf-page-endtext page)

    (hpdf-page-setlinejoin page HPDF_ROUND_JOIN)
    (hpdf-page-moveto page 120 195)
    (hpdf-page-lineto page 160 235)
    (hpdf-page-lineto page 200 195)
    (hpdf-page-stroke page)

    (hpdf-page-begin-text page)
    (hpdf-page-movetextpos page 60 255)
    (hpdf-page-showtext page "PDF-ROUND-JOIN")
    (hpdf-page-endtext page)

    (hpdf-page-setlinejoin page hpdf-bevel-join)
    (hpdf-page-moveto page 120 90)
    (hpdf-page-lineto page 160 130)
    (hpdf-page-lineto page 200 90)
    (hpdf-page-stroke page)

    (hpdf-page-begin-text page)
    (hpdf-page-movetextpos page 60 150)
    (hpdf-page-showtext page "PDF_BEVEL_JOIN")
    (hpdf-page-endtext page)

    ;; draw rectangle 
    (hpdf-page-set-line-width page 2)
    (hpdf-page-setrgbstroke page 0 0 0)
    (hpdf-page-setrgbfill page 0.75 0.0 0.0)

    (draw-rect page 300 770 "stroke")
    (hpdf-page-stroke page)

    (draw-rect page 300 720 "fill")
    (hpdf-page-fill page)

    (draw-rect page 300 670 "fill then stroke")
    (hpdf-page-fillstroke page)

    ;; clip rect 
    (hpdf-page-gsave page)  ;; save the current graphic state 
    (draw-rect page 300 620 "clip rectangle")
    (hpdf-page-clip page)
    (hpdf-page-stroke page)
    (hpdf-page-set-font-and-size page font 13)

    (hpdf-page-begin-text page)
    (hpdf-page-movetextpos page 290 600)
    (hpdf-page-settextleading page 12)
    (hpdf-page-showtext page
                "clip clip clip clip clip clipi clip clip clip")
    (hpdf-page-showtextnextline page
                "clip clip clip clip clip clip clip clip clip")
    (hpdf-page-showtextnextline page
                "clip clip clip clip clip clip clip clip clip")
    (hpdf-page-endtext page)
    (hpdf-page-grestore page)

;;     /* curve example(curveto2) */
;;     x = 330;
;;     y = 440;
;;     x1 = 430;
;;     y1 = 530;
;;     x2 = 480;
;;     y2 = 470;
;;     x3 = 480;
;;     y3 = 90;

;;     (hpdf-page-setrgbfill page 0 0 0)

;;     (hpdf-page-begin-text page)
;;     (hpdf-page-movetextpos page 300 540)
;;     (hpdf-page-showtext page "curveto2(x1 y1 x2. y2)")
;;     (hpdf-page-endtext page)

;;     (hpdf-page-begin-text page)
;;     (hpdf-page-movetextpos page x + 5 y - 5)
;;     (hpdf-page-showtext page "current point")
;;     (hpdf-page-movetextpos page x1 - x y1 - y)
;;     (hpdf-page-showtext page "(x1 y1)")
;;     (hpdf-page-movetextpos page x2 - x1 y2 - y1)
;;     (hpdf-page-showtext page "(x2 y2)")
;;     (hpdf-page-endtext page)

;;     (hpdf-page-set-dash page dash-mode1 1 0)

;;     (hpdf-page-set-line-width page 0.5)
;;     (hpdf-page-moveto page x1 y1)
;;     (hpdf-page-lineto page x2 y2)
;;     (hpdf-page-stroke page)

;;     (hpdf-page-set-dash page null 0 0)

;;     (hpdf-page-set-line-width page 1.5)

;;     (hpdf-page-moveto page x y)
;;     (hpdf-page-curveto2 page x1 y1 x2 y2)
;;     (hpdf-page-stroke page)

;; ;; curve example(curveto3) 
;;     y -= 150;
;;     y1 -= 150;
;;     y2 -= 150;

;;     (hpdf-page-begin-text page)
;;     (hpdf-page-movetextpos page 300 390)
;;     (hpdf-page-showtext page "curveto3(x1 y1 x2. y2)")
;;     (hpdf-page-endtext page)

;;     (hpdf-page-begin-text page)
;;     (hpdf-page-movetextpos page x + 5 y - 5)
;;     (hpdf-page-showtext page "current point")
;;     (hpdf-page-movetextpos page x1 - x y1 - y)
;;     (hpdf-page-showtext page "(x1 y1)")
;;     (hpdf-page-movetextpos page x2 - x1 y2 - y1)
;;     (hpdf-page-showtext page "(x2 y2)")
;;     (hpdf-page-endtext page)

;;     (hpdf-page-set-dash page dash-mode1 1 0)

;;     (hpdf-page-set-line-width page 0.5)
;;     (hpdf-page-moveto page x y)
;;     (hpdf-page-lineto page x1 y1)
;;     (hpdf-page-stroke page)

;;     (hpdf-page-set-dash page null 0 0)

;;     (hpdf-page-set-line-width page 1.5)
;;     (hpdf-page-moveto page x y)
;;     (hpdf-page-curveto3 page x1 y1 x2 y2)
;;     (hpdf-page-stroke page)

;; ;; curve example(curveto) 
;; (set! y (- y 150))
;; (set! y1 (- y1 160))
;; (set! y2 (- y2 130))
;; (set! x2 (+ x2 10))

;;     (hpdf-page-begin-text page)
;;     (hpdf-page-movetextpos page 300 240)
;;     (hpdf-page-showtext page "curveto(x1 y1 x2. y2 x3 y3)")
;;     (hpdf-page-endtext page)

;;     (hpdf-page-begin-text page)
;;     (hpdf-page-movetextpos page x + 5 y - 5)
;;     (hpdf-page-showtext page "current point")
;;     (hpdf-page-movetextpos page x1 - x y1 - y)
;;     (hpdf-page-showtext page "(x1 y1)")
;;     (hpdf-page-movetextpos page x2 - x1 y2 - y1)
;;     (hpdf-page-showtext page "(x2 y2)")
;;     (hpdf-page-movetextpos page x3 - x2 y3 - y2)
;;     (hpdf-page-showtext page "(x3 y3)")
;;     (hpdf-page-endtext page)

;;     (hpdf-page-set-dash page dash-mode1 1 0)

;;     (hpdf-page-set-line-width page 0.5)
;;     (hpdf-page-moveto page x y)
;;     (hpdf-page-lineto page x1 y1)
;;     (hpdf-page-stroke page)
;;     (hpdf-page-moveto page x2 y2)
;;     (hpdf-page-lineto page x3 y3)
;;     (hpdf-page-stroke page)

;;     (hpdf-page-set-dash page null 0 0)

;;     (hpdf-page-set-line-width page 1.5)
;;     (hpdf-page-moveto page x y)
;;     (hpdf-page-curveto page x1 y1 x2 y2 x3 y3)
;;     (hpdf-page-stroke page)

    ;; save the document to a file 
    (hpdf-save-to-file pdf fname)

    ;; clean up 
    (hpdf-free pdf)

    ))
    

