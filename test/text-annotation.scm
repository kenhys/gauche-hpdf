

(use gauche.sequence)
(use gauche.interactive)
(use hpdf)

(define (main args)
  (let* ([rect1 (make-rect 50 350 150 400)]
	 [rect2 (make-rect 210 350 350 400)]
	 [rect3 (make-rect 50 250 150 300)]
	 [rect4 (make-rect 210 250 350 300)]
	 [rect5 (make-rect 50 150 150 200)]
	 [rect6 (make-rect 210 150 350 200)]
	 [rect7 (make-rect 50 50 150 100)]
	 [rect8 (make-rect 210 50 350 100)]
	 [pdf (hpdf-new)]
	 [page (hpdf-add-page pdf)]
	 [font (hpdf-get-font pdf "Times-Roman" "WinAnsiEncoding")]
	 [annot 0]
	 [filename (if (rxmatch #/.*test\/.*\.scm$/ *program-name*)
		       "test/text-annotation.pdf" "text-annotation.pdf")])
    
    (width! page 400)
    (height! page 500)

    (begin-text page)
    (font-and-size! page font 16)
    (move-text-pos page 130 450)
    (show-text page "Annotation Demo")
    (end-text page)

    (set! annot (hpdf-page-create-text-annot
		 page rect1 "Annotation with Comment Icon. \n This annotation set to be opened initially."))

    
    (text-annot-icon! annot HPDF_ANNOT_ICON_COMMENT)
    (text-annot-opened! annot HPDF_TRUE)

    ;; rect2 .. rect7
    (map (^ (entry)
	   (let* ([rect (~ entry 0)]
		  [text (~ entry 1)]
		  [icon (~ entry 2)]
		  [annot 0]
		  [encoding 0])
	     (set! annot (create-text-annot page rect text #f))
	     (text-annot-icon! annot icon)))
	 `((,rect2 "Annotation with Key Icon" ,HPDF_ANNOT_ICON_PARAGRAPH)
	   (,rect3 "Annotation with Note Icon" ,HPDF_ANNOT_ICON_NOTE)
	   (,rect4 "Annotation with Help Icon" ,HPDF_ANNOT_ICON_HELP)
	   (,rect5 "newparagraph icon." ,HPDF_ANNOT_ICON_NEW_PARAGRAPH)
	   (,rect6 "paragraph icon." ,HPDF_ANNOT_ICON_PARAGRAPH)
	   (,rect7 "insert icon." ,HPDF_ANNOT_ICON_INSERT)))

    ;; (set! encoding (hpdf-get-encoder pdf "ISO8859-2"))
    ;; (d encoding)
    ;; (create-text-annot (page rect8
    ;; 			     "annotation with iso8859 text ﾓﾔﾕﾖﾗﾘﾙ" encoding))

    (font-and-size! page font 11)

    (map (^ (entry)
	   (let* ([rect (~ entry 0)]
		  [comment (~ entry 1)])
	     (begin-text page)
	     (move-text-pos page (+ (~ rect 'left) 35) (- (~ rect 'top) 20))
	     (show-text page comment)
	     (end-text page)))
	 `((,rect1 "Comment Icon")
	   (,rect2 "Key Icon")
	   (,rect3 "Note Icon")
	   (,rect4 "Help Icon")
	   (,rect5 "NewParagraph Icon")
	   (,rect6 "Paragraph Icon")
	   (,rect7 "Insert Icon")
	   (,rect8 "Text Icon(ISO8859-2 text)")
	   ))

    ;; save the document to a file 
    (save-to-file pdf filename)
    
    ;; clean up 
    (free pdf)))
    