;; (SinOsc freq phase)

;; Interpolating sine wavetable oscillator.  This is the same as Osc
;; except that the table is a sine table of 8192 entries.

;; freq - frequency in Hertz
;; phase - phase offset or modulator in radians

(Mul (SinOsc ar 440 0) (Mce 0.15 0.25))

;; Modulate freq

(Mul (SinOsc ar (XLine kr 2000 200 1 2) 0) 0.5)

;; Modulate freq

(Mul (SinOsc ar (MulAdd (SinOsc ar (XLine kr 1 1000 9 2) 0) 200 800) 0)
     0.25)

;; Modulate phase

(Mul (SinOsc ar 800 (Mul (SinOsc ar (XLine kr 20 8000 10 2) 0) two-pi)) 
     0.25)
