
;; envelope

;; If the curve specification is a string it must name a known curve
;; type. For numerical valued curves the shape '5' indicates the
;; actual curve input value is to be used.

;; String|Number -> Number
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

;; If the curve is a number the value is that number, else the value
;; will be ignored and is here set to zero.

;; Any -> Number
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
  (lambda (levels times curve release-node loop-node)
    (make-mce
     (append
      (list (head levels) (length times) release-node loop-node)
      (splice (map (lambda (l t c)
		     (list l
			   t
			   (curve-to-shape c)
			   (curve-to-value c)))
		   (tail levels) times (extend curve (length times))))))))

;; Co-ordinate based static envelope generator.

(define env/bp*
  (lambda (bp dur amp curve)
    (env (map (lambda (e) (Mul e amp)) (take-cycle (tail bp) 2))
	 (map (lambda (e) (Mul e dur)) ((d->dx Sub) (take-cycle bp 2)))
	 curve
	 -1
	 -1)))

(define env/bp
  (lambda (bp dur amp)
    (env/bp* bp dur amp "linear")))

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
      (env/bp bp dur amp))))

;; SC3 envelope generators.

(define env/triangle
  (lambda (dur level)
    (let ((half-dur (Mul dur 0.5)))
      (env (list 0.0 level 0.0)
	   (list half-dur half-dur)
	   "linear"
	   -1
	   -1))))

(define env/sine
  (lambda (dur level)
    (let ((half-dur (Mul dur 0.5)))
      (env (list 0.0 level 0.0)
	   (list half-dur half-dur)
	   "sin"
	   -1
	   -1))))

(define env/perc
  (lambda (attackTime releaseTime level curve)
    (env (list 0.0 level 0.0)
	 (list attackTime releaseTime)
	 curve
	 -1
	 -1)))

(define env/adsr 
  (lambda (attackTime
	   decayTime
	   sustainLevel
	   releaseTime
	   peakLevel
	   curve
	   bias)
    (env (map (lambda (e) (Mul e bias))
	      (list 0.0 peakLevel (Mul peakLevel sustainLevel) 0.0))
	 (list attackTime decayTime releaseTime)
	 curve
	 2
	 -1)))

(define env/asr
  (lambda (attackTime sustainLevel releaseTime curve)
    (env (list 0.0 sustainLevel 0.0)
	 (list attackTime releaseTime)
	 curve
	 1
	 -1)))

(define env/linen
  (lambda (attackTime sustainTime releaseTime level curve)
    (env (list 0.0 level level 0.0)
	 (list attackTime sustainTime releaseTime)
	 curve
	 -1
	 -1)))


;; fft

