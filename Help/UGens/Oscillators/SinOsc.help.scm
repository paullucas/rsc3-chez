;; (SinOsc rate freq phase)

;; Interpolating sine wavetable oscillator.  This is the same as Osc
;; except that the table is a sine table of 8192 entries.

;; freq - frequency in Hertz
;; phase - phase offset or modulator in radians

(audition (Out 0 (Mul (SinOsc ar 440 0) (mce2 0.15 0.25))))

;; Modulate freq

(let ((f (XLine kr 2000 200 1 removeSynth)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.5))))

;; Modulate freq

(let* ((f1 (XLine kr 1 1000 9 removeSynth))
       (f2 (MulAdd (SinOsc ar f1 0) 200 800)))
  (audition (Out 0 (Mul (SinOsc ar f2 0) 0.25))))

;; Modulate phase

(let* ((f (XLine kr 20 8000 10 removeSynth))
       (p (Mul (SinOsc ar f 0) (* pi 2))))
  (audition (Out 0 (Mul (SinOsc ar 800 p) 0.25))))
