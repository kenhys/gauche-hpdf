

(use file.util)
(use gauche.interactive)
(use hpdf)



(define (show-description page x y text)
  (let* ([msg ""])
    (hpdf-page-moveto page x (- y 10))
    (hpdf-page-lineto page x (+ y 10))
    (hpdf-page-moveto page (- x 10) y)
    (hpdf-page-lineto page (+ x 10) y)
    (hpdf-page-stroke page)

    (hpdf-page-set-font-and-size page (hpdf-page-get-current-font page) 8)
    (hpdf-page-set-rgb-fill page 0 0 0)

    (hpdf-page-begin-text page)

    (set! msg (format #f "(x=~D,y=~D)" x y))
    (hpdf-page-move-text-pos page
			     (- x (hpdf-page-text-width page msg) 5)
			     (- y 10))
    (hpdf-page-show-text page msg)
    (hpdf-page-end-text page)

    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page (- x 20) (- y 25))
    (hpdf-page-show-text page text)
    (hpdf-page-end-text page)))

(define (load-png pdf name)
  (let* ([filename (cond [(file-is-readable?
			   (format #f "test/pngsuite/~a.png" name))
			  (format #f "test/pngsuite/~a.png" name)]
			 [(file-is-readable? 
			   (format #f "test/PngSuite-2011apr25/~a.png" name))
			  (format #f "test/PngSuite-2011apr25/~a.png" name)]
			 [else #f])])
    (if (and filename (file-is-readable? filename))
	(hpdf-load-png-image-from-file pdf filename)
	(error "not <hpdf-image>"))))

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (hpdf-add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" "")]
	 [dst 0]
	 [iw 0]
	 [ih 0]
	 [image 0]
	 [image1 0]
	 [image2 0]
	 [image3 0]
	 [x 0]
	 [y 0])
    (hpdf-set-compression-mode pdf HPDF_COMP_ALL)

    (hpdf-page-set-width page 550)
    (hpdf-page-set-height page 500)
    
    (set! dst (hpdf-page-create-destination page))
    (hpdf-destination-set-xyz dst 0 (hpdf-page-get-height page) 1)
    (hpdf-set-open-action pdf dst)

    (hpdf-page-begin-text page)
    (hpdf-page-set-font-and-size page font 20)
    (hpdf-page-move-text-pos page 220 (- (hpdf-page-get-height page) 70))
    (hpdf-page-show-text page "ImageDemo")
    (hpdf-page-end-text page)
    
    (set! image (load-png pdf "basn3p02"))
    (set! image1 (load-png pdf "basn3p02"))
    (set! image2 (load-png pdf "basn0g01"))
    ;; maskimage
    (set! image3 (load-png pdf "maskimage"))

    (set! iw (hpdf-image-get-width image))
    (set! ih (hpdf-image-get-height image))

    (hpdf-page-set-line-width page 0.5)

    (set! x 100)
    (set! y (- (hpdf-page-get-height page) 150))
      
    (hpdf-page-draw-image page image x y iw ih)

    (show-description page x y "Actual Size")

    ;; Scalling image (X direction)
    (set! x (+ x 150))
    
    (hpdf-page-draw-image page image x y (* iw 1.5) ih)
    (show-description page x y "Scalling image (X direction)")

    (set! x (+ x 150))

    ;; Scalling image (Y direction)
    (hpdf-page-draw-image page image x y iw (* ih 1.5))
    (show-description page x y "Scalling image (Y direction)")

    (set! x 100)
    (set! y (- y 120))
    
    ;; Skewing image
    (let* ([angle1 10]
	   [angle2 20]
	   [rad1 (* (/ angle1 180) 3.141592)]
	   [rad2 (* (/ angle2 180) 3.141592)])
      (hpdf-page-gsave page)
      (hpdf-page-concat page iw (* (tan rad1) iw) (* (tan rad2) ih) ih x y)

      (hpdf-page-execute-xobject page image)
      (hpdf-page-grestore page)
      (show-description page x y "Skewing image"))

    (set! x (+ x 150))

    ;; Rotating image
    (let* ([angle 30]
	   [rad (* (/ angle 180) 3.141592)])
      (hpdf-page-gsave page)
      (hpdf-page-concat page (* iw (cos rad)) (* iw (sin rad))
			(* ih (- (sin rad)))
			(* ih (cos rad)) x y)

      (hpdf-page-execute-xobject page image)
      (hpdf-page-grestore page)
      (show-description page x y "Rotating image"))

    (set! x (+ x 150))

    ;; Set image2 to the mask image of image1
    (hpdf-image-set-mask-image image1 image2)

    (hpdf-page-set-rgb-fill page 0 0 0)
    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page (- x 6) (+ y 14))
    (hpdf-page-show-text page "MASKMASK")
    (hpdf-page-end-text page)

    (hpdf-page-draw-image page image1 (- x 3) (- y 3) (+ iw 6) (+ ih 6))
    (show-description page x y "masked image")    

    (set! x 100)
    (set! y (- y 120))

    (hpdf-page-set-rgb-fill page 0 0 0)
    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page (- x 6) (+ y 14))
    (hpdf-page-show-text page "MASKMASK")
    (hpdf-page-end-text page)

    (hpdf-image-set-color-mask image3 0 255 0 0 0 255)
    (hpdf-page-draw-image page image3 x y iw ih)
    (show-description page x y "Color Mask")

    (hpdf-save-to-file pdf "test/image-demo.pdf")
    (hpdf-free pdf)
    ))