;; (Saw rate freq)

;; Band limited sawtooth wave generator.

(let ((f (XLine kr 40 4000 6 doNothing)))
  (audition (Out 0 (Mul (Saw ar f) 0.2))))

;; Two band limited sawtooth waves thru a resonant low pass filter

(let ((f (XLine kr 8000 400 5 doNothing)))
  (audition (Out 0 (RLPF (Mul (Saw ar (Mce 100 250)) 0.1) f 0.05))))
