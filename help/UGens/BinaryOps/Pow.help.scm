;; (Pow a b)

;; Exponentiation, written ** in sclang.  When the signal is negative
;; this function extends the usual definition of exponentiation and
;; returns neg(neg(a) ** b). This allows exponentiation of negative
;; signal values by noninteger exponents.

(let ((a (FSinOsc ar 100 0)))
  (Mce a (Pow a 10)))

;; http://create.ucsb.edu/pipermail/sc-users/2006-December/029998.html

(let* ((n0 (MulAdd (LFNoise2 kr 8) 200 300))
       (n1 (MulAdd (LFNoise2 kr 3) 10 20))
       (s  (Blip ar n0 n1))
       (x  (MouseX kr 1000 (Mul (SampleRate ir) 0.5) 1 0.1))
       (y  (MouseY kr 1 24 1 0.1))
       (d  (Latch s (Impulse ar x 0)))
       (b  (Round d (Pow 0.5 y))))
  (Mce d b))
