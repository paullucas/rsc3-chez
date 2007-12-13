;; (audioin channel)

;; Reads audio from the sound input hardware.  

;; channel - input channel number to read, counting from one, can be
;; Mce.

(audition (Out 0 (audioin 1)))

(audition (Out 0 (audioin (Mce 1 2))))

(audition (Out 0 (audioin (Mce 1 3 2 4))))
