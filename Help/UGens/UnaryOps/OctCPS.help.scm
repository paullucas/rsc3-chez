;; (OctCPS a)

;; Convert decimal octaves to cycles per second.

(Mul (Saw ar (OctCPS (Line kr 2 9 6 removeSynth))) 0.2)

(Mul (Saw ar (OctCPS (Round (Line kr 2 9 6 removeSynth) (/ 1 12)))) 0.2)
