;; (Atan2 x y)

;; Returns the arctangent of y/x.

;; See also hypot.

;; Add a pan to the hypot doppler examples by using atan2 to find the
;; azimuth, or direction angle, of the sound source.  Assume speakers
;; at +/- 45 degrees and clip the direction to between those.

(let* ((x 10)
       (y (Mul (LFSaw kr 1/6 0) 100))
       (distance (Hypot x y))
       (amplitude (FDiv 40 (Squared distance)))
       (sound (RLPF (Mul (FSinOsc ar 200 0) (LFPulse ar 31.3 0 0.4)) 400 0.3))
       (azimuth (Atan2 y x))
       (loc (Clip2 (FDiv azimuth half-pi) 1)))
  (Pan2 (DelayL sound 110/344 (FDiv distance 344))
	loc
	amplitude))
