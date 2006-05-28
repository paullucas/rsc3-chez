;; graphdef.scm - (c) rohan drape, 2003-2006

;; A <graphdef> represents a UGen graph.

(define-structure graphdef name constants defaults controls ugens)

(define (graphdef-ugen g n)
  (list-ref (graphdef-ugens g) n))

(define (graphdef-control g n)
  (list-ref (graphdef-controls g) n))

(define (graphdef-constant g n)
  (list-ref (graphdef-constants g) n))

(define (graphdef->u8 g)
  (let ((n (graphdef-name g))
	(c (graphdef-constants g))
	(d (graphdef-defaults g))
	(k (graphdef-controls g))
	(u (graphdef-ugens g)))
    (list
     (str "SCgf")
     (i32 0)
     (i16 1)
     (pstr n)
     (i16 (length c))
     (map f32 c)
     (i16 (length d))
     (map f32 d)
     (i16 (length k))
     (map control->u8 k)
     (i16 (length u))
     (map ugen->u8 u))))

(define (graphdef->u8v g)
  (mk-u8v (graphdef->u8 g)))
