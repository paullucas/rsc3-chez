;; specialized.scm - (c) rohan drape, 2005-2006

(define-syntax define-specialized
  (syntax-rules ()
    ((_ n (i ...) o r)
     (define (n i ...)
       (construct-ugen 'n r (list i ...) #f o 0 (make-uid 0))))))

(define-specialized FFT (buf in) 1 kr)
(define-specialized IFFT (buf) 1 ar)

(define-specialized PV_Add (bufA bufB) 1 kr)
(define-specialized PV_BinScramble (buffer wipe width trig) 1 kr)
(define-specialized PV_BinShift (buffer stretch shift) 1 kr)
(define-specialized PV_BinWipe () 1 kr)
(define-specialized PV_BrickWall (buffer wipe) 1 kr)
(define-specialized PV_ConformalMap (buffer real imag) 1 kr)
(define-specialized PV_CopyPhase () 1 kr)
(define-specialized PV_Diffuser () 1 kr)
(define-specialized PV_HainsworthFoote (buffer proph propf threshold waittime) 1 kr)
(define-specialized PV_JensenAndersen (buffer propsc prophfe prophfc propsf threshold waittime) 1 kr)
(define-specialized PV_LocalMax () 1 kr)
(define-specialized PV_MagAbove (buffer threshold) 1 kr)
(define-specialized PV_MagBelow (buffer threshold) 1 kr)
(define-specialized PV_MagClip () 1 kr)
(define-specialized PV_MagFreeze (buffer freeze) 1 kr)
(define-specialized PV_MagMul () 1 kr)
(define-specialized PV_MagNoise () 1 kr)
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

(define-specialized Dgeom (length start grow) 1 dr)
(define-specialized Dseries (length start step) 1 dr)

(define-syntax define-specialized*
  (syntax-rules ()
    ((_ n (i ... v) o r)
     (define (n i ... v)
       (construct-ugen 'n r (list i ...) v o 0 (make-uid 0))))))

(define-specialized* Dseq (length array) 1 dr)
(define-specialized* Dser (length array) 1 dr)
(define-specialized* Dswitch1 (length array) 1 dr)

(define-syntax define-specialized/id
  (syntax-rules ()
    ((_ n (i ...) o r)
     (define (n i ...)
       (construct-ugen 'n r (list i ...) #f o 0 (unique-uid))))))

(define-specialized/id Dbrown (length lo hi step) 1 dr)
(define-specialized/id Dibrown (length lo hi step) 1 dr)
(define-specialized/id Diwhite (length lo hi) 1 dr)
(define-specialized/id Dwhite (length lo hi) 1 dr)

(define-syntax define-specialized*/id
  (syntax-rules ()
    ((_ n (i ... v) o r)
     (define (n i ... v)
       (construct-ugen 'n r (list i ...) v o 0 (unique-uid))))))

(define-specialized*/id Drand (length array) 1 dr)
(define-specialized*/id Dxrand (length array) 1 dr)

;; Local Variables:
;; truncate-lines:t
;; End:            
