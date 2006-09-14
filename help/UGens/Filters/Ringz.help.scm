;; (Ringz in freq decayTime)

;; Ringing filter.  This is the same as Resonz, except that instead of
;; a resonance parameter, the bandwidth is specified in a 60dB ring
;; decay time. One Ringz is equivalent to one component of the Klank
;; UGen.

(Ringz (Mul (Dust ar 3) 0.3) 2000 2)

(Ringz (Mul (WhiteNoise ar) 0.005) 2000 0.5)

;; Modulate frequency

(Ringz (Mul (WhiteNoise ar) 0.005) (XLine kr 100 3000 10 doNothing) 0.5)

(Ringz (Mul (Impulse ar 6 0) 0.3) (XLine kr 100 3000 10 doNothing) 0.5)

;; Modulate ring time

(Ringz (Mul (Impulse ar 6 0) 0.3) 2000 (XLine kr 4 0.04 8 doNothing))

;; Modulate ring time opposite direction

(Ringz (Mul (Impulse ar 6 0) 0.3) 2000 (XLine kr 0.04 4 8 doNothing))

(let ((n (Mul (WhiteNoise ar) 0.001)))
  (mix/fill 
   10 
   (lambda (_)
     (Ringz n (XLine kr (rand 100 5000) (rand 100 5000) 20 doNothing) 0.5))))
