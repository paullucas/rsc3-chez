;; graphdef.scm - (c) rohan drape, 2003-2005

;; A <graphdef> is the static representation of a UGen graph.

(define-structure graphdef name constants defaults controls ugens)

;; Accessor for indexed ugen elements.

(define (graphdef-ugen g n)     (ref (graphdef-ugens g)     n))
(define (graphdef-control g n)  (ref (graphdef-controls g)  n))
(define (graphdef-constant g n) (ref (graphdef-constants g) n))

;; Serialize the <graphdef> g.

(defineH graphdef->u8t (graphdef name constants defaults controls ugens)
  (list
   (string->u8v "SCgf")
   (i32->u8v 0)
   (i16->u8v 1)
   (pstring->u8v name)
   (i16->u8v (length constants))
   (map f32->u8v constants)
   (i16->u8v (length defaults))
   (map f32->u8v defaults)
   (i16->u8v (length controls))
   (map control->u8t controls)
   (i16->u8v (length ugens))
   (map ugen->u8t ugens)))

(define (graphdef->u8v g)
  (u8t->u8v (graphdef->u8t g)))
