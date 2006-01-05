;; (LinPan2 in pos level)

;; Two channel linear pan.  See Pan2.

(LinPan2 (PinkNoise 0 ar) (FSinOsc kr 2 0) 0.1)

(LinPan2 (FSinOsc ar 800 0.1) (FSinOsc kr 3 0) 0.1)
