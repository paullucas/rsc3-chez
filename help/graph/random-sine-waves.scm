;; random sine waves (jmcc) #1

(import (rsc3) (rsc3 lang))

(define random-sine-waves
  (pan2 (f-sin-osc ar (rand 0 2000) 0) (rand -1 1) 0.02))

(with-sc3 (overlap-texture-u (list 2 5 12 +inf.0) random-sine-waves))
