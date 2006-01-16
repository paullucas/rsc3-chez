;; (ReplaceOut bufferIndex inputs)

;; Send signal to a bus, overwrite existing signal.

(Mrg (Out 0 (Mul (SinOsc ar (Mce 330 331) 0) 0.1))
     (ReplaceOut 0 (Mul (SinOsc ar (Mce 880 881) 0) 0.1))
     (Out 0 (Mul (SinOsc ar (Mce 120 121) 0) 0.1)))

;; Compare to:

(Mrg (Out 0 (Mul (SinOsc ar (Mce 330 331) 0) 0.1))
     (Out 0 (Mul (SinOsc ar (Mce 880 881) 0) 0.1))
     (Out 0 (Mul (SinOsc ar (Mce 120 121) 0) 0.1)))
