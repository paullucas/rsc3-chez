;; (Formlet in freq attackTime decayTime) 

;; FOF-like filter

(let ((i (Impulse ar 20 0.5)))
  (audition (Out 0 (Formlet i 1000 0.01 0.1))))

(let* ((f (XLine kr 10 400 8 removeSynth))
       (i (Mul (Blip ar f 1000) 0.1)))
  (audition (Out 0 (Formlet i 1000 0.01 0.1))))

;; Modulating formant frequency.

(let ((i (Mul (Blip ar (MulAdd (SinOsc kr 5 0) 20 300) 1000) 0.1))
      (f (XLine kr 1500 700 8 removeSynth)))
  (audition (Out 0 (Formlet i f 0.005 0.04))))
