;; (Decay2 in attackTime decayTime)			

;; Exponential decay.  Decay has a very sharp attack and can produce
;; clicks. Decay2 rounds off the attack by subtracting one Decay from
;; another.

;; (Decay2 ar in attackTime decayTime) is equivalent to (Sub (Decay ar
;; in decayTime) (Decay ar in attackTime)).

;; Used as an envelope

(Decay2 ar (Impulse ar (XLine kr 1 50 20) 1/4) 0.01 0.2 (FSinOsc ar 600 0 1/4))

;; Compare the above with Decay used as the envelope.

(Decay ar (Impulse ar (XLine kr 1 50 20) 1/4) 0.2 (FSinOsc ar 600 0 1/4) 0)

