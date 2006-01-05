;; (Pulse freq width)

;; Bandlimited pulse wave generator.

;; Modulate frequency

(Mul (Pulse ar (XLine kr 40 4000 6 2) 0.1) 0.2)

;; Modulate pulse width

(Mul (Pulse ar 200 (Line kr 0.01 0.99 8 2)) 0.2)

;; Two band limited square waves thru a resonant low pass filter

(RLPF (Mul (Pulse ar (Mce 100 250) 0.5) 0.1) 
      (XLine kr 8000 400 5 2) 
      0.05)
