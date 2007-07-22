;; shuffle.scm - (c) rohan drape, 2005-2007

(module shuffle (lib "lang.ss" "r5rs")
(#%require "../mzscheme/r6rs.ss"
	   (only "range.scm"
		 rand))
(#%provide shuffle)

;; Return a random permutation of the <list> `l'.  This is not a
;; mutation operation.  For a critique of this method see
;; http://okmij.org/ftp/Haskell/perfect-shuffle.txt.

(define (shuffle l)
  (let ((q (map (lambda (e) (cons (rand 0 1) e)) l))
	(c (lambda (a b) (> (car a) (car b)))))
    (map cdr (list-sort q c))))

;; sclang name for shuffle.

(define scramble shuffle)

)
