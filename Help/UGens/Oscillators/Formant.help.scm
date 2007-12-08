;; (Formant rate fundfreq formfreq bwfreq)

;; Formant oscillator. Generates a set of harmonics around a formant
;; frequency at a given fundamental frequency.

;; Modulate fundamental frequency, formant frequency stays constant.

(audition
 (let ((f (XLine kr 400 1000 8 removeSynth)))
   (Out 0 (Mul (Formant ar f 2000 800) 0.125))))

;; Modulate formant frequency, fundamental frequency stays constant.

(audition
 (let ((f (XLine kr 400 4000 8 removeSynth)))
   (Out 0 (Mul (Formant ar (Mce 200 300) f 200) 0.125))))

;; Modulate width frequency, other frequencies stay constant.

(audition
 (let ((w (XLine kr 800 8000 8 removeSynth)))
   (Out 0 (Mul (Formant ar 400 2000 w) 0.125))))
