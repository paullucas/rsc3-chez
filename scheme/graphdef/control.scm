;; control.scm - (c) rohan drape, 2003-2005

;; A <control> is accessed by a <string> name and an <integer> index.

(define-structure control name index)

(defineH control->u8t (control name index)
  (list (pstring->u8v (symbol->string name))
	(i16->u8v index)))

;; A <control*> is a place holder for a <control>.

(define-structure control* name default rate lag)
