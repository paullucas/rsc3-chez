;; (octcps a)

;; Convert decimal octaves to cycles per second.

(audition 
   (out 0 (mul (saw ar (octcps (line kr 2 9 6 remove-synth))) 0.2)))

(audition 
   (out 0 (mul (saw ar (octcps (u:round (line kr 2 9 6 remove-synth) (/ 1 12)))) 0.2)))
