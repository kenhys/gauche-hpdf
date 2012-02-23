;;;
;;; hpdf
;;;

(define-module hpdf.u3d
  (extend hpdf)
  (use file.util)
  (export-all)
  )
(select-module hpdf.u3d)

;; Loads extension
(dynamic-load "gauche--hpdf")

;;
;; Put your Scheme definitions here
;;

(define-method load-u3d-from-file ((self <hpdf-doc>)
				   filename)
  (hpdf-load-u3d-from-file self filename))

(define-method create-3dview ((self <hpdf-image>)
			       viewname)
  (hpdf-create-3dview self viewname))

(define-method u3d-add-3dview
  ((self <hpdf-image>) view)
  (hpdf-u3d-add-3dview self view))

(define-method u3d-default-3dview!
  ((self <hpdf-image>) view)
  (hpdf-u3d-set-default-3d-view self view))

(define-method 3dview-camera! ((self <hpdf-dict>)
			       coox cooy cooz c2cx c2cy c2cz roo roll)
  (hpdf-3dview-set-camera self coox cooy cooz c2cx c2cy c2cz roo roll))

(define-method 3dview-add-node
  ((self <hpdf-dict>) name opacity visible)
  (hpdf-3dview-add-node self name opacity visible))

(define-method 3dview-lighting!
  ((self <hpdf-dict>) scheme)
  (hpdf-3dview-set-lighting self scheme))

(define-method 3dview-background-color!
  ((self <hpdf-dict>) r g b)
  (hpdf-3dview-set-background-color self r g b))

(define-method 3dview-perspective-projection!
  ((self <hpdf-dict>) fov)
  (hpdf-3dview-set-perspective-projection self fov))

;; Epilogue
(provide "hpdf/u3d")
