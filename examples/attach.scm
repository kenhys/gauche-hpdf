
(use gauche.sequence)
(use hpdf)


(define text "This PDF should have an attachment named attach.scm")

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" #f)]
	 [tw 0]
	 [prefix (if (rxmatch #/.*examples\/.*\.scm/ *program-name*) "examples"".")]
	 [scmname (format #f "~a/attach.scm" prefix)]
	 [filename (format #f "~a/attach.pdf" prefix)])
    (size! page HPDF_PAGE_SIZE_LETTER HPDF_PAGE_PORTRAIT)

    (begin-text page)
    (font-and-size! page font 20)
    (set! tw (text-width page text))
    
    (move-text-pos page (/ (- (width page) tw) 2)
			     (/ (- (height page) 20) 2))
    (show-text page text)
    (end-text page)

    (attach-file pdf scmname)

    (save-to-file pdf filename)

    (free pdf)))
