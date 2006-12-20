;; (Median length in) 

;; Median filter.

;; Signal with impulse noise.

(Median 3 (Add (Mul (Saw ar 500) 0.1) (Mul (Dust2 ar 100) 0.9)))

;; The median length can be increased for longer duration noise.

(Median 5 (Add (Mul (Saw ar 500) 0.1) (LPZ1 (Mul (Dust2 ar 100) 0.9))))

;; Long Median filters begin chopping off the peaks of the waveform

(let ((x (Mul (SinOsc ar 1000 0) 0.2)))
  (Mce x (Median 31 x)))

;; Another noise reduction application. Use Median filter for high
;; frequency noise.  Use LeakDC for low frequency noise.

(let* ((s0 (MulAdd (WhiteNoise ar) 0.1 (Mul (SinOsc ar 800 0) 0.1)))
       (s1 (Median 31 s0)))
  (LeakDC s1 0.9))
