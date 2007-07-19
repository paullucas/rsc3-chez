;; (MIDICPS a)

;; Convert MIDI note to cycles per second.

(Mul (Saw ar (MIDICPS (Line kr 24 108 10 removeSynth))) 0.2)
