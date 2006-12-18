;; oscillator.scm - (c) rohan drape, 2005-2006

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

(define-oscillator LagIn () 1)
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

(define-oscillator NumAudioBuses () 1)
(define-oscillator NumBuffers () 1)
(define-oscillator NumControlBuses () 1)
(define-oscillator NumInputBuses () 1)
(define-oscillator NumOutputBuses () 1)
(define-oscillator NumRunningSynths () 1)
(define-oscillator RadiansPerSample () 1)
(define-oscillator SampleDur () 1)
(define-oscillator SampleRate () 1)

(define (without n l)
  (append (take l n) (drop l (+ n 1))))

(define-syntax define-oscillator/n
  (syntax-rules ()
    ((_ n (i ...))
     (define (n nc r i ...)
       (if (not (integer? nc))
	   (error "illegal channel count:" 'n nc))
       (let ((l (list i ...)))
	 (construct-ugen 'n r l #f nc 0 (make-uid 0)))))))

(define-oscillator/n BufRd (bufnum phase loop interpolation))
(define-oscillator/n DiskIn (bufnum))
(define-oscillator/n In (bus))
(define-oscillator/n InFeedback (bus))
(define-oscillator/n InTrig (bus))
(define-oscillator/n LocalIn ())
(define-oscillator/n PlayBuf (bufnum rate trigger startPos loop))
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
(define-oscillator/id DustR (lo hi) 1)
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

;; Local Variables:
;; truncate-lines:t
;; End:
