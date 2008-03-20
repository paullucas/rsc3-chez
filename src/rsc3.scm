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
(define ampdb 
  (lambda (x) 
    (* (s:log10 x) 20)))

;; float -> float
(define dbamp
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
(define s:midicps
  (lambda (note)
    (* 440.0 (expt 2.0 (* (- note 69.0) 0.083333333333)))))

;; float -> float
(define s:cpsmidi
  (lambda (freq)
    (+ (* (s:log2 (* freq 0.0022727272727)) 12.0) 69.0)))

;; float -> float
(define s:midiratio
  (lambda (midi)
    (expt 2.0 (* midi 0.083333333333))))

;; float -> float
(define ratiomidi
  (lambda (ratio)
    (* 12.0 (s:log2 ratio))))

;; float -> float
(define s:octcps
  (lambda (note)
    (* 440.0 (expt 2.0 (- note 4.75)))))

;; float -> float
(define s:cpsoct
  (lambda (freq)
    (+ (s:log2 (* freq 0.0022727272727)) 4.75)))

;; float -> [float] -> int -> float
(define degree->key
  (lambda (degree scale steps)
    (let ((scale-n (length scale)))
      (+ (* steps (div degree scale-n))
	 (list-ref scale (mod degree scale-n))))))

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

;; symbol -> int -> (float -> float) :bind: (node -> node)
(define-syntax define-unary-operator
  (syntax-rules ()
    ((_ n s f)
     (define n
       (lambda (a)
	 (if (and (number? a) f)
	     (f a)
	     (construct-ugen "UnaryOpUGen" #f (list a) #f 1 s (make-uid 0))))))))

(define-syntax define-binary-operator
  (syntax-rules ()
    ((_ n s f)
     (define n
       (lambda (a b)
	 (if (and (number? a)
		  (number? b)
		  f)
	     (f a b)
	     (construct-ugen "BinaryOpUGen" #f (list a b) #f 1 s (make-uid 0))))))))

(define-syntax define-filter
  (syntax-rules ()
    ((_ n m (i ...) o)
     (define n
       (lambda (i ...)
	 (construct-ugen m #f (list i ...) #f o 0 (make-uid 0)))))))

(define-syntax define-filter-n
  (syntax-rules ()
    ((_ n m (i ...))
     (define n
       (lambda (nc i ...)
	 (if (not (integer? nc))
	     (error "define-filter-n" "illegal channel count" 'n nc)
	     #f)
	 (let ((l (list i ...)))
	   (construct-ugen m #f l #f nc 0 (make-uid 0))))))))

(define-syntax define-filter*
  (syntax-rules ()
    ((_ n m (i ... v) o)
     (define n
       (lambda (i ... v)
	 (construct-ugen m #f (list i ...) v o 0 (make-uid 0)))))))

(define-syntax define-filter-id
  (syntax-rules ()
    ((_ n m (i ...) o)
     (define n
       (lambda (i ...)
	 (construct-ugen m #f (list i ...) #f o 0 (unique-uid)))))))

;; keyed filter, rate is determined by a known input
(define-syntax define-filter-k
  (syntax-rules ()
    ((_ n m (i ...) o k)
     (define n
       (lambda (i ...)
	 (let ((l (list i ...)))
	   (construct-ugen m (rate-of (list-ref l k)) l #f o 0 (make-uid 0))))))))

(define-syntax define-oscillator
  (syntax-rules ()
    ((_ n m (i ...) o)
     (define n
       (lambda (r i ...)
	 (construct-ugen m r (list i ...) #f o 0 (make-uid 0)))))))

(define-syntax define-oscillator-n
  (syntax-rules ()
    ((_ n m (i ...))
     (define n
       (lambda (nc r i ...)
	 (if (not (integer? nc))
	     (error "define-oscillator-n" "illegal channel count:" 'n nc)
	     #f)
	 (let ((l (list i ...)))
	   (construct-ugen m r l #f nc 0 (make-uid 0))))))))

(define-syntax define-oscillator*
  (syntax-rules ()
    ((_ n m (i ... v) o)
     (define n
       (lambda (r i ... v)
	 (construct-ugen m r (list i ...) v o 0 (make-uid 0)))))))

(define-syntax define-oscillator-id
  (syntax-rules ()
    ((_ n m (i ...) o)
     (define n
       (lambda (r i ...)
	 (construct-ugen m r (list i ...) #f o 0 (unique-uid)))))))

(define-syntax define-specialized
  (syntax-rules ()
    ((_ n m (i ...) o r)
     (define n
       (lambda (i ...)
	 (construct-ugen m r (list i ...) #f o 0 (make-uid 0)))))))

(define-syntax define-specialized-c
  (syntax-rules ()
    ((_ n m o r)
     (define n
       (construct-ugen m r (list) #f o 0 (make-uid 0))))))

(define-syntax define-specialized*
  (syntax-rules ()
    ((_ n m (i ... v) o r)
     (define n
       (lambda (i ... v)
	 (construct-ugen m r (list i ...) v o 0 (make-uid 0)))))))

(define-syntax define-specialized-n
  (syntax-rules ()
    ((_ n m (i ...) r)
     (define n
       (lambda (nc i ...)
	 (if (not (integer? nc))
	     (error "define-specialized-n" "illegal channel count:" 'n nc)
	     #f)
	 (let ((l (list i ...)))
	   (construct-ugen m r l #f nc 0 (make-uid 0))))))))

(define-syntax define-specialized-id
  (syntax-rules ()
    ((_ n m (i ...) o r)
     (define n
       (lambda (i ...)
	 (construct-ugen m r (list i ...) #f o 0 (unique-uid)))))))

(define-syntax define-specialized*-id
  (syntax-rules ()
    ((_ n m (i ... v) o r)
     (define n
       (lambda (i ... v)
	 (construct-ugen m r (list i ...) v o 0 (unique-uid)))))))

;; ugen -> ugen
(define-unary-operator u:abs 5 abs)
(define-unary-operator amp-db 22 ampdb)
(define-unary-operator arc-cos 32 acos)
(define-unary-operator arc-sin 31 asin)
(define-unary-operator arc-tan 33 atan)
(define-unary-operator as-float 6 #f)
(define-unary-operator as-int 7 #f)
(define-unary-operator bi-lin-rand 40 #f)
(define-unary-operator bit-not 4 #f)
(define-unary-operator cpsmidi 18 s:cpsmidi)
(define-unary-operator cpsoct 24 s:cpsoct)
(define-unary-operator ceil 8 ceiling)
(define-unary-operator coin 44 #f)
(define-unary-operator u:cos 29 cos)
(define-unary-operator cos-h 35 #f)
(define-unary-operator cubed 13 s:cubed)
(define-unary-operator db-amp 21 dbamp)
(define-unary-operator digit-value 45 #f)
(define-unary-operator distort 42 #f)
(define-unary-operator u:exp 15 exp)
(define-unary-operator u:floor 9 floor)
(define-unary-operator frac 10 #f)
(define-unary-operator han-window 49 #f)
(define-unary-operator is-nil 2 #f)
(define-unary-operator u:log 25 log)
(define-unary-operator log10 27 s:log10)
(define-unary-operator log2 26 s:log2)
(define-unary-operator midicps 17 s:midicps)
(define-unary-operator midiratio 19 s:midiratio)
(define-unary-operator neg 0 -)
(define-unary-operator u:not 1 #f)
(define-unary-operator not-nil 3 #f)
(define-unary-operator octcps 23 s:octcps)
(define-unary-operator rand2 38 #f)
(define-unary-operator ratio-midi 20 ratiomidi)
(define-unary-operator recip 16 s:recip)
(define-unary-operator rect-window 48 #f)
(define-unary-operator scurve 53 #f)
(define-unary-operator sign 11 #f)
(define-unary-operator silence 46 #f)
(define-unary-operator u:sin 28 sin)
(define-unary-operator sin-h 34 #f)
(define-unary-operator soft-clip 43 #f)
(define-unary-operator u:sqrt 14 sqrt)
(define-unary-operator squared 12 s:squared)
(define-unary-operator sum3rand 41 #f)
(define-unary-operator u:tan 30 tan)
(define-unary-operator tan-h 36 #f)
(define-unary-operator thru 47 #f)
(define-unary-operator tri-window 51 #f)
(define-unary-operator welch-window 50 #f)
(define-unary-operator lin-rand* 39 #f)
(define-unary-operator ramp* 52 #f)
(define-unary-operator rand* 37 #f)

;; ugen -> ugen -> ugen
(define-binary-operator amclip 40 #f)
(define-binary-operator abs-dif 38 #f)
(define-binary-operator add 0 +)
(define-binary-operator atan2 22 #f)
(define-binary-operator bit-and 14 #f)
(define-binary-operator bit-or 15 #f)
(define-binary-operator bit-xor 16 #f)
(define-binary-operator clip2 42 #f)
(define-binary-operator dif-sqr 34 #f)
(define-binary-operator eq 6 #f)
(define-binary-operator excess 43 #f)
(define-binary-operator exp-rand-range 48 #f)
(define-binary-operator fdiv 4 /)
(define-binary-operator fill 29 #f)
(define-binary-operator first-arg 46 #f)
(define-binary-operator fold2 44 #f)
(define-binary-operator u:gcd 18 #f)
(define-binary-operator ge 11 s:ge)
(define-binary-operator gt 9 s:gt)
(define-binary-operator hypot 23 #f)
(define-binary-operator hypotx 24 #f)
(define-binary-operator idiv 3 #f)
(define-binary-operator u:lcm 17 #f)
(define-binary-operator le 10 s:le)
(define-binary-operator lt 8 s:lt)
(define-binary-operator u:max 13 max)
(define-binary-operator u:min 12 min)
(define-binary-operator u:mod 5 #f)
(define-binary-operator mul 2 *)
(define-binary-operator ne 7 #f)
(define-binary-operator pow 25 #f)
(define-binary-operator rand-range 47 #f)
(define-binary-operator ring1 30 #f)
(define-binary-operator ring2 31 #f)
(define-binary-operator ring3 32 #f)
(define-binary-operator ring4 33 #f)
(define-binary-operator u:round 19 #f)
(define-binary-operator round-up 20 #f)
(define-binary-operator scale-neg 41 #f)
(define-binary-operator shift-left 26 #f)
(define-binary-operator shift-right 27 #f)
(define-binary-operator sqr-dif 37 #f)
(define-binary-operator sqr-sum 36 #f)
(define-binary-operator sub 1 -)
(define-binary-operator sum-sqr 35 #f)
(define-binary-operator thresh 39 #f)
(define-binary-operator trunc 21 #f)
(define-binary-operator unsigned-shift 28 #f)
(define-binary-operator wrap2 45 #f)

(define-filter apf "APF" (in freq radius) 1)
(define-filter allpass-c "AllpassC" (in maxdelaytime delaytime decaytime) 1)
(define-filter allpass-l "AllpassL" (in maxdelaytime delaytime decaytime) 1)
(define-filter allpass-n "AllpassN" (in maxdelaytime delaytime decaytime) 1)
(define-filter amp-comp "AmpComp" (freq root exp) 1)
(define-filter amp-comp-a "AmpCompA" (freq root min-amp root-amp) 1)
(define-filter bpf "BPF" (in freq rq) 1)
(define-filter bpz2 "BPZ2" (in) 1)
(define-filter brf "BRF" (in freq rq) 1)
(define-filter brz2 "BRZ2" (in) 1)
(define-filter balance2 "Balance2" (left right pos level) 1)
(define-filter ball "Ball" (in g damp friction) 1)
(define-filter bi-pan-b2 "BiPanB2" (in-a in-b azimuth gain) 3)
(define-filter buf-allpass-c "BufAllpassC" (buf in delaytime decaytime) 1)
(define-filter buf-allpass-l "BufAllpassL" (buf in delaytime decaytime) 1)
(define-filter buf-allpass-n "BufAllpassN" (buf in delaytime decaytime) 1)
(define-filter buf-comb-c "BufCombC" (buf in delaytime decaytime) 1)
(define-filter buf-comb-l "BufCombL" (buf in delaytime decaytime) 1)
(define-filter buf-comb-n "BufCombN" (buf in delaytime decaytime) 1)
(define-filter buf-delay-c "BufDelayC" (buf in delaytime) 1)
(define-filter buf-delay-l "BufDelayL" (buf in delaytime) 1)
(define-filter buf-delay-n "BufDelayN" (buf in delaytime) 1)
(define-filter clip "Clip" (in lo hi) 1)
(define-filter comb-c "CombC" (in maxdelaytime delaytime decaytime) 1)
(define-filter comb-l "CombL" (in maxdelaytime delaytime decaytime) 1)
(define-filter comb-n "CombN" (in maxdelaytime delaytime decaytime) 1)
(define-filter compander "Compander" (in control thresh slope-below slope-above clamp-time relax-time) 1)
(define-filter compander-d "CompanderD" (in thresh slope-below slope-above clamp-time relax-time) 1)
(define-filter decay "Decay" (in decay-time) 1)
(define-filter decay2 "Decay2" (in attack-time decay-time) 1)
(define-filter degree-to-key "DegreeToKey" (bufnum in octave) 1)
(define-filter delay1 "Delay1" (in) 1)
(define-filter delay2 "Delay2" (in) 1)
(define-filter delay-c "DelayC" (in maxdelaytime delaytime) 1)
(define-filter delay-l "DelayL" (in maxdelaytime delaytime) 1)
(define-filter delay-n "DelayN" (in maxdelaytime delaytime) 1)
(define-filter detect-silence "DetectSilence" (in amp time done-action) 1)
(define-filter done "Done" (src) 1)
(define-filter fos "FOS" (in a0 a1 b1) 1)
(define-filter fold "Fold" (in lo hi) 1)
(define-filter formlet "Formlet" (in freq attacktime decaytime) 1)
(define-filter free "Free" (in node-id) 1)
(define-filter free-self "FreeSelf" (in) 1)
(define-filter free-self-when-done "FreeSelfWhenDone" (in) 1)
(define-filter free-verb "FreeVerb" (in mix room damp) 1)
(define-filter free-verb2 "FreeVerb2" (in1 in2 mix room damp) 2)
(define-filter gate "Gate" (in trig) 1)
(define-filter hpf "HPF" (in freq) 1)
(define-filter hpz1 "HPZ1" (in) 1)
(define-filter hpz2 "HPZ2" (in) 1)
(define-filter hasher "Hasher" (in) 1)
(define-filter hilbert "Hilbert" (in) 2)
(define-filter image-warp "ImageWarp" (pic x y interpolation-type) 1)
(define-filter in-range "InRange" (in lo hi) 1)
(define-filter in-rect "InRect" (x y rect) 1)
(define-filter index "Index" (bufnum in) 1)
(define-filter integrator "Integrator" (in coef) 1)
(define-filter lpf "LPF" (in freq) 1)
(define-filter lpz1 "LPZ1" (in) 1)
(define-filter lpz2 "LPZ2" (in) 1)
(define-filter lag "Lag" (in lag-time) 1)
(define-filter lag2 "Lag2" (in lag-time) 1)
(define-filter lag3 "Lag3" (in lag-time) 1)
(define-filter lag-control "LagControl" () 1)
(define-filter last-value "LastValue" (in diff) 1)
(define-filter latch "Latch" (in trig) 1)
(define-filter leak-dc "LeakDC" (in coef) 1)
(define-filter least-change "LeastChange" (a b) 1)
(define-filter limiter "Limiter" (in level dur) 1)
(define-filter lin-exp "LinExp" (in srclo srchi dstlo dsthi) 1)
(define-filter lin-lin "LinLin" (in srclo srchi dstlo dsthi) 1)
(define-filter lin-pan2 "LinPan2" (in pos level) 2)
(define-filter lin-xfade2 "LinXFade2" (in-a in-b pan level) 1)
(define-filter linen "Linen" (gate attack-time sus-level release-time done-action) 1)
(define-filter mantissa-mask "MantissaMask" (in bits) 1)
(define-filter median "Median" (length in) 1)
(define-filter mid-eq "MidEq" (in freq rq db) 1)
(define-filter moog-ff "MoogFF" (in freq gain reset) 1)
(define-filter most-change "MostChange" (a b) 1)
(define-filter mul-add "MulAdd" (a b c) 1)
(define-filter normalizer "Normalizer" (in level dur) 1)
(define-filter one-pole "OnePole" (in coef) 1)
(define-filter one-zero "OneZero" (in coef) 1)
(define-filter pan2 "Pan2" (in pos level) 2)
(define-filter pan4 "Pan4" (in xpos ypos level) 4)
(define-filter pan-az "PanAz" (num-chans in pos level width orientation) 1)
(define-filter pan-b "PanB" (in azimuth elevation gain) 3)
(define-filter pan-b2 "PanB2" (in azimuth gain) 3)
(define-filter pause "Pause" (in node-id) 1)
(define-filter pause-self "PauseSelf" (in) 1)
(define-filter pause-self-when-done "PauseSelfWhenDone" (in) 1)
(define-filter peak "Peak" (trig reset) 1)
(define-filter peak-follower "PeakFollower" (in decay) 1)
(define-filter pitch-shift "PitchShift" (in window-size pitch-ratio pitch-dispersion time-dispersion) 1)
(define-filter pluck "Pluck" (in trig maxdelaytime delaytime decaytime coef) 1)
(define-filter pulse-count "PulseCount" (trig reset) 1)
(define-filter pulse-divider "PulseDivider" (trig div start) 1)
(define-filter rhpf "RHPF" (in freq rq) 1)
(define-filter rlpf "RLPF" (in freq rq) 1)
(define-filter ramp "Ramp" (in lag-time) 1)
(define-filter resonz "Resonz" (in freq bwr) 1)
(define-filter ringz "Ringz" (in freq decaytime) 1)
(define-filter rotate2 "Rotate2" (x y pos) 2)
(define-filter running-max "RunningMax" (in trig) 1)
(define-filter running-min "RunningMin" (in trig) 1)
(define-filter running-sum "RunningSum" (in numsamp) 1)
(define-filter sos "SOS" (in a0 a1 a2 b1 b2) 1)
(define-filter schmidt "Schmidt" (in lo hi) 1)
(define-filter send-trig "SendTrig" (in id value) 0)
(define-filter set-reset-ff "SetResetFF" (trig reset) 1)
(define-filter shaper "Shaper" (bufnum in) 1)
(define-filter slew "Slew" (in up dn) 1)
(define-filter slope "Slope" (in) 1)
(define-filter spring "Spring" (in spring damp) 1)
(define-filter stepper "Stepper" (trig reset min max step resetval) 1)
(define-filter sweep "Sweep" (trig rate) 1)
(define-filter tball "TBall" (in g damp friction) 1)
(define-filter tdelay "TDelay" (in dur) 1)
(define-filter tpulse "TPulse" (trig freq width) 1)
(define-filter timer "Timer" (trig) 1)
(define-filter toggle-ff "ToggleFF" (trig) 1)
(define-filter trapezoid "Trapezoid" (in a b c d) 1)
(define-filter trig "Trig" (in dur) 1)
(define-filter trig1 "Trig1" (in dur) 1)
(define-filter two-pole "TwoPole" (in freq radius) 1)
(define-filter two-zero "TwoZero" (in freq radius) 1)
(define-filter vibrato "Vibrato" (freq rate depth delay onset rate-variation depth-variation iphase) 1)
(define-filter wrap "Wrap" (in lo hi) 1)
(define-filter wrap-index "WrapIndex" (bufnum in) 1)
(define-filter xfade2 "XFade2" (in-a in-b pan level) 1)
(define-filter xy "XY" (xscale yscale xoff yoff rot rate) 1)
(define-filter zero-crossing "ZeroCrossing" (in) 1)

(define-filter-k demand "Demand" (trig reset demand-ugens) 1 0)

(define-filter-n decode-b2 "DecodeB2" (w x y orientation))
(define-filter-n silent "Silent" ())
(define-filter-n tgrains "TGrains" (trigger bufnum rate center-pos dur pan amp interp))

(define-filter* buf-wr "BufWr" (bufnum phase loop input-array) 1)
(define-filter* klank "Klank" (input freqscale freqoffset decayscale specifications-array-ref) 1)
(define-filter* poll "Poll" (trig in trig-id label) 0)
(define-filter* record-buf "RecordBuf" (bufnum offset rec-level pre-level run loop trigger input-array) 1)
(define-filter* select "Select" (which array) 1)
(define-filter* twindex "TWindex" (in normalize array) 1)

(define-filter* disk-out "DiskOut" (bufnum channels-array) 0)
(define-filter* local-out "LocalOut" (channels-array) 0)
(define-filter* offset-out "OffsetOut" (bus channels-array) 0)
(define-filter* out "Out" (bus channels-array) 0)
(define-filter* replace-out "ReplaceOut" (bus channels-array) 0)
(define-filter* scope-out "ScopeOut" (input-array bufnum) 0)
(define-filter* xout "XOut" (bus xfade channels-array) 0)

(define-filter-id coin-gate "CoinGate" (prob in) 1)
(define-filter-id texp-rand "TExpRand" (lo hi trig) 1)
(define-filter-id tirand "TIRand" (lo hi trig) 1)
(define-filter-id trand "TRand" (lo hi trig) 1)

(define-oscillator amplitude "Amplitude" (in attack-time release-time) 1)
(define-oscillator blip "Blip" (freq numharm) 1)
(define-oscillator buf-channels "BufChannels" (buf) 1)
(define-oscillator buf-dur "BufDur" (buf) 1)
(define-oscillator buf-frames "BufFrames" (buf) 1)
(define-oscillator buf-rate-scale "BufRateScale" (buf) 1)
(define-oscillator buf-sample-rate "BufSampleRate" (buf) 1)
(define-oscillator buf-samples "BufSamples" (buf) 1)
(define-oscillator cosc "COsc" (bufnum freq beats) 1)
(define-oscillator crackle "Crackle" (chaos-param) 1)
(define-oscillator cusp-l "CuspL" (freq a b xi) 1)
(define-oscillator cusp-n "CuspN" (freq a b xi) 1)
(define-oscillator demand-env-gen "DemandEnvGen" (level dur shape curve gate reset level-scale level-bias time-scale done-action) 1)
(define-oscillator fbsine-c "FBSineC" (freq im fb a c xi yi) 1)
(define-oscillator fbsine-l "FBSineL" (freq im fb a c xi yi) 1)
(define-oscillator fbsine-n "FBSineN" (freq im fb a c xi yi) 1)
(define-oscillator fsin-osc "FSinOsc" (freq iphase) 1)
(define-oscillator formant "Formant" (fundfreq formfreq bwfreq) 1)
(define-oscillator gbman-c "GbmanC" (freq xi yi) 1)
(define-oscillator gbman-l "GbmanL" (freq xi yi) 1)
(define-oscillator gbman-n "GbmanN" (freq xi yi) 1)
(define-oscillator gendy1 "Gendy1" (ampdist durdist adparam ddparam minfreq maxfreq ampscale durscale init-cps knum) 1)
(define-oscillator gendy2 "Gendy2" (ampdist durdist adparam ddparam minfreq maxfreq ampscale durscale init-cps knum a c) 1)
(define-oscillator gendy3 "Gendy3" (ampdist durdist adparam ddparam freq ampscale durscale init-cps knum) 1)
(define-oscillator henon-c "HenonC" (freq a b x0 x1) 1)
(define-oscillator henon-l "HenonL" (freq a b x0 x1) 1)
(define-oscillator henon-n "HenonN" (freq a b x0 x1) 1)
(define-oscillator impulse "Impulse" (freq phase) 1)
(define-oscillator key-state "KeyState" (key min max lag) 1)
(define-oscillator lfcub "LFCub" (freq iphase) 1)
(define-oscillator lfpar "LFPar" (freq iphase) 1)
(define-oscillator lfpulse "LFPulse" (freq iphase width) 1)
(define-oscillator lfsaw "LFSaw" (freq iphase) 1)
(define-oscillator lftri "LFTri" (freq iphase) 1)
(define-oscillator latoocarfian-c "LatoocarfianC" (freq a b c d xi yi) 1)
(define-oscillator latoocarfian-l "LatoocarfianL" (freq a b c d xi yi) 1)
(define-oscillator latoocarfian-n "LatoocarfianN" (freq a b c d xi yi) 1)
(define-oscillator lin-cong-c "LinCongC" (freq a c m xi) 1)
(define-oscillator lin-cong-l "LinCongL" (freq a c m xi) 1)
(define-oscillator lin-cong-n "LinCongN" (freq a c m xi) 1)
(define-oscillator line "Line" (start end dur done-action) 1)
(define-oscillator logistic "Logistic" (chaos-param freq) 1)
(define-oscillator lorenz-l "LorenzL" (freq s r b h xi yi zi) 1)
(define-oscillator mouse-button "MouseButton" (minval maxval lag) 1)
(define-oscillator mouse-x "MouseX" (min max warp lag) 1)
(define-oscillator mouse-y "MouseY" (min max warp lag) 1)
(define-oscillator osc "Osc" (bufnum freq phase) 1)
(define-oscillator osc-n "OscN" (bufnum freq phase) 1)
(define-oscillator psin-grain "PSinGrain" (freq dur amp) 1)
(define-oscillator phasor "Phasor" (trig rate start end reset-pos) 1)
(define-oscillator pulse "Pulse" (freq width) 1)
(define-oscillator quad-c "QuadC" (freq a b c xi) 1)
(define-oscillator quad-l "QuadL" (freq a b c xi) 1)
(define-oscillator quad-n "QuadN" (freq a b c xi) 1)
(define-oscillator saw "Saw" (freq) 1)
(define-oscillator shared-in "SharedIn" () 1)
(define-oscillator sin-osc "SinOsc" (freq phase) 1)
(define-oscillator sin-osc-fb "SinOscFB" (freq feedback) 1)
(define-oscillator standard-l "StandardL" (freq k xi yi) 1)
(define-oscillator standard-n "StandardN" (freq k xi yi) 1)
(define-oscillator sync-saw "SyncSaw" (sync-freq saw-freq) 1)
(define-oscillator vosc "VOsc" (bufpos freq phase) 1)
(define-oscillator vosc3 "VOsc3" (bufpos freq1 freq2 freq3) 1)
(define-oscillator var-saw "VarSaw" (freq iphase width) 1)
(define-oscillator xline "XLine" (start end dur done-action) 1)

(define-oscillator-n buf-rd "BufRd" (bufnum phase loop interpolation))
(define-oscillator-n disk-in "DiskIn" (bufnum))
(define-oscillator-n in "In" (bus))
(define-oscillator-n local-in "LocalIn" ())
(define-oscillator-n trig-control "TrigControl" ())

(define-oscillator* duty "Duty" (dur reset done-action level) 1)
(define-oscillator* env-gen "EnvGen" (gate level-scale level-bias time-scale done-action envelope-array) 1)
(define-oscillator* klang "Klang" (freqscale freqoffset spec-array) 1)
(define-oscillator* tduty "TDuty" (dur reset done-action level) 1)

(define-oscillator-id brown-noise "BrownNoise" () 1)
(define-oscillator-id clip-noise "ClipNoise" () 1)
(define-oscillator-id dust "Dust" (density) 1)
(define-oscillator-id dust2 "Dust2" (density) 1)
(define-oscillator-id gray-noise "GrayNoise" () 1)
(define-oscillator-id lfclip-noise "LFClipNoise" (freq) 1)
(define-oscillator-id lfdclip-noise "LFDClipNoise" (freq) 1)
(define-oscillator-id lfdnoise0 "LFDNoise0" (freq) 1)
(define-oscillator-id lfdnoise1 "LFDNoise1" (freq) 1)
(define-oscillator-id lfdnoise3 "LFDNoise3" (freq) 1)
(define-oscillator-id lfnoise0 "LFNoise0" (freq) 1)
(define-oscillator-id lfnoise1 "LFNoise1" (freq) 1)
(define-oscillator-id lfnoise2 "LFNoise2" (freq) 1)
(define-oscillator-id noah-noise "NoahNoise" () 1)
(define-oscillator-id pink-noise "PinkNoise" () 1)
(define-oscillator-id rand-id "RandId" (id) 1)
(define-oscillator-id rand-seed "RandSeed" (trig seed) 1)
(define-oscillator-id white-noise "WhiteNoise" () 1)

(define-specialized convolution "Convolution" (in kernel frame-size) 1 ar)
(define-specialized convolution2 "Convolution2" (in bufnum trigger frame-size) 1 ar)
(define-specialized fft "FFT" (buf in hop wintype active) 1 kr)
(define-specialized ifft "IFFT" (buf wintype) 1 ar)
(define-specialized k2a "K2A" (in) 1 ar)
(define-specialized pv-add "PV_Add" (buf-a buf-b) 1 kr)
(define-specialized pv-bin-scramble "PV_BinScramble" (buffer wipe width trig) 1 kr)
(define-specialized pv-bin-shift "PV_BinShift" (buffer stretch shift) 1 kr)
(define-specialized pv-bin-wipe "PV_BinWipe" (buffer-a buffer-b wipe) 1 kr)
(define-specialized pv-brick-wall "PV_BrickWall" (buffer wipe) 1 kr)
(define-specialized pv-conformal-map "PV_ConformalMap" (buffer real imag) 1 kr)
(define-specialized pv-copy "PV_Copy" (buffer-a buffer-b) 1 kr)
(define-specialized pv-copy-phase "PV_CopyPhase" (buffer-a buffer-b) 1 kr)
(define-specialized pv-diffuser "PV_Diffuser" (buffer trig) 1 kr)
(define-specialized pv-hainsworth-foote "PV_HainsworthFoote" (buffer proph propf threshold waittime) 1 ar)
(define-specialized pv-jensen-andersen "PV_JensenAndersen" (buffer propsc prophfe prophfc propsf threshold waittime) 1 ar)
(define-specialized pv-local-max "PV_LocalMax" (buffer threshold) 1 kr)
(define-specialized pv-mag-above "PV_MagAbove" (buffer threshold) 1 kr)
(define-specialized pv-mag-below "PV_MagBelow" (buffer threshold) 1 kr)
(define-specialized pv-mag-clip "PV_MagClip" (buffer threshold) 1 kr)
(define-specialized pv-mag-freeze "PV_MagFreeze" (buffer freeze) 1 kr)
(define-specialized pv-mag-mul "PV_MagMul" () 1 kr)
(define-specialized pv-mag-noise "PV_MagNoise" (buffer) 1 kr)
(define-specialized pv-mag-shift "PV_MagShift" () 1 kr)
(define-specialized pv-mag-smear "PV_MagSmear" (buffer bins) 1 kr)
(define-specialized pv-mag-squared "PV_MagSquared" () 1 kr)
(define-specialized pv-max "PV_Max" () 1 kr)
(define-specialized pv-min "PV_Min" () 1 kr)
(define-specialized pv-mul "PV_Mul" () 1 kr)
(define-specialized pv-phase-shift "PV_PhaseShift" (buffer shift) 1 kr)
(define-specialized pv-phase-shift270 "PV_PhaseShift270" (buffer) 1 kr)
(define-specialized pv-phase-shift90 "PV_PhaseShift90" (buffer) 1 kr)
(define-specialized pv-rand-comb "PV_RandComb" (buffer wipe trig) 1 kr)
(define-specialized pv-rand-wipe "PV_RandWipe" (buffer-a buffer-b wipe trig) 1 kr)
(define-specialized pv-rect-comb "PV_RectComb" (buffer num-teeth phase width) 1 kr)
(define-specialized pv-rect-comb2 "PV_RectComb2" () 1 kr)
(define-specialized pitch "Pitch" (in init-freq min-freq max-freq exec-freq max-bins-per-octave median amp-threshold peak-threshold down-sample) 2 kr)
(define-specialized shared-out "SharedOut" (bus channels-array) 0 kr)
(define-specialized unpack1-fft "Unpack1FFT" (chain bufsize binindex whichmeasure) 1 dr)

(define-specialized-c control-rate "ControlRate" 1 ir)
(define-specialized-c num-audio-buses "NumAudioBuses" 1 ir)
(define-specialized-c num-buffers "NumBuffers" 1 ir)
(define-specialized-c num-control-buses "NumControlBuses" 1 ir)
(define-specialized-c num-input-buses "NumInputBuses" 1 ir)
(define-specialized-c num-output-buses "NumOutputBuses" 1 ir)
(define-specialized-c num-running-synths "NumRunningSynths" 1 ir)
(define-specialized-c radians-per-sample "RadiansPerSample" 1 ir)
(define-specialized-c sample-dur "SampleDur" 1 ir)
(define-specialized-c sample-rate "SampleRate" 1 ir)
(define-specialized-c subsample-offset "SubsampleOffset" 1 ir)

(define-specialized-n grain-buf "GrainBuf" (tr dur sndbuf rate pos interp pan envbuf) ar)
(define-specialized-n grain-fm "GrainFM" (tr dur carfreq modfreq index pan envbuf) ar)
(define-specialized-n grain-in "GrainIn" (tr dur in pan envbuf) ar)
(define-specialized-n grain-sin "GrainSin" (tr dur freq pan envbuf) ar)
(define-specialized-n in-feedback "InFeedback" (bus) ar)
(define-specialized-n in-trig "InTrig" (bus) kr)
(define-specialized-n lag-in "LagIn" (bus lag) kr)
(define-specialized-n play-buf "PlayBuf" (bufnum rate trigger start-pos loop) ar)
(define-specialized-n warp1 "Warp1" (bufnum pointer freq-scale window-size envbufnum overlaps window-rand-ratio interp) ar)

(define-specialized* pack-fft "PackFFT" (chain bufsize from to z magsphases) 1 kr)

(define-specialized-id dbrown "Dbrown" (length lo hi step) 1 dr)
(define-specialized-id dbufrd "Dbufrd" (bufnum phase loop) 1 dr)
(define-specialized-id dgeom "Dgeom" (length start grow) 1 dr)
(define-specialized-id dibrown "Dibrown" (length lo hi step) 1 dr)
(define-specialized-id diwhite "Diwhite" (length lo hi) 1 dr)
(define-specialized-id dseries "Dseries" (length start step) 1 dr)
(define-specialized-id dwhite "Dwhite" (length lo hi) 1 dr)
(define-specialized-id exp-rand "ExpRand" (lo hi) 1 ir)
(define-specialized-id irand "IRand" (lo hi) 1 ir)
(define-specialized-id lin-rand "LinRand" (lo hi minmax) 1 ir)
(define-specialized-id nrand "NRand" (lo hi n) 1 ir)
(define-specialized-id rand "Rand" (lo hi) 1 ir)

(define-specialized*-id drand "Drand" (length array) 1 dr)
(define-specialized*-id dseq "Dseq" (length array) 1 dr)
(define-specialized*-id dser "Dser" (length array) 1 dr)
(define-specialized*-id dswitch1 "Dswitch1" (length array) 1 dr)
(define-specialized*-id dxrand "Dxrand" (length array) 1 dr)

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

(define tchoose
  (lambda (trig array)
    (select (tirand 0 (length (mce-channels array)) trig) array)))

(define twchoose
  (lambda (trig array weights normalize)
    (select (twindex trig normalize weights) array)))

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
	    ((string=? c "sin") 3.0)
	    ((string=? c "cos") 4.0)
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
	   (list "sin" "sin")
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
