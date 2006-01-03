;; (LocalIn numChannels)

;; Define and read from buses local to a SynthDef

;; numChannels - the number of channels of local buses.  The default
;;                is 1.

;; LocalIn defines buses that are local to the SynthDef. These are
;; like the global buses, but are more convenient if you want to
;; implement a self contained effect that uses a feedback processing
;; loop.  There can only be one audio rate and one control rate
;; LocalIn per SynthDef.  The audio can be written to the bus using
;; LocalOut.

(seq (local (Add (LocalIn ar 2) 
		 (list (Mul (Decay ar (Impulse ar 0.3) 0.1)
			    (WhiteNoise ar 0.2)) 0)))
     (DelayN ar local 0.2 0.2)
     (begin (LocalOut ar (Mul (reverse local) 0.8)) local))

(let ((f (lambda () 
	   (Pan2 ar (Mul (Decay2 ar (Dust ar 0.05) 0.1 0.5 0.1)
			 (Max (Cubed (FSinOsc ar (MIDICPS (IRand ir 36 84)))) 
			      0))
		    (Rand ir -1 1)))))
  (seq (local (Mul (LocalIn ar 2) 0.98))
       (OnePole ar local 0.5)
       (Rotate2 ar (ref local 0) (ref local 1) 0.23)
       (AllpassN ar local 0.05 (random-list 2 0.01 0.05) 2)
       (DelayN ar local 0.3 (list 0.19 0.26))
       (AllpassN ar local 0.05 (random-list 2 0.03 0.15) 2)
       (LeakDC ar local)
       (Add local
	    (seq (in (Mix.fill 12 f))
		 (Add in (Pan2 ar (Mul (Decay2 ar (Dust ar 0.03) 0.04 0.3) 
				       (BrownNoise ar))))
		 (AllpassN ar in 0.03 (random-list 2 0.005 0.02) 1)
		 (AllpassN ar in 0.03 (random-list 2 0.005 0.02) 1)
		 (AllpassN ar in 0.03 (random-list 2 0.005 0.02) 1)
		 (AllpassN ar in 0.03 (random-list 2 0.005 0.02) 1)))
       (begin (LocalOut ar local) local)))
