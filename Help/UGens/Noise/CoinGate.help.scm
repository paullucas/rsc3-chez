;; (CoinGate prob in)

;; When it receives a trigger, it tosses a coin, and either passes the
;; trigger or doesn't.

(let ((f (TRand 300 400 (CoinGate 0.8 (Impulse kr 10 0)))))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))

(let* ((p 0.2)
       (t (Mul (Impulse ar 20 0) (Add (SinOsc kr 0.5 0) 1)))
       (t* (TExpRand (Mce 1000 1000) 12000 t))
       (i (lambda () (CoinGate (+ p (rand 0 0.1)) (Mul t 0.5))))
       (s (lambda () (Ringz (i) t* 0.01)))
       (ignore (lambda (f) (lambda (_) (f)))))
  (audition (Out 0 (mix/fill 3 (ignore s)))))
