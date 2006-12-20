;; (LFDNoise0 rate freq)
;; (LFDNoise1 rate freq)
;; (LFDNoise3 rate freq)

;; LFDNoise0: Dynamic step noise. Like LFNoise0, it generates random
;; values at a rate given by the freq argument, with two differences:
;; no time quantization, and fast recovery from low freq values.

;; LFDNoise1: Dynamic ramp noise. Like LFNoise1, it generates linearly
;; interpolated random values at a rate given by the freq argument,
;; with two differences: no time quantization, and fast recovery from
;; low freq values.

;; LFDNoise3: Dynamic cubic noise. Like LFNoise3, it generates
;; linearly interpolated random values at a rate given by the freq
;; argument, with two differences: no time quantization, and fast
;; recovery from low freq values.

;; (LFNoise0,1,3 quantize to the nearest integer division of the
;; samplerate, and they poll the freq argument only when scheduled,
;; and thus seem to hang when freqs get very low).

;; If you don't need very high or very low freqs, or use fixed freqs,
;; LFNoise0,1,3 is more efficient.

;; Try wiggling mouse quickly; LFNoise frequently seems stuck,
;; LFDNoise changes smoothly.

(Mul (LFNoise0 ar (MouseX kr 0.1 1000 1 0.1)) 0.1)
(Mul (LFDNoise0 ar (MouseX kr 0.1 1000 1 0.1)) 0.1)

;; silent for 2 secs before going up in freq

(Mul (LFNoise0 ar (XLine kr 0.5 10000 3 removeSynth)) 0.1)
(Mul (LFDNoise0 ar (XLine kr 0.5 10000 3 removeSynth)) 0.1)

;; LFNoise quantizes time steps at high freqs, LFDNoise does not:

(Mul (LFNoise0 ar (XLine kr 1000 20000 10 removeSynth)) 0.1)
(Mul (LFDNoise0 ar (XLine kr 1000 20000 10 removeSynth)) 0.1)
