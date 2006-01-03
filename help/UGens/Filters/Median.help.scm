;; (Median length in) 

;; Median filter.

;; Signal with impulse noise.

(Median ar 3 (Add (Saw ar 500 0.1) (Dust2 ar 100 0.9)))

;; The median length can be increased for longer duration noise.

(Median ar 5 (Add (Saw ar 500 0.1) (LPZ1 ar (Dust2 ar 100 0.9))))

;; Long Median filters begin chopping off the peaks of the waveform

(let ((x (SinOsc ar 1000 0 0.2)))
  (list x (Median ar 31 x)))

;; Another noise reduction application. Use Median filter for high
;; frequency noise.  Use LeakDC for low frequency noise.

(LeakDC ar (Median ar 31 (Add (WhiteNoise ar 0.1) (SinOsc ar 800 0 0.1))) 0.9)
