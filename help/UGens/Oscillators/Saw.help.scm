;; (Saw freq)

;; Band limited sawtooth wave generator.

(Mul (Saw ar (XLine kr 40 4000 6 doNothing)) 0.2)

;; Two band limited sawtooth waves thru a resonant low pass filter

(let ((f (XLine kr 8000 400 5 doNothing)))
  (RLPF (Mul (Saw ar (Mce 100 250)) 0.1) f 0.05))
