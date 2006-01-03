;; (Mix in ...)

;; Sum a list of signals.  

(Mul (Mix (FSinOsc ar '(600.2 622.0 641.3 677.7))) 0.1)

;; The input list may be nested, the expression below forces multiple
;; channel expansion.

(Mul 0.05 (Mix (list (FSinOsc ar '(100  500))
		     (FSinOsc ar '(5000 501)))))
