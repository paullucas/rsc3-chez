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

;; number a => a -> a -> a -> a
(define clip
  (lambda (a b n) 
    (cond ((< n a) a)
	  ((> n b) b)
	  (else n))))

;; number a => a -> a
(define squared 
  (lambda (n)
    (* n n)))

;; number a => a -> a
(define cubed 
  (lambda (n)
    (* n n n)))

;; number a => a -> a
(define recip 
  (lambda (n)
    (/ 1 n)))

;; float
(define e 
  (exp 1.0))

;; float
(define pi
  (* 4 (atan 1)))

;; float -> float
(define log2
  (lambda (x)
    (/ (log (abs x)) (log 2))))

;; float -> float
(define log10
  (lambda (x)
    (/ (log x) (log 10))))

;; float -> float
(define ampdb 
  (lambda (x) 
    (* (log10 x) 20)))

;; float -> float
(define dbamp
  (lambda (x)
    (expt 10 (* x 0.05))))

;; float -> float
(define powdb
  (lambda (x) 
    (* (log10 x) 10)))

;; float -> float
(define dbpow
  (lambda (x) 
    (expt 10 (* x 0.1))))

;; float -> float
(define midicps
  (lambda (note)
    (* 440.0 (expt 2.0 (* (- note 69.0) 0.083333333333)))))

;; float -> float
(define cpsmidi
  (lambda (freq)
    (+ (* (log2 (* freq 0.0022727272727)) 12.0) 69.0)))

;; float -> float
(define midiratio
  (lambda (midi)
    (expt 2.0 (* midi 0.083333333333))))

;; float -> float
(define ratiomidi
  (lambda (ratio)
    (* 12.0 (log2 ratio))))

;; float -> float
(define octcps
  (lambda (note)
    (* 440.0 (expt 2.0 (- note 4.75)))))

;; float -> float
(define cpsoct
  (lambda (freq)
    (+ (log2 (* freq 0.0022727272727)) 4.75)))

