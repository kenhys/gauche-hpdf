
(use gauche.sequence)
(use gauche.collection)
(use gauche.interactive)
(use hpdf)

(define text "User cannot print and copy this document.")
(define owner_passwd "owner")
(define user_passwd "")

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" #f)]
	 [tw 0]
	 [filename (if (rxmatch #/.*examples\/.+\.scm$/ *program-name*)
		       "examples/permission.pdf" "permission.pdf")])
    (size! page HPDF_PAGE_SIZE_B5 HPDF_PAGE_LANDSCAPE)
    
    (begin-text page)
    (font-and-size! page font 20)
    (set! tw (text-width page text))
    (move-text-pos page (/ (- (width page) tw) 2)
			     (/ (- (height page) 20) 2))
    (show-text page text)
    (end-text page)
    
    (password! pdf owner_passwd user_passwd)
    (permission! pdf HPDF_ENABLE_READ)
    (encryption-mode! pdf HPDF_ENCRYPT_R3 16)

    (save-to-file pdf filename)

    (free pdf)))
