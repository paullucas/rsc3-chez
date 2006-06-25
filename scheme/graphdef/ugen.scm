;; ugen.scm - (c) rohan drape, 2003-2006

;; A <ugen> represents a UGen in a UGen graph.  The <string> name
;; names the C level UGen.  Each value at the <list> inputs is either
;; a <number>, a <constant>, a <control>, a <ugen> or a <proxy>.  Each
;; value at the <list> outputs is a an <output>.  The id is an <id>.

(define-structure ugen name rate inputs outputs special id)

(define (ugen-output u n)
  (list-ref (ugen-outputs u) n))

(define (ugen-transform u f)
  (let ((n (ugen-name u))
	(r (ugen-rate u))
	(i (ugen-inputs u))
	(o (ugen-outputs u))
	(s (ugen-special u))
	(d (ugen-id u)))
    (f n r i o s d)))

(define (ugen-validate u)
  (ugen-transform
   u
   (lambda (n r i o s d)
     (and (string? n)
	  (rate? r)
	  (and (list? i) (every input*? i))
	  (and (list? o) (every output? o))
	  (integer? s)
	  (uid? d)))))

(define (ugen->npt u)
  (ugen-transform
   u
   (lambda (n r i o s d)
     (list
      (pstr n)
      (u8 (rate-value r))
      (i16 (length i))
      (i16 (length o))
      (i16 s)
      (map input->npt i)
      (map output->npt o)))))

(define (uniquify u)
  (ugen-transform
   u
   (lambda (n r i o s d)
     (make-ugen n r i o s (unique-uid)))))

(define (dupn n u)
  (make-mce
   (map (lambda (_) (uniquify u)) (iota n))))

(define (dup u) (dupn 2 u))

