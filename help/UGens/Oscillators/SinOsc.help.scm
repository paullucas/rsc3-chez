;; (SinOsc freq phase)

;; Interpolating sine wavetable oscillator.  This is the same as Osc
;; except that the table is a sine table of 8192 entries.

;; freq - frequency in Hertz
;; phase - phase offset or modulator in radians

(SinOsc.ar 440 0 0.5)

;; Modulate freq

(SinOsc.ar (XLine.kr 2000 200) 0 0.5)

;; Modulate freq

(SinOsc.ar (SinOsc.ar (XLine.kr 1 1000 9) 0 200 800) 0 0.25)

;; Modulate phase

(SinOsc.ar 800 (SinOsc.ar (XLine.kr 20 8000 10) 0 two-pi) 0.25)
