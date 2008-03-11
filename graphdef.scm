
;; control

;; A <control> is accessed by a <string> name and an <integer> index.

(define-structure control name index)

(define (control->npt c)
  (list (pstr (control-name c))
	(i16 (control-index c))))

;; A <control*> is a place holder for a <control>.

(define-structure control* name default rate lag)


;; graphdef

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


;; uid

(define-structure uid value)

;; Counting from 1...

(define unique-uid
  (let ((id 0))
    (lambda ()
      (set! id (+ id 1))
      (make-uid id))))


;; input

;; An <input> represents a UGen input signal in a UGen graph, an
;; 'Input Specification'.  The <integer> ugen is the index of the
;; UGen, the <integer> port is an output port at ugen.

(define-structure input ugen port)

(define (input->npt i)
  (list (i16 (input-ugen i))
	(i16 (input-port i))))


;; letc

;; Syntax for defining <control*> values.  Does not implement rate or
;; lag variants.  See deleted file control-set.scm for details.

(define-syntax letc
  (syntax-rules ()
    ((_ () expr)
     expr)
    ((_ ((name default) ...) expr)
     (let ((name (make-control* (symbol->string (quote name)) default kr 0))
	   ...)
       expr))))


;; mce

(define-structure mce channels)

(define (Mce . channels)
  (if (null? channels)
      (error "empty mce")
      (make-mce channels)))

(define (mce-channel u n)
  (list-ref (mce-channels u) n))


;; mrg

(define-structure mrg roots)

(define (Mrg . roots)
  (if (null? roots)
      (error 'Mrg "empty mrg")
      (make-mrg roots)))


;; output

;; An <output> represents a UGen output signal in a UGen graph.

(define-structure output rate)

(define (output->npt o)
  (u8 (rate-value (output-rate o))))

(define (make-outputs n r)
  (make-list n (make-output r)))


;; proxy

;; An <mce> of <proxy> records represents a UGen with multiple
;; outputs.

(define-structure proxy ugen port)


;; rate-of

(define (rate-of o)
  (cond ((number? o)    ir)
	((control*? o)  (control*-rate o))
	((ugen? o)      (ugen-rate o))
	((proxy? o)     (rate-of (proxy-ugen o)))
	((mce? o)       (rate-select (map rate-of (mce-channels o))))
	((mrg? o)       (error 'rate-of "mrg?" o))
	(else           (error 'rate-of "illegal value" o))))


;; rate

(define-structure rate value)

(define ir (make-rate 0))
(define kr (make-rate 1))
(define ar (make-rate 2))
(define dr (make-rate 3))

;; Order rates for determing the result of math operators.  Operators
;; involving a Demand rate UGen operate at Demand rate.

(define (rate->ordinal r)
  (cond ((eq? r ir)  0)
	((eq? r kr)  1)
	((eq? r ar)  2)
	((eq? r dr)  3)
	(else        (error 'rate->ordinal "illegal rate"))))

(define (rate-select* a b)
  (let ((a* (rate->ordinal a))
	(b* (rate->ordinal b)))
    (if (> a* b*) a b)))

(define (rate-select l)
  (foldl1 rate-select* l))


;; ugen

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

(define (input*? i)
  (or (number? i)
      (control*? i)
      (ugen? i)
      (proxy? i)
      (mce? i)))

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

(define (clone n u)
  (make-mce
   (map (lambda (_) (uniquify u)) (iota n))))
