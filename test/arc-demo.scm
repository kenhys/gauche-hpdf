
(use gauche.sequence)
(use gauche.interactive)
(use gauche.collection)
(use hpdf)

(define (print-grid 
	 pdf::<hpdf-doc> page::<hpdf-page>)
  (let* ([height (hpdf-page-get-height page)]
	 [width (hpdf-page-get-width page)]
	 [font (hpdf-get-font pdf "Helvetica" "")]
	 [x 0]
	 [y 0])
    
    (hpdf-page-set-font-and-size page font 5)
    (hpdf-page-set-gray-fill page 0.5)
    (hpdf-page-set-gray-stroke page 0.8)

    ;; Draw horizontal lines 
    (while (y < height) 
      (if (== (% y 10) 0)
	  (hpdf-page-set-line-width page 0.5)
	  (if (!= (hpdf-page-get-line-width page) 0.25)
	      (hpdf-page-set-line-width page 0.25)))
      
      (hpdf-page-moveto page 0 y)
      (Hpdf-page-lineto page width y)
      (hpdf-page-stroke page)

      (if (and (== (% y 10) 0) (> y 0))
	  (begin
	    (hpdf-page-set-gray-stroke page 0.5)

            (hpdf-page-moveto page 0 y)
            (hpdf-page-lineto page 5 y)
            (hpdf-page-stroke page)

            (hpdf-page-set-gray-stroke page 0.8)
	    ))
      (set! y (+ y 5))
      )


;;     ;; Draw virtical lines
;;     x = 0;
;;     while (x < width) {
;;         if (x % 10 == 0)
;;             HPDF_Page_SetLineWidth (page, 0.5);
;;         else {
;;             if (HPDF_Page_GetLineWidth (page) != 0.25)
;;                 HPDF_Page_SetLineWidth (page, 0.25);
;;         }

;;         HPDF_Page_MoveTo (page, x, 0);
;;         HPDF_Page_LineTo (page, x, height);
;;         HPDF_Page_Stroke (page);

;;         if (x % 50 == 0 && x > 0) {
;;             HPDF_Page_SetGrayStroke (page, 0.5);

;;             HPDF_Page_MoveTo (page, x, 0);
;;             HPDF_Page_LineTo (page, x, 5);
;;             HPDF_Page_Stroke (page);

;;             HPDF_Page_MoveTo (page, x, height);
;;             HPDF_Page_LineTo (page, x, height - 5);
;;             HPDF_Page_Stroke (page);

;;             HPDF_Page_SetGrayStroke (page, 0.8);
;;         }

;;         x += 5;
;;     }

;;     /* Draw horizontal text */
;;     y = 0;
;;     while (y < height) {
;;         if (y % 10 == 0 && y > 0) {
;;             char buf[12];

;;             HPDF_Page_BeginText (page);
;;             HPDF_Page_MoveTextPos (page, 5, y - 2);
;; #ifdef __WIN32__
;;             _snprintf (buf, 12, "%u", y);
;; #else
;;             snprintf (buf, 12, "%u", y);
;; #endif
;;             HPDF_Page_ShowText (page, buf);
;;             HPDF_Page_EndText (page);
;;         }

;;         y += 5;
;;     }


;;     /* Draw virtical text */
;;     x = 0;
;;     while (x < width) {
;;         if (x % 50 == 0 && x > 0) {
;;             char buf[12];

;;             HPDF_Page_BeginText (page);
;;             HPDF_Page_MoveTextPos (page, x, 5);
;; #ifdef __WIN32__
;;             _snprintf (buf, 12, "%u", x);
;; #else
;;             snprintf (buf, 12, "%u", x);
;; #endif
;;             HPDF_Page_ShowText (page, buf);
;;             HPDF_Page_EndText (page);

;;             HPDF_Page_BeginText (page);
;;             HPDF_Page_MoveTextPos (page, x, height - 10);
;;             HPDF_Page_ShowText (page, buf);
;;             HPDF_Page_EndText (page);
;;         }

;;         x += 5;
;;     }

    (hpdf-page-set-gray-fill page 0)
    (hpdf-page-set-gray-stroke page 0)
    ))

(let* ([pdf (hpdf-new)]
       [page (hpdf-add-page pdf)]
       [s (hpdf-page-set-height page 220)]
       [s (hpdf-page-set-width page 220)]
       [pos 0])
  ;;(print-grid pdf page)

  ;; A 
  (hpdf-page-set-rgb-fill page 1.0 0 0)
  (hpdf-page-moveto page 100 100)
  (hpdf-page-lineto page 100 180)
  (hpdf-page-arc page 100 100 80 0 (* 360 0.45))
  (set! pos (hpdf-page-get-current-pos page))
  (hpdf-page-lineto page 100 100)
  (hpdf-page-fill page)

    ;; /* B */
    ;; HPDF_Page_SetRGBFill (page 0 0 1.0)
    ;; HPDF_Page_MoveTo (page 100 100)
    ;; HPDF_Page_LineTo (page pos.x pos.y)
    ;; HPDF_Page_Arc (page 100 100 80 360 * 0.45 360 * 0.7)
    ;; pos = HPDF_Page_GetCurrentPos (page)
    ;; HPDF_Page_LineTo (page 100 100)
    ;; HPDF_Page_Fill (page)

    ;; /* C */
    ;; HPDF_Page_SetRGBFill (page 0 1.0 0)
    ;; HPDF_Page_MoveTo (page 100 100)
    ;; HPDF_Page_LineTo (page pos.x pos.y)
    ;; HPDF_Page_Arc (page 100 100 80 360 * 0.7 360 * 0.85)
    ;; pos = HPDF_Page_GetCurrentPos (page)
    ;; HPDF_Page_LineTo (page 100 100)
    ;; HPDF_Page_Fill (page)

    ;; /* D */
    ;; HPDF_Page_SetRGBFill (page 1.0 1.0 0)
    ;; HPDF_Page_MoveTo (page 100 100)
    ;; HPDF_Page_LineTo (page pos.x pos.y)
    ;; HPDF_Page_Arc (page 100 100 80 360 * 0.85 360)
    ;; pos = HPDF_Page_GetCurrentPos (page)
    ;; HPDF_Page_LineTo (page 100 100)
    ;; HPDF_Page_Fill (page)

    ;; draw center circle 
    (hpdf-page-set-gray-stroke page 0)
    (hpdf-page-set-gray-fill page 1)
    (hpdf-page-circle page 100 100 30)
    (hpdf-page-fill page)

    ;; save the document to a file 
    (hpdf-save-to-file pdf "test/arc-demo.pdf")

    ;; clean up 
    (hpdf-free pdf)
    )

