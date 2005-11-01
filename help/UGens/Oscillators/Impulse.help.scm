;; (Impulse freq iphase)

;; Impulse oscillator.  Outputs non band limited single sample
;; impulses.

;; freq - frequency in Hertz
;; phase - phase offset in cycles (0..1)

(Impulse.ar 800 0 0.1)

(Impulse.ar (XLine.kr 800 10 5) 0.0 0.5)

(Impulse.ar (MouseY.kr 4 8) (list 0 (MouseX.kr 0 1)) 0.2)
