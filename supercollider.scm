
;; envelope

;; A curve specification is either a <string> or a <number>.  If it is
;; a string it must name a known curve type.  For numerical valued
;; curves the shape '5' indicates the actual curve input value is to
;; be used.

(define (curve->shape curve)
  (cond ((string? curve)
	 (let ((f (lambda (s) (string=? s curve))))
	   (cond
	    ((f "step")        0.0)
	    ((f "linear")      1.0)
	    ((f "exponential") 2.0)
	    ((f "sin")         3.0)
	    ((f "cos")         4.0)
	    ((f "squared")     6.0)
	    ((f "cubed")       7.0)
	    (else              (error "curve->shape:" curve)))))
	((number? curve)
	 5.0)
	(else
	 (error "curve->shape: illegal curve" curve))))

;; If the curve is a number the value is that number, else the value
;; will be ignored and is here set to zero.

(define (curve->value curve)
  (if (number? curve) curve 0.0))

;; Make a <list> for use with the EnvGen UGen. `levels' is a <list>
;; containing the left to right gain values for the envelope, it has
;; one more element than the <list> `times', having the delta times
;; for each envelope segment.  `curve' is either a string or a number
;; or a <list> of such, in either case it is expanded to a list of the
;; same length as `times'.  `release-node' is the index of the
;; 'release' stage of the envelope, `loop-node' is the index of the
;; 'loop' stage of the envelope.  These indices are set as invalid, by
;; convention -1, to indicate there is no such node.

(define (env levels times curve release-node loop-node)
  (make-mce
   (append
    (list (car levels) (length times) release-node loop-node)
    (splice (map (lambda (l t c)
		   (list l
			 t
			 (curve->shape c)
			 (curve->value c)))
		 (cdr levels) times (extend curve (length times)))))))

;; Co-ordinate based static envelope generator.

(define (env/bp* bp dur amp curve)
  (env (map (lambda (e) (Mul e amp)) (take-cycle (cdr bp) 2))
       (map (lambda (e) (Mul e dur)) ((d->dx Sub) (take-cycle bp 2)))
       curve
       -1
       -1))

(define (env/bp bp dur amp)
  (env/bp* bp dur amp "linear"))

;; Design a standard trapezoidal envelope.  `shape' determines the
;; sustain time as a proportion of `dur', zero is a triangular
;; envelope, one a rectangular envelope.  `skew' determines the
;; attack/decay ratio, zero is an immediate attack and a slow decay,
;; one a slow attack and an immediate decay.  This implementation
;; builds a zero one breakpoint data set and calls env/bp.

(define (env/trapezoid shape skew dur amp)
  (let* ((x1 (* skew (- 1.0 shape)))
	 (bp (list 0
		   (if (<= skew 0.0) 1.0 0.0)
		   x1
		   1.0
		   (+ shape x1)
		   1.0
		   1.0
		   (if (>= skew 1.0) 1.0 0.0))))
    (env/bp bp dur amp)))

;; SC3 envelope generators.

(define (env/triangle dur level)
  (let ((half-dur (Mul dur 0.5)))
    (env (list 0.0 level 0.0)
	 (list half-dur half-dur)
	 "linear"
	 -1
	 -1)))

(define (env/sine dur level)
  (let ((half-dur (Mul dur 0.5)))
    (env (list 0.0 level 0.0)
	 (list half-dur half-dur)
	 "sin"
	 -1
	 -1)))

(define (env/perc attackTime releaseTime level curve)
  (env (list 0.0 level 0.0)
       (list attackTime releaseTime)
       curve
       -1
       -1))

(define (env/adsr attackTime
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
       -1))

(define (env/asr attackTime sustainLevel releaseTime curve)
  (env (list 0.0 sustainLevel 0.0)
       (list attackTime releaseTime)
       curve
       1
       -1))

(define (env/linen attackTime sustainTime releaseTime level curve)
  (env (list 0.0 level level 0.0)
       (list attackTime sustainTime releaseTime)
       curve
       -1
       -1))


;; fft

