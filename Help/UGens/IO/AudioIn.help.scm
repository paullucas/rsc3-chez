;; (audioin channel)

;; Reads audio from the sound input hardware.  

;; channel - input channel number to read, counting from one, can be
;; Mce.

(audioin 1)

(audioin (Mce 1 2))

(audioin (Mce 1 3 2 4))
