;; (CPSMIDI a)

;; Convert cycles per second to MIDI note.

(Mul (Saw ar (MIDICPS (CPSMIDI (Line kr 600 900 5 removeSynth)))) 0.1)
