;; (CPSOct a)

;; Convert cycles per second to decimal octaves.

(Mul (Saw ar (OctCPS (CPSOct (XLine kr 600 900 6 removeSynth)))) 0.2)
