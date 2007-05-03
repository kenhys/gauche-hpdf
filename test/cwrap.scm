(use c-wrapper)
(use gauche.interactive)

(c-load "/home/khayashi/include/hpdf.h" :libs "-L/home/khayashi/lib -lhpdf")
(define pdf (HPDF_New (lambda (a b c)) (make <HPDF_Doc>)))
(define page (HPDF_AddPage pdf))
(apropos 'HPDF)

