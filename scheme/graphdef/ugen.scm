;; ugen.scm - (c) rohan drape, 2003-2005

;; A <ugen> represents a UGen in a UGen graph.  The <symbol> name
;; names the C level UGen.  Each value at the <list> inputs is either
;; a <number>, a <constant>, a <control>, a <ugen> or an
;; <output-proxy>.  Each value at the <list> outputs is a calculation
;; rate indicator <integer> or an <output>.

(define-structure ugen name rate inputs outputs special)

(defineH make-ugen* name rate inputs outputs special
  (make-ugen name rate inputs (map make-output outputs) special))

(defineH ugen->u8t (ugen name rate inputs outputs special)
  (list 
   (pstring->u8v (symbol->string name))
   (i8->u8v rate)
   (i16->u8v (length inputs))
   (i16->u8v (length outputs))
   (i16->u8v special)
   (map input->u8t inputs)
   (map output->u8v outputs)))

;; Return the `n'th output at `u'.

(defineH ugen-output u n
  (ref (ugen-outputs u) n))

