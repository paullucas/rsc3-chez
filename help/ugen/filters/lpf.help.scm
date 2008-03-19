;; (lpf in freq)

;; Second order Butterworth lowpass filter.

(lpf (mul (saw ar 200) 0.1)
     (mul-add (fsin-osc kr (xline kr 0.7 300 20 remove-synth) 0) 3600 4000))
