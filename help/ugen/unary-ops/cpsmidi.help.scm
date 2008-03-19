;; (cpsmidi a)

;; Convert cycles per second to MIDI note.

(let ((f (line kr 600 900 5 remove-synth)))
  (audition 
   (out 0 (mul (saw ar (midicps (cpsmidi f))) 0.1))))
