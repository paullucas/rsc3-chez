;; (LinPan2 in pos level)

;; Two channel linear pan.  See Pan2.

(audition (Out 0 (LinPan2 (PinkNoise ar) (FSinOsc kr 2 0) 0.1)))

(audition (Out 0 (LinPan2 (FSinOsc ar 800 0.1) (FSinOsc kr 3 0) 0.1)))
