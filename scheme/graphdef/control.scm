;; control.scm - (c) rohan drape, 2003-2006

;; A <control> is accessed by a <string> name and an <integer> index.

(define-structure control name index)

(define (control->u8t c)
  (list (pstring->u8v (control-name c))
	(i16->u8v (control-index c))))

;; A <control*> is a place holder for a <control>.

(define-structure control* name default rate lag)
