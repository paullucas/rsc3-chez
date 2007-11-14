;; quantize.scm - (c) rohan drape, 2005-2007

(module quantize scheme/base

(require (only-in "../math/exact.scm"
	       round-exact))

(provide quantize)

;; Quantize `n' to the nearest multiple of `quanta'.

(define (quantize quanta n)
  (* (round-exact (/ n quanta)) quanta))

)
