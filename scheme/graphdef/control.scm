;; control.scm - (c) rohan drape, 2003-2006

;; A <control> is accessed by a <string> name and an <integer> index.

(define-structure control name index)

(define (control->u8 c)
  (list (pstr (control-name c))
	(i16 (control-index c))))

;; A <control*> is a place holder for a <control>.

(define-structure control* name default rate lag)
