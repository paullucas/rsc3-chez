;; (OffsetOut bufferIndex inputs)				 
 
;; Output signal to a bus, the sample offset within the bus is kept
;; exactly.  This ugen is used where sample accurate output is needed.

(begin (OffsetOut ar 0 (Impulse ar 5))
       (SinOsc ar 60 0 0.1))

(begin (Out ar 0 (Impulse ar 5))
       (SinOsc ar 60 0 0.1))
