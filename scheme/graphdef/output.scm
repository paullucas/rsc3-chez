;; output.scm - (c) rohan drape, 2003-2007

(module output (lib "lang.ss" "r5rs")
(#%require (only (lib "1.ss" "srfi")
		 make-list)
	   (only "../structure/structure.scm"
		 define-structure)
	   (only "../u8/np.scm"
		 u8)
	   (only "rate.scm"
		 rate-value))
(#%provide make-outputs
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
