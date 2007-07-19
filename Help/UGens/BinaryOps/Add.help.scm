;; (Add a b)

;; Addition, written '+' in sclang.

(Add (Mul (FSinOsc ar 800 0) 0.1)
     (Mul (PinkNoise ar) 0.1))

;; DC offset.

(Add (FSinOsc ar 440 0) 0.1)
