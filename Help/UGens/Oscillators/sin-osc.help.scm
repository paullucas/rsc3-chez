;; (sin-osc rate freq phase)

;; interpolating sine wavetable oscillator.  This is the same as osc
;; except that the table is a sine table of 8192 entries.

;; freq - frequency in Hertz
;; phase - phase offset or modulator in radians

(audition (out 0 (mul (sin-osc ar 440 0) (mce2 0.15 0.25))))

;; Modulate freq

(let ((f (xline kr 2000 200 1 remove-synth)))
  (audition (out 0 (mul (sin-osc ar f 0) 0.5))))

;; Modulate freq

(let* ((f1 (xline kr 1 1000 9 remove-synth))
       (f2 (mul-add (sin-osc ar f1 0) 200 800)))
  (audition (out 0 (mul (sin-osc ar f2 0) 0.25))))

;; Modulate phase

(let* ((f (xline kr 20 8000 10 remove-synth))
       (p (mul (sin-osc ar f 0) (* pi 2))))
  (audition (out 0 (mul (sin-osc ar 800 p) 0.25))))
