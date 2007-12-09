;; (mix UGen)

;; Force multiple channel expansion and sum signals.

(let ((f (Mce 600.2 622.0 641.3 677.7)))
  (audition (Out 0 (Mul (mix (FSinOsc ar f 0)) 0.1))))

;; Expansion nests.

(let ((l (FSinOsc ar (Mce 100  500) 0))
      (r (FSinOsc ar (Mce 5000 501) 0)))
  (audition (Out 0 (Mul 0.05 (mix (Mce l r))))))

;; Simple idiom...

(let ((n 6)
      (o (lambda (_) (Mul (FSinOsc ar (rand 200 700) 0) 0.1))))
  (audition (Out 0 (mix/fill n o))))
