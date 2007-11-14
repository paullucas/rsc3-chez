;; input.scm - (c) rohan drape, 2003-2007

(module input scheme/base

(require (only-in "../structure/structure.scm"
		  define-structure)
	 (only-in "../u8/np.scm"
		  i16))

(provide input
	 make-input
	 input-ugen
	 input-port
	 input->npt)

;; An <input> represents a UGen input signal in a UGen graph, an
;; 'Input Specification'.  The <integer> ugen is the index of the
;; UGen, the <integer> port is an output port at ugen.

(define-structure input ugen port)

(define (input->npt i)
  (list (i16 (input-ugen i))
	(i16 (input-port i))))

)
