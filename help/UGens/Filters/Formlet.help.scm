;; (Formlet in freq attackTime decayTime) 

;; FOF-like filter

(Formlet.ar (Impulse.ar 20 0.5) 1000 0.01 0.1)

(Formlet.ar (Blip.ar (XLine.kr 10 400 8) 1000 0.1) 1000 0.01 0.1)

;; Modulating formant frequency.

(Formlet.ar (Blip.ar (SinOsc.kr 5 0 20 300) 1000 0.1)
	    (XLine.kr 1500 700 8) 0.005 0.04)
