
;; constructor

;; name = <string> | <symbol>
;; rate? = <rate> | #f
;; inputs = <list> of <input*>
;; mce? = <input*> | #f
;; outputs = <integer>
;; special = <integer>

;; It is significant whether MCE or Proxing occurs first, the ordering
;; here follows that in sclang.

(define construct-ugen
  (lambda (name rate? inputs mce? outputs special id)
    (let* ((inputs* (if mce?
			(append2 inputs (mce-l mce?))
			inputs))
	   (rate (if rate?
		     rate?
		     (rate-select (map rate-of inputs*))))
	   (u (make-ugen
	       (symbol->string name)
	       rate
	       inputs*
	       (make-outputs outputs rate)
	       special
	       id)))
      (proxied (mced u)))))


;; graph

;; Return the <list> of all elements of the UGen graph rooted at `u'.
;; Nodes are values of type <ugen>|<proxy>|<control*>|<number>.

(define (graph-nodes u)
  (cond
   ((ugen? u)       (cons u (splice (map graph-nodes (ugen-inputs u)))))
   ((proxy? u)      (cons u (graph-nodes (proxy-ugen u))))
   ((control*? u)   (list u))
   ((number? u)     (list u))
   ((mce? u)        (concat (map graph-nodes (mce-channels u))))
   ((mrg? u)        (concat (map graph-nodes (mrg-roots u))))
   (else            (error "graph-nodes: illegal value" u))))

;; Depth first traversal

(define (graph-traverse f u)
  (let ((f* (lambda (u) (graph-traverse f u))))
    (cond
     ((ugen? u)  (f (make-ugen (ugen-name u)
			       (ugen-rate u)
			       (map f* (ugen-inputs u))
			       (ugen-outputs u)
			       (ugen-special u)
			       (ugen-id u))))
     ((proxy? u) (f (make-proxy (graph-traverse f (proxy-ugen u))
				(proxy-port u))))
     ((mce? u)   (f (make-mce (map f* (mce-channels u)))))
     ((mrg? u)   (f (make-mrg (map f* (mrg-roots u)))))
     (else       u))))

;; Filters over nodes.

;; right preserving variant
(define nub-right
  (lambda (l)
    (reverse (nub (reverse l)))))

(define (graph-constants u)
  (nub
   (filter number? (graph-nodes u))))

(define (graph-controls* u)
  (nub
   (filter control*? (graph-nodes u))))

;; Ordering is *essential* - the antecedents of `u' are depth first,
;; `u' is the last element.

(define (graph-ugens u)
  (nub
   (reverse (filter ugen? (graph-nodes u)))))

(define (ugen-close u nn cc uu)
  (if (not (ugen-validate u))
      (error "ugen-close: ugen invalid" u)
      (make-ugen (ugen-name u)
		 (ugen-rate u)
		 (map (lambda (i)
			(input*->input i nn cc uu))
		      (ugen-inputs u))
		 (ugen-outputs u)
		 (ugen-special u)
		 (ugen-id u))))

(define (graph->graphdef name u)
  (let* ((nn  (graph-constants u))
	 (cc  (graph-controls* u))
	 (uu  (graph-ugens u))
	 (uu* (if (null? cc) uu (cons (implicit-ugen cc) uu))))
    (make-graphdef
     name
     nn
     (map control*-default cc)
     (map (lambda (c) (control*->control c cc)) cc)
     (map (lambda (u) (ugen-close u nn cc uu*)) uu*))))


;; implicit

;; Gloss, k-rate only, no lag.

(define (implicit-ugen cc)
  (make-ugen "Control"
	     kr
	     (list)
	     (map make-output (replicate (length cc) kr))
	     0
	     (make-uid 0)))


;; input

;; In the context of graphdef serialization <ugen> inputs must be
;; re-written into an <input> form.

(define calculate-index 
  (lambda (n nn)
    (let ((i (find-index (lambda (e) (equal? e n)) nn)))
      (if (not i)
	  (error "calculate-index: not located" n nn)
	  i))))

(define (number->input n nn)
  (make-input -1 (calculate-index n nn)))

(define (control*->control c cc)
  (make-control (control*-name c) (calculate-index c cc)))

(define (control*->input c cc)
  (make-input 0 (calculate-index c cc)))

(define (ugen->input u uu)
  (make-input (calculate-index u uu) 0))

(define (proxy->input p uu)
  (make-input (calculate-index (proxy-ugen p) uu)
	      (proxy-port p)))

(define (input*->input i nn cc uu)
  (cond
   ((number? i)   (number->input i nn))
   ((control*? i) (control*->input i cc))
   ((ugen? i)     (ugen->input i uu))
   ((proxy? i)    (proxy->input i uu))
   ((mce? i)      (error "input*->input: mce?" i))
   ((mrg? i)      (error "input*->input: mrg?" i))
   (else          (error "input*->input: illegal input" i))))


;; mce

(define (mce-degree m)
  (length (mce-channels m)))

(define (mce-ref m n)
  (list-ref (mce-channels m) n))

(define (mce-reverse u)
  (make-mce (reverse (mce-channels u))))

(define (mce-required? u)
  (not (null? (filter mce? (ugen-inputs u)))))

(define (mce-extend n i)
  (if (mce? i)
      (extend (mce-channels i) n)
      (replicate n i)))

(define (mce-transform u)
  (ugen-transform
   u
   (lambda (n r i o s d)
     (let* ((f (lambda (i*) (make-ugen n r i* o s d)))
	    (m (maximum (map mce-degree (filter mce? i))))
	    (e (lambda (i) (mce-extend m i)))
	    (i* (transpose (map e i))))
       (make-mce (map f i*))))))

(define (mced u)
  (if (mce-required? u)
      (mce-transform u)
      u))

(define (mce-l u)
  (if (mce? u)
      (mce-channels u)
      (list u)))


;; proxied

(define (proxied u)
  (cond
   ((ugen? u) (let* ((o (ugen-outputs u))
		     (n (length o)))
	        (if (< n 2)
		    u
		    (make-mce (map (lambda (i) (make-proxy u i))
				   (enum-from-to 0 (- n 1)))))))
   ((mce? u)  (make-mce (map proxied (mce-channels u))))))


;; operator

;; Operators may, when applied to numbers, yield numbers.

(define-syntax define-unary-operator
  (syntax-rules ()
    ((_ n s f)
     (define (n a)
       (if (and (number? a) f)
	   (f a)
	   (construct-ugen 'UnaryOpUGen #f (list a) #f 1 s (make-uid 0)))))))

(define-unary-operator Neg 0 -)
(define-unary-operator Not 1 #f)
(define-unary-operator IsNil 2 #f)
(define-unary-operator NotNil 3 #f)
(define-unary-operator BitNot 4 #f)
(define-unary-operator Abs 5 abs)
(define-unary-operator AsFloat 6 #f)
(define-unary-operator AsInt 7 #f)
(define-unary-operator Ceil 8 ceiling)
(define-unary-operator Floor 9 floor)
(define-unary-operator Frac 10 #f)
(define-unary-operator Sign 11 #f)
(define-unary-operator Squared 12 squared)
(define-unary-operator Cubed 13 cubed)
(define-unary-operator Sqrt 14 sqrt)
(define-unary-operator Exp 15 #f)
(define-unary-operator Recip 16 recip)
(define-unary-operator MIDICPS 17 midicps)
(define-unary-operator CPSMIDI 18 cpsmidi)
(define-unary-operator MIDIRatio 19 midiratio)
(define-unary-operator RatioMIDI 20 ratiomidi)
(define-unary-operator DbAmp 21 dbamp)
(define-unary-operator AmpDb 22 ampdb)
(define-unary-operator OctCPS 23 octcps)
(define-unary-operator CPSOct 24 cpsoct)
(define-unary-operator Log 25 log)
(define-unary-operator Log2 26 log2)
(define-unary-operator Log10 27 log10)
(define-unary-operator Sin 28 sin)
(define-unary-operator Cos 29 cos)
(define-unary-operator Tan 30 tan)
(define-unary-operator ArcSin 31 asin)
(define-unary-operator ArcCos 32 acos)
(define-unary-operator ArcTan 33 atan)
(define-unary-operator SinH 34 #f)
(define-unary-operator CosH 35 #f)
(define-unary-operator TanH 36 #f)
(define-unary-operator _Rand 37 #f)
(define-unary-operator Rand2 38 #f)
(define-unary-operator _LinRand 39 #f)
(define-unary-operator BiLinRand 40 #f)
(define-unary-operator Sum3Rand 41 #f)
(define-unary-operator Distort 42 #f)
(define-unary-operator SoftClip 43 #f)
(define-unary-operator Coin 44 #f)
(define-unary-operator DigitValue 45 #f)
(define-unary-operator Silence 46 #f)
(define-unary-operator Thru 47 #f)
(define-unary-operator RectWindow 48 #f)
(define-unary-operator HanWindow 49 #f)
(define-unary-operator WelchWindow 50 #f)
(define-unary-operator TriWindow 51 #f)
(define-unary-operator _Ramp 52 #f)
(define-unary-operator SCurve 53 #f)

(define-syntax define-binary-operator
  (syntax-rules ()
    ((_ n s f)
     (define (n a b)
       (if (and (number? a)
		(number? b)
		f)
	   (f a b)
	   (construct-ugen 'BinaryOpUGen #f (list a b) #f 1 s (make-uid 0)))))))

(define-binary-operator Add 0 +)
(define-binary-operator Sub 1 -)
(define-binary-operator Mul 2 *)
(define-binary-operator IDiv 3 #f)
(define-binary-operator FDiv 4 /)
(define-binary-operator Mod 5 #f)
(define-binary-operator EQ* 6 #f)
(define-binary-operator NE 7 #f)
(define-binary-operator LT* 8 #f)
(define-binary-operator GT* 9 #f)
(define-binary-operator LE 10 #f)
(define-binary-operator GE 11 #f)
(define-binary-operator Min 12 min)
(define-binary-operator Max 13 max)
(define-binary-operator BitAnd 14 #f)
(define-binary-operator BitOr 15 #f)
(define-binary-operator BitXor 16 #f)
(define-binary-operator LCM 17 #f)
(define-binary-operator GCD 18 #f)
(define-binary-operator Round 19 #f)
(define-binary-operator RoundUp 20 #f)
(define-binary-operator Trunc 21 #f)
(define-binary-operator Atan2 22 #f)
(define-binary-operator Hypot 23 #f)
(define-binary-operator Hypotx 24 #f)
(define-binary-operator Pow 25 #f)
(define-binary-operator ShiftLeft 26 #f)
(define-binary-operator ShiftRight 27 #f)
(define-binary-operator UnsignedShift 28 #f)
(define-binary-operator Fill 29 #f)
(define-binary-operator Ring1 30 #f)
(define-binary-operator Ring2 31 #f)
(define-binary-operator Ring3 32 #f)
(define-binary-operator Ring4 33 #f)
(define-binary-operator DifSqr 34 #f)
(define-binary-operator SumSqr 35 #f)
(define-binary-operator SqrSum 36 #f)
(define-binary-operator SqrDif 37 #f)
(define-binary-operator AbsDif 38 #f)
(define-binary-operator Thresh 39 #f)
(define-binary-operator AMClip 40 #f)
(define-binary-operator ScaleNeg 41 #f)
(define-binary-operator Clip2 42 #f)
(define-binary-operator Excess 43 #f)
(define-binary-operator Fold2 44 #f)
(define-binary-operator Wrap2 45 #f)
(define-binary-operator FirstArg 46 #f)
(define-binary-operator RandRange 47 #f)
(define-binary-operator ExpRandRange 48 #f)

;; N-ary variants

(define (Mul* . l) (foldl Mul 1 l))
(define (Add* . l) (foldl Add 0 l))


;; filter

(define-syntax define-filter
  (syntax-rules ()
    ((_ n (i ...) o)
     (define (n i ...)
       (construct-ugen 'n #f (list i ...) #f o 0 (make-uid 0))))))

(define-filter AllpassC (in maxdelaytime delaytime decaytime) 1)
(define-filter AllpassL (in maxdelaytime delaytime decaytime) 1)
(define-filter AllpassN (in maxdelaytime delaytime decaytime) 1)
(define-filter AmpComp (freq root exp) 1)
(define-filter AmpCompA (freq root minAmp rootAmp) 1)
(define-filter APF (in freq radius) 1)
(define-filter Balance2 (left right pos level) 1)
(define-filter Ball (in g damp friction) 1)
(define-filter BiPanB2 (inA inB azimuth gain) 3)
(define-filter BPF (in freq rq) 1)
(define-filter BPZ2 (in) 1)
(define-filter BRF (in freq rq) 1)
(define-filter BRZ2 (in) 1)
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
(define-filter Decay2 (in attackTime decayTime) 1)
(define-filter Decay (in decayTime) 1)
(define-filter DegreeToKey (bufnum in octave) 1)
(define-filter Delay1 (in) 1)
(define-filter Delay2 (in) 1)
(define-filter DelayC (in maxdelaytime delaytime) 1)
(define-filter DelayL (in maxdelaytime delaytime) 1)
(define-filter DelayN (in maxdelaytime delaytime) 1)
(define-filter DetectSilence (in amp time doneAction) 1)
(define-filter Done (src) 1)
(define-filter Fold (in lo hi) 1)
(define-filter Formlet (in freq attacktime decaytime) 1)
(define-filter FOS (in a0 a1 b1) 1)
(define-filter Free (in nodeID) 1)
(define-filter FreeVerb (in mix room damp) 1)
(define-filter FreeVerb2 (in1 in2 mix room damp) 2)
(define-filter FreeSelf (in) 1)
(define-filter FreeSelfWhenDone (in) 1)
(define-filter Gate (in trig) 1)
(define-filter Hasher (in) 1)
(define-filter Hilbert (in) 2)
(define-filter HPF (in freq) 1)
(define-filter HPZ1 (in) 1)
(define-filter HPZ2 (in) 1)
(define-filter ImageWarp (pic x y interpolationType) 1)
(define-filter Index (bufnum in) 1)
(define-filter InRange (in lo hi) 1)
(define-filter InRect (x y rect) 1)
(define-filter Integrator (in coef) 1)
(define-filter Lag2 (in lagTime) 1)
(define-filter Lag3 (in lagTime) 1)
(define-filter Lag (in lagTime) 1)
(define-filter LagControl () 1)
(define-filter LastValue (in diff) 1)
(define-filter Latch (in trig) 1)
(define-filter LeakDC (in coef) 1)
(define-filter LeastChange (a b) 1)
(define-filter Limiter (in level dur) 1)
(define-filter Linen (gate attackTime susLevel releaseTime doneAction) 1)
(define-filter LinExp (in srclo srchi dstlo dsthi) 1)
(define-filter LinLin (in srclo srchi dstlo dsthi) 1)
(define-filter LinPan2 (in pos level) 2)
(define-filter LinXFade2 (inA inB pan level) 1)
(define-filter LPF (in freq) 1)
(define-filter LPZ1 (in) 1)
(define-filter LPZ2 (in) 1)
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
(define-filter PanB2 (in azimuth gain) 3)
(define-filter PanB (in azimuth elevation gain) 3)
(define-filter Pause (in nodeID) 1)
(define-filter PauseSelf (in) 1)
(define-filter PauseSelfWhenDone (in) 1)
(define-filter Peak (trig reset) 1)
(define-filter PeakFollower (in decay) 1)
(define-filter PitchShift (in windowSize pitchRatio pitchDispersion timeDispersion) 1)
(define-filter Pluck (in trig maxdelaytime delaytime decaytime coef) 1)
(define-filter PulseCount (trig reset) 1)
(define-filter PulseDivider (trig div start) 1)
(define-filter Ramp (in lagTime) 1)
(define-filter Resonz (in freq bwr) 1)
(define-filter RHPF (in freq rq) 1)
(define-filter Ringz (in freq decaytime) 1)
(define-filter RLPF (in freq rq) 1)
(define-filter Rotate2 (x y pos) 2)
(define-filter RunningMax (in trig) 1)
(define-filter RunningMin (in trig) 1)
(define-filter RunningSum (in numsamp) 1)
(define-filter Schmidt (in lo hi) 1)
(define-filter SendTrig (in id value) 0)
(define-filter SetResetFF (trig reset) 1)
(define-filter Shaper (bufnum in) 1)
(define-filter Slew (in up dn) 1)
(define-filter Slope (in) 1)
(define-filter SOS (in a0 a1 a2 b1 b2) 1)
(define-filter Spring (in spring damp) 1)
(define-filter Stepper (trig reset min max step resetval) 1)
(define-filter Sweep (trig rate) 1)
(define-filter TBall (in g damp friction) 1)
(define-filter TDelay (in dur) 1)
(define-filter Timer (trig) 1)
(define-filter ToggleFF (trig) 1)
(define-filter TPulse (trig freq width) 1)
(define-filter Trapezoid (in a b c d) 1)
(define-filter Trig1 (in dur) 1)
(define-filter Trig (in dur) 1)
(define-filter TwoPole (in freq radius) 1)
(define-filter TwoZero (in freq radius) 1)
(define-filter Vibrato (freq rate depth delay onset rateVariation depthVariation iphase) 1)
(define-filter Wrap (in lo hi) 1)
(define-filter WrapIndex (bufnum in) 1)
(define-filter XFade2 (inA inB pan level) 1)
(define-filter XY (xscale yscale xoff yoff rot rate) 1)
(define-filter ZeroCrossing (in) 1)

(define-syntax define-filter/n
  (syntax-rules ()
    ((_ n (i ...))
     (define (n nc i ...)
       (if (not (integer? nc))
	   (error "illegal channel count" 'n nc)
	   #f)
       (let ((l (list i ...)))
	 (construct-ugen 'n #f l #f nc 0 (make-uid 0)))))))

(define-filter/n DecodeB2 (w x y orientation))
(define-filter/n Silent ())
(define-filter/n TGrains (trigger bufnum rate centerPos dur pan amp interp))

(define-syntax define-filter*
  (syntax-rules ()
    ((_ n (i ... v) o)
     (define (n i ... v)
       (construct-ugen 'n #f (list i ...) v o 0 (make-uid 0))))))

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

(define-syntax define-filter/id
  (syntax-rules ()
    ((_ n (i ...) o)
     (define (n i ...)
       (construct-ugen 'n #f (list i ...) #f o 0 (unique-uid))))))

(define-filter/id CoinGate (prob in) 1)
(define-filter/id TExpRand (lo hi trig) 1)
(define-filter/id TIRand (lo hi trig) 1)
(define-filter/id TRand (lo hi trig) 1)

;; Keyed filter, rate is determined by a known input.

(define-syntax define-filter/k
  (syntax-rules ()
    ((_ n (i ...) o k)
     (define (n i ...)
       (let ((l (list i ...)))
	 (construct-ugen 'n (rate-of (list-ref l k)) l #f o 0 (make-uid 0)))))))

(define-filter/k Demand (trig reset demandUGens) 1 0)

;; JITLIB

(define (TChoose trig array)
  (Select (TIRand 0 (length (mce-channels array)) trig) array))

(define (TWChoose trig array weights normalize)
  (Select (TWindex trig normalize weights) array))


;; oscillator

(define-syntax define-oscillator
  (syntax-rules ()
    ((_ n (i ...) o)
     (define (n r i ...)
       (construct-ugen (quote n) r (list i ...) #f o 0 (make-uid 0))))))

(define-oscillator Amplitude (in attackTime releaseTime) 1)
(define-oscillator Blip (freq numharm) 1)
(define-oscillator COsc (bufnum freq beats) 1)
(define-oscillator Crackle (chaosParam) 1)
(define-oscillator CuspL (freq a b xi) 1)
(define-oscillator CuspN (freq a b xi) 1)
(define-oscillator DemandEnvGen (level dur shape curve gate reset levelScale levelBias timeScale doneAction) 1)
(define-oscillator FBSineC (freq im fb a c xi yi) 1)
(define-oscillator FBSineL (freq im fb a c xi yi) 1)
(define-oscillator FBSineN (freq im fb a c xi yi) 1)
(define-oscillator Formant (fundfreq formfreq bwfreq) 1)
(define-oscillator FSinOsc (freq iphase) 1)
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
(define-oscillator LatoocarfianC (freq a b c d xi yi) 1)
(define-oscillator LatoocarfianL (freq a b c d xi yi) 1)
(define-oscillator LatoocarfianN (freq a b c d xi yi) 1)
(define-oscillator LinCongC (freq a c m xi) 1)
(define-oscillator LinCongL (freq a c m xi) 1)
(define-oscillator LinCongN (freq a c m xi) 1)
(define-oscillator LFCub (freq iphase) 1)
(define-oscillator LFPar (freq iphase) 1)
(define-oscillator LFPulse (freq iphase width) 1)
(define-oscillator LFSaw (freq iphase) 1)
(define-oscillator LFTri (freq iphase) 1)
(define-oscillator Line (start end dur doneAction) 1)
(define-oscillator Logistic (chaosParam freq) 1)
(define-oscillator LorenzL (freq s r b h xi yi zi) 1)
(define-oscillator Osc (bufnum freq phase) 1)
(define-oscillator OscN (bufnum freq phase) 1)
(define-oscillator Phasor (trig rate start end resetPos) 1)
(define-oscillator PSinGrain (freq dur amp) 1)
(define-oscillator Pulse (freq width) 1)
(define-oscillator QuadC (freq a b c xi) 1)
(define-oscillator QuadL (freq a b c xi) 1)
(define-oscillator QuadN (freq a b c xi) 1)
(define-oscillator Saw (freq) 1)
(define-oscillator SinOsc (freq phase) 1)
(define-oscillator SinOscFB (freq feedback) 1)
(define-oscillator StandardL (freq k xi yi) 1)
(define-oscillator StandardN (freq k xi yi) 1)
(define-oscillator SyncSaw (syncFreq sawFreq) 1)
(define-oscillator VarSaw (freq iphase width) 1)
(define-oscillator VOsc3 (bufpos freq1 freq2 freq3) 1)
(define-oscillator VOsc (bufpos freq phase) 1)
(define-oscillator XLine (start end dur doneAction) 1)

(define-oscillator MouseButton (minval maxval lag) 1)
(define-oscillator MouseX (min max warp lag) 1)
(define-oscillator MouseY (min max warp lag) 1)
(define-oscillator SharedIn () 1)

(define-oscillator BufChannels (buf) 1)
(define-oscillator BufDur (buf) 1)
(define-oscillator BufFrames (buf) 1)
(define-oscillator BufRateScale (buf) 1)
(define-oscillator BufSampleRate (buf) 1)
(define-oscillator BufSamples (buf) 1)

(define (without n l)
  (append (take n l) (drop (+ n 1) l)))

(define-syntax define-oscillator/n
  (syntax-rules ()
    ((_ n (i ...))
     (define (n nc r i ...)
       (if (not (integer? nc))
	   (error "illegal channel count:" 'n nc)
	   #f)
       (let ((l (list i ...)))
	 (construct-ugen 'n r l #f nc 0 (make-uid 0)))))))

(define-oscillator/n BufRd (bufnum phase loop interpolation))
(define-oscillator/n DiskIn (bufnum))
(define-oscillator/n In (bus))
(define-oscillator/n LocalIn ())
(define-oscillator/n TrigControl ())

(define (BufRdN nc r b p l) (BufRd nc r b p l 1))
(define (BufRdL nc r b p l) (BufRd nc r b p l 2))
(define (BufRdC nc r b p l) (BufRd nc r b p l 4))

(define-syntax define-oscillator*
  (syntax-rules ()
    ((_ n (i ... v) o)
     (define (n r i ... v)
       (construct-ugen 'n r (list i ...) v o 0 (make-uid 0))))))

(define-oscillator* Duty (dur reset doneAction level) 1)
(define-oscillator* EnvGen (gate levelScale levelBias timeScale doneAction envelopeArray) 1)
(define-oscillator* Klang (freqscale freqoffset specArray) 1)
(define-oscillator* TDuty (dur reset doneAction level) 1)

(define-syntax define-oscillator/id
  (syntax-rules ()
    ((_ n (i ...) o)
     (define (n r i ...)
       (construct-ugen 'n r (list i ...) #f o 0 (unique-uid))))))

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


;; specialized

(define-syntax define-specialized
  (syntax-rules ()
    ((_ n (i ...) o r)
     (define (n i ...)
       (construct-ugen 'n r (list i ...) #f o 0 (make-uid 0))))))

(define-specialized K2A (in) 1 ar)
(define-specialized Pitch (in initFreq minFreq maxFreq execFreq maxBinsPerOctave median ampThreshold peakThreshold downSample) 2 kr)

(define-specialized FFT (buf in hop wintype active) 1 kr)
(define (FFT* buf in) (FFT buf in 0.5 0 1))
(define-specialized IFFT (buf wintype) 1 ar)
(define (IFFT* buf) (IFFT buf 0))

(define-specialized Unpack1FFT (chain bufsize binindex whichmeasure) 1 dr)

(define-specialized Convolution (in kernel frameSize) 1 ar)
(define-specialized Convolution2 (in bufnum trigger frameSize) 1 ar)

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
(define-specialized PV_PhaseShift270 (buffer) 1 kr)
(define-specialized PV_PhaseShift90 (buffer) 1 kr)
(define-specialized PV_PhaseShift (buffer shift) 1 kr)
(define-specialized PV_RandComb (buffer wipe trig) 1 kr)
(define-specialized PV_RandWipe (bufferA bufferB wipe trig) 1 kr)
(define-specialized PV_RectComb2 () 1 kr)
(define-specialized PV_RectComb (buffer numTeeth phase width) 1 kr)

(define-specialized SharedOut (bus channelsArray) 0 kr)

(define-syntax define-specialized/c
  (syntax-rules ()
    ((_ n o r)
     (define n
       (construct-ugen 'n r (list) #f o 0 (make-uid 0))))))

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

(define-syntax define-specialized*
  (syntax-rules ()
    ((_ n (i ... v) o r)
     (define (n i ... v)
       (construct-ugen 'n r (list i ...) v o 0 (make-uid 0))))))

(define-specialized* PackFFT (chain bufsize from to z magsphases) 1 kr)

(define-syntax define-specialized/n
  (syntax-rules ()
    ((_ n (i ...) r)
     (define (n nc i ...)
       (if (not (integer? nc))
	   (error "illegal channel count:" 'n nc)
	   #f)
       (let ((l (list i ...)))
	 (construct-ugen 'n r l #f nc 0 (make-uid 0)))))))

(define-specialized/n InFeedback (bus) ar)
(define-specialized/n InTrig (bus) kr)
(define-specialized/n GrainBuf (tr dur sndbuf rate pos interp pan envbuf) ar)
(define-specialized/n GrainFM (tr dur carfreq modfreq index pan envbuf) ar)
(define-specialized/n GrainIn (tr dur in pan envbuf) ar)
(define-specialized/n GrainSin (tr dur freq pan envbuf) ar)
(define-specialized/n LagIn (bus lag) kr)
(define-specialized/n PlayBuf (bufnum rate trigger startPos loop) ar)
(define-specialized/n Warp1 (bufnum pointer freqScale windowSize envbufnum overlaps windowRandRatio interp) ar)

(define-syntax define-specialized/id
  (syntax-rules ()
    ((_ n (i ...) o r)
     (define (n i ...)
       (construct-ugen 'n r (list i ...) #f o 0 (unique-uid))))))

(define-specialized/id Dbufrd (bufnum phase loop) 1 dr)
(define-specialized/id Dbrown (length lo hi step) 1 dr)
(define-specialized/id Dibrown (length lo hi step) 1 dr)
(define-specialized/id Diwhite (length lo hi) 1 dr)
(define-specialized/id Dgeom (length start grow) 1 dr)
(define-specialized/id Dseries (length start step) 1 dr)
(define-specialized/id Dwhite (length lo hi) 1 dr)
(define-specialized/id ExpRand (lo hi) 1 ir)
(define-specialized/id IRand (lo hi) 1 ir)
(define-specialized/id LinRand (lo hi minmax) 1 ir)
(define-specialized/id NRand (lo hi n) 1 ir)
(define-specialized/id Rand (lo hi) 1 ir)

(define-syntax define-specialized*/id
  (syntax-rules ()
    ((_ n (i ... v) o r)
     (define (n i ... v)
       (construct-ugen 'n r (list i ...) v o 0 (unique-uid))))))

(define-specialized*/id Drand (length array) 1 dr)
(define-specialized*/id Dseq (length array) 1 dr)
(define-specialized*/id Dser (length array) 1 dr)
(define-specialized*/id Dswitch1 (length array) 1 dr)
(define-specialized*/id Dxrand (length array) 1 dr)
