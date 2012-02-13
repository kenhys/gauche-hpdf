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
(test-start "page")

(define (test-subsection msg)
  (format #t "~a()\n" msg))
(define (test-subsubsection msg)
  (format #t "#=> ~a\n" msg))

(test-section "hpdf font")

;;
;; portrait
;; 

(define page-size
  `(("letter" ,HPDF_PAGE_SIZE_LETTER 612 792)
    ("legal" ,HPDF_PAGE_SIZE_LEGAL 612 1008)
    ("a3" ,HPDF_PAGE_SIZE_A3 841.8900146484375 1199.551025390625)
    ("a4" ,HPDF_PAGE_SIZE_A4 595.2760009765625 841.8900146484375)
    ("a5" ,HPDF_PAGE_SIZE_A5 419.52801513671875 595.2760009765625)
    ("executive" ,HPDF_PAGE_SIZE_EXECUTIVE 522 756)
    ("b4" ,HPDF_PAGE_SIZE_B4 708.6610107421875 1000.6300048828125)
    ("b5" ,HPDF_PAGE_SIZE_B5 498.89801025390625 708.6610107421875)
    ("us4x6" ,HPDF_PAGE_SIZE_US4x6 288 432)
    ("us4x8" ,HPDF_PAGE_SIZE_US4x8 288 576)
    ("us5x7" ,HPDF_PAGE_SIZE_US5x7 360 504)
    ("comm10" ,HPDF_PAGE_SIZE_COMM10 297 684)
    ))

;;
;; hpdf-page-set-size
;;
(test-subsection "hpdf-page-set-size")

(define (mktest name size direction)
  (let* ([pdf (hpdf-new)]
	 [page (hpdf-add-page pdf)]
	 [dir (if (= direction HPDF_PAGE_PORTRAIT) "portrait" "landscape")]
	 [filename (format #f "test/data/page-set-size-~a-~a.pdf" dir name)]
	 [msg (format #f "~a ~a size" dir name)])
    (test* msg HPDF_OK (hpdf-page-set-size page size direction))
    (hpdf-save-to-file pdf filename)))

;; portrait
(test-subsubsection "portrait")
(map (^ (arg)
       (mktest (~ arg 0) (~ arg 1) HPDF_PAGE_PORTRAIT)) page-size)

;; landscape
(test-subsubsection "landscape")
(map (^ (arg)
       (mktest (~ arg 0) (~ arg 1) HPDF_PAGE_LANDSCAPE)) page-size)


;;
;; hpdf-page-get-width/height
;;
(test-subsection "hpdf-page-get-width/height")

(define (mktest page_style page_direction width height)
  (let* ([page (hpdf-add-page (hpdf-new))]
	 [null (d page)]
	 [s (hpdf-page-set-size page page_style page_direction)]
         [null (d s)]
	 [w (hpdf-page-get-width page)]
         [null (d w)]
	 [h (hpdf-page-get-height page)]
         [null (d h)]
	 )
    (if (and (= width w) (= height h))
        #t
        #f)))
;; (map (^ (arg)
;;        (mktest (~ arg 1) HPDF_PAGE_LANDSCAPE (~ arg 2) (~ arg 3))) page-size)

;; (map (^ (arg)
;;        (mktest (~ arg 1) HPDF_PAGE_PORTRAIT (~ arg 3) (~ arg 2))) page-size)


(define (test-hpdf-page-set-height height)
  (let* ((page (hpdf-add-page (hpdf-new))))
    (hpdf-page-set-height page height)))

;;
;; hpdf-page-set-width/height
;;
(test-subsection "hpdf-page-set-width/height")

(define (mktest expect width)
  (let* ([page (hpdf-add-page (hpdf-new))]
	 [msg (cond ((< width 3) (format #f "page width(~D) under 3" width))
		    ((> width 14400) (format #f "page width(~D) over 14400" width))
		    (else (format #f "page width(~D) between 3 and 14400" width)))]
	 )
    (test* msg expect (hpdf-page-set-width page width))))


(map (^ (width) (mktest *test-error* width))
     '(0 1 2 14401))

(map (^ (width) (mktest HPDF_OK width))
     '(3 4 14399 14400))


;; error
;; (test* "-1" *test-error* (hpdf-page-set-size (hpdf-add-page (hpdf-new)) -1 HPDF_PAGE_PORTRAIT))
;; (test* "HPDF_PAGE_SIZE_EOF" *test-error* (hpdf-page-set-size (hpdf-add-page (hpdf-new)) HPDF_PAGE_SIZE_EOF HPDF_PAGE_PORTRAIT))
;; (define (test-page-content pdf m page)
;;   (let* ((font (hpdf-get-font pdf "Helvetica" ""))
;;          (h (hpdf-page-get-height page))
;;          (w (hpdf-page-get-width page))
;;          (s (hpdf-page-begin-text page))
;;          (i (round (/ w 2)))
;;          (st (hpdf-page-move-text-pos page (mt-random-integer m 290) (- h 36)))
;;          (s (hpdf-page-set-font-and-size page font 24))
;;          (s (hpdf-page-set-text-leading page 24))
;;          (s (hpdf-page-show-text page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-show-text-next-line page "Hello, I'm Robot."))
;;          (s (hpdf-page-end-text page))
;;          )
;;     page))
  
;; (define (test-hpdf-page-set-slide-show file slide)
;;   (let* ((pdf (hpdf-new))
;;          (disp 3)
;;          (trans 5)
;;          (m (make <mersenne-twister> :seed (sys-time)))
;;          (s (if (equal? slide #t)
;;                 (begin0
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_WIPE_RIGHT disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_WIPE_UP disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_WIPE_LEFT disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_WIPE_DOWN disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_BARN_DOORS_HORIZONTAL_OUT disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_BARN_DOORS_HORIZONTAL_IN disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_BARN_DOORS_VERTICAL_OUT disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_BARN_DOORS_VERTICAL_IN disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_BOX_OUT disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_BOX_IN disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_BLINDS_HORIZONTAL disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_BLINDS_VERTICAL disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_DISSOLVE disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_GLITTER_RIGHT disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_GLITTER_DOWN disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT                                          disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) HPDF_TS_REPLACE disp trans)
;;                  (hpdf-save-to-file pdf file)
;;                  )
;;                 (begin0
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) slide disp trans)
;;                  (hpdf-page-set-slide-show (test-page-content pdf m (hpdf-add-page pdf)) slide disp trans)
;;                  (hpdf-save-to-file pdf file)
;;                  )
;;                 )))
;;     s))

;;
;; hpdf-page-set-slide-show
;; 
(define slide-show
  `(("HPDF_TS_WIPE_RIGHT" ,HPDF_TS_WIPE_RIGHT "wipe-right")
    ("HPDF_TS_WIPE_UP" ,HPDF_TS_WIPE_UP "wipe-up")
    ("HPDF_TS_WIPE_LEFT" ,HPDF_TS_WIPE_LEFT "wipe-left")
    ("HPDF_TS_WIPE_DOWN" ,HPDF_TS_WIPE_DOWN "wipe-down")
    ("HPDF_TS_BARN_DOORS_HORIZONTAL_IN" ,HPDF_TS_BARN_DOORS_HORIZONTAL_IN "h-in")
    ("HPDF_TS_BARN_DOORS_HORIZONTAL_OUT" ,HPDF_TS_BARN_DOORS_HORIZONTAL_OUT "h-out")
    ("HPDF_TS_BARN_DOORS_VERTICAL_IN" ,HPDF_TS_BARN_DOORS_VERTICAL_IN "v-in")
    ("HPDF_TS_BARN_DOORS_VERTICAL_OUT" ,HPDF_TS_BARN_DOORS_VERTICAL_OUT "v-out")
    ("HPDF_TS_BOX_OUT" ,HPDF_TS_BOX_OUT "box-out")
    ("HPDF_TS_BOX_IN" ,HPDF_TS_BOX_IN "box-in")
    ("HPDF_TS_BLINDS_HORIZONTAL" ,HPDF_TS_BLINDS_HORIZONTAL "blinds-h")
    ("HPDF_TS_BLINDS_VERTICAL" ,HPDF_TS_BLINDS_VERTICAL "blinds-v")
    ("HPDF_TS_DISSOLVE" ,HPDF_TS_DISSOLVE "dissolve")
    ("HPDF_TS_GLITTER_RIGHT" ,HPDF_TS_GLITTER_RIGHT "g-right")
    ("HPDF_TS_GLITTER_DOWN" ,HPDF_TS_GLITTER_DOWN "g-down")
    ("HPDF_TS_GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT" ,HPDF_TS_GLITTER_TOP_LEFT_TO_BOTTOM_RIGHT "g-tl2br")
    ("HPDF_TS_REPLACE" ,HPDF_TS_REPLACE "replace")
    ))

(define (mktest name effect sname)
  (let* ([pdf (hpdf-new)]
	 [s (hpdf-use-jp-fonts pdf)]
	 [disp 3]
	 [trans 10]
	 [page (hpdf-add-page pdf)]
	 [font (hpdf-get-font pdf "Helvetica" "")]
         [s (hpdf-page-set-font-and-size page font 24)]
	 [s (hpdf-page-set-text-leading page 24)]
	 [filename (format #f "test/data/hpdf-page-set-slide-show-~a.pdf" sname)])

    (hpdf-page-set-slide-show page effect disp trans)
    (hpdf-page-begin-text page)
    (dotimes (n 20)
      (hpdf-page-show-text-next-line page name))
    (hpdf-page-end-text page)

    (set! page (hpdf-add-page pdf))
    (hpdf-page-set-slide-show page effect disp trans)
    (hpdf-page-begin-text page)
    (dotimes (n 20)
      (hpdf-page-show-text-next-line page name))
    (hpdf-page-end-text page)

    (hpdf-save-to-file pdf filename)))
	 
(map (^ (entry)
       (mktest (~ entry 0) (~ entry 1) (~ entry 2))) slide-show)

;; epilogue
(test-end)





