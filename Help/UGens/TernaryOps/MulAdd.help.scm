;; (MulAdd a b c)

;; Functionally equivalent to (Add (Mul a b) c).

(Mul (SinOsc ar (MulAdd (LFSaw kr (Mce 10 9) 0) 200 400) 0) 0.1)

(Mul (SinOsc ar (Add (Mul (LFSaw kr (Mce 10 9) 0) 200) 400) 0) 0.1)
