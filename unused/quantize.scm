;; Quantize `n' to the nearest multiple of `quanta'.

(define quantize
  (lambda (quanta n)
    (* (round-exact (/ n quanta)) quanta)))

