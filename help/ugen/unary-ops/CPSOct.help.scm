;; (CPSOct a)

;; Convert cycles per second to decimal octaves.

(mul (saw ar (OctCPS (CPSOct (xline kr 600 900 6 remove-synth)))) 0.2)
