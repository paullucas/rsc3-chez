;; (Formant fundfreq formfreq bwfreq)

;; Formant oscillator. Generates a set of harmonics around a formant
;; frequency at a given fundamental frequency.

;; Modulate fundamental frequency, formant frequency stays constant.

(Formant.ar (XLine.kr 400 1000 8) 2000 800 0.125)

;; Modulate formant frequency, fundamental frequency stays constant.

(Formant.ar '(200 300 400 500) (XLine.kr 400 4000 8) 200 0.125)

;; Modulate width frequency, other frequencies stay constant.

(Formant.ar 400 2000 (XLine.kr 800 8000 8) 0.125)

