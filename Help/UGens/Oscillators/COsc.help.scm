;; (COsc bufnum freq beats)

;; Chorusing wavetable lookup oscillator. Produces sum of two signals
;; at (freq +/- (beats / 2)). Due to summing, the peak amplitude is
;; twice that of the wavetable.

;; bufnum - the number of a buffer filled in wavetable format
;; freq   - frequency in Hertz
;; beats  - beat frequency in Hertz

(->< s (/b_alloc 10 512 1))

(->< s (/b_gen 10 "sine1" (+ 1 2 4) 1 1/2 1/3 1/4 1/5 1/6 1/7 1/8 1/9 1/10))

(Mul (COsc ar 10 200 0.7) 0.25)

(Mul (COsc ar 10 200 (MouseX kr 0 4 0 0.1)) 0.25)

;; Compare with:

(Mul (Osc ar 10 200 0.0) 0.25)
