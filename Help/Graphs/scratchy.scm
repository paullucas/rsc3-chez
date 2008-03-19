;; scratchy (jmcc)

(let* ((n (Mul (clone 2 (BrownNoise ar)) 0.5))
       (f (Mul (Max (Sub n 0.49) 0) 20)))
  (audition (Out 0 (RHPF f 5000 1))))
