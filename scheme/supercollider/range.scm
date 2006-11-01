;; range.scm - (c) rohan drape, 2006

(define (unipolar? u)
  (member (ugen-name u)
	  (list "LFPulse" "Impulse" "TPulse" "Trig1" "Dust")))

(define (range u l r)
  (if (unipolar? u)
      (MulAdd (Sub r l) l)
      (let* ((m (Mul (Sub r l) 0.5))
	     (a (Add m l)))
	(MulAdd u m a))))

(define (exprange u l r)
  (if (unipolar? u)
      (LinExp u  0 1 l r)
      (LinExp u -1 1 l r)))
