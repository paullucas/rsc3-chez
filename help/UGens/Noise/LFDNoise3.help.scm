;; (LFDNoise3 freq)

;; Dynamic cubic noise. Like LFNoise3, it generates linearly
;; interpolated random values at a rate given by the freq argument,
;; with two differences: no time quantization, and fast recovery from
;; low freq values.

;; (LFNoise0,1,2 quantize to the nearest integer division of the
;; samplerate, and they poll the freq argument only when scheduled,
;; and thus seem to hang when freqs get very low).

;; If you don't need very high or very low freqs, or use fixed freqs,
;; LFNoise2 is more efficient.

;; Try wiggling mouse quickly; LFNoise frequently seems stuck,
;; LFDNoise changes smoothly.

(SinOsc ar (LFNoise2 ar (MouseX kr 0.1 1000 1) 200 500) 0 0.2)

(SinOsc ar (LFDNoise3 ar (MouseX kr 0.1 1000 1) 200 500) 0 0.2)

;; LFNoise quantizes time steps at high freqs, LFDNoise does not:

(LFNoise2 ar (XLine kr 1000 20000 10) 0.1)

(LFDNoise3 ar (XLine kr 1000 20000 10) 0.1)
