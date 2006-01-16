;; (InTrig bus numChannels)

;; Generate a trigger anytime a bus is set.

;; Any time the bus is "touched" ie. has its value set (using "/c_set"
;; etc.), a single impulse trigger will be generated.  Its amplitude
;; is the value that the bus was set to.

;; Run an oscillator with the trigger at bus 10.

(let ((t (InTrig kr 10 1)))
  (Mul (SinOsc ar 440 0)
       (EnvGen kr t t 0 1 0 (env/perc 0.01 1 1 -4))))

;; Set bus 10.

(->! s (/c_set 10 (rand! 0 0.2)))
