;; (Decay2 in attackTime decayTime)			

;; Exponential decay.  Decay has a very sharp attack and can produce
;; clicks. Decay2 rounds off the attack by subtracting one Decay from
;; another.

;; (Decay2 in a d) is equivalent to (Sub (Decay in d) (Decay in a)).

;; Used as an envelope

(Mul (Decay2 (Impulse ar (XLine kr 1 50 20 removeSynth) 0.25)
	     0.01
	     0.2)
     (Mul (FSinOsc ar 600 0) 0.25))

;; Compare the above with Decay used as the envelope.

(Mul (Decay (Impulse ar (XLine kr 1 50 20 removeSynth) 0.25)
	    0.01)
     (Mul (FSinOsc ar 600 0) 0.25))
