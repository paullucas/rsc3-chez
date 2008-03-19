;; (leak-dc in coef)                

;; Remove DC.  This filter removes a DC offset from a signal.

;; in   - input signal
;; coef - leak coefficient

(let ((a (mul (lfpulse ar 800 0.5 0.5) 0.1)))
  (audition (out 0 (Mce a (leak-dc a 0.995)))))
