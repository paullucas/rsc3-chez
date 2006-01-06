;; (Hypot x y)

;; Returns the square root of the sum of the squares of a and b. Or
;; equivalently, the distance from the origin to the point (x, y).

(Mul (SinOsc ar 440 0)
     (Hypot (MouseX kr 0 0.1 0 0.1) 
	    (MouseY kr 0 0.1 0 0.1)))

;; Object travels 200 meters in 6 secs (=120kph) passing 10 meters
;; from the listener

(let* ((x 10)
       (y (LFSaw kr 1/6 0 100))
       (distance (Hypot x y))
       (velocity (Slope kr distance))
       (pitchRatio (FDiv (Sub 344 velocity) 344)) ;; speed of sound is 344 meters/sec
       (amplitude (FDiv 10 (Squared distance))))
  (FSinOsc ar (Mul 1000 pitchRatio) 0 amplitude))

(let* ((x 10)
       (y (LFSaw kr 1/6 0 100))
       (distance (Hypot x y))
       (amplitude (FDiv 40 (Squared distance)))
       (motor-sound (RLPF ar (FSinOsc ar 200 0 (LFPulse ar 31.3 0 0.4)) 400 0.3)))
  (DelayL ar motor-sound 110/344 (FDiv distance 344) amplitude))
