;; fft.scm - (c) rohan drape, 2005

(define-specialized FFT (buf in) 1 kr)
(define-specialized IFFT (buf) 1 ar)

(define-specialized PV_Add (bufA bufB) 1 kr)
(define-specialized PV_BinScramble (buffer wipe width trig) 1 kr)
(define-specialized PV_BinShift () 1 kr)
(define-specialized PV_BinWipe () 1 kr)
(define-specialized PV_BrickWall () 1 kr)
(define-specialized PV_ConformalMap () 1 kr)
(define-specialized PV_CopyPhase () 1 kr)
(define-specialized PV_Diffuser () 1 kr)
(define-specialized PV_HainsworthFoote (buffer proph propf threshold waittime) 1 kr)
(define-specialized PV_JensenAndersen (buffer propsc prophfe prophfc propsf threshold waittime) 1 kr)
(define-specialized PV_LocalMax () 1 kr)
(define-specialized PV_MagAbove () 1 kr)
(define-specialized PV_MagBelow () 1 kr)
(define-specialized PV_MagClip () 1 kr)
(define-specialized PV_MagFreeze () 1 kr)
(define-specialized PV_MagMul () 1 kr)
(define-specialized PV_MagNoise () 1 kr)
(define-specialized PV_MagShift () 1 kr)
(define-specialized PV_MagSmear () 1 kr)
(define-specialized PV_MagSquared () 1 kr)
(define-specialized PV_Max () 1 kr)
(define-specialized PV_Min () 1 kr)
(define-specialized PV_Mul () 1 kr)
(define-specialized PV_PhaseShift270 () 1 kr)
(define-specialized PV_PhaseShift90 () 1 kr)
(define-specialized PV_PhaseShift () 1 kr)
(define-specialized PV_RandComb (buffer wipe trig) 1 kr)
(define-specialized PV_RandWipe (bufferA bufferB wipe trig) 1 kr)
(define-specialized PV_RectComb2 () 1 kr)
(define-specialized PV_RectComb () 1 kr)

;; Local Variables:
;; truncate-lines:t
;; End:            
