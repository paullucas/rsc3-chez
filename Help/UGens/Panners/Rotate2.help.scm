;; (Rotate2 x y pos)			

;; Rotate a sound field.  Rotate2 can be used for rotating an
;; ambisonic B-format sound field around an axis.  Rotate2 does an
;; equal power rotation so it also works well on stereo sounds.  It
;; takes two audio inputs (x, y) and an angle control (pos).  It
;; outputs two channels (x, y).

;; It computes: 

;;      xout = cos(angle) * xin + sin(angle) * yin; 
;;      yout = cos(angle) * yin - sin(angle) * xin; 

;; where angle = pos * pi, so that -1 becomes -pi and +1 becomes +pi.
;; This allows you to use an LFSaw to do continuous rotation around a
;; circle.

;; The control pos is the angle to rotate around the circle from -1
;; to +1. -1 is 180 degrees, -0.5 is left, 0 is forward, +0.5 is
;; right, +1 is behind.

(let ((p (Mul (WhiteNoise ar) 0.05))
      (q (Mul (mix (LFSaw ar (Mce 200 200.37 201) 0)) 0.03)))
  (let* ((encoded (Add (PanB2 p -0.5 1) (PanB2 q -0.5 1)))
	 (rotated (Rotate2 (mce-ref encoded 1) 
			   (mce-ref encoded 2) 
			   (MouseX kr -1 1 0 0.1)))
	 (decoded (DecodeB2 4 
			    (mce-ref encoded 0) 
			    (mce-ref rotated 0)
			    (mce-ref rotated 1) 
			    0.5)))
    decoded))

;; Rotation of stereo sound, via LFO.

(Rotate2 (Mul (PinkNoise ar) 0.4)
	 (Mul (LFTri ar 800 0) (Mul (LFPulse kr 3 0 0.3) 0.2))
	 (LFSaw kr 0.1 0))

;; Rotation of stereo sound, via mouse.

(Rotate2 (mix/fill 4 (lambda (_) (Mul (LFSaw ar (rand 198 202) 0) 0.1)))
	 (Mul (SinOsc ar 900 0) (Mul (LFPulse kr 3 0 0.3) 0.2))
	 (MouseX kr 0 2 0 0.1))
