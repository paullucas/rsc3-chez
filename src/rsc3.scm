;; [a] -> int -> [a]
(define extend
  (lambda (l n)
    (let ((z (length l)))
      (cond ((= z n) l)
	    ((> z n) (take n l))
	    (else (extend (append2 l l) n))))))

;; [a] -> int -> [a]
(define take-cycle
  (lambda (l n)
    (if (null? l)
	nil
	(cons (head l)
	      (take-cycle (drop n l) n)))))

;; (a -> a -> a) -> ([a] -> [a])
(define d->dx 
  (lambda (f)
    (lambda (l)
      (unfoldr
       (lambda (x)
	 (if (null? (tail x))
	     #f
	     (tuple2 (f (head (tail x)) (head x)) (tail x))))
       l))))

;; (a -> a -> a) -> (a -> [a] -> [a])
(define dx->d 
  (lambda (f)
    (lambda (n i)
      (if (null? i)
	  (list1 n)
	  (cons n (dx->d (f (head i) n) (tail i)))))))

;; ord a => a -> a -> a
(define s:lt
  (lambda (p q)
    (if (< p q) 1 0)))

;; ord a => a -> a -> a
(define s:le
  (lambda (p q)
    (if (<= p q) 1 0)))

;; ord a => a -> a -> a
(define s:ge
  (lambda (p q)
    (if (>= p q) 1 0)))

;; ord a => a -> a -> a
(define s:gt
  (lambda (p q)
    (if (> p q) 1 0)))

;; ord a => a -> a -> a -> a
(define s:clip
  (lambda (a b n) 
    (cond ((< n a) a)
	  ((> n b) b)
	  (else n))))

;; number a => a -> a
(define s:squared 
  (lambda (n)
    (* n n)))

;; number a => a -> a
(define s:cubed 
  (lambda (n)
    (* n n n)))

;; number a => a -> a
(define s:recip 
  (lambda (n)
    (/ 1 n)))

;; float
(define e 
  (exp 1.0))

;; float
(define pi
  (* 4 (atan 1)))

;; float -> float
(define s:log2
  (lambda (x)
    (/ (log (abs x)) (log 2))))

;; float -> float
(define s:log10
  (lambda (x)
    (/ (log x) (log 10))))

;; float -> float
(define s:amp-db 
  (lambda (x) 
    (* (s:log10 x) 20)))

;; float -> float
(define s:db-amp
  (lambda (x)
    (expt 10 (* x 0.05))))

;; float -> float
(define powdb
  (lambda (x) 
    (* (s:log10 x) 10)))

;; float -> float
(define dbpow
  (lambda (x) 
    (expt 10 (* x 0.1))))

;; float -> float
(define s:midi-cps
  (lambda (note)
    (* 440.0 (expt 2.0 (* (- note 69.0) 0.083333333333)))))

;; float -> float
(define s:cps-midi
  (lambda (freq)
    (+ (* (s:log2 (* freq 0.0022727272727)) 12.0) 69.0)))

;; float -> float
(define s:midi-ratio
  (lambda (midi)
    (expt 2.0 (* midi 0.083333333333))))

;; float -> float
(define s:ratio-midi
  (lambda (ratio)
    (* 12.0 (s:log2 ratio))))

;; float -> float
(define s:oct-cps
  (lambda (note)
    (* 440.0 (expt 2.0 (- note 4.75)))))

;; float -> float
(define s:cps-oct
  (lambda (freq)
    (+ (s:log2 (* freq 0.0022727272727)) 4.75)))

;; float -> [float] -> int -> float
(define degree->key
  (lambda (degree scale steps)
    (let ((scale-n (length scale)))
      (+ (* steps (div degree scale-n))
	 (list-ref scale (exact (mod degree scale-n)))))))

;; int -> [any] -> [any]
(define without
  (lambda (n l)
    (append2 (take n l) (drop (+ n 1) l))))

;; [int] -> bool
(define consecutive?
  (lambda (l)
    (let ((x (head l))
	  (xs (tail l)))
      (or (null? xs)
	  (and (= (+ x 1) (head xs))
	       (consecutive? xs))))))
;; int -> uid
(define-record-type uid 
  (fields n))

;; () -> uid
(define unique-uid
  (let ((n 0))
    (lambda ()
      (set! n (+ n 1))
      (make-uid n))))

;; string -> int -> control
(define-record-type control 
  (fields name index))

;; string -> float -> rate -> float -> control*
(define-record-type control* 
  (fields name default rate lag))

;; string -> [float] -> [float] -> [controls] -> [ugens] -> graphdef
(define-record-type graphdef 
  (fields name constants defaults controls ugens))

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
(define-record-type input 
  (fields ugen port))

;; [ugen] -> mce
(define-record-type mce 
  (fields channels))

;; ugen -> ugen -> mce
(define mce2
  (lambda (a b)
    (make-mce (list2 a b))))

;; ugen -> ugen -> ugen -> mce
(define mce3
  (lambda (a b c)
    (make-mce (list3 a b c))))

;; ugen -> ugen -> ugen -> ugen -> mce
(define mce4
  (lambda (a b c d)
    (make-mce (list4 a b c d))))

;; ugen -> ugen -> ugen -> ugen -> ugen -> mce
(define mce5
  (lambda (a b c d e)
    (make-mce (list5 a b c d e))))

;; mce -> int -> ugen
(define mce-channel
  (lambda (u n)
    (list-ref (mce-channels u) n)))

;; ugen -> ugen -> mrg
(define-record-type mrg
  (fields left right))

;; [ugen] -> mrg
(define mrg-n
  (lambda (xs)
    (if (null? xs)
	(undefined)
	(if (null? (tail xs))
	    (head xs)
	    (mrg2 (head xs) (mrg-n (tail xs)))))))

;; ugen -> ugen -> mrg
(define mrg2
  make-mrg)

;; ugen -> ugen -> ugen -> mrg
(define mrg3
  (lambda (a b c)
    (make-mrg a (make-mrg b c))))

;; ugen -> ugen -> ugen -> ugen -> mrg
(define mrg4
  (lambda (a b c d)
    (make-mrg a (make-mrg b (make-mrg c d)))))

;; rate -> output
(define-record-type output
  (fields rate))

;; ugen -> int -> proxy
(define-record-type proxy
  (fields ugen port))

;; int -> rate
(define-record-type rate
  (fields value))

;; rate
(define ir
  (make-rate 0))

;; rate
(define kr
  (make-rate 1))

;; rate
(define ar
  (make-rate 2))

;; rate
(define dr
  (make-rate 3))

;; any -> rate
(define rate-of
  (lambda (o)
    (cond ((number? o) ir)
	  ((control*? o) (control*-rate o))
	  ((ugen? o) (ugen-rate o))
	  ((proxy? o) (rate-of (proxy-ugen o)))
	  ((mce? o) (rate-select (map rate-of (mce-channels o))))
	  ((mrg? o) (error "rate-of" "mrg?" o))
	  (else (error "rate-of" "illegal value" o)))))

;; rate -> int
(define rate-to-ordinal
  (lambda (r)
    (cond ((eq? r ir) 0)
	  ((eq? r kr) 1)
	  ((eq? r ar) 2)
	  ((eq? r dr) 3)
	  (else (error "rate-to-ordinal" "illegal rate")))))

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

;; string -> rate -> [ugen] -> [output] -> int -> uid -> ugen
(define-record-type ugen
  (fields name rate inputs outputs special id))

;; ugen -> int -> output
(define ugen-output
  (lambda (u n)
    (list-ref (ugen-outputs u) n)))

;; ugen -> (ugen -> any) -> any
(define ugen-transform
  (lambda (u f)
    (let ((n (ugen-name u))
	  (r (ugen-rate u))
	  (i (ugen-inputs u))
	  (o (ugen-outputs u))
	  (s (ugen-special u))
	  (d (ugen-id u)))
      (f n r i o s d))))

;; any -> bool
(define input*?
  (lambda (i)
    (or (number? i)
	(control*? i)
	(ugen? i)
	(proxy? i)
	(mce? i))))