;; [m] -> [p] -> [#, m, p...]
(define packfft-data
  (lambda (m p)
    (make-mce (cons (* 2 (length m)) (splice (map list m p))))))

;; [[m, p]] -> [#, m, p...]
(define packfft-data*
  (lambda (mp)
    (make-mce (cons (* 2 (length mp)) (splice mp)))))

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


;; in

;; Audio input. Does not support MulAdd.

(define consecutive?
  (lambda (l)
    (let ((x (head l))
	  (xs (tail l)))
      (or (null? xs)
	  (and (= (+ x 1) (head xs))
	       (consecutive? xs))))))

(define audio-in
  (lambda (n)
    (let ((offset (Sub NumOutputBuses 1)))
      (if (mce? n)
	  (let ((l (mce-channels n)))
	    (if (consecutive? l)
		(In (length l) ar (Add offset (head l)))
		(In 1 ar (Add offset n))))
	  (In 1 ar (Add offset n))))))


;; klang

;; Generate a 'spec' list for a Klang UGen. `freqs' is a list that
;; determines the number of partials, `amps' and `phases' are possibly
;; abbreviated lists subject to expansion by 'extend' to the length of
;; `freqs'.

(define klang-data
  (lambda (freqs amps phases)
    (let ((n (length freqs)))
      (make-mce
       (concat
	(transpose
	 (list freqs
	       (extend amps n)
	       (extend phases n))))))))

;; Variant to generate a 'spec' list for a Klank UGen, the last
;; argument is `ring-time', not `phases'.

(define klank-data klang-data)

(define dyn-klank
  (lambda (i fs fo ds s)
    (letrec ((gen (lambda (l)
		    (if (null? l)
			0
			(let ((f (head l))
			      (a (cadr l))
			      (d (caddr l)))
			  (Add (Mul (Ringz i (MulAdd f fs fo) (Mul d ds)) a)
			       (gen (cdddr l))))))))
      (gen (mce-channels s)))))

;; Frequency shifter, in terms of Hilbert UGen.

(define freq-shift
  (lambda (i f p)
    (let ((o (SinOsc ar f (mce2 (Add p (* 0.5 pi)) p)))
	  (h (Hilbert i)))
      (mix (Mul h o)))))

;; PMOsc

(define pm-osc
  (lambda (r cf mf pm mp)
    (SinOsc r cf (Mul (SinOsc r mf mp) pm))))


;; mix

;; Mix the UGen at `inputs'. This is an idiom over the binary math
;; operator 'Add'.

(define mix
  (lambda (u)
    (cond
     ((mce? u) (foldl1 Add (mce-channels u)))
     (else u))))

;; Use the unary procedure `f' to build an mce value of `n' places.

(define mce/fill
  (lambda (n f)
    (make-mce (map1 f (enum-from-to 0 (- n 1))))))

;; mix . mce/fill

(define mix/fill
  (lambda (n f)
    (mix (mce/fill n f))))



;; [Symbol]
(define unary-operator-names 
  (list 'Neg 
	'Not 
	'IsNil 
	'NotNil 
	'BitNot 
	'Abs
	'AsFloat 
	'AsInt 
	'Ceil 
	'Floor 
	'Frac 
	'Sign 
	'Squared 
	'Cubed 
	'Sqrt 
	'Exp 
	'Recip
	'MIDICPS 
	'CPSMIDI 
	'MIDIRatio 
	'RatioMIDI 
	'DbAmp 
	'AmpDb 
	'OctCPS 
	'CPSOct 
	'Log 
	'Log2
	'Log10 
	'Sin 
	'Cos 
	'Tan 
	'ArcSin 
	'ArcCos 
	'ArcTan 
	'SinH 
	'CosH 
	'TanH 
	'_Rand 
	'Rand2
	'_LinRand 
	'BiLinRand 
	'Sum3Rand 
	'Distort 
	'SoftClip 
	'Coin 
	'DigitValue 
	'Silence
	'Thru 
	'RectWindow 
	'HanWindow 
	'WelchWindow 
	'TriWindow 
	'_Ramp 
	'SCurve))

;; Int -> Symbol
(define unary-operator-name
  (lambda (i)
    (list-ref unary-operator-names i)))

;; [Symbol]
(define binary-operator-names
  (list 'Add
	'Sub
	'Mul
	'IDiv
	'FDiv
	'Mod
	'EQ
	'NE
	'LT
	'GT
	'LE
	'GE
	'Min
	'Max
	'BitAnd
	'BitOr
	'BitXor
	'LCM
	'GCD
	'Round
	'RoundUp
	'Trunc
	'Atan2
	'Hypot
	'Hypotx
	'Pow
	'ShiftLeft
	'ShiftRight
	'UnsignedShift
	'Fill
	'Ring1
	'Ring2
	'Ring3
	'Ring4
	'DifSqr
	'SumSqr
	'SqrSum
	'SqrDif
	'AbsDif
	'Thresh
	'AMClip
	'ScaleNeg
	'Clip2
	'Excess
	'Fold2
	'Wrap2
	'FirstArg
	'RandRange
	'ExpRandRange))

;; Int -> Symbol
(define binary-operator-name
  (lambda (i)
    (list-ref binary-operator-names i)))

;; String -> Int -> String
(define ugen-name/operator
  (lambda (s i)
    (cond
     ((string=? s "BinaryOpUGen") (binary-operator-name i))
     ((string=? s "UnaryOpUGen") (unary-operator-name i))
     (else s))))



;; Port -> UGen -> IO ()
(define play
  (lambda (fd u)
    (async fd (/d_recv (encode-graphdef (synthdef "Anonymous" u))))
    (send fd (/s_new0 "Anonymous" -1 1 1))))

;; UGen -> IO ()
(define audition
  (lambda (u)
    (with-sc3
     (lambda (fd)
       (play fd u)))))


;; range

(define unipolar?
  (lambda (u)
    (if (mce? u)
	(all unipolar? (mce-channels u))
	(member (ugen-name u)
		(list "LFPulse" "Impulse" "TPulse" "Trig1" "Dust")))))

(define range
  (lambda (u l r)
    (if (unipolar? u)
	(MulAdd u (Sub r l) l)
	(let* ((m (Mul (Sub r l) 0.5))
	       (a (Add m l)))
	  (MulAdd u m a)))))

;; Note: uses LinExp so `l' and `r' are i-rate.

(define exprange
  (lambda (u l r)
    (if (unipolar? u)
	(LinExp u 0 1 l r)
	(LinExp u -1 1 l r))))


;; synthdef

;; Transform a <ugen> into a <graphdef>.

(define send-synth
  (lambda (fd n u)
    (async fd (/d_recv (encode-graphdef (synthdef n u))))))

;; A large positive integer that can be used as an argument to
;; synthdefs.

(define +inf.sc 9.0e8)


;; math

;; SuperCollider names.

(define pi2
  (/ pi 2))

(define pi32
  (* pi 1.5))

(define twopi
  (* pi 2))

(define rtwopi
  (/ 1 twopi))

(define log001
  (log 0.001))

(define log01
  (log 0.01))

(define log1
  (log 0.1))

(define rlog2
  (/ 1.0 (log 2.0)))

(define sqrt2
  (sqrt 2.0))

(define rsqrt2
  (/ 1.0 sqrt2))

;; +inf.0 cannot be use in unit generator graphs
(define inf 
  1073741824.0)
