;; -*- mode:scheme; coding: utf-8 -*-

(use gauche.interactive)
(use gauche.sequence)
(use gauche.collection)
(use hpdf)


;;
;; see http://libharu.org/wiki/Downloads/Contributed#u3d_demo.c
;;

(define (main args)
  (let* ([pdf (hpdf-new)]
	 [rect (make-rect 0 0 600 600)]
	 [prefix (if (rxmatch #/.*test\/.*\.scm$/ *program-name*) "test" ".")]
	 [filename (format #f "~a/u3d-demo.pdf" prefix)]
	 [modelfile (format #f "~a/3dmodels/axes.u3d" prefix)]
	 [page (add-page pdf)]
	 [u3d 0] [view1 0] [view2 0])

    (width! page 600)
    (height! page 600)
    
    (version! pdf HPDF_VER_17)

    (set! u3d (load-u3d-from-file pdf modelfile))

    (set! view1 (create-3dview u3d "DefaultView"))
    (3dview-camera! view1 0 0 0 0 0 1 5 0)
    (3dview-perspective-projection! view1 30)

    (3dview-background-color! view1 0.9 0.9 0.0)

    (3dview-lighting! view1 "CAD")

    (3dview-add-node view1 "xlabel" 1.0 #f)
    (3dview-add-node view1 "ylabel" 0.5 #t)

    ;; Second view
    (set! view2 (create-3dview u3d "OrthoView"))
    (3dview-camera! view2 0 0 0 0 0 1 5 0)
    (3dview-perspective-projection! view2 300)

    (3dview-background-color! view2 0.9 0.9 0.9)

    (3dview-lighting! view2 "Day")

    (3dview-add-node view2 "xlabel" 1.0 #t)
    (3dview-add-node view2 "ylabel" 1.0 #t)

    ;; Add views
    (u3d-add-3dview u3d view2)
    (u3d-add-3dview u3d view1)
    (u3d-default-3dview! u3d "DefaultView")

    ;; Create annotation
    (create-3d-annot page rect u3d)

    (save-to-file pdf filename)

    (free pdf)))


    
    
    
    

    
	 
