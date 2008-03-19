;; (Atan2 x y)

;; Returns the arctangent of y/x.

;; See also hypot.

;; add a pan to the hypot doppler examples by using atan2 to find the
;; azimuth, or direction angle, of the sound source.  Assume speakers
;; at +/- 45 degrees and clip the direction to between those.

(let* ((x 10)
       (y (mul (lfsaw kr 1/6 0) 100))
       (distance (Hypot x y))
       (amplitude (fdiv 40 (Squared distance)))
       (sound (Rlpf (mul (fsin-osc ar 200 0) (lfpulse ar 31.3 0 0.4)) 400 0.3))
       (azimuth (Atan2 y x))
       (loc (clip2 (fdiv azimuth half-pi) 1)))
  (pan2 (delay-l sound 110/344 (fdiv distance 344))
	loc
	amplitude))
