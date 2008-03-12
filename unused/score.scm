;; score

;; A score is a list of OSC bundles. The timestamps are given in
;; seconds where zero is the start of the score. An OSC file is a
;; binary file format understood by the SC3 synthesis server, and
;; consists of a sequence of length prefixed OSC bundles.

;; Generate the <u8l> for the score `data'.

(define score->u8l
  (lambda (bundles)
    (flatten
     (map (lambda (bundle)
	    (let ((l (npt->u8l (encode-bundle-ntp bundle))))
	      (list (i32->u8l (length l))
		    l)))
	  bundles))))
