;; (BRZ2 in)

;; A two zero fixed midcut filter.  A special case fixed
;; filter. Implements the formula:

;; out(i) = 0.5 * (in(i) + in(i-2))

;; This filter cuts out frequencies around 1/2 of the Nyquist
;; frequency.

;; Compare:

(audition (Out 0 (Mul (WhiteNoise ar) 0.15)))

(audition (Out 0 (BRZ2 (Mul (WhiteNoise ar) 0.15))))
