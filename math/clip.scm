;; clip.scm - (c) rohan drape, 2005-2007

(module clip scheme/base

(provide clip)

;; Clip `n' between a and b.

(define (clip a b n) (if (< n a) a (if (> n b) b n)))
(define (clipu n)    (clip 0 1 n))

;; Clip real and imaginary components of z.

(define (clipz a b z)
  (make-rectangular (clip a b (real-part z))
		    (clip a b (imag-part z))))

)
