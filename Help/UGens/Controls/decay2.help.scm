;; (decay2 in attackTime decayTime)			

;; Exponential decay.  decay has a very sharp attack and can produce
;; clicks. decay2 rounds off the attack by subtracting one decay from
;; another.

;; (decay2 in a d) is equivalent to (sub (decay in d) (Decay in a)).

;; Used as an envelope

(mul (decay2 (impulse ar (xline kr 1 50 20 remove-synth) 0.25)
	     0.01
	     0.2)
     (mul (fsin-osc ar 600 0) 0.25))

;; Compare the above with decay used as the envelope.

(mul (decay (impulse ar (xline kr 1 50 20 remove-synth) 0.25)
	    0.01)
     (mul (fsin-osc ar 600 0) 0.25))
