;; (Impulse rate freq iphase)

;; Impulse oscillator.  Outputs non band limited single sample
;; impulses.

;; freq - frequency in Hertz
;; phase - phase offset in cycles (0..1)

(audition (Out 0 (Mul (Impulse ar 800 0) 0.1)))

(let ((f (XLine kr 800 10 5 removeSynth)))
  (audition (Out 0 (Mul (Impulse ar f 0.0) 0.5))))

(let ((f (MouseY kr 4 8 0 0.1))
      (p (MouseX kr 0 1 0 0.1)))
  (audition (Out 0 (Mul (Impulse ar f (Mce 0 p)) 0.2))))
