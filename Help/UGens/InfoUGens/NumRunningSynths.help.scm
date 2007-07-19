;; NumRunningSynths

;; Number of currently running synths.

(Mul (SinOsc ar (MulAdd NumRunningSynths 200 400) 0) 0.1)
