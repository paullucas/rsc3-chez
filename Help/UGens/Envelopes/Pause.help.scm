;; (Pause gate nodeID)

;; When triggered pauses a node.

;; gate   - when gate is 0,  node is paused, when 1 it runs
;; nodeID - node to be paused

(with-sc3
 (lambda (fd)
   (send-synth fd "a" (Out 0 (Mul (SinOsc ar 800 0) 0.1)))
   (send-synth fd "b" (letc ((g 1))
			(Mrg (Out 1 (Mul (PinkNoise ar) 0.05))
			     (Pause g 1001))))
   (send fd (/s_new "a" 1001 0 0))
   (send fd (/s_new "b" 1002 0 0))
   (sleep 1)
   (send fd (/n_set 1002 "g" 0))
   (sleep 1)
   (send fd (/n_set 1002 "g" 1))
   (sleep 1)
   (reset fd)))
