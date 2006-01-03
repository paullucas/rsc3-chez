;; (CoinGate prob in)
 
;; When it receives a trigger, it tosses a coin, and either passes the
;; trigger or doesn't.

(let ((prob 1/5))
  (SinOsc ar (TRand kr 300.0 400.0 (CoinGate kr prob (Impulse kr 10))) 
	     0 0.2))

(let ((prob 1/5)
      (trig (Impulse ar 20 0 (SinOsc kr 0.5 0 1 1))))
  (mix/fill 3 (lambda (_)
		(Ringz ar (CoinGate ar (+ prob (rand! 0 0.1)) (*u trig 0.5))
			  (TExpRand kr (make-list 2 1000.0) 12000.0 trig)
			  0.01))))

