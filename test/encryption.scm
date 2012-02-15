
(use gauche.sequence)
(use gauche.collection)
(use hpdf)

(define text "This is an encrypt document example")
(define owner_passwd "owner")
(define user_passwd "user")

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [page (hpdf-add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" "")]
	 [tw 0])
    (hpdf-page-set-size page HPDF_PAGE_SIZE_B5 HPDF_PAGE_LANDSCAPE)
    
    (hpdf-page-begin-text page)
    (hpdf-page-set-font-and-size page font 20)
    (set! tw (hpdf-page-text-width page text))

    (hpdf-page-move-text-pos page (/ (- (hpdf-page-get-width page) tw) 2)
			     (/ (- (hpdf-page-get-height  page) 20 2)))

    (hpdf-page-show-text page text)
    (hpdf-page-end-text page)

    (hpdf-set-password pdf owner_passwd user_passwd)

    (hpdf-save-to-file pdf "test/encryption.pdf")
    (hpdf-free pdf)))
