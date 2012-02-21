;; -*- mode:scheme; coding: utf-8 -*-



(use gauche.interactive)
(use hpdf)

(define fonts
  '(("MS-Mincyo" "90ms-RKSJ-H")
    ("MS-Mincyo,Bold" "90ms-RKSJ-H")
    ("MS-Mincyo,Italic" "90ms-RKSJ-H")
    ("MS-Mincyo,BoldItalic" "90ms-RKSJ-H")
    ("MS-PMincyo" "90ms-RKSJ-H")
    ("MS-PMincyo,Bold" "90ms-RKSJ-H")
    ("MS-PMincyo,Italic" "90ms-RKSJ-H")
    ("MS-PMincyo,BoldItalic" "90ms-RKSJ-H")
    ("MS-Gothic" "90ms-RKSJ-H")
    ("MS-Gothic,Bold" "90ms-RKSJ-H")
    ("MS-Gothic,Italic" "90ms-RKSJ-H")
    ("MS-Gothic,BoldItalic" "90ms-RKSJ-H")
    ("MS-PGothic" "90ms-RKSJ-H")
    ("MS-PGothic,Bold" "90ms-RKSJ-H")
    ("MS-PGothic,Italic" "90ms-RKSJ-H")
    ("MS-PGothic,BoldItalic" "90ms-RKSJ-H")))
    
(define (main args)
  (let* ([pdf (hpdf-new)]
	 [prefix (if 
		  (rxmatch #/.*test\/.*\.scm$/ *program-name*) "test" ".")]
	 [filename (format #f "~a/jpfont-demo.pdf" prefix)]
	 [root 0])
    
    (compression-mode! pdf HPDF_COMP_ALL)
    
    (use-jp-encodings pdf)
    (use-jp-fonts pdf)
    
    (page-mode! pdf HPDF_PAGE_MODE_USE_OUTLINE)

    (set! root (create-outline pdf #f "JP font demo" #f))
    (outline-opened! root HPDF_TRUE)

    (save-to-file pdf filename)
    
    (map (^ (entry)
	   (let* ([face (~ entry 0)]
		  [enc (~ entry 1)])
	     (d face)
	     (d enc)
	     )) fonts)
    
    (free pdf)))
    
    

