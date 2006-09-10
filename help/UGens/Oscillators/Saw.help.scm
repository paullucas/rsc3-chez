;; (Saw freq)

;; Band limited sawtooth wave generator.

(Mul (Saw ar (XLine kr 40 4000 6 doNothing)) 0.2)

;; Two band limited sawtooth waves thru a resonant low pass filter

(RLPF ar (Saw ar '(100 250) 0.1) (XLine kr 8000 400 5) 0.05)
