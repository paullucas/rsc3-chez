;; range.scm - (c) rohan drape, 2006-2007

(module range (lib "lang.ss" "r5rs")
(#%require (only "../graphdef/ugen.scm"
		 ugen-name)
	   (only "../ugen/filter.scm"
		 LinExp
		 MulAdd)
	   (only "../ugen/operator.scm"
		 Sub
		 Mul
		 Add))
(#%provide (all-defined))

(define (unipolar? u)
  (member (ugen-name u)
	  (list "LFPulse" "Impulse" "TPulse" "Trig1" "Dust")))

(define (range u l r)
  (if (unipolar? u)
      (MulAdd (Sub r l) l)
      (let* ((m (Mul (Sub r l) 0.5))
	     (a (Add m l)))
	(MulAdd u m a))))

;; Note: uses LinExp so `l' and `r' are i-rate.

(define (exprange u l r)
  (if (unipolar? u)
      (LinExp u  0 1 l r)
      (LinExp u -1 1 l r)))

)
