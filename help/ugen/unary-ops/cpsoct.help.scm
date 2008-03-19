;; (cpsoct a)

;; Convert cycles per second to decimal octaves.

(audition 
   (out 0 (mul (saw ar (octcps (cpsoct (xline kr 600 900 6 remove-synth)))) 0.2)))
