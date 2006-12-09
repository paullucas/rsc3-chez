;; (Latch in trig)

;; Sample and hold. Holds input signal value when triggered.

;; in   - input signal.
;; trig - trigger. The trigger can be any signal. A trigger happens when the
;;        signal changes from non-positive to positive.

(Mul (Blip ar (MulAdd (Latch (WhiteNoise ar) (Impulse ar 9 0)) 400 500) 4) 0.2)

;; The above is just meant as example. LFNoise0 is a faster way to
;; generate random steps :

(Mul (Blip ar (MulAdd (LFNoise0 kr 9) 400 500) 4) 0.2)

;; http://create.ucsb.edu/pipermail/sc-users/2006-December/029991.html

(let* ((n0 (MulAdd (LFNoise2 kr 8) 200 300))
       (n1 (MulAdd (LFNoise2 kr 3) 10 20))
       (s  (Blip ar n0 n1))
       (x  (MouseX kr 1000 (Mul (SampleRate ir) 0.1) 1 0.1)))
  (Latch s (Impulse ar x 0)))
