;; graphdef.scm - (c) rohan drape, 2003-2006

;; A <graphdef> represents a UGen graph.

(define-structure graphdef name constants defaults controls ugens)

(define (graphdef-ugen g n)
  (ref (graphdef-ugens g) n))

(define (graphdef-control g n)
  (ref (graphdef-controls g) n))

(define (graphdef-constant g n)
  (ref (graphdef-constants g) n))

(define (graphdef->u8t g)
  (let ((n (graphdef-name g))
	(c (graphdef-constants g))
	(d (graphdef-defaults g))
	(k (graphdef-controls g))
	(u (graphdef-ugens g)))
    (list
     (string->u8v "SCgf")
     (i32->u8v 0)
     (i16->u8v 1)
     (pstring->u8v n)
     (i16->u8v (length c))
     (map f32->u8v c)
     (i16->u8v (length d))
     (map f32->u8v d)
     (i16->u8v (length k))
     (map control->u8t k)
     (i16->u8v (length u))
     (map ugen->u8t u))))

(define (graphdef->u8v g)
  (u8t->u8v (graphdef->u8t g)))
