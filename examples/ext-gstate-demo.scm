;; -*- mode:scheme;coding:utf-8 -*-

(use gauche.interactive)
(use hpdf)


(define (draw-circles page description x y)
  (let* ()
    (line-width! page 1.0)
    (rgb-stroke! page 0.0 0.0 0.0)
    (rgb-fill! page 1.0 0.0 0.0)
    (circle page (+ x 40) (+ y 40) 40)
    (close-path-fill-stroke page)
    (rgb-fill! page 0.0 1.0 0.0)
    (circle page (+ x 100) (+ y 40) 40)
    (close-path-fill-stroke page)
    (rgb-fill! page 0.0 0.0 1.0)
    (circle page (+ x 70) (+ y 74.64) 40)
    (close-path-fill-stroke page)

    (rgb-fill! page 0.0 0.0 0.0)
    (begin-text page)
    (text-out page x (+ y 130.0) description)
    (end-text page)))

(define PAGE_HEIGHT 900)
(define PAGE_WIDTH 600)

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [prefix (if (rxmatch #/.*examples\/.*\.scm/ *program-name*) "examples" ".")]
	 [filename (format #f "~a/ext-gstate-demo.pdf" prefix)]
	 [hfont (hpdf-get-font pdf "Helvetica" #f)]
	 [page (add-page pdf)]
	 [gstate 0])
    (font-and-size! page hfont 10)
    
    (height! page PAGE_HEIGHT)
    (width! page PAGE_WIDTH)
    
    ;; normal
    (gsave page)
    (draw-circles page "normal" 40.0 (- PAGE_HEIGHT 170))
    (grestore page)

    ;; transparency 0.8
    (gsave page)
    (set! gstate (create-ext-gstate pdf))
    (ext-gstate-alpha-fill! gstate 0.8)
    (ext-gstate-alpha-stroke! gstate 0.8)
    (ext-gstate! page gstate)
    (draw-circles page "alpha fill = 0.8" 230.0 (- PAGE_HEIGHT 170))
    (grestore page)

    ;; transparency 0.4
    (gsave page)
    (set! gstate (create-ext-gstate pdf))
    (ext-gstate-alpha-fill! gstate 0.4)
    (ext-gstate-alpha-stroke! gstate 0.4)
    (ext-gstate! page gstate)
    (draw-circles page "alpha fill = 0.4" 420.0 (- PAGE_HEIGHT 170))
    (grestore page)

    ;; blend-mode
    (map (^ (entry)
	   (let* ([mode (~ entry 0)]
		  [xpos (~ entry 1)]
		  [ypos (~ entry 2)]
		  [desc (~ entry 3)])
	     (gsave page)
	     (set! gstate (create-ext-gstate pdf))
	     (ext-gstate-blend-mode! gstate mode)
	     (ext-gstate! page gstate)
	     (draw-circles page desc xpos ypos)
	     (grestore page)))
	 `((,HPDF_BM_MULTIPLY 40.0 ,(- PAGE_HEIGHT 340) "HPDF_BM_MULTIPLY")
	   (,HPDF_BM_SCREEN 230.0 ,(- PAGE_HEIGHT 340) "HPDF_BM_SCREEN")
	   (,HPDF_BM_OVERLAY 420.0 ,(- PAGE_HEIGHT 340) "HPDF_BM_OVERLAY")
	   (,HPDF_BM_DARKEN 40.0 ,(- PAGE_HEIGHT 510) "HPDF_BM_DARKEN")
	   (,HPDF_BM_LIGHTEN 230.0 ,(- PAGE_HEIGHT 510) "HPDF_BM_LIGHTEN")
	   (,HPDF_BM_COLOR_DODGE 420.0 ,(- PAGE_HEIGHT 510) "HPDF_BM_COLOR_DODGE")
	   (,HPDF_BM_COLOR_BUM 40.0 ,(- PAGE_HEIGHT 680) "HPDF_BM_COLOR_BUM")
	   (,HPDF_BM_HARD_LIGHT 230.0 ,(- PAGE_HEIGHT 680) "HPDF_BM_HARD_LIGHT")
	   (,HPDF_BM_SOFT_LIGHT 420.0 ,(- PAGE_HEIGHT 680) "HPDF_BM_SOFT_LIGHT")
	   (,HPDF_BM_DIFFERENCE 40.0 ,(- PAGE_HEIGHT 850) "HPDF_BM_DIFFERENCE")
	   (,HPDF_BM_EXCLUSHON 230.0 ,(- PAGE_HEIGHT 850) "HPDF_BM_EXCLUSHON")
	   ))

    (save-to-file pdf filename)
    (free pdf)))