;; [m] -> [p] -> [#, m, p...]
(define (packfft-data m p)
  (make-mce (cons (* 2 (length m)) (splice (map list m p)))))

;; [[m, p]] -> [#, m, p...]
(define (packfft-data* mp)
  (make-mce (cons (* 2 (length mp)) (splice mp))))

(define (unpack-fft c nf from to mp?)
  (map (lambda (i) 
	 (Unpack1FFT c nf i mp?))
       (enum-from-to from to)))

(define (pvcollect c nf f from to z?)
  (let* ((m (unpack-fft c nf from to 0))
	 (p (unpack-fft c nf from to 1))
	 (i (enum-from-to from to))
	 (e (map f m p i)))
    (PackFFT c nf from to z? (packfft-data* e))))


;; in

;; Audio input.  Does not support MulAdd.

(define (consecutive? l)
  (let ((x (car l))
	(xs (cdr l)))
    (or (null? xs)
	(and (= (+ x 1) (car xs))
	     (consecutive? xs)))))

(define (audio-in n)
  (let ((offset (Sub NumOutputBuses 1)))
    (if (mce? n)
	(let ((l (mce-channels n)))
	  (if (consecutive? l)
	      (In (length l) ar (Add offset (car l)))
	      (In 1 ar (Add offset n))))
	(In 1 ar (Add offset n)))))


;; klang

;; Generate a 'spec' list for a Klang UGen.  `freqs' is a list that
;; determines the number of partials, `amps' and `phases' are possibly
;; abbreviated lists subject to expansion by 'extend' to the length of
;; `freqs'.

(define (klang-data freqs amps phases)
  (let ((n (length freqs)))
    (make-mce
     (concat 
      (transpose
       (list freqs
	     (extend amps n)
	     (extend phases n)))))))

;; Variant to generate a 'spec' list for a Klank UGen, the last
;; argument is `ring-time', not `phases'.

(define klank-data klang-data)

(define (dyn-klank i fs fo ds s)
  (letrec ((gen (lambda (l)
		  (if (null? l)
		      0
		      (let ((f (car l))
			    (a (cadr l))
			    (d (caddr l)))
			(Add (Mul (Ringz i (MulAdd f fs fo) (Mul d ds)) a)
			     (gen (cdddr l))))))))
    (gen (mce-channels s))))

;; Frequency shifter, in terms of Hilbert UGen.

(define (freq-shift i f p)
  (let ((o (SinOsc ar f (Mce (Add p (* 0.5 pi)) p)))
	(h (Hilbert i)))
    (mix (Mul h o))))

;; PMOsc

(define (pm-osc r cf mf pm mp)
  (SinOsc r cf (Mul (SinOsc r mf mp) pm)))


;; mix

;; Mix the UGen at `inputs'.  This is an idiom over the binary math
;; operator 'Add'.

(define (mix u)
  (cond
   ((mce? u) (foldl1 Add (mce-channels u)))
   (else     u)))

;; Use the unary procedure `f' to build an mce value of `n' places.

(define mce/fill 
  (lambda (n f)
    (make-mce (map1 f (enum-from-to 0 (- n 1))))))

;; mix . mce/fill

(define (mix/fill n f)
  (mix (mce/fill n f)))


;; name

(define unary-operator-names '(Neg Not IsNil NotNil BitNot Abs
AsFloat AsInt Ceil Floor Frac Sign Squared Cubed Sqrt Exp Recip
MIDICPS CPSMIDI MIDIRatio RatioMIDI DbAmp AmpDb OctCPS CPSOct Log Log2
Log10 Sin Cos Tan ArcSin ArcCos ArcTan SinH CosH TanH _Rand Rand2
_LinRand BiLinRand Sum3Rand Distort SoftClip Coin DigitValue Silence
Thru RectWindow HanWindow WelchWindow TriWindow _Ramp SCurve))

(define (unary-operator-name special)
  (list-ref unary-operator-names special))

(define binary-operator-names '(Add Sub Mul IDiv FDiv Mod EQ NE LT GT
LE GE Min Max BitAnd BitOr BitXor LCM GCD Round RoundUp Trunc Atan2
Hypot Hypotx Pow ShiftLeft ShiftRight UnsignedShift Fill Ring1 Ring2
Ring3 Ring4 DifSqr SumSqr SqrSum SqrDif AbsDif Thresh AMClip ScaleNeg
Clip2 Excess Fold2 Wrap2 FirstArg RandRange ExpRandRange))

(define (binary-operator-name special)
  (list-ref binary-operator-names special))

(define (ugen-name/operator name special)
  (cond
   ((string=? name "BinaryOpUGen") (binary-operator-name special))
   ((string=? name "UnaryOpUGen")  (unary-operator-name special))
   (else                           name)))


;; play

;; Play the graph rooted at the <ugen> `u' at the server `s'.

