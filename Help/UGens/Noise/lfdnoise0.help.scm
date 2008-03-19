;; (lfdnoise0 rate freq)
;; (lfdnoise1 rate freq)
;; (lfdnoise3 rate freq)

;; lfdnoise0: Dynamic step noise. Like lfnoise0, it generates random
;; values at a rate given by the freq argument, with two differences:
;; no time quantization, and fast recovery from low freq values.

;; lfdnoise1: Dynamic ramp noise. Like lfnoise1, it generates linearly
;; interpolated random values at a rate given by the freq argument,
;; with two differences: no time quantization, and fast recovery from
;; low freq values.

;; lfdnoise3: Dynamic cubic noise. Like LFNoise3, it generates
;; linearly interpolated random values at a rate given by the freq
;; argument, with two differences: no time quantization, and fast
;; recovery from low freq values.

;; (lfnoise0,1,3 quantize to the nearest integer division of the
;; samplerate, and they poll the freq argument only when scheduled,
;; and thus seem to hang when freqs get very low).

;; If you don't need very high or very low freqs, or use fixed freqs,
;; lfnoise0,1,3 is more efficient.

;; Try wiggling mouse quickly; LFNoise frequently seems stuck,
;; LFDNoise changes smoothly.

(audition
 (out 0 (mul (lfnoise0 ar (mouse-x kr 0.1 1000 1 0.1)) 0.1)))

(audition
 (out 0 (mul (lfdnoise0 ar (mouse-x kr 0.1 1000 1 0.1)) 0.1)))

;; silent for 2 secs before going up in freq

(audition
 (out 0 (mul (lfnoise0 ar (xline kr 0.5 10000 3 remove-synth)) 0.1)))

(audition
 (out 0 (mul (lfdnoise0 ar (xline kr 0.5 10000 3 remove-synth)) 0.1)))

;; LFNoise quantizes time steps at high freqs, LFDNoise does not:

(audition
 (out 0 (mul (lfnoise0 ar (xline kr 1000 20000 10 remove-synth)) 0.1)))

(audition
 (out 0 (mul (lfdnoise0 ar (xline kr 1000 20000 10 remove-synth)) 0.1)))
