;; (OffsetOut bufferIndex inputs)				 
 
;; Output signal to a bus, the sample offset within the bus is kept
;; exactly.  This ugen is used where sample accurate output is needed.

(audition
 (Mrg (OffsetOut 0 (Impulse ar 5 0))
      (Out 0 (Mul (SinOsc ar 60 0) 0.1))))

(audition
 (Mrg (Out 0 (Impulse ar 5 0))
      (Out 0 (Mul (SinOsc ar 60 0) 0.1))))
