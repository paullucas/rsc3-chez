;; control.scm - (c) rohan drape, 2003-2007

(module control (lib "lang.ss" "r5rs")
(#%require (only "../structure/structure.scm"
		 define-structure)
	   (only "../u8/np.scm"
		 i16
		 pstr))
(#%provide (all-defined))

;; A <control> is accessed by a <string> name and an <integer> index.

(define-structure control name index)

(define (control->npt c)
  (list (pstr (control-name c))
	(i16 (control-index c))))

;; A <control*> is a place holder for a <control>.

(define-structure control* name default rate lag)

)
