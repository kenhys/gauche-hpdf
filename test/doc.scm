;;;
;;; Test hpdf
;;;

(use gauche.test)

(test-start "hpdf")
(use hpdf)
(test-module 'hpdf)

(define (test-subsection msg)
  (format #t "~a()\n" msg))

(test-section "hpdf doc")
(test-subsection "hpdf-set-info-attr")

(test* "HPDF_INFO_AUTHOR" HPDF_OK (hpdf-set-info-attr (hpdf-new) AUTHOR "author"))
(test* "HPDF_INFO_CREATOR" HPDF_OK (hpdf-set-info-attr (hpdf-new) CREATOR "creator"))
(test* "HPDF_INFO_TITLE" HPDF_OK (hpdf-set-info-attr (hpdf-new) TITLE "title"))
(test* "HPDF_INFO_SUBJECT" HPDF_OK (hpdf-set-info-attr (hpdf-new) SUBJECT "subject"))
(test* "HPDF_INFO_KEYWORDS" HPDF_OK (hpdf-set-info-attr (hpdf-new) KEYWORDS "keywords"))

(define (test-hpdf-get-info-attr key expect)
  (let* ((pdf (hpdf-new))
         (st (cond ((= key HPDF_INFO_CREATION_DATE)
                    #t)
                   ((= key HPDF_INFO_MOD_DATE)
                    #t)
                   (else
                    (hpdf-set-info-attr pdf key expect))))
         )
    (hpdf-get-info-attr pdf key)))

(test-subsection "hpdf-get-info-attr")
;; (test* "HPDF_INFO_CREATION_DATE" "author" (test-hpdf-get-info-attr HPDF_INFO_CREATION_DATE "hoge"))
;; (test* "HPDF_INFO_MOD_DATE" HPDF_OK (test-hpdf-get-info-attr HPDF_INFO_MOD_DATE "hoge"))
(test* "HPDF_INFO_AUTHOR" "author" (test-hpdf-get-info-attr AUTHOR "author"))
(test* "HPDF_INFO_CREATOR" "creator" (test-hpdf-get-info-attr CREATOR "creator"))
(test* "HPDF_INFO_TITLE" "title" (test-hpdf-get-info-attr TITLE "title"))
(test* "HPDF_INFO_SUBJECT" "subject" (test-hpdf-get-info-attr SUBJECT "subject"))
(test* "HPDF_INFO_KEYWORDS" "keywords" (test-hpdf-get-info-attr KEYWORDS "keywords"))

;; epilogue
(test-end)





