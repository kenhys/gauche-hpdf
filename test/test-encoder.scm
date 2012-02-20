


(use gauche.interactive)
(use gauche.test)

(use hpdf)

(test-record-file "test.record")
(test-start "encoder")

(define encodes
  '(("FontSpecific")
    ("StandardEncoding")
    ("MacRomanEncoding")
    ("WinAnsiEncoding")
    ("ISO8859-2")
    ("ISO8859-3")
    ("ISO8859-4")
    ("ISO8859-5")
    ("ISO8859-6")
    ("ISO8859-7")
    ("ISO8859-8")
    ("ISO8859-9")
    ("ISO8859-10")
    ("ISO8859-11")
    ("ISO8859-13")
    ("ISO8859-14")
    ("ISO8859-15")
    ("ISO8859-16")
    ("CP1250")
    ("CP1251")
    ("CP1252")
    ("CP1253")
    ("CP1254")
    ("CP1255")
    ("CP1256")
    ("CP1257")
    ("CP1258")
    ("KOI8-R")))

;;
;; hpdf-get-encoder
;;
(test-section "hpdf-get-encoder")

(define (mktest enc)
  (let* ([pdf (hpdf-new)]
	 [encoder (hpdf-get-encoder pdf enc)])
    (test* (format #f "encoder ~a" enc) <hpdf-encoder> (class-of encoder))))

(map (^ (entry)
       (mktest (~ entry 0))) encodes)

;;
;; hpdf-encoder-get-type
;;
(test-section "hpdf-encoder-get-type")

(define (mktest enc)
  (let* ([pdf (hpdf-new)]
	 [encoder (hpdf-get-encoder pdf enc)])
    (hpdf-use-utf-encodings pdf)
    ;;(hpdf-use-jp-encodings pdf)
    (test* (format #f "encoder(~a) get type" enc) 0
	   (hpdf-encoder-get-type encoder))))

(map (^ (entry)
       (mktest (~ entry 0))) encodes)


(test-end)