;; (median length in) 

;; median filter.

;; Signal with impulse noise.

(median 3 (add (mul (saw ar 500) 0.1) (Mul (dust2 ar 100) 0.9)))

;; The median length can be increased for longer duration noise.

(median 5 (add (mul (saw ar 500) 0.1) (lpz1 (Mul (dust2 ar 100) 0.9))))

;; Long median filters begin chopping off the peaks of the waveform

(let ((x (mul (sin-osc ar 1000 0) 0.2)))
  (Mce x (median 31 x)))

;; Another noise reduction application. Use median filter for high
;; frequency noise.  Use leak-dc for low frequency noise.

(let* ((s0 (mul-add (white-noise ar) 0.1 (mul (sin-osc ar 800 0) 0.1)))
       (s1 (median 31 s0)))
  (leak-dc s1 0.9))
