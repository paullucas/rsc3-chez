;; ugen.scm - (c) rohan drape, 2003-2006

;; A <ugen> represents a UGen in a UGen graph.  The <string> name
;; names the C level UGen.  Each value at the <list> inputs is either
;; a <number>, a <constant>, a <control>, a <ugen> or a <proxy>.  Each
;; value at the <list> outputs is a an <output>.  The id is an <id>.

(define-structure ugen name rate inputs outputs special id)

(define (ugen-output u n)
  (list-ref (ugen-outputs u) n))

(define (ugen-validate u)
  (let ((n (ugen-name u))
	(r (ugen-rate u))
	(i (ugen-inputs u))
	(o (ugen-outputs u))
	(s (ugen-special u))
	(d (ugen-id u)))
    (and (string? n)
	 (rate? r)
	 (and (list? i) (every input*? i))
	 (and (list? o) (every output? o))
	 (integer? s)
	 (uid? d))))

(define (ugen->u8t u)
  (let ((n (ugen-name u))
	(r (ugen-rate u))
	(i (ugen-inputs u))
	(o (ugen-outputs u))
	(s (ugen-special u))
	(d (ugen-id u)))
    (list 
     (pstring->u8v n)
     (i8->u8v (rate-value r))
     (i16->u8v (length i))
     (i16->u8v (length o))
     (i16->u8v s)
     (map input->u8t i)
     (map output->u8v o))))
