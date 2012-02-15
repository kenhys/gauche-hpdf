
(use gauche.sequence)
(use hpdf)

(define text "This PDF should have an attachment named attach.scm")

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (hpdf-add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" "")]
	 [tw 0])
    (hpdf-page-set-size page HPDF_PAGE_SIZE_LETTER HPDF_PAGE_PORTRAIT)

    (hpdf-page-begin-text page)
    (hpdf-page-set-font-and-size page font 20)
    (set! tw (hpdf-page-text-width page text))
    
    (hpdf-page-move-text-pos page (/ (- (hpdf-page-get-width page) tw) 2)
			     (/ (- (hpdf-page-get-height page) 20) 2))
    (hpdf-page-show-text page text)
    (hpdf-page-end-text page)

    (hpdf-attach-file pdf "test/attach.scm")

    (hpdf-save-to-file pdf "test/attach.pdf")

    (hpdf-free pdf)
    ))