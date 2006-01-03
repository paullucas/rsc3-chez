;; (Ringz in freq decayTime)

;; Ringing filter.  This is the same as Resonz, except that instead of
;; a resonance parameter, the bandwidth is specified in a 60dB ring
;; decay time. One Ringz is equivalent to one component of the Klank
;; UGen.

(Ringz ar (Dust ar 3 0.3) 2000 2)

(Ringz ar (WhiteNoise ar 0.005) 2000 0.5)

;; Modulate frequency

(Ringz ar (WhiteNoise ar 0.005) (XLine kr 100 3000 10) 0.5)

(Ringz ar (Impulse ar 6 0.3) (XLine kr 100 3000 10) 0.5)

;; Modulate ring time

(Ringz ar (Impulse ar 6 0.3) 2000 (XLine kr 4 0.04 8))

;; Modulate ring time opposite direction

(Ringz ar (Impulse ar 6 0.3) 2000 (XLine kr 0.04 4 8))

(let ((exciter (WhiteNoise ar 0.001)))
  (Mix.fill 10 (lambda ()
		 (Ringz ar exciter
			   (XLine kr (random 100 5000)
				     (random 100 5000) 20) 0.5))))
