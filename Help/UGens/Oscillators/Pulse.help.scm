;; (Pulse rate freq width)

;; Bandlimited pulse wave generator.

;; Modulate frequency

(audition
 (let ((f (XLine kr 40 4000 6 removeSynth)))
   (Out 0 (Mul (Pulse ar f 0.1) 0.2))))

;; Modulate pulse width

(audition
 (let ((w (Line kr 0.01 0.99 8 removeSynth)))
   (Out 0 (Mul (Pulse ar 200 w) 0.2))))

;; Two band limited square waves thru a resonant low pass filter

(audition
 (Out 0 (RLPF (Mul (Pulse ar (Mce 100 250) 0.5) 0.1) 
	      (XLine kr 8000 400 5 removeSynth) 
	      0.05)))
