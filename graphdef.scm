;; int -> uid
(define-structure uid n)

;; () -> uid
(define unique-uid
  (let ((n 0))
    (lambda ()
      (set! n (+ n 1))
      (make-uid n))))

;; string -> int -> control
(define-structure control name index)

;; string -> float -> rate -> float -> control*
(define-structure control* name default rate lag)

;; string -> [float] -> [float] -> [controls] -> [ugens] -> graphdef
(define-structure graphdef name constants defaults controls ugens)

;; graphdef -> int -> ugen
(define graphdef-ugen
  (lambda (g n)
    (list-ref (graphdef-ugens g) n)))

;; graphdef -> int -> control
(define graphdef-control
  (lambda (g n)
    (list-ref (graphdef-controls g) n)))

;; graphdef -> int -> float
(define graphdef-constant
  (lambda (g n)
    (list-ref (graphdef-constants g) n)))

;; int -> int -> input
(define-structure input ugen port)

;; [ugen] -> mce
(define-structure mce channels)

;; ugen -> ugen -> mce
(define mce2
  (lambda (a b)
    (make-mce (list a b))))

;; ugen -> ugen -> ugen -> mce
(define mce3
  (lambda (a b c)
    (make-mce (list a b c))))

;; mce -> int -> ugen
(define mce-channel
  (lambda (u n)
    (list-ref (mce-channels u) n)))

;; ugen -> ugen -> mrg
(define-structure mrg left right)

;; ugen -> ugen -> mrg
(define mrg2
  make-mrg)

;; ugen -> ugen -> ugen -> mrg
(define mrg3
  (lambda (a b c)
    (make-mrg a (make-mrg b c))))

;; rate -> output
(define-structure output rate)

;; ugen -> int -> proxy
(define-structure proxy ugen port)

;; int -> rate
(define-structure rate value)

;; string -> rate -> [ugen] -> [output] -> int -> uid -> ugen
(define-structure ugen name rate inputs outputs special id)

;; syntax for binding control values
(define-syntax letc
  (syntax-rules ()
    ((_ () expr)
     expr)
    ((_ ((name default) ...) expr)
     (let ((name (make-control* (symbol->string (quote name)) default kr 0))
	   ...)
       expr))))



;; proxy

;; An <mce> of <proxy> records represents a UGen with multiple
;; outputs.



;; rate


(define ir
  (make-rate 0))

(define kr
  (make-rate 1))

(define ar
  (make-rate 2))

(define dr
  (make-rate 3))

;; Order rates for determing the result of math operators.  Operators
;; involving a Demand rate UGen operate at Demand rate.

;; rate -> int
(define rate-to-ordinal
  (lambda (r)
    (cond ((eq? r ir)  0)
	  ((eq? r kr)  1)
	  ((eq? r ar)  2)
	  ((eq? r dr)  3)
	  (else        (error "rate-to-ordinal: illegal rate")))))

;; rate -> rate -> rate
(define rate-select*
  (lambda (a b)
    (let ((a* (rate-to-ordinal a))
	  (b* (rate-to-ordinal b)))
      (if (> a* b*) a b))))

;; [rate] -> rate
(define rate-select 
  (lambda (l)
    (foldl1 rate-select* l)))


;; rate-of

(define rate-of
  (lambda (o)
    (cond ((number? o)    ir)
	  ((control*? o)  (control*-rate o))
	  ((ugen? o)      (ugen-rate o))
	  ((proxy? o)     (rate-of (proxy-ugen o)))
	  ((mce? o)       (rate-select (map rate-of (mce-channels o))))
	  ((mrg? o)       (error 'rate-of "mrg?" o))
	  (else           (error 'rate-of "illegal value" o)))))


;; ugen

;; A <ugen> represents a UGen in a UGen graph.  The <string> name
;; names the C level UGen.  Each value at the <list> inputs is either
;; a <number>, a <constant>, a <control>, a <ugen> or a <proxy>.  Each
;; value at the <list> outputs is a an <output>.  The id is an <id>.


(define ugen-output
  (lambda (u n)
    (list-ref (ugen-outputs u) n)))

(define ugen-transform
  (lambda (u f)
    (let ((n (ugen-name u))
	  (r (ugen-rate u))
	  (i (ugen-inputs u))
	  (o (ugen-outputs u))
	  (s (ugen-special u))
	  (d (ugen-id u)))
      (f n r i o s d))))

(define input*?
  (lambda (i)
    (or (number? i)
	(control*? i)
	(ugen? i)
	(proxy? i)
	(mce? i))))

(define ugen-validate
  (lambda (u)
    (ugen-transform
     u
     (lambda (n r i o s d)
       (and (string? n)
	    (rate? r)
	    (and (list? i) (all input*? i))
	    (and (list? o) (all output? o))
	    (integer? s)
	    (uid? d))))))

(define uniquify
  (lambda (u)
    (ugen-transform
     u
     (lambda (n r i o s d)
       (make-ugen n r i o s (unique-uid))))))

(define clone
  (lambda (n u)
    (make-mce
     (map (lambda (_) (uniquify u)) (enum-from-to 1 n)))))



(define encode-control
  (lambda (c)
    (list (encode-pstr (control-name c))
	  (encode-i16 (control-index c)))))

(define encode-input
  (lambda (i)
    (list (encode-i16 (input-ugen i))
	  (encode-i16 (input-port i)))))

(define encode-output
  (lambda (o)
    (encode-u8 (rate-value (output-rate o)))))

(define SCgf (map encode-u8 (map char->integer (string->list "SCgf"))))

(define encode-ugen
  (lambda (u)
    (ugen-transform
     u
     (lambda (n r i o s d)
       (list
	(encode-pstr n)
	(encode-u8 (rate-value r))
	(encode-i16 (length i))
	(encode-i16 (length o))
	(encode-i16 s)
	(map encode-input i)
	(map encode-output o))))))

(define encode-graphdef
  (lambda (g)
    (flatten-bytevectors
     (let ((n (graphdef-name g))
	   (c (graphdef-constants g))
	   (d (graphdef-defaults g))
	   (k (graphdef-controls g))
	   (u (graphdef-ugens g)))
       (list
	SCgf
	(encode-i32 0)
	(encode-i16 1)
	(encode-pstr n)
	(encode-i16 (length c))
	(map encode-f32 c)
	(encode-i16 (length d))
	(map encode-f32 d)
	(encode-i16 (length k))
	(map encode-control k)
	(encode-i16 (length u))
	(map encode-ugen u))))))

