;; -*- mode: scheme; coding:utf-8 -*-

;;;
;;; Test hpdf
;;;

(use gauche.test)
(use gauche.interactive)

(test-start "hpdf")
(use hpdf)

(test-record-file "test.record")

(test-module 'hpdf)
(test-start "doc")


;;
;; hpdf-new
;; 
(test-section "hpdf-new")
(test* "new instance" <hpdf-doc> (class-of (hpdf-new)))

;;
;; hpdf-free
;; 
(test-section "hpdf-free")
(test* "hpdf-free" (undefined) (hpdf-free (hpdf-new)))

;;
;; hpdf-new-doc
;; 
(test-section "hpdf-new-doc")

;;
;; hpdf-has-doc
;; 
(test-section "hpdf-has-doc")

;;
;; hpdf-free-doc
;; 
(test-section "hpdf-free-doc")

;;
;; hpdf-free-doc-all
;; 
(test-section "hpdf-free-doc-all")

;;
;; hpdf-add-page
;; 
(test-section "hpdf-add-page")

;;
;; hpdf-get-stream-size
;; 
(test-section "hpdf-get-stream-size")

;;
;; hpdf-read-from-stream
;; 
(test-section "hpdf-read-from-stream")

;;
;; hpdf-reset-stream
;; 
(test-section "hpdf-reset-stream")

;;
;; hpdf-save-to-file
;; 
(test-section "hpdf-save-to-file")

;;
;; hpdf-get-error
;; 
(test-section "hpdf-get-error")

;;
;; hpdf-get-error-detail
;; 
(test-section "hpdf-get-error-detail")

;;
;; hpdf-set-info-attr
;; 
(test-section "hpdf-set-info-attr")

(define (mktest key value desc)
  (let* ([pdf (hpdf-new)])
    (test* desc HPDF_OK (hpdf-set-info-attr pdf key value))))

(mktest AUTHOR "author" "HPDF_INFO_AUTHOR")
(mktest CREATOR "creator" "HPDF_INFO_CREATOR")
(mktest TITLE "title" "HPDF_INFO_TITLE")
(mktest SUBJECT "subject" "HPDF_INFO_SUBJECT")
(mktest KEYWORDS "keywords" "HPDF_INFO_KEYWORDS")

(define (mktest)
  (let* ([pdf (hpdf-new)]
	 [page (hpdf-add-page pdf)]
	 [prefix (if (rxmatch #/.*test\/.*\.scm$/ *program-name*) "test" ".")]
	 [filename (format #f "~a/data/hpdf-set-info-attr.pdf" prefix)])
    (hpdf-set-info-attr pdf AUTHOR "author")
    (hpdf-set-info-attr pdf CREATOR "Gauche-hpdf")
    (hpdf-set-info-attr pdf TITLE "title")
    (hpdf-set-info-attr pdf SUBJECT "subject")
    (hpdf-set-info-attr pdf KEYWORDS "keywords")
    (hpdf-save-to-file pdf filename)))

(mktest)

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
;; (test* "HPDF_INFO_CREATION_DATE" *test-error* (test-hpdf-get-info-attr HPDF_INFO_CREATION_DATE "hoge"))
;; (test* "HPDF_INFO_MOD_DATE" *test-error* (test-hpdf-get-info-attr HPDF_INFO_MOD_DATE "hoge"))
(test* "HPDF_INFO_AUTHOR" "author" (test-hpdf-get-info-attr AUTHOR "author"))
(test* "HPDF_INFO_CREATOR" "creator" (test-hpdf-get-info-attr CREATOR "creator"))
(test* "HPDF_INFO_TITLE" "title" (test-hpdf-get-info-attr TITLE "title"))
(test* "HPDF_INFO_SUBJECT" "subject" (test-hpdf-get-info-attr SUBJECT "subject"))
(test* "HPDF_INFO_KEYWORDS" "keywords" (test-hpdf-get-info-attr KEYWORDS "keywords"))

(define (test-hpdf-set-password owner user)
  (let* ([pdf (hpdf-new)]
	 [prefix (if (rxmatch #/.*test\/.*\.scm$/ *program-name*) "test" ".")]
         [st (if owner
                 (if user
                     (hpdf-set-password pdf owner user)
                     (hpdf-set-password pdf owner ""))
                 (if user
                     (hpdf-set-password pdf "" user)
                     (hpdf-set-password pdf "" "")))]
         [filename (if owner
		       (if user
			   (format #f "~a/data/hpdf-set-password-ou.pdf" prefix)
			   (format #f "~a/data/hpdf-set-password-o.pdf" prefix))
		       (if user
			   (format #f "~a/data/hpdf-set-password-u.pdf" prefix)
			   (format #f "~a/data/hpdf-set-password.pdf" prefix)))]
         (page (hpdf-add-page pdf))
         )
    (hpdf-save-to-file pdf filename)))

(test-subsection "hpdf-set-password")
(test* "owner, user" HPDF_OK (test-hpdf-set-password "owner" "user"))
(test* "owner, #f" HPDF_OK (test-hpdf-set-password "owner" #f))
;; owner password must be non zero length
(test* "#f, user" *test-error* (test-hpdf-set-password #f "user"))
;; owner password must be non zero length
(test* "#f, #f" *test-error* (test-hpdf-set-password #f #f))

(test-subsection "hpdf-set-info-date")
;; (define (test-hpdf-set-info-date)
;;   (let* ((pdf (hpdf-new))
;;          (date (make <hpdf-date>))
;;          (date)
;;     (

(define (test-hpdf-set-permission permission filename password)
  (let* ([pdf (hpdf-new)])
    (st (if password
                 ;; need to call before set-permission
                 (hpdf-set-password pdf "owner" "")
                 #f))
         (st (hpdf-set-permission pdf permission))
         ;; dummy
         (page (hpdf-add-page pdf))
         )
    (hpdf-save-to-file pdf filename))

;;
;; hpdf-set-permission
;;
(test-subsection "hpdf-set-permission")
;; (test* "read only" HPDF_OK (test-hpdf-set-permission HPDF_ENABLE_READ "data/hpdf-set-permission-read.pdf" #t))
;; (test* "print only" HPDF_OK (test-hpdf-set-permission HPDF_ENABLE_PRINT "data/hpdf-set-permission-print.pdf" #t))
;; (test* "edit-all only" HPDF_OK (test-hpdf-set-permission HPDF_ENABLE_EDIT_ALL "data/hpdf-set-permission-editall.pdf" #t))
;; (test* "copy only" HPDF_OK (test-hpdf-set-permission HPDF_ENABLE_COPY "data/hpdf-set-permission-copy.pdf" #t))
;; (test* "edit only" HPDF_OK (test-hpdf-set-permission HPDF_ENABLE_EDIT "data/hpdf-set-permission-edit.pdf" #t))
;; (test* "all" HPDF_OK (test-hpdf-set-permission (logior READ PRINT EDIT_ALL COPY EDIT) "data/hpdf-set-permission-all.pdf" #t))
;; (test* "read only" *test-error* (test-hpdf-set-permission HPDF_ENABLE_READ "data/hpdf-set-permission-read.pdf" #f))

(define (test-hpdf-set-compression-mode file mode)
  (let* ((pdf (hpdf-new))
         (s (hpdf-set-compression-mode pdf mode))
         (page (hpdf-add-page pdf))
         (null (hpdf-save-to-file pdf file)))
    s))
         
;; (test* "compress none" HPDF_OK (test-hpdf-set-compression-mode "data/hpdf-set-compression-mode-none.pdf" HPDF_COMP_NONE))
;; (test* "compress text" HPDF_OK (test-hpdf-set-compression-mode "data/hpdf-set-compression-mode-text.pdf" HPDF_COMP_TEXT))
;; (test* "compress image" HPDF_OK (test-hpdf-set-compression-mode "data/hpdf-set-compression-mode-image.pdf" HPDF_COMP_IMAGE))
;; (test* "compress metadata" HPDF_OK (test-hpdf-set-compression-mode "data/hpdf-set-compression-mode-meta.pdf" HPDF_COMP_METADATA))
;; (test* "compress all" HPDF_OK (test-hpdf-set-compression-mode "data/hpdf-set-compression-mode-all.pdf" HPDF_COMP_ALL))

;; epilogue
(test-end)





