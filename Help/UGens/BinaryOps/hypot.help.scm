;; (Hypot x y)

;; Returns the square root of the sum of the squares of a and b. Or
;; equivalently, the distance from the origin to the point (x, y).

(mul (sin-osc ar 440 0)
     (Hypot (mouse-x kr 0 0.1 0 0.1) 
	    (mouse-y kr 0 0.1 0 0.1)))

;; Object travels 200 meters in 6 secs (=120kph) passing 10 meters
;; from the listener.  The speed of sound is 344 meters/sec.

(let* ((x 10)
       (y (mul (lfsaw kr 1/6 0) 100))
       (distance (Hypot x y))
       (velocity (slope distance))
       (pitchRatio (fdiv (sub 344 velocity) 344)) 
       (amplitude (fdiv 10 (Squared distance))))
  (mul (fsin-osc ar (Mul 1000 pitchRatio) 0)
       amplitude))

(let* ((x 10)
       (y (mul (lfsaw kr 1/6 0) 100))
       (distance (Hypot x y))
       (amplitude (fdiv 40 (Squared distance)))
       (sound (Rlpf (mul (fsin-osc ar 200 0) (lfpulse ar 31.3 0 0.4)) 400 0.3)))
  (mul (delay-l sound 110/344 (fdiv distance 344))
       amplitude))
