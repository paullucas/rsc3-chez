;; score.scm - (c) rohan drape, 2004-2006

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