(define (play fd u)
  (let ((g (if (graphdef? u)
	       u
	       (ugen->graphdef/out u))))
    (async fd (/d_recv (graphdef->u8l g)))
    (send fd (/s_new0 (graphdef-name g) -1 1 1))))

(define (audition u)
  (with-sc3 
    (lambda (fd)
      (play fd u))))


;; quantize

;; Quantize `n' to the nearest multiple of `quanta'.

(define (quantize quanta n)
  (* (round-exact (/ n quanta)) quanta))


;; range

(define (unipolar? u)
  (if (mce? u)
      (all unipolar? (mce-channels u))
      (member (ugen-name u)
	      (list "LFPulse" "Impulse" "TPulse" "Trig1" "Dust"))))

(define (range u l r)
  (if (unipolar? u)
      (MulAdd u (Sub r l) l)
      (let* ((m (Mul (Sub r l) 0.5))
	     (a (Add m l)))
	(MulAdd u m a))))

;; Note: uses LinExp so `l' and `r' are i-rate.

(define (exprange u l r)
  (if (unipolar? u)
      (LinExp u  0 1 l r)
      (LinExp u -1 1 l r)))


;; score

;; A score is a list of OSC bundles.  The timestamps are given in
;; seconds where zero is the start of the score.  An OSC file is a
;; binary file format understood by the SC3 synthesis server, and
;; consists of a sequence of length prefixed OSC bundles.

;; Generate the <u8l> for the score `data'.

(define (score->u8l bundles)
  (flatten
   (map (lambda (bundle)
	  (let ((l (npt->u8l (encode-bundle-ntp bundle))))
	    (list (i32->u8l (length l))
		  l)))
	bundles)))


;; sndfile

(define au-magic #x2e736e64)

(define au-unspecified 0)
(define au-mulaw8      1)
(define au-linear8     2)
(define au-linear16    3)
(define au-linear24    4)
(define au-linear32    5)
(define au-float       6)
(define au-double      7)

(define (au-size-of e)
  (cond ((= e au-unspecified) (error 'au-size-of "unspecified encoding"))
	((= e au-mulaw8)      1)
	((= e au-linear8)     1)
	((= e au-linear16)    2)
	((= e au-linear24)    3)
	((= e au-linear32)    4)
	((= e au-float)       4)
	((= e au-double)      8)
	(else                 (error "au-size-of: illegal encoding"))))

(define (au-mk-hdr nf enc sr nc)
  (let ((nb (* nf nc (au-size-of enc))))
    (concat-map i32->u8l (list au-magic 28 nb enc sr nc 0))))

(define au-f32 (list au-float  f32->u8l))
(define au-f64 (list au-double f64->u8l))

(define (write-snd-file e sr nc fn d)
  (let ((enc   (car e))
	(encdr (cadr e))
	(nf    (/ (length d) nc)))
    (with-output-to-file fn
      (lambda ()
	(for-each put-u8 (au-mk-hdr nf enc sr nc))
	(for-each put-u8 (concat-map encdr d))))))


;; spec

;; An interface to the warp procedures.

(define-structure spec minima maxima warp range ratio)

(define (make-spec* minima maxima warp)
  (let ((w (if (symbol? warp) (symbol->warp warp) warp)))
    (make-spec minima maxima (w minima maxima)
	       (- maxima minima) (/ maxima minima))))

(define (spec-map s value)
  ((spec-warp s) 'map (clip 0.0 1.0 value)))

(define (spec-unmap s value)
  (clip 0.0 1.0 ((spec-warp s) 'unmap value)))

(define (symbol->spec s)
  (case s
    ((unipolar)       (make-spec  0.0 1.0     'linear))
    ((bipolar pan)    (make-spec -1.0 1.0     'linear))
    ((freq frequency) (make-spec 20.0 20000.0 'linear))
    ((phase)          (make-spec  0.0 two-pi  'linear))
    (else             (error 'symbol->spec "illegal value" s))))


;; synthdef

;; Transform a <ugen> into a <graphdef>.

(define synthdef graph->graphdef)

;; If ugen has output ports encapsulate it.

(define (with-out u)
  (if (or (mce? u)
	  (and (ugen? u) (not (null? (ugen-outputs u)))))
      (letc ((bus 0.0)) (Out bus u))
      u))

(define (send-synth fd n u)
  (async fd (/d_recv (graphdef->u8l (synthdef n (with-out u))))))

(define (ugen->graphdef/out u)
  (synthdef "Anonymous" (with-out u)))

;; A large positive integer that can be used as an argument to
;; synthdefs.

(define +inf.sc 9.0e8)


;; warp

;; A warp is a procedure of two arguments.  The first is the <symbol>
;; direction of the warp, which should be either 'map' or 'unmap'.
;; The second is a <real> number.  Warps map from the space [0,1] to a
;; user defined space [minima,maxima].  A warp generator takes the
;; arguments `minima' and `maxima', even if it then ignores these
;; values.

