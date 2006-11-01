;; (LeakDC in coef)                

;; Remove DC.  This filter removes a DC offset from a signal.

;; in   - input signal
;; coef - leak coefficient

(let ((a (Mul (LFPulse ar 800 0.5 0.5) 0.1)))
  (Mce a (LeakDC a 0.995)))
