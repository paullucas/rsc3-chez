;; (Slope in)

;; Slope of signal.  Measures the rate of change per second of a
;; signal.  Formula implemented is:

;; out[i] = (in[i] - in[i-1]) * sampling_rate

;; in - input signal to measure.

;; a = quadratic noise, b = first derivative line segments, c = second
;; derivative constant segments

(let* ((r 2)
       (a (LFNoise2 kr r))
       (scale (Recip r))
       (b (Mul (Slope a) scale))
       (c (Mul (Slope b) (Squared scale))))
  (mix (Mul (SinOsc ar (MulAdd (Mce a b c) 220 220) 0) 1/3)))
