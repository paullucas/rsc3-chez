;; (OctCPS a)

;; Convert decimal octaves to cycles per second.

(mul (saw ar (OctCPS (line kr 2 9 6 remove-synth))) 0.2)

(mul (saw ar (OctCPS (Round (line kr 2 9 6 remove-synth) (/ 1 12)))) 0.2)