;; float -> [float] -> int -> float
(define degree->key
  (lambda (degree scale steps)
    (let ((scale-n (length scale)))
      (+ (* steps (quotient degree scale-n))
	 (list-ref scale (modulo degree scale-n))))))

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
	  ((mrg? o) (error 'rate-of "mrg?" o))
	  (else (error 'rate-of "illegal value" o)))))

;; rate -> int
(define rate-to-ordinal
  (lambda (r)
    (cond ((eq? r ir) 0)
	  ((eq? r kr) 1)
	  ((eq? r ar) 2)
	  ((eq? r dr) 3)
	  (else (error "rate-to-ordinal: illegal rate")))))

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
(define-structure ugen name rate inputs outputs special id)

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

;; ugen -> ugen
(define uniquify
  (lambda (u)
    (ugen-transform
     u
     (lambda (n r i o s d)
       (make-ugen n r i o s (unique-uid))))))

;; int -> ugen -> mce
(define clone
  (lambda (n u)
    (make-mce
     (map (lambda (_) (uniquify u)) (enum-from-to 1 n)))))

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
(define SCgf 
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

;; symbol -> maybe rate -> [node] -> maybe node -> int -> int -> uid -> ugen
(define construct-ugen
  (lambda (name rate? inputs mce? outputs special id)
    (let* ((inputs* (if mce?
			(append2 inputs (mce-l mce?))
			inputs))
	   (rate (if rate?
		     rate?
		     (rate-select (map1 rate-of inputs*))))
	   (u (make-ugen
	       (symbol->string name)
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
     (else (error "graph-nodes: illegal value" u)))))

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
	(error "ugen-close: invalid ugen" u)
	(make-ugen (ugen-name u)
		   (ugen-rate u)
		   (map1 (lambda (i)
			   (input*-to-input i nn cc uu))
			 (ugen-inputs u))
		   (ugen-outputs u)
		   (ugen-special u)
		   (ugen-id u)))))

;; String -> UGen -> Graphdef
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
	  (error "calculate-index: not located" n nn)
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
     ((mce? i) (error "input*-to-input: mce?" i))
     ((mrg? i) (error "input*-to-input: mrg?" i))
     (else (error "input*-to-input: illegal input" i)))))

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

;; symbol -> int -> (float -> float) :bind: (node -> node)
(define-syntax define-unary-operator
  (syntax-rules ()
    ((_ n s f)
     (define n
       (lambda (a)
	 (if (and (number? a) f)
	     (f a)
	     (construct-ugen 'UnaryOpUGen #f (list a) #f 1 s (make-uid 0))))))))

(define-syntax define-binary-operator
  (syntax-rules ()
    ((_ n s f)
     (define n
       (lambda (a b)
	 (if (and (number? a)
		  (number? b)
		  f)
	     (f a b)
	     (construct-ugen 'BinaryOpUGen #f (list a b) #f 1 s (make-uid 0))))))))

(define-syntax define-filter
  (syntax-rules ()
    ((_ n (i ...) o)
     (define n
       (lambda (i ...)
	 (construct-ugen 'n #f (list i ...) #f o 0 (make-uid 0)))))))

(define-syntax define-filter/n
  (syntax-rules ()
    ((_ n (i ...))
     (define n
       (lambda (nc i ...)
	 (if (not (integer? nc))
	     (error "illegal channel count" 'n nc)
	     #f)
	 (let ((l (list i ...)))
	   (construct-ugen 'n #f l #f nc 0 (make-uid 0))))))))

(define-syntax define-filter*
  (syntax-rules ()
    ((_ n (i ... v) o)
     (define n
       (lambda (i ... v)
	 (construct-ugen 'n #f (list i ...) v o 0 (make-uid 0)))))))

(define-syntax define-filter/id
  (syntax-rules ()
    ((_ n (i ...) o)
     (define n
       (lambda (i ...)
	 (construct-ugen 'n #f (list i ...) #f o 0 (unique-uid)))))))

;; keyed filter, rate is determined by a known input
(define-syntax define-filter/k
  (syntax-rules ()
    ((_ n (i ...) o k)
     (define n
       (lambda (i ...)
	 (let ((l (list i ...)))
	   (construct-ugen 'n (rate-of (list-ref l k)) l #f o 0 (make-uid 0))))))))

(define-syntax define-oscillator
  (syntax-rules ()
    ((_ n (i ...) o)
     (define n
       (lambda (r i ...)
	 (construct-ugen (quote n) r (list i ...) #f o 0 (make-uid 0)))))))

(define-syntax define-oscillator/n
  (syntax-rules ()
    ((_ n (i ...))
     (define n
       (lambda (nc r i ...)
	 (if (not (integer? nc))
	     (error "illegal channel count:" 'n nc)
	     #f)
	 (let ((l (list i ...)))
	   (construct-ugen 'n r l #f nc 0 (make-uid 0))))))))

(define-syntax define-oscillator*
  (syntax-rules ()
    ((_ n (i ... v) o)
     (define n
       (lambda (r i ... v)
	 (construct-ugen 'n r (list i ...) v o 0 (make-uid 0)))))))

(define-syntax define-oscillator/id
  (syntax-rules ()
    ((_ n (i ...) o)
     (define n
       (lambda (r i ...)
	 (construct-ugen 'n r (list i ...) #f o 0 (unique-uid)))))))

(define-syntax define-specialized
  (syntax-rules ()
    ((_ n (i ...) o r)
     (define n
       (lambda (i ...)
	 (construct-ugen 'n r (list i ...) #f o 0 (make-uid 0)))))))

(define-syntax define-specialized/c
  (syntax-rules ()
    ((_ n o r)
     (define n
       (construct-ugen 'n r (list) #f o 0 (make-uid 0))))))

(define-syntax define-specialized*
  (syntax-rules ()
    ((_ n (i ... v) o r)
     (define n
       (lambda (i ... v)
	 (construct-ugen 'n r (list i ...) v o 0 (make-uid 0)))))))

(define-syntax define-specialized/n
  (syntax-rules ()
    ((_ n (i ...) r)
     (define n
       (lambda (nc i ...)
	 (if (not (integer? nc))
	     (error "illegal channel count:" 'n nc)
	     #f)
	 (let ((l (list i ...)))
	   (construct-ugen 'n r l #f nc 0 (make-uid 0))))))))

(define-syntax define-specialized/id
  (syntax-rules ()
    ((_ n (i ...) o r)
     (define n
       (lambda (i ...)
	 (construct-ugen 'n r (list i ...) #f o 0 (unique-uid)))))))

(define-syntax define-specialized*/id
  (syntax-rules ()
    ((_ n (i ... v) o r)
     (define n
       (lambda (i ... v)
	 (construct-ugen 'n r (list i ...) v o 0 (unique-uid)))))))

;; ugen -> ugen
(define-unary-operator Abs 5 abs)
(define-unary-operator AmpDb 22 ampdb)
(define-unary-operator ArcCos 32 acos)
(define-unary-operator ArcSin 31 asin)
(define-unary-operator ArcTan 33 atan)
(define-unary-operator AsFloat 6 #f)
(define-unary-operator AsInt 7 #f)
(define-unary-operator BiLinRand 40 #f)
(define-unary-operator BitNot 4 #f)
(define-unary-operator CPSMIDI 18 cpsmidi)
(define-unary-operator CPSOct 24 cpsoct)
(define-unary-operator Ceil 8 ceiling)
(define-unary-operator Coin 44 #f)
(define-unary-operator Cos 29 cos)
(define-unary-operator CosH 35 #f)
(define-unary-operator Cubed 13 cubed)
(define-unary-operator DbAmp 21 dbamp)
(define-unary-operator DigitValue 45 #f)
(define-unary-operator Distort 42 #f)
(define-unary-operator Exp 15 #f)
(define-unary-operator Floor 9 floor)
(define-unary-operator Frac 10 #f)
(define-unary-operator HanWindow 49 #f)
(define-unary-operator IsNil 2 #f)
(define-unary-operator Log 25 log)
(define-unary-operator Log10 27 log10)
(define-unary-operator Log2 26 log2)
(define-unary-operator MIDICPS 17 midicps)
(define-unary-operator MIDIRatio 19 midiratio)
(define-unary-operator Neg 0 -)
(define-unary-operator Not 1 #f)
(define-unary-operator NotNil 3 #f)
(define-unary-operator OctCPS 23 octcps)
(define-unary-operator Rand2 38 #f)
(define-unary-operator RatioMIDI 20 ratiomidi)
(define-unary-operator Recip 16 recip)
(define-unary-operator RectWindow 48 #f)
(define-unary-operator SCurve 53 #f)
(define-unary-operator Sign 11 #f)
(define-unary-operator Silence 46 #f)
(define-unary-operator Sin 28 sin)
(define-unary-operator SinH 34 #f)
(define-unary-operator SoftClip 43 #f)
(define-unary-operator Sqrt 14 sqrt)
(define-unary-operator Squared 12 squared)
(define-unary-operator Sum3Rand 41 #f)
(define-unary-operator Tan 30 tan)
(define-unary-operator TanH 36 #f)
(define-unary-operator Thru 47 #f)
(define-unary-operator TriWindow 51 #f)
(define-unary-operator WelchWindow 50 #f)
(define-unary-operator _LinRand 39 #f)
(define-unary-operator _Ramp 52 #f)
(define-unary-operator _Rand 37 #f)

;; ugen -> ugen -> ugen
(define-binary-operator AMClip 40 #f)
(define-binary-operator AbsDif 38 #f)
(define-binary-operator Add 0 +)
(define-binary-operator Atan2 22 #f)
(define-binary-operator BitAnd 14 #f)
(define-binary-operator BitOr 15 #f)
(define-binary-operator BitXor 16 #f)
(define-binary-operator Clip2 42 #f)
(define-binary-operator DifSqr 34 #f)
(define-binary-operator EQ 6 #f)
(define-binary-operator Excess 43 #f)
(define-binary-operator ExpRandRange 48 #f)
(define-binary-operator FDiv 4 /)
(define-binary-operator Fill 29 #f)
(define-binary-operator FirstArg 46 #f)
(define-binary-operator Fold2 44 #f)
(define-binary-operator GCD 18 #f)
(define-binary-operator GE 11 #f)
(define-binary-operator GT 9 #f)
(define-binary-operator Hypot 23 #f)
(define-binary-operator Hypotx 24 #f)
(define-binary-operator IDiv 3 #f)
(define-binary-operator LCM 17 #f)
(define-binary-operator LE 10 #f)
(define-binary-operator LT 8 #f)
(define-binary-operator Max 13 max)
(define-binary-operator Min 12 min)
(define-binary-operator Mod 5 #f)
(define-binary-operator Mul 2 *)
(define-binary-operator NE 7 #f)
(define-binary-operator Pow 25 #f)
(define-binary-operator RandRange 47 #f)
(define-binary-operator Ring1 30 #f)
(define-binary-operator Ring2 31 #f)
(define-binary-operator Ring3 32 #f)
(define-binary-operator Ring4 33 #f)
(define-binary-operator Round 19 #f)
(define-binary-operator RoundUp 20 #f)
(define-binary-operator ScaleNeg 41 #f)
(define-binary-operator ShiftLeft 26 #f)
(define-binary-operator ShiftRight 27 #f)
(define-binary-operator SqrDif 37 #f)
(define-binary-operator SqrSum 36 #f)
(define-binary-operator Sub 1 -)
(define-binary-operator SumSqr 35 #f)
(define-binary-operator Thresh 39 #f)
(define-binary-operator Trunc 21 #f)
(define-binary-operator UnsignedShift 28 #f)
(define-binary-operator Wrap2 45 #f)
(define-filter APF (in freq radius) 1)
(define-filter AllpassC (in maxdelaytime delaytime decaytime) 1)
(define-filter AllpassL (in maxdelaytime delaytime decaytime) 1)
(define-filter AllpassN (in maxdelaytime delaytime decaytime) 1)
(define-filter AmpComp (freq root exp) 1)
(define-filter AmpCompA (freq root minAmp rootAmp) 1)
(define-filter BPF (in freq rq) 1)
(define-filter BPZ2 (in) 1)
(define-filter BRF (in freq rq) 1)
(define-filter BRZ2 (in) 1)
(define-filter Balance2 (left right pos level) 1)
(define-filter Ball (in g damp friction) 1)
(define-filter BiPanB2 (inA inB azimuth gain) 3)
(define-filter BufAllpassC (buf in delaytime decaytime) 1)
(define-filter BufAllpassL (buf in delaytime decaytime) 1)
(define-filter BufAllpassN (buf in delaytime decaytime) 1)
(define-filter BufCombC (buf in delaytime decaytime) 1)
(define-filter BufCombL (buf in delaytime decaytime) 1)
(define-filter BufCombN (buf in delaytime decaytime) 1)
(define-filter BufDelayC (buf in delaytime) 1)
(define-filter BufDelayL (buf in delaytime) 1)
(define-filter BufDelayN (buf in delaytime) 1)
(define-filter Clip (in lo hi) 1)
(define-filter CombC (in maxdelaytime delaytime decaytime) 1)
(define-filter CombL (in maxdelaytime delaytime decaytime) 1)
(define-filter CombN (in maxdelaytime delaytime decaytime) 1)
(define-filter Compander (in control thresh slopeBelow slopeAbove clampTime relaxTime) 1)
(define-filter CompanderD (in thresh slopeBelow slopeAbove clampTime relaxTime) 1)
(define-filter Decay (in decayTime) 1)
(define-filter Decay2 (in attackTime decayTime) 1)
(define-filter DegreeToKey (bufnum in octave) 1)
(define-filter Delay1 (in) 1)
(define-filter Delay2 (in) 1)
(define-filter DelayC (in maxdelaytime delaytime) 1)
(define-filter DelayL (in maxdelaytime delaytime) 1)
(define-filter DelayN (in maxdelaytime delaytime) 1)
(define-filter DetectSilence (in amp time doneAction) 1)
(define-filter Done (src) 1)
(define-filter FOS (in a0 a1 b1) 1)
(define-filter Fold (in lo hi) 1)
(define-filter Formlet (in freq attacktime decaytime) 1)
(define-filter Free (in nodeID) 1)
(define-filter FreeSelf (in) 1)
(define-filter FreeSelfWhenDone (in) 1)
(define-filter FreeVerb (in mix room damp) 1)
(define-filter FreeVerb2 (in1 in2 mix room damp) 2)
(define-filter Gate (in trig) 1)
(define-filter HPF (in freq) 1)
(define-filter HPZ1 (in) 1)
(define-filter HPZ2 (in) 1)
(define-filter Hasher (in) 1)
(define-filter Hilbert (in) 2)
(define-filter ImageWarp (pic x y interpolationType) 1)
(define-filter InRange (in lo hi) 1)
(define-filter InRect (x y rect) 1)
(define-filter Index (bufnum in) 1)
(define-filter Integrator (in coef) 1)
(define-filter LPF (in freq) 1)
(define-filter LPZ1 (in) 1)
(define-filter LPZ2 (in) 1)
(define-filter Lag (in lagTime) 1)
(define-filter Lag2 (in lagTime) 1)
(define-filter Lag3 (in lagTime) 1)
(define-filter LagControl () 1)
(define-filter LastValue (in diff) 1)
(define-filter Latch (in trig) 1)
(define-filter LeakDC (in coef) 1)
(define-filter LeastChange (a b) 1)
(define-filter Limiter (in level dur) 1)
(define-filter LinExp (in srclo srchi dstlo dsthi) 1)
(define-filter LinLin (in srclo srchi dstlo dsthi) 1)
(define-filter LinPan2 (in pos level) 2)
(define-filter LinXFade2 (inA inB pan level) 1)
(define-filter Linen (gate attackTime susLevel releaseTime doneAction) 1)
(define-filter MantissaMask (in bits) 1)
(define-filter Median (length in) 1)
(define-filter MidEQ (in freq rq db) 1)
(define-filter MoogFF (in freq gain reset) 1)
(define-filter MostChange (a b) 1)
(define-filter MulAdd (a b c) 1)
(define-filter Normalizer (in level dur) 1)
(define-filter OnePole (in coef) 1)
(define-filter OneZero (in coef) 1)
(define-filter Pan2 (in pos level) 2)
(define-filter Pan4 (in xpos ypos level) 4)
(define-filter PanAz (numChans in pos level width orientation) 1)
(define-filter PanB (in azimuth elevation gain) 3)
(define-filter PanB2 (in azimuth gain) 3)
(define-filter Pause (in nodeID) 1)
(define-filter PauseSelf (in) 1)
(define-filter PauseSelfWhenDone (in) 1)
(define-filter Peak (trig reset) 1)
(define-filter PeakFollower (in decay) 1)
(define-filter PitchShift (in windowSize pitchRatio pitchDispersion timeDispersion) 1)
(define-filter Pluck (in trig maxdelaytime delaytime decaytime coef) 1)
(define-filter PulseCount (trig reset) 1)
(define-filter PulseDivider (trig div start) 1)
(define-filter RHPF (in freq rq) 1)
(define-filter RLPF (in freq rq) 1)
(define-filter Ramp (in lagTime) 1)
(define-filter Resonz (in freq bwr) 1)
(define-filter Ringz (in freq decaytime) 1)
(define-filter Rotate2 (x y pos) 2)
(define-filter RunningMax (in trig) 1)
(define-filter RunningMin (in trig) 1)
(define-filter RunningSum (in numsamp) 1)
(define-filter SOS (in a0 a1 a2 b1 b2) 1)
(define-filter Schmidt (in lo hi) 1)
(define-filter SendTrig (in id value) 0)
(define-filter SetResetFF (trig reset) 1)
(define-filter Shaper (bufnum in) 1)
(define-filter Slew (in up dn) 1)
(define-filter Slope (in) 1)
(define-filter Spring (in spring damp) 1)
(define-filter Stepper (trig reset min max step resetval) 1)
(define-filter Sweep (trig rate) 1)
(define-filter TBall (in g damp friction) 1)
(define-filter TDelay (in dur) 1)
(define-filter TPulse (trig freq width) 1)
(define-filter Timer (trig) 1)
(define-filter ToggleFF (trig) 1)
(define-filter Trapezoid (in a b c d) 1)
(define-filter Trig (in dur) 1)
(define-filter Trig1 (in dur) 1)
(define-filter TwoPole (in freq radius) 1)
(define-filter TwoZero (in freq radius) 1)
(define-filter Vibrato (freq rate depth delay onset rateVariation depthVariation iphase) 1)
(define-filter Wrap (in lo hi) 1)
(define-filter WrapIndex (bufnum in) 1)
(define-filter XFade2 (inA inB pan level) 1)
(define-filter XY (xscale yscale xoff yoff rot rate) 1)
(define-filter ZeroCrossing (in) 1)

(define-filter/k Demand (trig reset demandUGens) 1 0)

(define-filter/n DecodeB2 (w x y orientation))
(define-filter/n Silent ())
(define-filter/n TGrains (trigger bufnum rate centerPos dur pan amp interp))

(define-filter* BufWr (bufnum phase loop inputArray) 1)
(define-filter* Klank (input freqscale freqoffset decayscale specificationsArrayRef) 1)
(define-filter* Poll (trig in trigId label) 0)
(define-filter* RecordBuf (bufnum offset recLevel preLevel run loop trigger inputArray) 1)
(define-filter* Select (which array) 1)
(define-filter* TWindex (in normalize array) 1)

(define-filter* DiskOut (bufnum channelsArray) 0)
(define-filter* LocalOut (channelsArray) 0)
(define-filter* OffsetOut (bus channelsArray) 0)
(define-filter* Out (bus channelsArray) 0)
(define-filter* ReplaceOut (bus channelsArray) 0)
(define-filter* ScopeOut (inputArray bufnum) 0)
(define-filter* XOut (bus xfade channelsArray) 0)

(define-filter/id CoinGate (prob in) 1)
(define-filter/id TExpRand (lo hi trig) 1)
(define-filter/id TIRand (lo hi trig) 1)
(define-filter/id TRand (lo hi trig) 1)

(define-oscillator Amplitude (in attackTime releaseTime) 1)
(define-oscillator Blip (freq numharm) 1)
(define-oscillator BufChannels (buf) 1)
(define-oscillator BufDur (buf) 1)
(define-oscillator BufFrames (buf) 1)
(define-oscillator BufRateScale (buf) 1)
(define-oscillator BufSampleRate (buf) 1)
(define-oscillator BufSamples (buf) 1)
(define-oscillator COsc (bufnum freq beats) 1)
(define-oscillator Crackle (chaosParam) 1)
(define-oscillator CuspL (freq a b xi) 1)
(define-oscillator CuspN (freq a b xi) 1)
(define-oscillator DemandEnvGen (level dur shape curve gate reset levelScale levelBias timeScale doneAction) 1)
(define-oscillator FBSineC (freq im fb a c xi yi) 1)
(define-oscillator FBSineL (freq im fb a c xi yi) 1)
(define-oscillator FBSineN (freq im fb a c xi yi) 1)
(define-oscillator FSinOsc (freq iphase) 1)
(define-oscillator Formant (fundfreq formfreq bwfreq) 1)
(define-oscillator GbmanL (freq xi yi) 1)
(define-oscillator GbmanN (freq xi yi) 1)
(define-oscillator Gendy1 (ampdist durdist adparam ddparam minfreq maxfreq ampscale durscale initCPs knum) 1)
(define-oscillator Gendy2 (ampdist durdist adparam ddparam minfreq maxfreq ampscale durscale initCPs knum a c) 1)
(define-oscillator Gendy3 (ampdist durdist adparam ddparam freq ampscale durscale initCPs knum) 1)
(define-oscillator HenonC (freq a b x0 x1) 1)
(define-oscillator HenonL (freq a b x0 x1) 1)
(define-oscillator HenonN (freq a b x0 x1) 1)
(define-oscillator Impulse (freq phase) 1)
(define-oscillator KeyState (key min max lag) 1)
(define-oscillator LFCub (freq iphase) 1)
(define-oscillator LFPar (freq iphase) 1)
(define-oscillator LFPulse (freq iphase width) 1)
(define-oscillator LFSaw (freq iphase) 1)
(define-oscillator LFTri (freq iphase) 1)
(define-oscillator LatoocarfianC (freq a b c d xi yi) 1)
(define-oscillator LatoocarfianL (freq a b c d xi yi) 1)
(define-oscillator LatoocarfianN (freq a b c d xi yi) 1)
(define-oscillator LinCongC (freq a c m xi) 1)
(define-oscillator LinCongL (freq a c m xi) 1)
(define-oscillator LinCongN (freq a c m xi) 1)
(define-oscillator Line (start end dur doneAction) 1)
(define-oscillator Logistic (chaosParam freq) 1)
(define-oscillator LorenzL (freq s r b h xi yi zi) 1)
(define-oscillator MouseButton (minval maxval lag) 1)
(define-oscillator MouseX (min max warp lag) 1)
(define-oscillator MouseY (min max warp lag) 1)
(define-oscillator Osc (bufnum freq phase) 1)
(define-oscillator OscN (bufnum freq phase) 1)
(define-oscillator PSinGrain (freq dur amp) 1)
(define-oscillator Phasor (trig rate start end resetPos) 1)
(define-oscillator Pulse (freq width) 1)
(define-oscillator QuadC (freq a b c xi) 1)
(define-oscillator QuadL (freq a b c xi) 1)
(define-oscillator QuadN (freq a b c xi) 1)
(define-oscillator Saw (freq) 1)
(define-oscillator SharedIn () 1)
(define-oscillator SinOsc (freq phase) 1)
(define-oscillator SinOscFB (freq feedback) 1)
(define-oscillator StandardL (freq k xi yi) 1)
(define-oscillator StandardN (freq k xi yi) 1)
(define-oscillator SyncSaw (syncFreq sawFreq) 1)
(define-oscillator VOsc (bufpos freq phase) 1)
(define-oscillator VOsc3 (bufpos freq1 freq2 freq3) 1)
(define-oscillator VarSaw (freq iphase width) 1)
(define-oscillator XLine (start end dur doneAction) 1)

(define-oscillator/n BufRd (bufnum phase loop interpolation))
(define-oscillator/n DiskIn (bufnum))
(define-oscillator/n In (bus))
(define-oscillator/n LocalIn ())
(define-oscillator/n TrigControl ())

(define-oscillator* Duty (dur reset doneAction level) 1)
(define-oscillator* EnvGen (gate levelScale levelBias timeScale doneAction envelopeArray) 1)
(define-oscillator* Klang (freqscale freqoffset specArray) 1)
(define-oscillator* TDuty (dur reset doneAction level) 1)

(define-oscillator/id BrownNoise () 1)
(define-oscillator/id ClipNoise () 1)
(define-oscillator/id Dust (density) 1)
(define-oscillator/id Dust2 (density) 1)
(define-oscillator/id GrayNoise () 1)
(define-oscillator/id LFClipNoise (freq) 1)
(define-oscillator/id LFDClipNoise (freq) 1)
(define-oscillator/id LFDNoise0 (freq) 1)
(define-oscillator/id LFDNoise1 (freq) 1)
(define-oscillator/id LFDNoise3 (freq) 1)
(define-oscillator/id LFNoise0 (freq) 1)
(define-oscillator/id LFNoise1 (freq) 1)
(define-oscillator/id LFNoise2 (freq) 1)
(define-oscillator/id NoahNoise () 1)
(define-oscillator/id PinkNoise () 1)
(define-oscillator/id RandID (id) 1)
(define-oscillator/id RandSeed (trig seed) 1)
(define-oscillator/id WhiteNoise () 1)

(define-specialized Convolution (in kernel frameSize) 1 ar)
(define-specialized Convolution2 (in bufnum trigger frameSize) 1 ar)
(define-specialized FFT (buf in hop wintype active) 1 kr)
(define-specialized IFFT (buf wintype) 1 ar)
(define-specialized K2A (in) 1 ar)
(define-specialized PV_Add (bufA bufB) 1 kr)
(define-specialized PV_BinScramble (buffer wipe width trig) 1 kr)
(define-specialized PV_BinShift (buffer stretch shift) 1 kr)
(define-specialized PV_BinWipe (bufferA bufferB wipe) 1 kr)
(define-specialized PV_BrickWall (buffer wipe) 1 kr)
(define-specialized PV_ConformalMap (buffer real imag) 1 kr)
(define-specialized PV_Copy (bufferA bufferB) 1 kr)
(define-specialized PV_CopyPhase (bufferA bufferB) 1 kr)
(define-specialized PV_Diffuser (buffer trig) 1 kr)
(define-specialized PV_HainsworthFoote (buffer proph propf threshold waittime) 1 ar)
(define-specialized PV_JensenAndersen (buffer propsc prophfe prophfc propsf threshold waittime) 1 ar)
(define-specialized PV_LocalMax (buffer threshold) 1 kr)
(define-specialized PV_MagAbove (buffer threshold) 1 kr)
(define-specialized PV_MagBelow (buffer threshold) 1 kr)
(define-specialized PV_MagClip (buffer threshold) 1 kr)
(define-specialized PV_MagFreeze (buffer freeze) 1 kr)
(define-specialized PV_MagMul () 1 kr)
(define-specialized PV_MagNoise (buffer) 1 kr)
(define-specialized PV_MagShift () 1 kr)
(define-specialized PV_MagSmear (buffer bins) 1 kr)
(define-specialized PV_MagSquared () 1 kr)
(define-specialized PV_Max () 1 kr)
(define-specialized PV_Min () 1 kr)
(define-specialized PV_Mul () 1 kr)
(define-specialized PV_PhaseShift (buffer shift) 1 kr)
(define-specialized PV_PhaseShift270 (buffer) 1 kr)
(define-specialized PV_PhaseShift90 (buffer) 1 kr)
(define-specialized PV_RandComb (buffer wipe trig) 1 kr)
(define-specialized PV_RandWipe (bufferA bufferB wipe trig) 1 kr)
(define-specialized PV_RectComb (buffer numTeeth phase width) 1 kr)
(define-specialized PV_RectComb2 () 1 kr)
(define-specialized Pitch (in initFreq minFreq maxFreq execFreq maxBinsPerOctave median ampThreshold peakThreshold downSample) 2 kr)
(define-specialized SharedOut (bus channelsArray) 0 kr)
(define-specialized Unpack1FFT (chain bufsize binindex whichmeasure) 1 dr)

(define-specialized/c ControlRate 1 ir)
(define-specialized/c NumAudioBuses 1 ir)
(define-specialized/c NumBuffers 1 ir)
(define-specialized/c NumControlBuses 1 ir)
(define-specialized/c NumInputBuses 1 ir)
(define-specialized/c NumOutputBuses 1 ir)
(define-specialized/c NumRunningSynths 1 ir)
(define-specialized/c RadiansPerSample 1 ir)
(define-specialized/c SampleDur 1 ir)
(define-specialized/c SampleRate 1 ir)
(define-specialized/c SubsampleOffset 1 ir)

(define-specialized/n GrainBuf (tr dur sndbuf rate pos interp pan envbuf) ar)
(define-specialized/n GrainFM (tr dur carfreq modfreq index pan envbuf) ar)
(define-specialized/n GrainIn (tr dur in pan envbuf) ar)
(define-specialized/n GrainSin (tr dur freq pan envbuf) ar)
(define-specialized/n InFeedback (bus) ar)
(define-specialized/n InTrig (bus) kr)
(define-specialized/n LagIn (bus lag) kr)
(define-specialized/n PlayBuf (bufnum rate trigger startPos loop) ar)
(define-specialized/n Warp1 (bufnum pointer freqScale windowSize envbufnum overlaps windowRandRatio interp) ar)

(define-specialized* PackFFT (chain bufsize from to z magsphases) 1 kr)

(define-specialized/id Dbrown (length lo hi step) 1 dr)
(define-specialized/id Dbufrd (bufnum phase loop) 1 dr)
(define-specialized/id Dgeom (length start grow) 1 dr)
(define-specialized/id Dibrown (length lo hi step) 1 dr)
(define-specialized/id Diwhite (length lo hi) 1 dr)
(define-specialized/id Dseries (length start step) 1 dr)
(define-specialized/id Dwhite (length lo hi) 1 dr)
(define-specialized/id ExpRand (lo hi) 1 ir)
(define-specialized/id IRand (lo hi) 1 ir)
(define-specialized/id LinRand (lo hi minmax) 1 ir)
(define-specialized/id NRand (lo hi n) 1 ir)
(define-specialized/id Rand (lo hi) 1 ir)

(define-specialized*/id Drand (length array) 1 dr)
(define-specialized*/id Dseq (length array) 1 dr)
(define-specialized*/id Dser (length array) 1 dr)
(define-specialized*/id Dswitch1 (length array) 1 dr)
(define-specialized*/id Dxrand (length array) 1 dr)

(define Add3
  (lambda (a b c)
    (Add (Add a b) c)))

(define BufRdC
  (lambda (nc r b p l) 
    (BufRd nc r b p l 4)))

(define BufRdL
  (lambda (nc r b p l) 
    (BufRd nc r b p l 2)))

(define BufRdN
  (lambda (nc r b p l) 
    (BufRd nc r b p l 1)))

(define FFT*
  (lambda (buf in)
    (FFT buf in 0.5 0 1)))

(define IFFT* 
  (lambda (buf)
    (IFFT buf 0)))

(define Mul3
  (lambda (a b c)
    (Mul (Mul a b) c)))

(define TChoose
  (lambda (trig array)
    (Select (TIRand 0 (length (mce-channels array)) trig) array)))

(define TWChoose
  (lambda (trig array weights normalize)
    (Select (TWindex trig normalize weights) array)))

;; int
(define addToHead 0)
(define addToTail 1)
(define addBefore 2)
(define addAfter 3)
(define addReplace 4)

;; int
(define genNormalize 1)
(define genWavetable 2)
(define genClear 4)

;; int
(define doNothing 0)
(define pauseSynth 1)
(define removeSynth 2)

(define /quit
  (message "/quit" nil))

(define /notify
  (lambda (i)
    (message "/notify" (list i))))

(define /status
  (message "/status" nil))

(define /dumpOSC
  (lambda (i)
    (message "/dumpOSC" (list i))))

(define /sync
  (lambda (i)
    (message "/sync" (list i))))

(define /clearSched
  (message "/clearSched" nil))

(define /d_recv
  (lambda (b)
    (message "/d_recv" (list b))))

(define /d_load
  (lambda (s)
    (message "/d_load" (list s))))

(define /d_loadDir
  (lambda (s)
    (message "/d_loadDir" (list s))))

(define /d_free1
  (lambda (s)
    (message "/d_free" (list s))))

(define /n_free1
  (lambda (i)
    (message "/n_free" (list i))))

(define /n_run1
  (lambda (i j)
    (message "/n_run" (list i j))))

(define /n_set1
  (lambda (i s f)
    (message "/n_set" (list i s f))))

(define /n_setn1
  (lambda (i s fs)
    (message "/n_setn" (cons i (cons s (cons (length fs) fs))))))

(define /n_fill1
  (lambda (i s j f)
    (message "/n_fill" (list i s j f))))

(define /n_map1
  (lambda (i s j)
    (message "/n_map" (list i s j))))

(define /n_mapn1
  (lambda (i s j k)
    (message "/n_mapn" (list i s j k))))

(define /n_before
  (lambda (i j)
    (message "/n_before" (list i j))))

(define /n_query
  (lambda (i)
    (message "/n_query" (list i))))

(define /n_trace
  (lambda (i)
    (message "/n_trace" (list i))))

(define /s_new0
  (lambda (s i j k)
    (message "/s_new" (list s i j k))))

(define /s_new1
  (lambda (s i j k t f)
    (message "/s_new" (list s i j k t f))))

(define /s_new2
  (lambda (s i j k t1 f1 t2 f2)
    (message "/s_new" (list s i j k t1 f1 t2 f2))))

(define /s_new
  (lambda (s i j k cs)
    (message "/s_new" (append2 (list s i j k) cs))))

(define /s_get1
  (lambda (i j)
    (message "/s_get" (list i j))))

(define /s_getn1
  (lambda (i s j)
    (message "/s_getn" (list i s j))))

(define /s_noid
  (lambda (i)
    (message "/s_noid" (list i))))

(define /g_new1
  (lambda (i j k)
    (message "/g_new" (list i j k))))

(define /g_head1
  (lambda (i j)
    (message "/g_head" (list i j))))

(define /g_tail1
  (lambda (i j)
    (message "/g_tail" (list i j))))

(define /g_freeAll1
  (lambda (i)
    (message "/g_freeAll" (list i))))

(define /g_deepFree1
  (lambda (i)
    (message "/g_deepFree" (list i))))

(define /b_alloc
  (lambda (id frames channels)
    (message "/b_alloc" (list id frames channels))))

(define /b_allocRead
  (lambda (id path frame n)
    (message "/b_allocRead" (list id path frame n))))

(define /b_read
  (lambda (id path frame n bframe flag)
    (message "/b_read" (list id path frame n bframe flag))))

(define /b_write
  (lambda (id path header type frames start flag)
    (message "/b_write" (list id path header type frames start flag))))

(define /b_free
  (lambda (i)
    (message "/b_free" (list i))))

(define /b_zero
  (lambda (i)
    (message "/b_zero" (list i))))

(define /b_set1
  (lambda (i j f)
    (message "/b_set" (list i j f))))

(define /b_setn1
  (lambda (i j fs)
    (message "/b_setn" (cons i (cons j (cons (length fs) fs))))))

(define /b_fill1
  (lambda (i j k f)
    (message "/b_fill" (list i j k f))))

(define /b_close
  (lambda (i)
    (message "/b_close" (list i))))

(define /b_query1
  (lambda (i)
    (message "/b_query" (list i))))

(define /b_get1
  (lambda (i j)
    (message "/b_get" (list i j))))

(define /b_getn1
  (lambda (i j k)
    (message "/b_getn" (list i j k))))

(define /b_gen1
  (lambda (i s fs)
    (message "/b_gen" (cons i (cons s fs)))))

(define /c_set1
  (lambda (i f)
    (message "/c_set" (list i f))))

(define /c_setn1
  (lambda (i fs)
    (message "/c_setn" (cons i (cons (length fs) fs)))))

(define /c_fill1
  (lambda (i j f)
    (message "/c_fill" (list i j f))))

(define /c_get1
  (lambda (i)
    (message "/c_get" (list i))))

(define /c_getn1
  (lambda (i j)
    (message "/c_getn" (list i j))))

;; float
(define timeout 
  1.0)

;; port -> string -> osc
(define wait
  (lambda (fd s)
    (let ((p (recv fd timeout)))
      (cond
       ((not p) (error "wait: timed out"))
       ((not (string=? (head p) s)) (error "wait: bad return packet" p s))
       (else p)))))

;; port -> osc -> ()
(define async
  (lambda (fd m)
    (send fd m)
    (wait fd "/done")))

;; port -> ()
(define reset
  (lambda (fd)
    (send fd (bundle -1 (list (/g_freeAll1 0)
			      /clearSched
			      (/g_new1 1 0 0))))))

;; (port -> a) -> a
(define with-sc3
  (lambda (f)
    (let* ((fd (open-udp* "127.0.0.1" 57110))
	   (r (f fd)))
      (udp*-close fd)
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
    (send fd /status)
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
    (send fd /status)
    (let ((r (wait fd "status.reply")))
      (list-ref r n))))

;; port -> float
(define server-sample-rate/nominal
  (lambda (s)
    (server-status-field s 8)))

;; port -> float
(define server-sample-rate/actual
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
	    ((string=? c "sin") 3.0)
	    ((string=? c "cos") 4.0)
	    ((string=? c "squared") 6.0)
	    ((string=? c "cubed") 7.0)
	    (else (error "curve-to-shape:" c))))
     ((number? c)
      5.0)
     (else
      (error "curve-to-shape: illegal curve" c)))))

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
(define env/bp
  (lambda (bp dur amp curves)
    (env (map (lambda (e) (Mul e amp)) (take-cycle (tail bp) 2))
	 (map (lambda (e) (Mul e dur)) ((d->dx Sub) (take-cycle bp 2)))
	 curves
	 -1
	 -1)))

;; Design a standard trapezoidal envelope. `shape' determines the
;; sustain time as a proportion of `dur', zero is a triangular
;; envelope, one a rectangular envelope. `skew' determines the
;; attack/decay ratio, zero is an immediate attack and a slow decay,
;; one a slow attack and an immediate decay. This implementation
;; builds a zero one breakpoint data set and calls env/bp.

(define env/trapezoid
  (lambda (shape skew dur amp)
    (let* ((x1 (* skew (- 1.0 shape)))
	   (bp (list 0
		     (if (<= skew 0.0) 1.0 0.0)
		     x1
		     1.0
		     (+ shape x1)
		     1.0
		     1.0
		     (if (>= skew 1.0) 1.0 0.0))))
      (env/bp bp dur amp (replicate 4 "linear")))))

(define env/triangle
  (lambda (dur level)
    (let ((half-dur (Mul dur 0.5)))
      (env (list 0.0 level 0.0)
	   (list half-dur half-dur)
	   (list "linear" "linear")
	   -1
	   -1))))

(define env/sine
  (lambda (dur level)
    (let ((half-dur (Mul dur 0.5)))
      (env (list 0.0 level 0.0)
	   (list half-dur half-dur)
	   (list "sin" "sin")
	   -1
	   -1))))

(define env/perc
  (lambda (attackTime releaseTime level curves)
    (env (list 0.0 level 0.0)
	 (list attackTime releaseTime)
	 curves
	 -1
	 -1)))

(define env/adsr 
  (lambda (attackTime
	   decayTime
	   sustainLevel
	   releaseTime
	   peakLevel
	   curves
	   bias)
    (env (map (lambda (e) (Mul e bias))
	      (list 0.0 peakLevel (Mul peakLevel sustainLevel) 0.0))
	 (list attackTime decayTime releaseTime)
	 curves
	 2
	 -1)))

(define env/asr
  (lambda (attackTime sustainLevel releaseTime curves)
    (env (list 0.0 sustainLevel 0.0)
	 (list attackTime releaseTime)
	 curves
	 1
	 -1)))

(define env/linen
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
	   (Unpack1FFT c nf i mp?))
	 (enum-from-to from to))))

(define pvcollect
  (lambda (c nf f from to z?)
    (let* ((m (unpack-fft c nf from to 0))
	   (p (unpack-fft c nf from to 1))
	   (i (enum-from-to from to))
	   (e (map f m p i)))
      (PackFFT c nf from to z? (packfft-data* e)))))

;; ugen -> ugen
(define audio-in
  (lambda (n)
    (let ((offset (Sub NumOutputBuses 1)))
      (if (mce? n)
	  (let ((l (mce-channels n)))
	    (if (consecutive? l)
		(In (length l) ar (Add offset (head l)))
		(In 1 ar (Add offset n))))
	  (In 1 ar (Add offset n))))))

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
			  (Add (Mul (Ringz i (MulAdd f fs fo) (Mul d ds)) a)
			       (gen (drop 3 l))))))))
      (gen (mce-channels s)))))

;; ugen -> ugen -> ugen -> ugen
(define freq-shift
  (lambda (i f p)
    (let ((o (SinOsc ar f (mce2 (Add p (* 0.5 pi)) p)))
	  (h (Hilbert i)))
      (mix (Mul h o)))))

;; rate -> ugen -> ugen -> ugen -> ugen -> ugen
(define pm-osc
  (lambda (r cf mf pm mp)
    (SinOsc r cf (Mul (SinOsc r mf mp) pm))))

;; ugen|mce -> ugen
(define mix
  (lambda (u)
    (cond
     ((mce? u) (foldl1 Add (mce-channels u)))
     (else u))))

;; int -> (int -> ugen) -> mce
(define mce/fill
  (lambda (n f)
    (make-mce (map1 f (enum-from-to 0 (- n 1))))))

;; int -> (int -> ugen) -> ugen
(define mix/fill
  (lambda (n f)
    (mix (mce/fill n f))))

;; port -> string -> ugen -> ()
(define send-synth
  (lambda (fd n u)
    (async fd (/d_recv (encode-graphdef (synthdef n u))))))

;; port -> ugen -> ()
(define play
  (lambda (fd u)
    (send-synth fd "Anonymous" u)
    (send fd (/s_new0 "Anonymous" -1 1 1))))

;; ugen -> ()
(define audition
  (lambda (u)
    (with-sc3
     (lambda (fd)
       (play fd u)))))

;; float
(define dinf 
  9.0e8)
