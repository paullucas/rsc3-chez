
;; spec

;; An interface to the warp procedures.

(define-structure spec minima maxima warp range ratio)

(define make-spec*
  (lambda (minima maxima warp)
    (let ((w (if (symbol? warp) (symbol->warp warp) warp)))
      (make-spec minima maxima (w minima maxima)
		 (- maxima minima) (/ maxima minima)))))

(define spec-map
  (lambda (s value)
    ((spec-warp s) 'map (clip 0.0 1.0 value))))

(define spec-unmap
  (lambda (s value)
    (clip 0.0 1.0 ((spec-warp s) 'unmap value))))

(define symbol->spec
  (lambda (s)
    (case s
      ((unipolar) (make-spec 0.0 1.0 'linear))
      ((bipolar pan) (make-spec -1.0 1.0 'linear))
      ((freq frequency) (make-spec 20.0 20000.0 'linear))
      ((phase) (make-spec 0.0 (* 2 pi) 'linear))
      (else (error 'symbol->spec "illegal value" s)))))

