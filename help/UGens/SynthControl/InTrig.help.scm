;; (InTrig bus numChannels)

;; Generate a trigger anytime a bus is set.
 
;; Any time the bus is "touched" ie. has its value set (using "/c_set"
;; etc.), a single impulse trigger will be generated.  Its amplitude
;; is the value that the bus was set to.

;; Run an oscillator with the trigger at bus 10.

(let ((t (InTrig.kr 10)))
  (Mul (SinOsc.ar)
       (EnvGen.kr envelope: (Env.perc) 
		  gate: t
		  levelScale: t)))

;; Set bus 10.

(-> '/c_set 10 (random 1/2))
