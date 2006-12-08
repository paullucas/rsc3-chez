; filter.scm - (c) rohan drape, 2005-2006

(define-syntax define-filter
  (syntax-rules ()
    ((_ n (i ...) o)
     (define (n i ...)
       (construct-ugen 'n #f (list i ...) #f o 0 (make-uid 0))))))

(define-filter AllpassC (in maxdelaytime delaytime decaytime) 1)
(define-filter AllpassL (in maxdelaytime delaytime decaytime) 1)
(define-filter AllpassN (in maxdelaytime delaytime decaytime) 1)
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
(define-filter FreeSelf (in) 1)
(define-filter FreeSelfWhenDone (in) 1)
(define-filter Gate (in trig) 1)
(define-filter Hasher (in) 1)
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
(define-filter PulseCount (trig reset) 1)
(define-filter PulseDivider (trig div start) 1)
(define-filter Ramp (in lagTime) 1)
(define-filter Resonz (in freq bwr) 1)
(define-filter RHPF (in freq rq) 1)
(define-filter Ringz (in freq decaytime) 1)
(define-filter RLPF (in freq rq) 1)
(define-filter Rotate2 (x y pos) 2)
(define-filter RunningMax (in trig) 1)
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
    ((_ n (i ...) z)
     (define (n i ...)
       (let ((l (list i ...)))
	 (construct-ugen 'n #f (without z l) #f (list-ref l z) 0 (make-uid 0)))))))

(define-filter/n DecodeB2 (numChans w x y orientation) 0)
(define-filter/n Silent (numChannels) 0)
(define-filter/n TGrains (numChannels trigger bufnum rate centerPos dur pan amp interp) 0)

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

;; Local Variables:
;; truncate-lines:t
;; End:            
