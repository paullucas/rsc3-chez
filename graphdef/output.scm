;; output.scm - (c) rohan drape, 2003-2007

(module output scheme/base

(require (only-in srfi/1
		  make-list)
	 (only-in "../structure/structure.scm"
		  define-structure)
	 (only-in "../u8/np.scm"
		  u8)
	 (only-in "rate.scm"
		  rate-value))

(provide make-outputs
	 make-output
	 output?
	 output-rate
	 output->npt)

;; An <output> represents a UGen output signal in a UGen graph.

(define-structure output rate)

(define (output->npt o)
  (u8 (rate-value (output-rate o))))

(define (make-outputs n r)
  (make-list n (make-output r)))

)
