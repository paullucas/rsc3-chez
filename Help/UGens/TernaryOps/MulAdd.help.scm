;; (MulAdd a b c)

;; Functionally equivalent to (Add (Mul a b) c).

(let ((f (MulAdd (LFSaw kr (Mce 10 9) 0) 200 400)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))

(let ((f (Add (Mul (LFSaw kr (Mce 10 9) 0) 200) 400)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))