;; ugen -> bool
(define ugen-valid?
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

;; int -> (() -> ugen) -> mce
(define clone*
  (lambda (n f)
    (make-mce (replicate-m* n f))))

(define-syntax clone
  (syntax-rules ()
    ((_ n u) (make-mce (replicate-m n u)))))

;; control -> [bytevector]
(define encode-control
  (lambda (c)
    (list (encode-pstr (control-name c))
	  (encode-i16 (control-index c)))))

;; input -> [bytevector]
(define encode-input
  (lambda (i)
    (list (encode-i16 (input-ugen i))
	  (encode-i16 (input-port i)))))

;; output -> [bytevector]
(define encode-output
  (lambda (o)
    (encode-u8 (rate-value (output-rate o)))))

;; [bytevector]
(define scgf 
  (map encode-u8 (map char->integer (string->list "SCgf"))))

;; ugen -> [bytevector]
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

;; graphdef -> bytevector
(define encode-graphdef
  (lambda (g)
    (flatten-bytevectors
     (let ((n (graphdef-name g))
	   (c (graphdef-constants g))
	   (d (graphdef-defaults g))
	   (k (graphdef-controls g))
	   (u (graphdef-ugens g)))
       (list
	scgf
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

;; syntax for binding control values
(define-syntax letc
  (syntax-rules ()
    ((_ () expr)
     expr)
    ((_ ((name default) ...) expr)
     (let ((name (make-control* (symbol->string (quote name)) default kr 0))
	   ...)
       expr))))

;; node = ugen | proxy | control* | float

;; string -> maybe rate -> [node] -> maybe node -> int -> int -> uid -> ugen
(define construct-ugen
  (lambda (name rate? inputs mce? outputs special id)
    (let* ((inputs* (if mce?
			(append2 inputs (mce-l mce?))
			inputs))
	   (rate (if rate?
		     rate?
		     (rate-select (map1 rate-of inputs*))))
	   (u (make-ugen
	       name
	       rate
	       inputs*
	       (replicate outputs (make-output rate))
	       special
	       id)))
      (proxied (mced u)))))

;; ugen -> [node]
(define graph-nodes
  (lambda (u)
    (cond
     ((ugen? u) (cons u (concat-map graph-nodes (ugen-inputs u))))
     ((proxy? u) (cons u (graph-nodes (proxy-ugen u))))
     ((control*? u) (list u))
     ((number? u) (list u))
     ((mce? u) (concat (map1 graph-nodes (mce-channels u))))
     ((mrg? u) (append2 (graph-nodes (mrg-left u)) (graph-nodes (mrg-right u))))
     (else (error "graph-nodes" "illegal value" u)))))

;; ugen -> [float]
(define graph-constants
  (lambda (u)
    (nub (filter number? (graph-nodes u)))))

;; ugen -> [control*]
(define graph-controls*
  (lambda (u)
    (nub (filter control*? (graph-nodes u)))))

;; ugen -> [ugen]
(define graph-ugens
  (lambda (u)
    (nub (reverse (filter ugen? (graph-nodes u))))))

;; ugen -> [node] -> [control] -> [ugen] -> ugen
(define ugen-close
  (lambda (u nn cc uu)
    (if (not (ugen-valid? u))
	(error "ugen-close" "invalid ugen" u)
	(make-ugen (ugen-name u)
		   (ugen-rate u)
		   (map1 (lambda (i)
			   (input*-to-input i nn cc uu))
			 (ugen-inputs u))
		   (ugen-outputs u)
		   (ugen-special u)
		   (ugen-id u)))))

;; string -> ugen -> graphdef
(define synthdef
  (lambda (name u)
    (let* ((nn (graph-constants u))
	   (cc (graph-controls* u))
	   (uu (graph-ugens u))
	   (uu* (if (null? cc) uu (cons (implicit-ugen cc) uu))))
      (make-graphdef
       name
       nn
       (map1 control*-default cc)
       (map1 (lambda (c) (control*-to-control c cc)) cc)
       (map1 (lambda (u) (ugen-close u nn cc uu*)) uu*)))))

;; [control] -> ugen
(define implicit-ugen
  (lambda (cc)
    (make-ugen "Control"
	       kr
	       (list)
	       (map1 make-output (replicate (length cc) kr))
	       0
	       (make-uid 0))))

;; node -> [node] -> int
(define calculate-index
  (lambda (n nn)
    (let ((i (find-index (lambda (e) (equal? e n)) nn)))
      (if (not i)
	  (error "calculate-index" "not located" n nn)
	  i))))

;; float -> [node] -> input
(define number-to-input
  (lambda (n nn)
    (make-input -1 (calculate-index n nn))))

;; control* -> [control*] -> control
(define control*-to-control
  (lambda (c cc)
    (make-control (control*-name c) (calculate-index c cc))))

;; control* -> [control*] -> input
(define control*-to-input
  (lambda (c cc)
    (make-input 0 (calculate-index c cc))))

;; ugen -> [ugen] -> input
(define ugen-to-input
  (lambda (u uu)
    (make-input (calculate-index u uu) 0)))

;; proxy -> [ugen] -> input
(define proxy-to-input
  (lambda (p uu)
    (make-input (calculate-index (proxy-ugen p) uu)
		(proxy-port p))))

;; node -> [node] -> [control] -> [ugen] -> input
(define input*-to-input
  (lambda (i nn cc uu)
    (cond
     ((number? i) (number-to-input i nn))
     ((control*? i) (control*-to-input i cc))
     ((ugen? i) (ugen-to-input i uu))
     ((proxy? i) (proxy-to-input i uu))
     ((mce? i) (error "input*-to-input" "mce?" i))
     ((mrg? i) (error "input*-to-input" "mrg?" i))
     (else (error "input*-to-input" "illegal input" i)))))

;; mce -> int
(define mce-degree
  (lambda (m)
    (length (mce-channels m))))

;; mce -> int -> node
(define mce-ref
  (lambda (m n)
    (list-ref (mce-channels m) n)))

;; mce -> mce
(define mce-reverse
  (lambda (u)
    (make-mce (reverse (mce-channels u)))))

;; mce -> mce
(define mce-transpose
  (lambda (u)
    (make-mce (map make-mce (transpose (map mce-channels (mce-channels u)))))))

;; node -> bool
(define mce-required?
  (lambda (u)
    (not (null? (filter mce? (ugen-inputs u))))))

;; int -> node -> [node]
(define mce-extend
  (lambda (n i)
    (if (mce? i)
	(extend (mce-channels i) n)
	(replicate n i))))

;; ugen -> mce
(define mce-transform
  (lambda (u)
    (ugen-transform
     u
     (lambda (n r i o s d)
       (let* ((f (lambda (i*) (make-ugen n r i* o s d)))
	      (m (maximum (map1 mce-degree (filter mce? i))))
	      (e (lambda (i) (mce-extend m i)))
	      (i* (transpose (map1 e i))))
	 (make-mce (map1 f i*)))))))

;; node -> node|mce
(define mced
  (lambda (u)
    (if (mce-required? u)
	(mce-transform u)
	u)))

;; node -> [node]
(define mce-l
  (lambda (u)
    (if (mce? u)
	(mce-channels u)
	(list u))))

;; node -> mce
(define proxied
  (lambda (u)
    (cond
     ((ugen? u) (let* ((o (ugen-outputs u))
		       (n (length o)))
		  (if (< n 2)
		      u
		      (make-mce (map1 (lambda (i) (make-proxy u i))
				      (enum-from-to 0 (- n 1)))))))
     ((mce? u) (make-mce (map1 proxied (mce-channels u)))))))

;; int -> maybe (float -> float) -> (node -> node)
(define mk-unary-operator
  (lambda (s f)
    (lambda (a)
      (if (and (number? a) 
	       f)
	  (f a)
	  (construct-ugen "UnaryOpUGen" #f (list a) #f 1 s (make-uid 0))))))

;; int -> maybe (float -> float -> float) -> (node -> node -> node)
(define mk-binary-operator
  (lambda (s f)
    (lambda (a b)
      (if (and (number? a)
	       (number? b)
	       f)
	  (f a b)
	  (construct-ugen "BinaryOpUGen" #f (list a b) #f 1 s (make-uid 0))))))

;; string -> [symbol] -> int ~> (ugen ... -> ugen)
(define-syntax mk-filter
  (syntax-rules ()
    ((_ m (i ...) o)
     (lambda (i ...)
       (construct-ugen m #f (list i ...) #f o 0 (make-uid 0))))))

;; string -> [symbol] ~> (int -> ugen ... -> ugen)
(define-syntax mk-filter-n
  (syntax-rules ()
    ((_ m (i ...))
     (lambda (nc i ...)
       (if (not (integer? nc))
	   (error "define-filter-n" "illegal channel count" 'n nc)
	   #f)
       (let ((l (list i ...)))
	 (construct-ugen m #f l #f nc 0 (make-uid 0)))))))

;; string -> [symbol] -> int ~> (ugen ... -> ugen)
(define-syntax mk-filter*
  (syntax-rules ()
    ((_ m (i ... v) o)
     (lambda (i ... v)
       (construct-ugen m #f (list i ...) v o 0 (make-uid 0))))))

;; string -> [symbol] -> int ~> (ugen ... -> ugen)
(define-syntax mk-filter-id
  (syntax-rules ()
    ((_ m (i ...) o)
     (lambda (i ...)
       (construct-ugen m #f (list i ...) #f o 0 (unique-uid))))))

;; string -> [symbol] -> int -> int ~> (ugen ... -> ugen)
(define-syntax mk-filter-k
  (syntax-rules ()
    ;; k = keyed input
    ((_ m (i ...) o k)
     (lambda (i ...)
       (let ((l (list i ...)))
	 (construct-ugen m (rate-of (list-ref l k)) l #f o 0 (make-uid 0)))))))

;; string -> [symbol] -> int ~> (rate -> ugen ... -> ugen)
(define-syntax mk-oscillator
  (syntax-rules ()
    ((_ m (i ...) o)
     (lambda (r i ...)
       (construct-ugen m r (list i ...) #f o 0 (make-uid 0))))))

;; string -> [symbol] ~> (int -> rate -> ugen ... -> ugen)
(define-syntax mk-oscillator-n
  (syntax-rules ()
    ((_ m (i ...))
     (lambda (nc r i ...)
       (if (not (integer? nc))
	   (error "define-oscillator-n" "illegal channel count:" 'n nc)
	   #f)
       (let ((l (list i ...)))
	 (construct-ugen m r l #f nc 0 (make-uid 0)))))))

;; string -> [symbol] -> int ~> (rate -> ugen ... -> ugen)
(define-syntax mk-oscillator*
  (syntax-rules ()
    ((_ m (i ... v) o)
     (lambda (r i ... v)
       (construct-ugen m r (list i ...) v o 0 (make-uid 0))))))

;; string -> [symbol] -> int ~> (rate -> ugen ... -> ugen)
(define-syntax mk-oscillator-id
  (syntax-rules ()
    ((_ m (i ...) o)
     (lambda (r i ...)
       (construct-ugen m r (list i ...) #f o 0 (unique-uid))))))

;; string -> [symbol] -> int -> rate ~> (ugen ... -> ugen)
(define-syntax mk-specialized
  (syntax-rules ()
    ((_ m (i ...) o r)
     (lambda (i ...)
       (construct-ugen m r (list i ...) #f o 0 (make-uid 0))))))

;; string -> int -> rate ~> ugen
(define-syntax mk-specialized-c
  (syntax-rules ()
    ((_ m o r)
     (construct-ugen m r (list) #f o 0 (make-uid 0)))))

;; string -> [symbol] -> int -> rate ~> (ugen ... -> ugen)
(define-syntax mk-specialized*
  (syntax-rules ()
    ((_ m (i ... v) o r)
     (lambda (i ... v)
       (construct-ugen m r (list i ...) v o 0 (make-uid 0))))))

;; string -> [symbol] -> rate ~> (int -> ugen ... -> ugen)
(define-syntax mk-specialized-n
  (syntax-rules ()
    ((_ m (i ...) r)
     (lambda (nc i ...)
       (if (not (integer? nc))
	   (error "define-specialized-n" "illegal channel count:" 'n nc)
	   #f)
       (let ((l (list i ...)))
	 (construct-ugen m r l #f nc 0 (make-uid 0)))))))

;; string -> [symbol] -> int -> rate ~> (ugen ... -> ugen)
(define-syntax mk-specialized-id
  (syntax-rules ()
    ((_ m (i ...) o r)
     (lambda (i ...)
       (construct-ugen m r (list i ...) #f o 0 (unique-uid))))))

;; string -> [symbol] -> int -> rate ~> (ugen ... -> ugen)
(define-syntax mk-specialized*-id
  (syntax-rules ()
    ((_ m (i ... v) o r)
     (lambda (i ... v)
       (construct-ugen m r (list i ...) v o 0 (unique-uid))))))

;; ugen -> ugen
(define u:abs (mk-unary-operator 5 abs))
(define amp-db (mk-unary-operator 22 s:amp-db))
(define arc-cos (mk-unary-operator 32 acos))
(define arc-sin (mk-unary-operator 31 asin))
(define arc-tan (mk-unary-operator 33 atan))
(define as-float (mk-unary-operator 6 #f))
(define as-int (mk-unary-operator 7 #f))
(define bi-lin-rand (mk-unary-operator 40 #f))
(define bit-not (mk-unary-operator 4 #f))
(define cps-midi (mk-unary-operator 18 s:cps-midi))
(define cps-oct (mk-unary-operator 24 s:cps-oct))
(define ceil (mk-unary-operator 8 ceiling))
(define coin (mk-unary-operator 44 #f))
(define u:cos (mk-unary-operator 29 cos))
(define cos-h (mk-unary-operator 35 #f))
(define cubed (mk-unary-operator 13 s:cubed))
(define db-amp (mk-unary-operator 21 s:db-amp))
(define digit-value (mk-unary-operator 45 #f))
(define distort (mk-unary-operator 42 #f))
(define u:exp (mk-unary-operator 15 exp))
(define u:floor (mk-unary-operator 9 floor))
(define frac (mk-unary-operator 10 #f))
(define han-window (mk-unary-operator 49 #f))
(define is-nil (mk-unary-operator 2 #f))
(define u:log (mk-unary-operator 25 log))
(define log10 (mk-unary-operator 27 s:log10))
(define log2 (mk-unary-operator 26 s:log2))
(define midi-cps (mk-unary-operator 17 s:midi-cps))
(define midi-ratio (mk-unary-operator 19 s:midi-ratio))
(define neg (mk-unary-operator 0 -))
(define u:not (mk-unary-operator 1 #f))
(define not-nil (mk-unary-operator 3 #f))
(define oct-cps (mk-unary-operator 23 s:oct-cps))
(define rand2 (mk-unary-operator 38 #f))
(define ratio-midi (mk-unary-operator 20 s:ratio-midi))
(define recip (mk-unary-operator 16 s:recip))
(define rect-window (mk-unary-operator 48 #f))
(define scurve (mk-unary-operator 53 #f))
(define sign (mk-unary-operator 11 #f))
(define silence (mk-unary-operator 46 #f))
(define u:sin (mk-unary-operator 28 sin))
(define sin-h (mk-unary-operator 34 #f))
(define soft-clip (mk-unary-operator 43 #f))
(define u:sqrt (mk-unary-operator 14 sqrt))
(define squared (mk-unary-operator 12 s:squared))
(define sum3rand (mk-unary-operator 41 #f))
(define u:tan (mk-unary-operator 30 tan))
(define tan-h (mk-unary-operator 36 #f))
(define thru (mk-unary-operator 47 #f))
(define tri-window (mk-unary-operator 51 #f))
(define welch-window (mk-unary-operator 50 #f))
(define lin-rand* (mk-unary-operator 39 #f))
(define ramp* (mk-unary-operator 52 #f))
(define rand* (mk-unary-operator 37 #f))

;; ugen -> ugen -> ugen
(define amclip (mk-binary-operator 40 #f))
(define abs-dif (mk-binary-operator 38 #f))
(define add (mk-binary-operator 0 +))
(define atan2 (mk-binary-operator 22 #f))
(define bit-and (mk-binary-operator 14 #f))
(define bit-or (mk-binary-operator 15 #f))
(define bit-xor (mk-binary-operator 16 #f))
(define clip2 (mk-binary-operator 42 #f))
(define dif-sqr (mk-binary-operator 34 #f))
(define eq (mk-binary-operator 6 #f))
(define excess (mk-binary-operator 43 #f))
(define exp-rand-range (mk-binary-operator 48 #f))
(define fdiv (mk-binary-operator 4 /))
(define fill (mk-binary-operator 29 #f))
(define first-arg (mk-binary-operator 46 #f))
(define fold2 (mk-binary-operator 44 #f))
(define u:gcd (mk-binary-operator 18 #f))
(define ge (mk-binary-operator 11 s:ge))
(define gt (mk-binary-operator 9 s:gt))
(define hypot (mk-binary-operator 23 #f))
(define hypotx (mk-binary-operator 24 #f))
(define idiv (mk-binary-operator 3 #f))
(define u:lcm (mk-binary-operator 17 #f))
(define le (mk-binary-operator 10 s:le))
(define lt (mk-binary-operator 8 s:lt))
(define u:max (mk-binary-operator 13 max))
(define u:min (mk-binary-operator 12 min))
(define u:mod (mk-binary-operator 5 #f))
(define mul (mk-binary-operator 2 *))
(define ne (mk-binary-operator 7 #f))
(define pow (mk-binary-operator 25 #f))
(define rand-range (mk-binary-operator 47 #f))
(define ring1 (mk-binary-operator 30 #f))
(define ring2 (mk-binary-operator 31 #f))
(define ring3 (mk-binary-operator 32 #f))
(define ring4 (mk-binary-operator 33 #f))
(define u:round (mk-binary-operator 19 #f))
(define round-up (mk-binary-operator 20 #f))
(define scale-neg (mk-binary-operator 41 #f))
(define shift-left (mk-binary-operator 26 #f))
(define shift-right (mk-binary-operator 27 #f))
(define sqr-dif (mk-binary-operator 37 #f))
(define sqr-sum (mk-binary-operator 36 #f))
(define sub (mk-binary-operator 1 -))
(define sum-sqr (mk-binary-operator 35 #f))
(define thresh (mk-binary-operator 39 #f))
(define trunc (mk-binary-operator 21 #f))
(define unsigned-shift (mk-binary-operator 28 #f))
(define wrap2 (mk-binary-operator 45 #f))

(define apf (mk-filter "APF" (in freq radius) 1))
(define allpass-c (mk-filter "AllpassC" (in max-dt dt decay) 1))
(define allpass-l (mk-filter "AllpassL" (in max-dt dt decay) 1))
(define allpass-n (mk-filter "AllpassN" (in max-dt dt decay) 1))
(define amp-comp (mk-filter "AmpComp" (freq root exp) 1))
(define amp-comp-a (mk-filter "AmpCompA" (freq root min-amp root-amp) 1))
(define bpf (mk-filter "BPF" (in freq rq) 1))
(define bpz2 (mk-filter "BPZ2" (in) 1))
(define brf (mk-filter "BRF" (in freq rq) 1))
(define brz2 (mk-filter "BRZ2" (in) 1))
(define balance2 (mk-filter "Balance2" (left right pos level) 1))
(define ball (mk-filter "Ball" (in g damp friction) 1))
(define bi-pan-b2 (mk-filter "BiPanB2" (in-a in-b azimuth gain) 3))
(define buf-allpass-c (mk-filter "BufAllpassC" (buf in delaytime decaytime) 1))
(define buf-allpass-l (mk-filter "BufAllpassL" (buf in delaytime decaytime) 1))
(define buf-allpass-n (mk-filter "BufAllpassN" (buf in delaytime decaytime) 1))
(define buf-comb-c (mk-filter "BufCombC" (buf in delaytime decaytime) 1))
(define buf-comb-l (mk-filter "BufCombL" (buf in delaytime decaytime) 1))
(define buf-comb-n (mk-filter "BufCombN" (buf in delaytime decaytime) 1))
(define buf-delay-c (mk-filter "BufDelayC" (buf in delaytime) 1))
(define buf-delay-l (mk-filter "BufDelayL" (buf in delaytime) 1))
(define buf-delay-n (mk-filter "BufDelayN" (buf in delaytime) 1))
(define clip (mk-filter "Clip" (in lo hi) 1))
(define comb-c (mk-filter "CombC" (in maxdelaytime delaytime decaytime) 1))
(define comb-l (mk-filter "CombL" (in maxdelaytime delaytime decaytime) 1))
(define comb-n (mk-filter "CombN" (in maxdelaytime delaytime decaytime) 1))
(define compander (mk-filter "Compander" (in ctl thr sl-blw sl-abv cl-tm rx-tm) 1))
(define compander-d (mk-filter "CompanderD" (in thr sl-blw sl-abv cl-tm rx-tm) 1))
(define decay (mk-filter "Decay" (in decay-time) 1))
(define decay2 (mk-filter "Decay2" (in attack-time decay-time) 1))
(define degree-to-key (mk-filter "DegreeToKey" (bufnum in octave) 1))
(define delay1 (mk-filter "Delay1" (in) 1))
(define delay2 (mk-filter "Delay2" (in) 1))
(define delay-c (mk-filter "DelayC" (in maxdelaytime delaytime) 1))
(define delay-l (mk-filter "DelayL" (in maxdelaytime delaytime) 1))
(define delay-n (mk-filter "DelayN" (in maxdelaytime delaytime) 1))
(define detect-silence (mk-filter "DetectSilence" (in amp time done-action) 1))
(define done (mk-filter "Done" (src) 1))
(define fos (mk-filter "FOS" (in a0 a1 b1) 1))
(define fold (mk-filter "Fold" (in lo hi) 1))
(define formlet (mk-filter "Formlet" (in freq attacktime decaytime) 1))
(define free (mk-filter "Free" (in node-id) 1))
(define free-self (mk-filter "FreeSelf" (in) 1))
(define free-self-when-done (mk-filter "FreeSelfWhenDone" (in) 1))
(define free-verb (mk-filter "FreeVerb" (in mix room damp) 1))
(define free-verb2 (mk-filter "FreeVerb2" (in1 in2 mix room damp) 2))
(define gate (mk-filter "Gate" (in trig) 1))
(define hpf (mk-filter "HPF" (in freq) 1))
(define hpz1 (mk-filter "HPZ1" (in) 1))
(define hpz2 (mk-filter "HPZ2" (in) 1))
(define hasher (mk-filter "Hasher" (in) 1))
(define hilbert (mk-filter "Hilbert" (in) 2))
(define image-warp (mk-filter "ImageWarp" (pic x y interpolation-type) 1))
(define in-range (mk-filter "InRange" (in lo hi) 1))
(define in-rect (mk-filter "InRect" (x y rect) 1))
(define index (mk-filter "Index" (bufnum in) 1))
(define integrator (mk-filter "Integrator" (in coef) 1))
(define lpf (mk-filter "LPF" (in freq) 1))
(define lpz1 (mk-filter "LPZ1" (in) 1))
(define lpz2 (mk-filter "LPZ2" (in) 1))
(define lag (mk-filter "Lag" (in lag-time) 1))
(define lag2 (mk-filter "Lag2" (in lag-time) 1))
(define lag3 (mk-filter "Lag3" (in lag-time) 1))
(define lag-control (mk-filter "LagControl" () 1))
(define last-value (mk-filter "LastValue" (in diff) 1))
(define latch (mk-filter "Latch" (in trig) 1))
(define leak-dc (mk-filter "LeakDC" (in coef) 1))
(define least-change (mk-filter "LeastChange" (a b) 1))
(define limiter (mk-filter "Limiter" (in level dur) 1))
(define lin-exp (mk-filter "LinExp" (in srclo srchi dstlo dsthi) 1))
(define lin-lin (mk-filter "LinLin" (in srclo srchi dstlo dsthi) 1))
(define lin-pan2 (mk-filter "LinPan2" (in pos level) 2))
(define lin-x-fade2 (mk-filter "LinXFade2" (in-a in-b pan level) 1))
(define linen (mk-filter "Linen" (gate atk-time sus-lvl rel-time done-action) 1))
(define mantissa-mask (mk-filter "MantissaMask" (in bits) 1))
(define median (mk-filter "Median" (length in) 1))
(define mid-eq (mk-filter "MidEq" (in freq rq db) 1))
(define moog-ff (mk-filter "MoogFF" (in freq gain reset) 1))
(define most-change (mk-filter "MostChange" (a b) 1))
(define mul-add (mk-filter "MulAdd" (a b c) 1))
(define normalizer (mk-filter "Normalizer" (in level dur) 1))
(define one-pole (mk-filter "OnePole" (in coef) 1))
(define one-zero (mk-filter "OneZero" (in coef) 1))
(define pan2 (mk-filter "Pan2" (in pos level) 2))
(define pan4 (mk-filter "Pan4" (in xpos ypos level) 4))
(define pan-az (mk-filter "PanAz" (num-chans in pos level width orientation) 1))
(define pan-b (mk-filter "PanB" (in azimuth elevation gain) 3))
(define pan-b2 (mk-filter "PanB2" (in azimuth gain) 3))
(define pause (mk-filter "Pause" (in node-id) 1))
(define pause-self (mk-filter "PauseSelf" (in) 1))
(define pause-self-when-done (mk-filter "PauseSelfWhenDone" (in) 1))
(define peak (mk-filter "Peak" (trig reset) 1))
(define peak-follower (mk-filter "PeakFollower" (in decay) 1))
(define pitch-shift (mk-filter "PitchShift" (in win-sz p-ratio p-disp t-disp) 1))
(define pluck (mk-filter "Pluck" (in trig max-dt dt decay coef) 1))
(define pulse-count (mk-filter "PulseCount" (trig reset) 1))
(define pulse-divider (mk-filter "PulseDivider" (trig div start) 1))
(define rhpf (mk-filter "RHPF" (in freq rq) 1))
(define rlpf (mk-filter "RLPF" (in freq rq) 1))
(define ramp (mk-filter "Ramp" (in lag-time) 1))
(define resonz (mk-filter "Resonz" (in freq bwr) 1))
(define ringz (mk-filter "Ringz" (in freq decaytime) 1))
(define rotate2 (mk-filter "Rotate2" (x y pos) 2))
(define running-max (mk-filter "RunningMax" (in trig) 1))
(define running-min (mk-filter "RunningMin" (in trig) 1))
(define running-sum (mk-filter "RunningSum" (in numsamp) 1))
(define sos (mk-filter "SOS" (in a0 a1 a2 b1 b2) 1))
(define schmidt (mk-filter "Schmidt" (in lo hi) 1))
(define send-trig (mk-filter "SendTrig" (in id value) 0))
(define set-reset-ff (mk-filter "SetResetFF" (trig reset) 1))
(define shaper (mk-filter "Shaper" (bufnum in) 1))
(define slew (mk-filter "Slew" (in up dn) 1))
(define slope (mk-filter "Slope" (in) 1))
(define spring (mk-filter "Spring" (in spring damp) 1))
(define stepper (mk-filter "Stepper" (trig reset min max step resetval) 1))
(define sweep (mk-filter "Sweep" (trig rate) 1))
(define t-ball (mk-filter "TBall" (in g damp friction) 1))
(define t-delay (mk-filter "TDelay" (in dur) 1))
(define t-pulse (mk-filter "TPulse" (trig freq width) 1))
(define timer (mk-filter "Timer" (trig) 1))
(define toggle-ff (mk-filter "ToggleFF" (trig) 1))
(define trapezoid (mk-filter "Trapezoid" (in a b c d) 1))
(define trig (mk-filter "Trig" (in dur) 1))
(define trig1 (mk-filter "Trig1" (in dur) 1))
(define two-pole (mk-filter "TwoPole" (in freq radius) 1))
(define two-zero (mk-filter "TwoZero" (in freq radius) 1))
(define vibrato (mk-filter "Vibrato" (f rt dpth dly onset rvar dvar iphase) 1))
(define wrap (mk-filter "Wrap" (in lo hi) 1))
(define wrap-index (mk-filter "WrapIndex" (bufnum in) 1))
(define x-fade2 (mk-filter "XFade2" (in-a in-b pan level) 1))
(define xy (mk-filter "XY" (xscale yscale xoff yoff rot rate) 1))
(define zero-crossing (mk-filter "ZeroCrossing" (in) 1))

(define decode-b2 (mk-filter-n "DecodeB2" (w x y orientation)))
(define silent (mk-filter-n "Silent" ()))
(define t-grains (mk-filter-n  "TGrains" (tr b rt c-pos dur pan amp interp)))

(define buf-wr (mk-filter* "BufWr" (bufnum phase loop input-array) 1))
(define disk-out (mk-filter* "DiskOut" (bufnum channels-array) 0))
(define klank (mk-filter* "Klank" (i f-scale f-offset dscale spec) 1))
(define local-out (mk-filter* "LocalOut" (channels-array) 0))
(define offset-out (mk-filter* "OffsetOut" (bus channels-array) 0))
(define out (mk-filter* "Out" (bus channels-array) 0))
(define poll (mk-filter* "Poll" (trig in trig-id label) 0))
(define record-buf (mk-filter* "RecordBuf" (b off rec-lvl pre-lvl run lp tr in) 1))
(define replace-out (mk-filter* "ReplaceOut" (bus channels-array) 0))
(define scope-out (mk-filter* "ScopeOut" (input-array bufnum) 0))
(define select (mk-filter* "Select" (which array) 1))
(define tw-index (mk-filter* "TWindex" (in normalize array) 1))
(define x-out (mk-filter* "XOut" (bus xfade channels-array) 0))

(define coin-gate (mk-filter-id "CoinGate" (prob in) 1))
(define t-exp-rand (mk-filter-id "TExpRand" (lo hi trig) 1))
(define ti-rand (mk-filter-id "TIRand" (lo hi trig) 1))
(define t-rand (mk-filter-id  "TRand" (lo hi trig) 1))

(define demand (mk-filter-k "Demand" (trig reset demand-ugens) 1 0))

(define amplitude (mk-oscillator "Amplitude" (in attack-time release-time) 1))
(define blip (mk-oscillator "Blip" (freq numharm) 1))
(define buf-channels (mk-oscillator "BufChannels" (buf) 1))
(define buf-dur (mk-oscillator "BufDur" (buf) 1))
(define buf-frames (mk-oscillator "BufFrames" (buf) 1))
(define buf-rate-scale (mk-oscillator "BufRateScale" (buf) 1))
(define buf-sample-rate (mk-oscillator "BufSampleRate" (buf) 1))
(define buf-samples (mk-oscillator "BufSamples" (buf) 1))
(define c-osc (mk-oscillator "COsc" (bufnum freq beats) 1))
(define crackle (mk-oscillator "Crackle" (chaos-param) 1))
(define cusp-l (mk-oscillator "CuspL" (freq a b xi) 1))
(define cusp-n (mk-oscillator "CuspN" (freq a b xi) 1))
(define demand-env-gen (mk-oscillator "DemandEnvGen" (level dur shape curve gate reset level-scale level-bias time-scale done-action) 1))
(define fb-sine-c (mk-oscillator "FBSineC" (freq im fb a c xi yi) 1))
(define fb-sine-l (mk-oscillator "FBSineL" (freq im fb a c xi yi) 1))
(define fb-sine-n (mk-oscillator "FBSineN" (freq im fb a c xi yi) 1))
(define f-sin-osc (mk-oscillator "FSinOsc" (freq iphase) 1))
(define formant (mk-oscillator "Formant" (fundfreq formfreq bwfreq) 1))
(define gbman-c (mk-oscillator "GbmanC" (freq xi yi) 1))
(define gbman-l (mk-oscillator "GbmanL" (freq xi yi) 1))
(define gbman-n (mk-oscillator "GbmanN" (freq xi yi) 1))
(define gendy1 (mk-oscillator "Gendy1" (ad dd adp ddp mnf mxf as ds ic kn) 1))
(define gendy2 (mk-oscillator "Gendy2" (ad dd adp ddp mnf mxf as ds ic kn a c) 1))
(define gendy3 (mk-oscillator "Gendy3" (ad dd adp ddp f as ds ic kn) 1))
(define henon-c (mk-oscillator "HenonC" (freq a b x0 x1) 1))
(define henon-l (mk-oscillator "HenonL" (freq a b x0 x1) 1))
(define henon-n (mk-oscillator "HenonN" (freq a b x0 x1) 1))
(define impulse (mk-oscillator "Impulse" (freq phase) 1))
(define key-state (mk-oscillator "KeyState" (key min max lag) 1))
(define lf-cub (mk-oscillator "LFCub" (freq iphase) 1))
(define lf-par (mk-oscillator "LFPar" (freq iphase) 1))
(define lf-pulse (mk-oscillator "LFPulse" (freq iphase width) 1))
(define lf-saw (mk-oscillator "LFSaw" (freq iphase) 1))
(define lf-tri (mk-oscillator "LFTri" (freq iphase) 1))
(define latoocarfian-c (mk-oscillator "LatoocarfianC" (freq a b c d xi yi) 1))
(define latoocarfian-l (mk-oscillator "LatoocarfianL" (freq a b c d xi yi) 1))
(define latoocarfian-n (mk-oscillator "LatoocarfianN" (freq a b c d xi yi) 1))
(define lin-cong-c (mk-oscillator "LinCongC" (freq a c m xi) 1))
(define lin-cong-l (mk-oscillator "LinCongL" (freq a c m xi) 1))
(define lin-cong-n (mk-oscillator "LinCongN" (freq a c m xi) 1))
(define line (mk-oscillator "Line" (start end dur done-action) 1))
(define logistic (mk-oscillator "Logistic" (chaos-param freq) 1))
(define lorenz-l (mk-oscillator "LorenzL" (freq s r b h xi yi zi) 1))
(define mouse-button (mk-oscillator "MouseButton" (minval maxval lag) 1))
(define mouse-x (mk-oscillator "MouseX" (min max warp lag) 1))
(define mouse-y (mk-oscillator "MouseY" (min max warp lag) 1))
(define osc (mk-oscillator "Osc" (bufnum freq phase) 1))
(define osc-n (mk-oscillator "OscN" (bufnum freq phase) 1))
(define p-sin-grain (mk-oscillator "PSinGrain" (freq dur amp) 1))
(define phasor (mk-oscillator "Phasor" (trig rate start end reset-pos) 1))
(define pulse (mk-oscillator "Pulse" (freq width) 1))
(define quad-c (mk-oscillator "QuadC" (freq a b c xi) 1))
(define quad-l (mk-oscillator "QuadL" (freq a b c xi) 1))
(define quad-n (mk-oscillator "QuadN" (freq a b c xi) 1))
(define saw (mk-oscillator "Saw" (freq) 1))
(define shared-in (mk-oscillator "SharedIn" () 1))
(define sin-osc (mk-oscillator "SinOsc" (freq phase) 1))
(define sin-osc-fb (mk-oscillator "SinOscFB" (freq feedback) 1))
(define standard-l (mk-oscillator "StandardL" (freq k xi yi) 1))
(define standard-n (mk-oscillator "StandardN" (freq k xi yi) 1))
(define sync-saw (mk-oscillator "SyncSaw" (sync-freq saw-freq) 1))
(define v-osc (mk-oscillator "VOsc" (bufpos freq phase) 1))
(define v-osc3 (mk-oscillator "VOsc3" (bufpos freq1 freq2 freq3) 1))
(define var-saw (mk-oscillator "VarSaw" (freq iphase width) 1))
(define x-line (mk-oscillator "XLine" (start end dur done-action) 1))

(define buf-rd (mk-oscillator-n "BufRd" (bufnum phase loop interpolation)))
(define disk-in (mk-oscillator-n "DiskIn" (bufnum)))
(define in (mk-oscillator-n "In" (bus)))
(define local-in (mk-oscillator-n "LocalIn" ()))
(define trig-control (mk-oscillator-n "TrigControl" ()))

(define duty (mk-oscillator* "Duty" (dur reset done-action level) 1))
(define env-gen (mk-oscillator* "EnvGen" (gate level-scale level-bias time-scale done-action envelope-array) 1))
(define klang (mk-oscillator* "Klang" (freqscale freqoffset spec-array) 1))
(define t-duty (mk-oscillator* "TDuty" (dur reset done-action level gap) 1))

(define brown-noise (mk-oscillator-id "BrownNoise" () 1))
(define clip-noise (mk-oscillator-id "ClipNoise" () 1))
(define dust (mk-oscillator-id "Dust" (density) 1))
(define dust2 (mk-oscillator-id "Dust2" (density) 1))
(define gray-noise (mk-oscillator-id "GrayNoise" () 1))
(define lf-clip-noise (mk-oscillator-id "LFClipNoise" (freq) 1))
(define lfd-clip-noise (mk-oscillator-id "LFDClipNoise" (freq) 1))
(define lfd-noise0 (mk-oscillator-id "LFDNoise0" (freq) 1))
(define lfd-noise1 (mk-oscillator-id "LFDNoise1" (freq) 1))
(define lfd-noise3 (mk-oscillator-id "LFDNoise3" (freq) 1))
(define lf-noise0 (mk-oscillator-id "LFNoise0" (freq) 1))
(define lf-noise1 (mk-oscillator-id "LFNoise1" (freq) 1))
(define lf-noise2 (mk-oscillator-id "LFNoise2" (freq) 1))
(define noah-noise (mk-oscillator-id "NoahNoise" () 1))
(define pink-noise (mk-oscillator-id "PinkNoise" () 1))
(define rand-id (mk-oscillator-id "RandID" (id) 1))
(define rand-seed (mk-oscillator-id "RandSeed" (trig seed) 1))
(define white-noise (mk-oscillator-id "WhiteNoise" () 1))

(define convolution (mk-specialized "Convolution" (in kernel frame-size) 1 ar))
(define convolution2 (mk-specialized "Convolution2" (in b tr frame-size) 1 ar))
(define fft (mk-specialized "FFT" (buf in hop wintype active) 1 kr))
(define ifft (mk-specialized "IFFT" (buf wintype) 1 ar))
(define k2a (mk-specialized "K2A" (in) 1 ar))
(define pv-add (mk-specialized "PV_Add" (buf-a buf-b) 1 kr))
(define pv-bin-scramble (mk-specialized "PV_BinScramble" (b wipe width trig) 1 kr))
(define pv-bin-shift (mk-specialized "PV_BinShift" (b stretch shift) 1 kr))
(define pv-bin-wipe (mk-specialized "PV_BinWipe" (b-a b-b wipe) 1 kr))
(define pv-brick-wall (mk-specialized "PV_BrickWall" (b wipe) 1 kr))
(define pv-conformal-map (mk-specialized "PV_ConformalMap" (b real imag) 1 kr))
(define pv-copy (mk-specialized "PV_Copy" (b-a b-b) 1 kr))
(define pv-copy-phase (mk-specialized "PV_CopyPhase" (b-a b-b) 1 kr))
(define pv-diffuser (mk-specialized "PV_Diffuser" (b trig) 1 kr))
(define pv-hainsworth-foote (mk-specialized "PV_HainsworthFoote" (b proph propf threshold waittime) 1 ar))
(define pv-jensen-andersen (mk-specialized "PV_JensenAndersen" (b propsc prophfe prophfc propsf threshold waittime) 1 ar))
(define pv-local-max (mk-specialized "PV_LocalMax" (buffer threshold) 1 kr))
(define pv-mag-above (mk-specialized "PV_MagAbove" (buffer threshold) 1 kr))
(define pv-mag-below (mk-specialized "PV_MagBelow" (buffer threshold) 1 kr))
(define pv-mag-clip (mk-specialized "PV_MagClip" (buffer threshold) 1 kr))
(define pv-mag-freeze (mk-specialized "PV_MagFreeze" (buffer freeze) 1 kr))
(define pv-mag-mul (mk-specialized "PV_MagMul" () 1 kr))
(define pv-mag-noise (mk-specialized "PV_MagNoise" (buffer) 1 kr))
(define pv-mag-shift (mk-specialized "PV_MagShift" () 1 kr))
(define pv-mag-smear (mk-specialized "PV_MagSmear" (buffer bins) 1 kr))
(define pv-mag-squared (mk-specialized "PV_MagSquared" () 1 kr))
(define pv-max (mk-specialized "PV_Max" () 1 kr))
(define pv-min (mk-specialized "PV_Min" () 1 kr))
(define pv-mul (mk-specialized "PV_Mul" () 1 kr))
(define pv-phase-shift (mk-specialized "PV_PhaseShift" (buffer shift) 1 kr))
(define pv-phase-shift270 (mk-specialized "PV_PhaseShift270" (buffer) 1 kr))
(define pv-phase-shift90 (mk-specialized "PV_PhaseShift90" (buffer) 1 kr))
(define pv-rand-comb (mk-specialized "PV_RandComb" (buffer wipe trig) 1 kr))
(define pv-rand-wipe (mk-specialized "PV_RandWipe" (buffer-a buffer-b wipe trig) 1 kr))
(define pv-rect-comb (mk-specialized "PV_RectComb" (buffer num-teeth phase width) 1 kr))
(define pv-rect-comb2 (mk-specialized "PV_RectComb2" () 1 kr))
(define pitch (mk-specialized "Pitch" (in init-freq min-freq max-freq exec-freq max-bins-per-octave median amp-threshold peak-threshold down-sample) 2 kr))
(define shared-out (mk-specialized "SharedOut" (bus channels-array) 0 kr))
(define unpack1-fft (mk-specialized "Unpack1FFT" (chain bufsize binindex whichmeasure) 1 dr))

(define control-rate (mk-specialized-c "ControlRate" 1 ir))
(define num-audio-buses (mk-specialized-c "NumAudioBuses" 1 ir))
(define num-buffers (mk-specialized-c "NumBuffers" 1 ir))
(define num-control-buses (mk-specialized-c "NumControlBuses" 1 ir))
(define num-input-buses (mk-specialized-c "NumInputBuses" 1 ir))
(define num-output-buses (mk-specialized-c "NumOutputBuses" 1 ir))
(define num-running-synths (mk-specialized-c "NumRunningSynths" 1 ir))
(define radians-per-sample (mk-specialized-c "RadiansPerSample" 1 ir))
(define sample-dur (mk-specialized-c "SampleDur" 1 ir))
(define sample-rate (mk-specialized-c "SampleRate" 1 ir))
(define subsample-offset (mk-specialized-c "SubsampleOffset" 1 ir))

(define grain-buf (mk-specialized-n "GrainBuf" (tr dur sndbuf rate pos interp pan envbuf) ar))
(define grain-fm (mk-specialized-n "GrainFM" (tr dur carfreq modfreq index pan envbuf) ar))
(define grain-in (mk-specialized-n "GrainIn" (tr dur in pan envbuf) ar))
(define grain-sin (mk-specialized-n "GrainSin" (tr dur freq pan envbuf) ar))
(define in-feedback (mk-specialized-n "InFeedback" (bus) ar))
(define in-trig (mk-specialized-n "InTrig" (bus) kr))
(define lag-in (mk-specialized-n "LagIn" (bus lag) kr))
(define play-buf (mk-specialized-n "PlayBuf" (bufnum rate trigger start-pos loop) ar))
(define warp1 (mk-specialized-n "Warp1" (bufnum pointer freq-scale window-size envbufnum overlaps window-rand-ratio interp) ar))

(define pack-fft (mk-specialized* "PackFFT" (chain bufsize from to z magsphases) 1 kr))

(define dbrown (mk-specialized-id "Dbrown" (length lo hi step) 1 dr))
(define dbufrd (mk-specialized-id "Dbufrd" (bufnum phase loop) 1 dr))
(define dgeom (mk-specialized-id "Dgeom" (length start grow) 1 dr))
(define dibrown (mk-specialized-id "Dibrown" (length lo hi step) 1 dr))
(define diwhite (mk-specialized-id "Diwhite" (length lo hi) 1 dr))
(define dseries (mk-specialized-id "Dseries" (length start step) 1 dr))
(define dwhite (mk-specialized-id "Dwhite" (length lo hi) 1 dr))
(define exp-rand (mk-specialized-id "ExpRand" (lo hi) 1 ir))
(define i-rand (mk-specialized-id "IRand" (lo hi) 1 ir))
(define lin-rand (mk-specialized-id "LinRand" (lo hi minmax) 1 ir))
(define n-rand (mk-specialized-id "NRand" (lo hi n) 1 ir))
(define rand (mk-specialized-id "Rand" (lo hi) 1 ir))

(define drand (mk-specialized*-id "Drand" (length array) 1 dr))
(define dseq (mk-specialized*-id "Dseq" (length array) 1 dr))
(define dser (mk-specialized*-id "Dser" (length array) 1 dr))
(define dswitch1 (mk-specialized*-id "Dswitch1" (length array) 1 dr))
(define dxrand (mk-specialized*-id "Dxrand" (length array) 1 dr))

(define add3
  (lambda (a b c)
    (add (add a b) c)))

(define buf-rd-c
  (lambda (nc r b p l) 
    (buf-rd nc r b p l 4)))

(define buf-rd-l
  (lambda (nc r b p l) 
    (buf-rd nc r b p l 2)))

(define buf-rd-n
  (lambda (nc r b p l) 
    (buf-rd nc r b p l 1)))

(define fft*				;
  (lambda (buf in)
    (fft buf in 0.5 0 1)))

(define ifft* 
  (lambda (buf)
    (ifft buf 0)))

(define mul3
  (lambda (a b c)
    (mul (mul a b) c)))

(define mul4
  (lambda (a b c d)
    (mul (mul (mul a b) c) d)))

(define t-choose
  (lambda (trig array)
    (select (ti-rand 0 (length (mce-channels array)) trig) array)))

(define tw-choose
  (lambda (trig array weights normalize)
    (select (tw-index trig normalize weights) array)))

;; int
(define add-to-head 0)
(define add-to-tail 1)
(define add-before 2)
(define add-after 3)
(define add-replace 4)

;; int
(define gen-normalize 1)
(define gen-wavetable 2)
(define gen-clear 4)

;; int
(define do-nothing 0)
(define pause-synth 1)
(define remove-synth 2)

;; int
(define no-loop 0)
(define loop 1)

;; int
(define linear 0)
(define exponential 1)

(define quit
  (message "/quit" nil))

(define notify
  (lambda (i)
    (message "/notify" (list i))))

(define status
  (message "/status" nil))

(define dump-osc
  (lambda (i)
    (message "/dumpOSC" (list i))))

(define sync
  (lambda (i)
    (message "/sync" (list i))))

(define clear-sched
  (message "/clearSched" nil))

(define d-recv
  (lambda (b)
    (message "/d_recv" (list b))))

(define d-load
  (lambda (s)
    (message "/d_load" (list s))))

(define d-load-dir
  (lambda (s)
    (message "/d_loadDir" (list s))))

(define d-free1
  (lambda (s)
    (message "/d_free" (list s))))

(define n-free1
  (lambda (i)
    (message "/n_free" (list i))))

(define n-run1
  (lambda (i j)
    (message "/n_run" (list i j))))

(define n-set1
  (lambda (i s f)
    (message "/n_set" (list i s f))))

(define n-setn1
  (lambda (i s fs)
    (message "/n_setn" (cons i (cons s (cons (length fs) fs))))))

(define n-fill1
  (lambda (i s j f)
    (message "/n_fill" (list i s j f))))

(define n-map1
  (lambda (i s j)
    (message "/n_map" (list i s j))))

(define n-mapn1
  (lambda (i s j k)
    (message "/n_mapn" (list i s j k))))

(define n-before
  (lambda (i j)
    (message "/n_before" (list i j))))

(define n-query
  (lambda (i)
    (message "/n_query" (list i))))

(define n-trace
  (lambda (i)
    (message "/n_trace" (list i))))

(define s-new0
  (lambda (s i j k)
    (message "/s_new" (list s i j k))))

(define s-new1
  (lambda (s i j k t f)
    (message "/s_new" (list s i j k t f))))

(define s-new2
  (lambda (s i j k t1 f1 t2 f2)
    (message "/s_new" (list s i j k t1 f1 t2 f2))))

(define s-new
  (lambda (s i j k cs)
    (message "/s_new" (append2 (list s i j k) cs))))

(define s-get1
  (lambda (i j)
    (message "/s_get" (list i j))))

(define s-getn1
  (lambda (i s j)
    (message "/s_getn" (list i s j))))

(define s-noid
  (lambda (i)
    (message "/s_noid" (list i))))

(define g-new1
  (lambda (i j k)
    (message "/g_new" (list i j k))))

(define g-head1
  (lambda (i j)
    (message "/g_head" (list i j))))

(define g-tail1
  (lambda (i j)
    (message "/g_tail" (list i j))))

(define g-free-all1
  (lambda (i)
    (message "/g_freeAll" (list i))))

(define g-deep-free1
  (lambda (i)
    (message "/g_deepFree" (list i))))

(define b-alloc
  (lambda (id frames channels)
    (message "/b_alloc" (list id frames channels))))

(define b-alloc-read
  (lambda (id path frame n)
    (message "/b_allocRead" (list id path frame n))))

(define b-read
  (lambda (id path frame n bframe flag)
    (message "/b_read" (list id path frame n bframe flag))))

(define b-write
  (lambda (id path header type frames start flag)
    (message "/b_write" (list id path header type frames start flag))))

(define b-free
  (lambda (i)
    (message "/b_free" (list i))))

(define b-zero
  (lambda (i)
    (message "/b_zero" (list i))))

(define b-set1
  (lambda (i j f)
    (message "/b_set" (list i j f))))

(define b-setn1
  (lambda (i j fs)
    (message "/b_setn" (cons i (cons j (cons (length fs) fs))))))

(define b-fill1
  (lambda (i j k f)
    (message "/b_fill" (list i j k f))))

(define b-close
  (lambda (i)
    (message "/b_close" (list i))))

(define b-query1
  (lambda (i)
    (message "/b_query" (list i))))

(define b-get1
  (lambda (i j)
    (message "/b_get" (list i j))))

(define b-getn1
  (lambda (i j k)
    (message "/b_getn" (list i j k))))

(define b-gen1
  (lambda (i s fs)
    (message "/b_gen" (cons i (cons s fs)))))

(define c-set1
  (lambda (i f)
    (message "/c_set" (list i f))))

(define c-setn1
  (lambda (i fs)
    (message "/c_setn" (cons i (cons (length fs) fs)))))

(define c-fill1
  (lambda (i j f)
    (message "/c_fill" (list i j f))))

(define c-get1
  (lambda (i)
    (message "/c_get" (list i))))

(define c-getn1
  (lambda (i j)
    (message "/c_getn" (list i j))))

;; port -> string -> osc
(define wait
  (lambda (fd s)
    (let ((p (recv fd)))
      (cond
       ((not p) (error "wait" "timed out"))
       ((not (string=? (head p) s)) (error "wait" "bad return packet" p s))
       (else p)))))

;; port -> osc -> ()
(define async
  (lambda (fd m)
    (send fd m)
    (wait fd "/done")))

;; port -> ()
(define reset
  (lambda (fd)
    (send fd (bundle -1 (list (g-free-all1 0)
			      clear-sched
			      (g-new1 1 0 0))))))

;; (socket -> a) -> a
(define with-udp-sc3
  (lambda (f)
    (let* ((fd (udp:open "127.0.0.1" 57110))
	   (r (f fd)))
      (udp:close fd)
      r)))

;; (socket -> a) -> a
(define with-tcp-sc3
  (lambda (f)
    (let* ((fd (tcp:open "127.0.0.1" 57110))
	   (r (f fd)))
      (tcp:close fd)
      r)))

;; [string]
(define status-fields
  (list "# UGens                     "
	"# Synths                    "
	"# Groups                    "
	"# Instruments               "
	"% CPU (Average)             "
	"% CPU (Peak)                "
	"Sample Rate (Nominal)       "
	"Sample Rate (Actual)        "))

;; osc -> [string]
(define status-format
  (lambda (r)
    (cons "***** SuperCollider Server Status *****"
	  (zip-with string-append
		    status-fields 
		    (map1 number->string (tail (tail r)))))))

;; port -> [string]
(define server-status
  (lambda (fd)
    (send fd status)
    (let ((r (wait fd "status.reply")))
      (status-format r))))

;; port -> ()
(define display-server-status
  (lambda (fd)
    (newline)
    (for-each display (intersperse "\n" (server-status fd)))
    (newline)))

;; port -> int -> number
(define server-status-field
  (lambda (fd n)
    (send fd status)
    (let ((r (wait fd "status.reply")))
      (list-ref r n))))

;; port -> float
(define server-sample-rate-nominal
  (lambda (s)
    (server-status-field s 8)))

;; port -> float
(define server-sample-rate-actual
  (lambda (s)
    (server-status-field s 9)))

;; string|number -> number
(define curve-to-shape
  (lambda (c)
    (cond
     ((string? c)
      (cond ((string=? c "step") 0.0)
	    ((string=? c "linear") 1.0)
	    ((string=? c "exponential") 2.0)
	    ((string=? c "sine") 3.0)
	    ((string=? c "welch") 4.0)
	    ((string=? c "squared") 6.0)
	    ((string=? c "cubed") 7.0)
	    (else (error "curve-to-shape" "string" c))))
     ((number? c)
      5.0)
     (else
      (error "curve-to-shape" "illegal curve" c)))))

;; any -> number
(define curve-to-value
  (lambda (c)
    (if (number? c) c 0.0)))

;; Make a <list> for use with the EnvGen UGen. `levels' is a <list>
;; containing the left to right gain values for the envelope, it has
;; one more element than the <list> `times', having the delta times
;; for each envelope segment. `curve' is either a string or a number
;; or a <list> of such, in either case it is expanded to a list of the
;; same length as `times'. `release-node' is the index of the
;; 'release' stage of the envelope, `loop-node' is the index of the
;; 'loop' stage of the envelope. These indices are set as invalid, by
;; convention -1, to indicate there is no such node.

(define env
  (lambda (levels times curves release-node loop-node)
    (make-mce
     (append2
      (list (head levels) (length times) release-node loop-node)
      (concat
       (zip-with3
	(lambda (l t c)
	  (list l
		t
		(curve-to-shape c)
		(curve-to-value c)))
	(tail levels) 
	times 
	curves))))))

;; Co-ordinate based static envelope generator.

;; [ugen] -> ugen -> ugen -> [ugen] -> ugen
(define env-bp
  (lambda (bp dur amp curves)
    (env (map (lambda (e) (mul e amp)) (take-cycle (tail bp) 2))
	 (map (lambda (e) (mul e dur)) ((d->dx sub) (take-cycle bp 2)))
	 curves
	 -1
	 -1)))

;; Design a standard trapezoidal envelope. `shape' determines the
;; sustain time as a proportion of `dur', zero is a triangular
;; envelope, one a rectangular envelope. `skew' determines the
;; attack/decay ratio, zero is an immediate attack and a slow decay,
;; one a slow attack and an immediate decay. This implementation
;; builds a zero one breakpoint data set and calls env-bp.

(define env-trapezoid
  (lambda (shape skew dur amp)
    (let* ((x1 (mul skew (sub 1.0 shape)))
	   (bp (list 0
		     (le skew 0.0)
		     x1
		     1.0
		     (add shape x1)
		     1.0
		     1.0
		     (ge skew 1.0))))
      (env-bp bp dur amp (replicate 3 "linear")))))

(define env-triangle
  (lambda (dur level)
    (let ((half-dur (mul dur 0.5)))
      (env (list 0.0 level 0.0)
	   (list half-dur half-dur)
	   (list "linear" "linear")
	   -1
	   -1))))

(define env-sine
  (lambda (dur level)
    (let ((half-dur (mul dur 0.5)))
      (env (list 0.0 level 0.0)
	   (list half-dur half-dur)
	   (list "sine" "sine")
	   -1
	   -1))))

(define env-perc
  (lambda (attackTime releaseTime level curves)
    (env (list 0.0 level 0.0)
	 (list attackTime releaseTime)
	 curves
	 -1
	 -1)))

(define env-adsr 
  (lambda (attackTime
	   decayTime
	   sustainLevel
	   releaseTime
	   peakLevel
	   curves
	   bias)
    (env (map (lambda (e) (mul e bias))
	      (list 0.0 peakLevel (mul peakLevel sustainLevel) 0.0))
	 (list attackTime decayTime releaseTime)
	 curves
	 2
	 -1)))

(define env-asr
  (lambda (attackTime sustainLevel releaseTime curves)
    (env (list 0.0 sustainLevel 0.0)
	 (list attackTime releaseTime)
	 curves
	 1
	 -1)))

(define env-linen
  (lambda (attackTime sustainTime releaseTime level curves)
    (env (list 0.0 level level 0.0)
	 (list attackTime sustainTime releaseTime)
	 curves
	 -1
	 -1)))

;; [m] -> [p] -> [#, m, p...]
(define packfft-data
  (lambda (m p)
    (make-mce
     (cons (* 2 (length m)) 
	   (concat (zip-with list m p))))))

;; [[m, p]] -> [#, m, p...]
(define packfft-data*
  (lambda (mp)
    (make-mce
     (cons (* 2 (length mp)) 
	   (concat mp)))))

(define unpack-fft
  (lambda (c nf from to mp?)
    (map (lambda (i)
	   (unpack1-fft c nf i mp?))
	 (enum-from-to from to))))

(define pvcollect
  (lambda (c nf f from to z?)
    (let* ((m (unpack-fft c nf from to 0))
	   (p (unpack-fft c nf from to 1))
	   (i (enum-from-to from to))
	   (e (map f m p i)))
      (pack-fft c nf from to z? (packfft-data* e)))))

;; ugen -> ugen
(define audio-in
  (lambda (n)
    (let ((offset (sub num-output-buses 1)))
      (if (mce? n)
	  (let ((l (mce-channels n)))
	    (if (consecutive? l)
		(in (length l) ar (add offset (head l)))
		(in 1 ar (add offset n))))
	  (in 1 ar (add offset n))))))

;; [ugen] -> [ugen] -> [ugen] -> ugen
(define klang-data
  (lambda (freqs amps phases)
    (make-mce
     (concat
      (zip-with3
       list3
       freqs amps phases)))))

;; [ugen] -> [ugen] -> [ugen] -> ugen
(define klank-data klang-data)

;; ugen -> ugen -> ugen -> ugen -> ugen -> ugen
(define dyn-klank
  (lambda (i fs fo ds s)
    (letrec ((gen (lambda (l)
		    (if (null? l)
			0
			(let ((f (list-ref l 0))
			      (a (list-ref l 1))
			      (d (list-ref l 2)))
			  (add (mul (ringz i (mul-add f fs fo) (mul d ds)) a)
			       (gen (drop 3 l))))))))
      (gen (mce-channels s)))))

;; ugen -> ugen -> ugen -> ugen
(define freq-shift
  (lambda (i f p)
    (let ((o (sin-osc ar f (mce2 (add p (* 0.5 pi)) p)))
	  (h (hilbert i)))
      (mix (mul h o)))))

;; rate -> ugen -> ugen -> ugen -> ugen -> ugen
(define pm-osc
  (lambda (r cf mf pm mp)
    (sin-osc r cf (mul (sin-osc r mf mp) pm))))

;; ugen|mce -> ugen
(define mix
  (lambda (u)
    (cond
     ((mce? u) (foldl1 add (mce-channels u)))
     (else u))))

;; int -> (int -> ugen) -> mce
(define mce-fill
  (lambda (n f)
    (make-mce (map1 f (enum-from-to 0 (- n 1))))))

;; int -> (int -> ugen) -> ugen
(define mix-fill
  (lambda (n f)
    (mix (mce-fill n f))))

;; port -> string -> ugen -> ()
(define send-synth
  (lambda (fd n u)
    (async fd (d-recv (encode-graphdef (synthdef n u))))))

;; port -> ugen -> ()
(define play
  (lambda (fd u)
    (send-synth fd "anonymous" u)
    (send fd (s-new0 "anonymous" -1 1 1))))

;; ((socket -> a) -> a) -> (ugen -> ())
(define audition-using
  (lambda (f)
    (lambda (u)
      (f
       (lambda (fd)
	 (play fd u))))))

;; float
(define dinf 
  9.0e8)

;; float -> float -> float
(define random
  (lambda (a b) 
    (+ (* (random-real) (- b a)) a)))

;; float -> float -> float
(define randomx
  (lambda (a b)
    (let ((r (/ b a)))
      (* (expt r (random 0 1)) a))))

;; [a] -> a
(define choose
  (lambda (xs)
    (list-ref xs (random-integer (length xs)))))
