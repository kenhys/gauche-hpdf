

(use file.util)
(use gauche.interactive)
(use hpdf)



(define (show-description page x y text)
  (let* ([msg ""])
    (moveto page x (- y 10))
    (lineto page x (+ y 10))
    (moveto page (- x 10) y)
    (lineto page (+ x 10) y)
    (stroke page)

    (font-and-size! page (current-font page) 8)
    (rgb-fill! page 0 0 0)

    (begin-text page)

    (set! msg (format #f "(x=~D,y=~D)" x y))
    (move-text-pos page
			     (- x (text-width page msg) 5)
			     (- y 10))
    (show-text page msg)
    (end-text page)

    (begin-text page)
    (move-text-pos page (- x 20) (- y 25))
    (show-text page text)
    (end-text page)))

(define (load-png pdf name)
  (let* ([prefix (if (rxmatch #/.*examples\/.*\.scm$/ *program-name*) "examples" ".")]
	 [name1 (format #f "~a/pngsuite/~a.png" prefix name)]
	 [name2 (format #f "~a/PngSuite-2011apr25/~a.png" prefix name)]
	 [filename (cond [(file-is-readable? name1) name1]			   
			 [(file-is-readable? name2) name2]
			 [else #f])])
    (if (and filename (file-is-readable? filename))
	(hpdf-load-png-image-from-file pdf filename)
	(error "not <hpdf-image>"))))

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" #f)]
	 [dst 0]
	 [iw 0]
	 [ih 0]
	 [image 0]
	 [image1 0]
	 [image2 0]
	 [image3 0]
	 [x 0]
	 [y 0]
	 [filename (if (rxmatch #/.*examples\/.*\.scm$/ *program-name*)
		       "examples/image-demo.pdf" "image-demo.pdf")])
    (compression-mode! pdf HPDF_COMP_ALL)

    (width! page 550)
    (height! page 500)
    
    (set! dst (create-destination page))
    (destination-xyz! dst 0 (height page) 1)
    (open-action! pdf dst)

    (begin-text page)
    (font-and-size! page font 20)
    (move-text-pos page 220 (- (height page) 70))
    (show-text page "ImageDemo")
    (end-text page)
    
    (set! image (load-png pdf "basn3p02"))
    (set! image1 (load-png pdf "basn3p02"))
    (set! image2 (load-png pdf "basn0g01"))
    ;; maskimage
    (set! image3 (load-png pdf "maskimage"))

    (set! iw (hpdf-image-get-width image))
    (set! ih (hpdf-image-get-height image))

    (line-width! page 0.5)

    (set! x 100)
    (set! y (- (height page) 150))
      
    (draw-image page image x y iw ih)

    (show-description page x y "Actual Size")

    ;; Scalling image (X direction)
    (set! x (+ x 150))
    
    (draw-image page image x y (* iw 1.5) ih)
    (show-description page x y "Scalling image (X direction)")

    (set! x (+ x 150))

    ;; Scalling image (Y direction)
    (draw-image page image x y iw (* ih 1.5))
    (show-description page x y "Scalling image (Y direction)")

    (set! x 100)
    (set! y (- y 120))
    
    ;; Skewing image
    (let* ([angle1 10]
	   [angle2 20]
	   [rad1 (* (/ angle1 180) 3.141592)]
	   [rad2 (* (/ angle2 180) 3.141592)])
      (gsave page)
      (concat page iw (* (tan rad1) iw) (* (tan rad2) ih) ih x y)

      (execute-xobject page image)
      (grestore page)
      (show-description page x y "Skewing image"))

    (set! x (+ x 150))

    ;; Rotating image
    (let* ([angle 30]
	   [rad (* (/ angle 180) 3.141592)])
      (gsave page)
      (concat page (* iw (cos rad)) (* iw (sin rad))
			(* ih (- (sin rad)))
			(* ih (cos rad)) x y)

      (execute-xobject page image)
      (grestore page)
      (show-description page x y "Rotating image"))

    (set! x (+ x 150))

    ;; Set image2 to the mask image of image1
    (mask-image! image1 image2)

    (rgb-fill! page 0 0 0)
    (begin-text page)
    (move-text-pos page (- x 6) (+ y 14))
    (show-text page "MASKMASK")
    (end-text page)

    (draw-image page image1 (- x 3) (- y 3) (+ iw 6) (+ ih 6))
    (show-description page x y "masked image")    

    (set! x 100)
    (set! y (- y 120))

    (rgb-fill! page 0 0 0)
    (begin-text page)
    (move-text-pos page (- x 6) (+ y 14))
    (show-text page "MASKMASK")
    (end-text page)

    (color-mask! image3 0 255 0 0 0 255)
    (draw-image page image3 x y iw ih)
    (show-description page x y "Color Mask")

    (save-to-file pdf filename)
    (free pdf)))
