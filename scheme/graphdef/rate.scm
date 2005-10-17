;; rate.scm - (c) rohan drape, 2003-2005

;; A rate may be specified either as an <integer> or as a <symbol>.

(define (rate r)
  (if (integer? r) 
      r
      (case r
	((i irate init initialization) 0)
	((k krate ctl control)         1)
	((a arate audio)               2)
	(else                          (error! "rate: illegal value" r)))))
