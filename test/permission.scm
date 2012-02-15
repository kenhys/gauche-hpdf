
(use gauche.sequence)
(use gauche.collection)
(use gauche.interactive)
(use hpdf)

(define text "User cannot print and copy this document.")
(define owner_passwd "owner")
(define user_passwd "")

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
			     (/ (- (hpdf-page-get-height page) 20 2)))
    (hpdf-page-show-text page text)
    (hpdf-page-end-text page)
    
    (hpdf-set-password pdf owner_passwd user_passwd)
    (hpdf-set-permission pdf HPDF_ENABLE_READ)
    (hpdf-set-encryption-mode pdf HPDF_ENCRYPT_R3 16)

    (hpdf-save-to-file pdf "test/permission.pdf")

    (hpdf-free pdf)
    ))