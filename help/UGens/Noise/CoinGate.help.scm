;; (CoinGate prob in)

;; When it receives a trigger, it tosses a coin, and either passes the
;; trigger or doesn't.

(Mul
 (SinOsc ar (TRand 300 400 (CoinGate 0.8 (Impulse kr 10 0))) 0)
 0.2)

(let ((prob 0.2)
      (trig (Mul (Impulse ar 20 0) (Add (SinOsc kr 0.5 0) 1))))
  (mix/fill 3 (lambda (_)
		(Ringz (CoinGate (+ prob (rand 0 0.1)) (Mul trig 0.5))
		       (TExpRand (Mce 1000 1000) 12000 trig)
		       0.01))))
