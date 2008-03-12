;; (Pluck in tr maxdelaytime delaytime decaytime coef)   

;; Karplus-Strong synthesis.

;; in - an excitation signal

;; tr - upon a negative to positive transition, the excitation signal
;;      will be fed into the delay line

;; maxdelaytime - the max delay time in seconds (initializes the
;;                internal delay buffer).

;; delaytime - delay time in seconds.

;; decaytime - time for the echoes to decay by 60 decibels. Negative
;;             times emphasize odd partials.

;; coef - the coef of the internal OnePole filter. Values should be
;;        between -1 and +1 (larger values will be unstable... so be
;;        careful!).

;; Excitation signal is WhiteNoise, triggered twice a second with
;; varying OnePole coef.

(let ((n (Mul (WhiteNoise ar) 0.1))
      (t (Impulse kr 2 0))
      (x (MouseX kr -0.999 0.999 0 0.1))
      (dl (/ 1 440)))
  (audition (Out 0 (Pluck n t dl dl 10 x))))

(let* ((n 25)
       (gen (lambda (n f) (mce/fill n (lambda (_) (f)))))
       (f (gen n (lambda () (Rand 0.05 0.2))))
       (p (gen n (lambda () (Rand 0 1))))
       (x (MouseX kr 60 1000 1 0.1))
       (o (LinLin (SinOsc kr f p) -1 1 x 3000))
       (w (clone n (Mul (WhiteNoise ar) 0.1)))
       (i (Impulse kr (gen n (lambda () (Rand 10 12))) 0))
       (ks (Pluck w i 0.01 (FDiv 1 o) 2 (Rand 0.01 0.2)))
       (l (gen n (lambda () (Rand -1 1)))))
  (audition (Out 0 (LeakDC (mix (Pan2 ks l 1)) 0.995))))
