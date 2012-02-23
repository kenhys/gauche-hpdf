
(use gauche.sequence)
(use gauche.collection)
(use hpdf)

(define text "This is an encrypt document example")
(define owner_passwd "owner")
(define user_passwd "user")

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (add-page pdf)]
	 [font (font pdf "Helvetica" #f)]
	 [tw 0]
	 [filename (if (rxmatch #/.*examples\/.*\.scm$/ *program-name*)
		       "examples/encryption.pdf" "encryption.pdf")])
    (size! page HPDF_PAGE_SIZE_B5 HPDF_PAGE_LANDSCAPE)
    
    (begin-text page)
    (font-and-size! page font 20)
    (set! tw (text-width page text))
    (move-text-pos page (/ (- (width page) tw) 2)
			     (/ (- (height  page) 20) 2))

    (show-text page text)
    (end-text page)

    (password! pdf owner_passwd user_passwd)

    (save-to-file pdf filename)
    (free pdf)))
