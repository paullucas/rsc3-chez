;; (LinPan2 in pos level)

;; Two channel linear pan.  See Pan2.

(LinPan2 ar (PinkNoise ar) (FSinOsc kr 2))

(LinPan2 ar (FSinOsc ar 800 0.1) (FSinOsc kr 3))
