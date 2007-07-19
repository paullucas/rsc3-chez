;; (Formant rate fundfreq formfreq bwfreq)

;; Formant oscillator. Generates a set of harmonics around a formant
;; frequency at a given fundamental frequency.

;; Modulate fundamental frequency, formant frequency stays constant.

(Mul (Formant ar (XLine kr 400 1000 8 removeSynth) 2000 800) 0.125)

;; Modulate formant frequency, fundamental frequency stays constant.

(Mul (Formant ar (Mce 200 300) (XLine kr 400 4000 8 removeSynth) 200) 0.125)

;; Modulate width frequency, other frequencies stay constant.

(Mul (Formant ar 400 2000 (XLine kr 800 8000 8 removeSynth)) 0.125)
