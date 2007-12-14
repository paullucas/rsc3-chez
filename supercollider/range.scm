;; range.scm - (c) rohan drape, 2006-2007

(module range scheme/base

(require (only-in srfi/1 
		  every)
	 "../graphdef/mce.scm"
	 "../graphdef/ugen.scm"
	 "../ugen/filter.scm"
	 "../ugen/operator.scm")

(provide (all-defined-out))

(define (unipolar? u)
  (if (mce? u)
      (every unipolar? (mce-channels u))
      (member (ugen-name u)
	      (list "LFPulse" "Impulse" "TPulse" "Trig1" "Dust"))))

(define (range u l r)
  (if (unipolar? u)
      (MulAdd u (Sub r l) l)
      (let* ((m (Mul (Sub r l) 0.5))
	     (a (Add m l)))
	(MulAdd u m a))))

;; Note: uses LinExp so `l' and `r' are i-rate.

(define (exprange u l r)
  (if (unipolar? u)
      (LinExp u  0 1 l r)
      (LinExp u -1 1 l r)))

)
