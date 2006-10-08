;; (NumRunningSynths)

;; Number of currently running synths.

(Mul (SinOsc ar (MulAdd (NumRunningSynths ir) 200 400) 0) 0.1)
