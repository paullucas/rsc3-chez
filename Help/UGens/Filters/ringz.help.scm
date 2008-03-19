;; (ringz in freq decayTime)

;; Ringing filter.  This is the same as resonz, except that instead of
;; a resonance parameter, the bandwidth is specified in a 60dB ring
;; decay time. One ringz is equivalent to one component of the klank
;; UGen.

(ringz (mul (dust ar 3) 0.3) 2000 2)

(ringz (mul (white-noise ar) 0.005) 2000 0.5)

;; Modulate frequency

(ringz (mul (white-noise ar) 0.005) (xline kr 100 3000 10 do-nothing) 0.5)

(ringz (mul (impulse ar 6 0) 0.3) (xline kr 100 3000 10 do-nothing) 0.5)

;; Modulate ring time

(ringz (mul (impulse ar 6 0) 0.3) 2000 (xline kr 4 0.04 8 do-nothing))

;; Modulate ring time opposite direction

(ringz (mul (impulse ar 6 0) 0.3) 2000 (xline kr 0.04 4 8 do-nothing))

(let ((n (mul (white-noise ar) 0.001)))
  (mix/fill 
   10 
   (lambda (_)
     (ringz n (xline kr (rand 100 5000) (rand 100 5000) 20 do-nothing) 0.5))))
