;; (Free trig nodeID)

;; When triggered frees a node.

;; trig   - when triggered, frees node
;; nodeID - node to be freed

(with-sc3
 (lambda (fd)
   (send-synth fd "a" (Out 0 (Mul (SinOsc ar 800 0) 0.1)))
   (send-synth fd "b" (Mrg (Out 1 (Mul (PinkNoise ar) 0.1)) 
			   (Free (Dust ar 6) 1001)))
   (send fd (/s_new "a" 1001 0 0))
   (send fd (/s_new "b" -1 0 0))))

(with-sc3 reset)
