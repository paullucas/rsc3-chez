;; (Free trig nodeID)

;; When triggered frees a node.

;; trig   - when triggered, frees node
;; nodeID - node to be freed

(send-synth s "a" (Out 0 (Mul (SinOsc ar 800 0) 0.1)))

(send-synth s "b" (Mrg (Out 1 (Mul (PinkNoise ar) 0.1)) (Free (Dust ar 2) 1001)))

(-> s (/s_new "a" 1001 0 0))

(-> s (/s_new "b" -1 0 0))

(reset s)
