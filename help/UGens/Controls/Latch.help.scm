;; (Latch in trig)

;; Sample and hold. Holds input signal value when triggered.

;; in   - input signal.
;; trig - trigger. The trigger can be any signal. A trigger happens when the
;;        signal changes from non-positive to positive.

(Mul (Blip ar (MulAdd (Latch (WhiteNoise ar) (Impulse ar 9 0)) 400 500) 4) 0.2)

; The above is just meant as example. LFNoise0 is a faster way to
; generate random steps :

(Mul (Blip ar (MulAdd (LFNoise0 kr 9) 400 500) 4) 0.2)
