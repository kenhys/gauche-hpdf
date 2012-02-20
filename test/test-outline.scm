;;;
;;; Test hpdf
;;;

(use gauche.test)
(use math.mt-random)
(use gauche.sequence)
(use gauche.collection)
(use gauche.interactive)
(use hpdf)

(test-record-file "test.record")

(test-module 'hpdf)

(test-start "outline")

(test-section "hpdf-create-outline")

(test-section "hpdf-outline-set-opened")

(test-section "hpdf-outline-set-destination")

(test-end)
