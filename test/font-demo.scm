

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
       [page (add-page pdf)]
       [height (height page)]
       [width (width page)]
       [fname "test/font-demo.pdf"]
       [def_font 0]
       [tw 0]
       [page_title "Font Demo"])
  
  ;;
  (line-width! page 1)
  (rectangle page 50 50 (- width 100) (- height 110))
  (stroke page)

  (set! def_font (hpdf-get-font pdf "Helvetica" ""))

  ;;(hpdf-page-set-text-rendering-mode page HPDF_FILL)

  (font-and-size! page def_font 24)

  (set! tw (text-width page "Font Demo"))
  (begin-text page)
  (textout page (/ (- width tw) 2) (- height 50) page_title)
  (end-text page)

  (begin-text page)
  (font-and-size! page def_font 16)
  (textout page 60 (- height 80) "<Standard Type1 fonts samples>")
  (end-text page)

  (begin-text page)
  (move-text-pos page 60 (- height 105))

  (map (^ (entry)
	 (let* ([name (~ entry 0)]
		[font (hpdf-get-font pdf name "")])

	   (font-and-size! page def_font 9)
	   (show-text page name)
	   (move-text-pos page 0 -18)

	   (font-and-size! page font 20)
	  (show-text page "abcdefgABCDEFG12345!#$%&+-@?")
	  (move-text-pos page 0 -20))) def-font)
	 
  (end-text page)

  (save-to-file pdf fname)

  (free pdf))
