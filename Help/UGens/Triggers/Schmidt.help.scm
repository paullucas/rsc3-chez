;; (Schmidt in lo hi)

;; Schmidt trigger.  When in crosses to greater than hi, output 1.0,
;; then when signal crosses lower than lo output 0.0. Output is
;; initially zero.

;; in - signal to be tested
;; lo - low threshold
;; hi - high threshold

(let* ((in (LFNoise1 kr 3))
       (octave (Add (Schmidt in -0.15 0.15) 1))
       (f (Add (Mul in 200) (Mul 500 octave))))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.1))))
