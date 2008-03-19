;; (CPSMIDI a)

;; Convert cycles per second to MIDI note.

(mul (saw ar (MIDICPS (CPSMIDI (line kr 600 900 5 remove-synth)))) 0.1)
