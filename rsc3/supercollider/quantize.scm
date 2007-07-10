;; quantize.scm - (c) rohan drape, 2005-2007

(module quantize (lib "lang.ss" "r5rs")
(#%require (only "../math/exact.scm"
		 round-exact))
(#%provide (all-defined))

;; Quantize `n' to the nearest multiple of `quanta'.

(define (quantize quanta n)
  (* (round-exact (/ n quanta)) quanta))

)
