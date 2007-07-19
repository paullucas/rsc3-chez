;; (Mul a b)

;; Multiplication, written '*' in sclang.

(Mul (SinOsc ar 440 0) 0.5)

;; Mul* is a variable argument variant.  

;; Creates a beating effect (subaudio rate).

(Mul* (FSinOsc kr 10 0) 
      (PinkNoise ar)
      0.5)

;; Ring modulation.

(Mul* (SinOsc ar (XLine kr 100 1001 10 doNothing) 0)
      (SyncSaw ar 100 200)
      0.25)
