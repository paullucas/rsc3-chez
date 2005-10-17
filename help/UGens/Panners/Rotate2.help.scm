;;; (Rotate2 x y pos)			

;;; Rotate a sound field.  Rotate2 can be used for rotating an
;;; ambisonic B-format sound field around an axis.  Rotate2 does an
;;; equal power rotation so it also works well on stereo sounds.  It
;;; takes two audio inputs (x, y) and an angle control (pos).  It
;;; outputs two channels (x, y).

;;; It computes: 
 
;;;      xout = cos(angle) * xin + sin(angle) * yin; 
;;;      yout = cos(angle) * yin - sin(angle) * xin; 
 
;;; where angle = pos * pi, so that -1 becomes -pi and +1 becomes +pi.
;;; This allows you to use an LFSaw to do continuous rotation around a
;;; circle.
 
;;; The control pos is the angle to rotate around the circle from -1
;;; to +1. -1 is 180 degrees, -0.5 is left, 0 is forward, +0.5 is
;;; right, +1 is behind.


(let ((p (WhiteNoise.ar 0.05))
      (q (Add (LFSaw.ar 200 0 0.03)
	      (Add (LFSaw.ar 200.37 0 0.03)
		   (LFSaw.ar 201 0 0.03)))))
  (let* ((encoded (Add (PanB2.ar p -0.5) (PanB2.ar q -0.5)))
	 (rotated (Rotate2.ar (second encoded) (third encoded) (MouseX.kr -1 1)))
	 (decoded (DecodeB2.ar 4 (first encoded) (first rotated) (second rotated))))
    decoded))
 
;; Rotation of stereo sound, via LFO.

(Rotate2.ar (PinkNoise.ar 0.4)
	    (Mul (LFTri.ar 800) (LFPulse.kr 3 0 0.3 0.2))
	    (LFSaw.kr 0.1))

;; Rotation of stereo sound, via mouse.

(Rotate2.ar (Mix.fill 4 (lambda () (LFSaw.ar (random 198 202) 0 0.1)))
	    (Mul (SinOsc.ar 900) (LFPulse.kr 3 0 0.3 0.2))
	    (MouseX.kr 0 2))
