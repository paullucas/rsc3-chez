;; (Pan2 in pos level)

;; Two channel equal power panner.  The pan position is bipolar, -1 is
;; left, +1 is right.  The level is a control rate input.

(let ((p (FSinOsc kr 2 0)))
  (audition (Out 0 (Pan2 (PinkNoise ar) p 0.3))))

(let ((x (MouseX kr -1 1 0 0.1))
      (y (MouseY kr 0 1 0 0.1)))
  (audition (Out 0 (Pan2 (PinkNoise ar) x y))))
