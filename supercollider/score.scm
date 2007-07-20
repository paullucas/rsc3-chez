;; score.scm - (c) rohan drape, 2004-2007

(module score (lib "lang.ss" "r5rs")
(#%require (only "../collection/tree.scm"
		 flatten)
	   (only "../osc/encode.scm"
		 osc->u8l)
	   (only "../u8/u8l.scm"
		 i32->u8l))
(#%provide (all-defined))

;; A score is a list of OSC bundles.  The timestamps are given in
;; seconds where zero is the start of the score.  An OSC file is a
;; binary file format understood by the SC3 synthesis server, and
;; consists of a sequence of length prefixed OSC bundles.

;; Generate the <u8l> for the score `data'.

(define (score->u8l bundles)
  (flatten
   (map (lambda (bundle)
	  (let ((l (osc->u8l bundle)))
	    (list (i32->u8l (length l))
		  l)))
	bundles)))

)