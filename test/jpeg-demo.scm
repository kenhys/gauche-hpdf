;; -*- mode:scheme; coding: utf-8 -*-

(use gauche.sequence)
(use gauche.interactive)
(use gauche.collection)
(use file.util)
(use hpdf)



(define (draw-image-proc pdf filename x y text)
  (let* ([prefix (if (rxmatch #/.*test\/.*\.scm$/ *program-name*) "test" ".")]
	 [page (current-page pdf)]
	 [filename1 (format #f "~a/images/~a" prefix filename)]
	 [image 0])

    (if (file-is-readable? filename1)
	(begin
	  (set! image (hpdf-load-jpeg-image-from-file pdf filename1))
	  (draw-image page image x y
		      (hpdf-image-get-width image)
		      (hpdf-image-get-height image))

	  (begin-text page)
	  (text-leading! page 16)
	  (move-text-pos page x y)
	  (show-text-next-line page filename)
	  (show-text-next-line page text)
	  (end-text page)))))

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [font (hpdf-get-font pdf "Helvetica" "")]
	 [page (add-page pdf)]
	 [dst 0]
	 [filename (if (rxmatch #/.*test\/.*\.scm$/ *program-name*)
		       "test/jpeg-demo.pdf" "jpeg-demo.pdf")])
    
    (compression-mode! pdf HPDF_COMP_ALL)
    
    (width! page 650)
    (height! page 500)

    (set! dst (create-destination page))
    (destination-xyz! dst 0 (height page) 1)
    (open-action! pdf dst)
    
    (begin-text page)
    (font-and-size! page font 20)
    (move-text-pos page 220 (- (height page) 70))
    (show-text page "JpegDemo")
    (end-text page)
    
    (font-and-size! page font 12)

    (draw-image-proc pdf "rgb.jpg" 70 (- (height page) 410)
		     "24bit color image")
    
    (draw-image-proc pdf "gray.jpg" 340 (- (height page) 410)
		     "8bit grayscale image")

    (save-to-file pdf filename)

    (free pdf)))


