;; (Replaceout bufferindex inputs)

;; Send signal to a bus, overwrite existing signal.

(audition
 (Mrg (out 0 (mul (sin-osc ar (Mce 330 331) 0) 0.1))
      (Replaceout 0 (mul (sin-osc ar (Mce 880 881) 0) 0.1))
      (out 0 (mul (sin-osc ar (Mce 120 121) 0) 0.1))))

;; Compare to:

(audition
 (Mrg (out 0 (mul (sin-osc ar (Mce 330 331) 0) 0.1))
      (out 0 (mul (sin-osc ar (Mce 880 881) 0) 0.1))
      (out 0 (mul (sin-osc ar (Mce 120 121) 0) 0.1))))
