;; (PanB2 in azimuth gain)

;; 2D Ambisonic B-format panner.  Encode a mono signal to two
;; dimensional ambisonic B-format.  The azimuth parameter is the
;; position around the circle from -1 to +1.  -1 is behind, -0.5 is
;; left, 0 is forward, +0.5 is right, +1 is behind.

(let* ((p (PinkNoise ar))
       (encoded (PanB2 p (MouseX kr -1 1 0 0.1) 0.1))
       (decoded (DecodeB2 4 
			  (mce-ref encoded 0)
			  (mce-ref encoded 1)
			  (mce-ref encoded 2)
			  0.5)))
  (audition (Out 0 decoded)))
