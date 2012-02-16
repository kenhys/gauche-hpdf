

(use gauche.sequence)
(use gauche.interactive)
(use hpdf)

(define (main args)
  (let* ([rect1 (make-rect 50 350 150 400)]
	 [pdf (hpdf-new)]
	 [page (hpdf-add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" "")]
	 [annot 0])
    
    (hpdf-page-set-width page 400)
    (hpdf-page-set-height page 500)

    (hpdf-page-begin-text page)
    (hpdf-page-set-font-and-size page font 16)
    (hpdf-page-move-text-pos page 130 450)
    (hpdf-page-show-text page "Annotation Demo")
    (hpdf-page-end-text page)

    (set! annot (hpdf-page-create-text-annot
		 page rect1 "Annotation with Comment Icon. \n This annotation set to be opened initially." (make <hpdf-encoder>)))

    
    (hpdf-text-annot-set-icon annot HPDF_ANNOT_ICON_COMMENT)
    (hpdf-text-annot-set-opened annot  HPDF_TRUE)

    ;; (set! annot (hpdf-page-createtext-annot
    ;; 		 page rect2
    ;; 		 "annotation with key icon" null))
    ;; (hpdf-text-annot-set-icon annot HPDF_ANNOT_ICON_PARAGRAPH)

    ;; (set! annot  (hpdf-page-createtext-annot 
    ;; 		  page rect3
    ;; 		  "annotation with note icon" null))
    ;; (hpdf-text-annot-set-icon annot  HPDF_ANNOT_ICON_NOTE)

    ;; (set! annot  (hpdf-page-createtext-annot
    ;; 		  page rect4
    ;; 		  "annotation with help icon" null))
    ;; (hpdf-text-annot-set-icon annot  HPDF_ANNOT_ICON_HELP)

    ;; (set! annot (hpdf-page-createtext-annot
    ;; 		 page rect5
    ;; 		 "annotation with newparagraph icon" null))
    ;; (hpdf-text-annot-set-icon annot  HPDF_ANNOT_ICON_NEW_PARAGRAPH)

    ;; (set! annot  (hpdf-page-createtext-annot (page rect6
    ;;             "annotation with paragraph icon" null)
    ;; (hpdf-text-annot-set-icon annot  (hpdf-annot-icon-paragraph)

    ;; (set! annot  (hpdf-page-createtext-annot (page rect7
    ;;             "annotation with insert icon" null)
    ;; (hpdf-text-annot-set-icon annot  (hpdf-annot-icon-insert)

    ;; encoding = (hpdf-getencoder (pdf "iso8859-2")

    ;; (hpdf-page-createtext-annot (page rect8
    ;;             "annotation with iso8859 text ﾓﾔﾕﾖﾗﾘﾙ" encoding)

    (hpdf-page-set-font-and-size page font 11)

    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page rect1.left + 35 rect1.top - 20)
    (hpdf-page-show-text page "comment icon.")
    (hpdf-page-end-text page)

    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page rect2.left + 35 rect2.top - 20)
    (hpdf-page-show-text page "key icon")
    (hpdf-page-end-text page)

    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page rect3.left + 35 rect3.top - 20)
    (hpdf-page-show-text page "note icon.")
    (hpdf-page-end-text page)

    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page rect4.left + 35 rect4.top - 20)
    (hpdf-page-show-text page "help icon")
    (hpdf-page-end-text page)

    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page rect5.left + 35 rect5.top - 20)
    (hpdf-page-show-text page "newparagraph icon")
    (hpdf-page-end-text page)

    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page rect6.left + 35 rect6.top - 20)
    (hpdf-page-show-text page "paragraph icon")
    (hpdf-page-end-text page)

    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page (+ (~ rect7 'left) 35)
			     (- (~ rect7 'top) 20))
    (hpdf-page-show-text page "insert icon")
    (hpdf-page-end-text page)

    (hpdf-page-begin-text page)
    (hpdf-page-move-text-pos page (+ (~ rect8 'left) 35)
			     (- (~ rect8 'top) 20))
    (hpdf-page-show-text page "text icon(iso8859-2 text)")
    (hpdf-page-end-text page)


    ;; save the document to a file 
    (hpdf-save-to-file pdf fname)

    ;; clean up 
    (hpdf-free pdf)

    ))
    