;; (FDiv a b)

;; Division, written '/' in sclang.

;; Division can be tricky with signals because of division by zero.

(FDiv (Mul (PinkNoise ar) 0.1) 
      (Mul (FSinOsc kr 10 0.5) 0.75))