;; Returns true iff the <symbol> `s' is 'map'.

(define (warp-fwd? s) (eq? s 'map))

;; A linear real value map.

(define (warp-linear minima maxima)
  (let ((range (- maxima minima)))
    (lambda (direction value)
      (if (warp-fwd? direction)
	  (+ (* value range) minima)
	  (/ (- value minima) range)))))

;; A linear integer value map.

(define (warp-linear-integer minima maxima)
  (let ((w (warp-linear minima maxima)))
    (lambda (direction value)
      (round-exact (w direction value)))))

;; The minima and maxima must both be non zero and have the same sign.

(define (warp-exponential minima maxima)
  (let ((ratio (/ maxima minima)))
    (lambda (direction value)
      (if (warp-fwd? direction)
	  (* (expt ratio value) minima)
	  (/ (log (/ value minima)) (log ratio))))))

;; Evaluates to a warp generator for warps with an exponetial curve
;; given by `curve'.

(define (warp-make-warp-curve curve)
  (lambda (minima maxima)
    (let ((range (- maxima minima)))
      (if (< (abs curve) 0.001)
	  (warp-linear minima range)
	  (let* ((grow (exp curve))
		 (a (/ range (- 1.0 grow)))
		 (b (+ minima a)))
	    (lambda (direction value)
	      (if (warp-fwd? direction)
		  (- b (* a (expt grow value)))
		  (/ (log (/ (- b value) a)) curve))))))))

(define (warp-cosine minima maxima)
  (let* ((range (- maxima minima))
	 (linear (warp-linear minima range)))
    (lambda (direction value)
      (if (warp-fwd? direction)
	  (linear 'map (- 0.5 (* (cos (* pi value)) 0.5)))
	  (/ (acos (- 1.0 (* (linear 'unmap value) 2))) pi)))))

(define (warp-sine minima maxima)
  (let* ((range (- maxima minima))
	 (linear (warp-linear minima range)))
    (lambda (direction value)
      (if (warp-fwd? direction)
	  (linear 'map (sin (* half-pi value)))
	  (/ (asin (linear 'unmap value)) half-pi)))))

;; The minima and maxima values are ignored, they are implicitly zero
;; and one.

(define (warp-fader minima maxima)
  (lambda (direction value)
    (if (warp-fwd? direction)
	(* value value)
	(sqrt value))))

;; The minima and maxima values are ignored, they are implicitly
;; negative infinity and zero.  An input value of zero gives -180.

(define (warp-db-fader minima maxima)
  (lambda (direction value)
    (if (warp-fwd? direction)
	(if (zero? value)
	    -180
	    (ampdb (* value value)))
	(sqrt (dbamp value)))))

;; Translate a symbolic warp name to a warp procedure.

(define (symbol->warp s)
  (case s
    ((lin linear) warp-linear)
    ((exp exponential) warp-exponential)
    ((sin) warp-sine)
    ((cos) warp-cosine)
    ((amp) warp-fader)
    ((db) warp-db-fader)
    (else (error 'symbol->warp "unknown symbol" s))))

;; Translate a number to a warp.

(define (number->warp n) (warp-make-warp-curve n))


;; signal

;; n element segments at intervals of k from l
(define segment
  (lambda (n k l)
    (let ((s (take n l)))
      (if (null? s)
	  s
	  (cons s (segment n k (drop k l)))))))

;; A Signal is half the size of a Wavetable, each element is the sum
;; of two adjacent elements of the Wavetable.

(define (wavetable->signal l)
  (concat-map sum (segment 2 2 l)))

;; A Wavetable is twice the size of a Signal.  Each element 'e0'
;; expands to {2*e0-e1, e1-e0} where e1 is the next element.

(define (signal->wavetable l)
  (let ((f (lambda (e0 e1) (list (- (* 2.0 e0) e1) (- e1 e0)))))
    (concat-map f (segment 1 2 (append2 l (list1 (head l)))))))
