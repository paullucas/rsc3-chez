;; (MIDICPS a)

;; Convert MIDI note to cycles per second.

(mul (saw ar (MIDICPS (line kr 24 108 10 remove-synth))) 0.2)
