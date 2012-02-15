

(use gauche.charconv)
(use gauche.sequence)
(use gauche.collection)
(use gauche.interactive)
(use hpdf)

(define def-font
  '(("Courier")
    ("Courier-Bold")
    ("Courier-Oblique")
    ("Courier-BoldOblique")
    ("Helvetica")
    ("Helvetica-Bold")
    ("Helvetica-Oblique")
    ("Helvetica-BoldOblique")
    ("Times-Roman")
    ("Times-Bold")
    ("Times-Italic")
    ("Times-BoldItalic")
    ("Symbol")
    ("ZapfDingbats")))

(let* ([pdf (hpdf-new)]
       [page (hpdf-add-page pdf)]
       [height (hpdf-page-get-height page)]
       [width (hpdf-page-get-width page)]
       [fname "test/font-demo.pdf"]
       [def_font 0]
       [tw 0]
       [page_title "Font Demo"])
  
  ;;
  (hpdf-page-set-line-width page 1)
  (hpdf-page-rectangle page 50 50 (- width 100) (- height 110))
  (hpdf-page-stroke page)

  (set! def_font (hpdf-get-font pdf "Helvetica" ""))

  ;;(hpdf-page-set-text-rendering-mode page HPDF_FILL)

  (hpdf-page-set-font-and-size page def_font 24)

  (set! tw (hpdf-page-text-width page "Font Demo"))
  (hpdf-page-begin-text page)
  (hpdf-page-textout page (/ (- width tw) 2) (- height 50) page_title)
  (hpdf-page-end-text page)

  (hpdf-page-begin-text page)
  (hpdf-page-set-font-and-size page def_font 16)
  (hpdf-page-textout page 60 (- height 80) "<Standard Type1 fonts samples>")
  (hpdf-page-end-text page)

  (hpdf-page-begin-text page)
  (hpdf-page-move-text-pos page 60 (- height 105))

  (map (^ (entry)
	 (let* ([name (~ entry 0)]
		[font (hpdf-get-font pdf name "")])

	   (hpdf-page-set-font-and-size page def_font 9)
	   (hpdf-page-show-text page name)
	   (hpdf-page-move-text-pos page 0 -18)

	   (hpdf-page-set-font-and-size page font 20)
	  (hpdf-page-show-text page "abcdefgABCDEFG12345!#$%&+-@?")
	  (hpdf-page-move-text-pos page 0 -20))) def-font)
	 
  (hpdf-page-end-text page)

  (hpdf-save-to-file pdf fname)

  (hpdf-free pdf))
