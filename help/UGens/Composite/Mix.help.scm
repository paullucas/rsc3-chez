;; (mix UGen)

;; Force multiple channel expansion and sum signals.

(Mul (mix (FSinOsc ar (Mce 600.2 622.0 641.3 677.7) 0)) 0.1)

(Mul 0.05 (mix (Mce (FSinOsc ar (Mce 100  500) 0)
		    (FSinOsc ar (Mce 5000 501) 0))))
