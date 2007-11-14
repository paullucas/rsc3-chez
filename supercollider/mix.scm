;; mix.scm - (c) rohan drape, 2003-2007

(module mix scheme/base

(require (only-in srfi/1
		  list-tabulate)
	 (only-in "../collection/list.scm"
		  foldl1)
	 (only-in "../graphdef/mce.scm"
		  make-mce
		  mce-channels
		  mce?)
	 (only-in "../ugen/operator.scm"
		  Add))

(provide (all-defined-out))

;; Mix the UGen at `inputs'.  This is an idiom over the binary math
;; operator 'Add'.

(define (mix u)
  (cond
   ((mce? u) (foldl1 Add (mce-channels u)))
   (else     u)))

;; Use the unary procedure `f' to build an mce value of `n' places.

(define (mce/fill n f)
  (make-mce (list-tabulate n f)))

;; mix . mce/fill

(define (mix/fill n f)
  (mix (mce/fill n f)))

)
