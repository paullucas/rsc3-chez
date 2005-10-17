;; rsc.scm - (c) rohan drape, 2003-2005

;; The rsc directory.  It should be somewhere along the library
;; collects path.  This raises an error if the directory cannot be
;; located.

(define rsc-directory (path->string (collection-path "rsc")))

;; Build a path name for an rsc file.

(define (rsc-file name) (path->string (build-path rsc-directory name)))
