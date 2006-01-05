;; ugen.scm - (c) rohan drape, 2003-2005

;; A <ugen> represents a UGen in a UGen graph.  The <string> name
;; names the C level UGen.  Each value at the <list> inputs is either
;; a <number>, a <constant>, a <control>, a <ugen> or a <proxy>.  Each
;; value at the <list> outputs is a an <output>.

(define-structure ugen name rate inputs outputs special)

(defineH ugen-output u n
  (ref (ugen-outputs u) n))

(defineH ugen->u8t (ugen name rate inputs outputs special)
  (list 
   (pstring->u8v name)
   (i8->u8v rate)
   (i16->u8v (length inputs))
   (i16->u8v (length outputs))
   (i16->u8v special)
   (map input->u8t inputs)
   (map output->u8v outputs)))
