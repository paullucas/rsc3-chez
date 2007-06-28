;; graphdef.scm - (c) rohan drape, 2003-2007

(module graphdef (lib "lang.ss" "r5rs")
(#%require (only "../structure/structure.scm"
		 define-structure)
	   (only "../u8/np.scm"
		 u8 i16 i32 f32 pstr npt->u8l)
	   (only "control.scm"
		 control->npt)
	   (only "ugen.scm"
		 ugen->npt))
(#%provide (all-defined))

;; A <graphdef> represents a UGen graph.

(define-structure graphdef name constants defaults controls ugens)

(define (graphdef-ugen g n)
  (list-ref (graphdef-ugens g) n))

(define (graphdef-control g n)
  (list-ref (graphdef-controls g) n))

(define (graphdef-constant g n)
  (list-ref (graphdef-constants g) n))

(define SCgf (map u8 (map char->integer (string->list "SCgf"))))

(define (graphdef->npt g)
  (let ((n (graphdef-name g))
	(c (graphdef-constants g))
	(d (graphdef-defaults g))
	(k (graphdef-controls g))
	(u (graphdef-ugens g)))
    (list
     SCgf
     (i32 0)
     (i16 1)
     (pstr n)
     (i16 (length c))
     (map f32 c)
     (i16 (length d))
     (map f32 d)
     (i16 (length k))
     (map control->npt k)
     (i16 (length u))
     (map ugen->npt u))))

(define (graphdef->u8l g)
  (npt->u8l (graphdef->npt g)))

)
