;; quantize.scm - (c) rohan drape, 2005-2006

;; Quantize `n' to the nearest multiple of `quanta'.

(define (quantize quanta n)
  (* (round-exact (/ n quanta)) quanta))
