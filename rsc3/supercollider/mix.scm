;; mix.scm - (c) rohan drape, 2003-2007

(module mix (lib "lang.ss" "r5rs")
(#%require (only (lib "1.ss" "srfi")
		 list-tabulate)
	   (only "../collection/list.scm"
		 foldl1)
	   (only "../graphdef/mce.scm"
		 make-mce
		 mce-channels
		 mce?)
	   (only "../ugen/operator.scm"
		 Add))
(#%provide (all-defined))

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
