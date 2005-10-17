;; (In bus numChannels)

;; Read signal from an audio or control bus.
 
;; Write noise to bus 10, then read it out.

(begin (Out.ar 10 (PinkNoise.ar 0.3))
       (In.ar 10))

;; Patching input to output

(In.ar 2)

;; Reading a control bus.

(-> "/c_set" 0 (random 200 5000))

(SinOsc.ar (In.kr 0) 0 0.1)
