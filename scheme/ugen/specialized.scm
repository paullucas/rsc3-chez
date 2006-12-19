;; specialized.scm - (c) rohan drape, 2005-2006

(define-syntax define-specialized
  (syntax-rules ()
    ((_ n (i ...) o r)
     (define (n i ...)
       (construct-ugen 'n r (list i ...) #f o 0 (make-uid 0))))))

(define-specialized K2A (in) 1 ar)
(define-specialized Pitch (in initFreq minFreq maxFreq execFreq maxBinsPerOctave median ampThreshold peakThreshold downSample) 2 kr)

(define-specialized FFT (buf in) 1 kr)
(define-specialized IFFT (buf) 1 ar)
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

(define-specialized/c NumAudioBuses 1 ir)
(define-specialized/c NumBuffers 1 ir)
(define-specialized/c NumControlBuses 1 ir)
(define-specialized/c NumInputBuses 1 ir)
(define-specialized/c NumOutputBuses 1 ir)
(define-specialized/c NumRunningSynths 1 ir)
(define-specialized/c RadiansPerSample 1 ir)
(define-specialized/c SampleDur 1 ir)
(define-specialized/c SampleRate 1 ir)

(define-syntax define-specialized*
  (syntax-rules ()
    ((_ n (i ... v) o r)
     (define (n i ... v)
       (construct-ugen 'n r (list i ...) v o 0 (make-uid 0))))))

(define-syntax define-specialized/n
  (syntax-rules ()
    ((_ n (i ...) r)
     (define (n nc i ...)
       (if (not (integer? nc))
	   (error "illegal channel count:" 'n nc))
       (let ((l (list i ...)))
	 (construct-ugen 'n r l #f nc 0 (make-uid 0)))))))

(define-specialized/n InFeedback (bus) ar)
(define-specialized/n InTrig (bus) kr)
(define-specialized/n LagIn (bus lag) kr)
(define-specialized/n PlayBuf (bufnum rate trigger startPos loop) ar)

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

;; Local Variables:
;; truncate-lines:t
;; End:            
