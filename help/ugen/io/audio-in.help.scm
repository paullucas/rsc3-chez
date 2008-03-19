;; (audio-in channel)

;; Reads audio from the sound input hardware.  

;; channel - input channel number to read, counting from one, can be
;; Mce.

(audition (out 0 (audio-in 1)))

(audition (out 0 (audio-in (Mce 1 2))))

(audition (out 0 (audio-in (Mce 1 3 2 4))))
