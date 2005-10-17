;;; (PanB2 in azimuth gain)

;;; 2D Ambisonic B-format panner.  Encode a mono signal to two
;;; dimensional ambisonic B-format.  The azimuth parameter is the
;;; position around the circle from -1 to +1.  -1 is behind, -0.5 is
;;; left, 0 is forward, +0.5 is right, +1 is behind.
 
(let* ((p (PinkNoise.ar))
       (encoded (PanB2.ar p (MouseX.kr -1 1) 0.1))
       (decoded (DecodeB2.ar 4 (first encoded) (second encoded) (third encoded))))
  decoded)
