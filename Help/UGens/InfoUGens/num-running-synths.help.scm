;; num-running-synths

;; Number of currently running synths.

(mul (sin-osc ar (mul-add num-running-synths 200 400) 0) 0.1)
