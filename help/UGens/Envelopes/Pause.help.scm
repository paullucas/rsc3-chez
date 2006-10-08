;; (Pause gate nodeID)

;; When triggered pauses a node.

;; gate   - when gate is 0,  node is paused, when 1 it runs
;; nodeID - node to be paused

(send-synth
 s "a"
 (Out 0 (Mul (SinOsc ar 800 0) 0.1)))

(send-synth
 s "b"
 (letc ((g 1))
   (Mrg (Out 1 (Mul (PinkNoise ar) 0.05))
	(Pause g 1001))))

(-> s (/s_new "a" 1001 0 0))

(-> s (/s_new "b" 1002 0 0))

(-> s (/n_set 1002 "g" 0))

(-> s (/n_set 1002 "g" 1))

(reset s)
