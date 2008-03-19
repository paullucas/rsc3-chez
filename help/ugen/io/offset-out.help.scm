;; (offset-out bufferindex inputs)				 
 
;; output signal to a bus, the sample offset within the bus is kept
;; exactly.  This ugen is used where sample accurate output is needed.

(audition
 (Mrg (offset-out 0 (impulse ar 5 0))
      (out 0 (mul (sin-osc ar 60 0) 0.1))))

(audition
 (Mrg (out 0 (impulse ar 5 0))
      (out 0 (mul (sin-osc ar 60 0) 0.1))))
