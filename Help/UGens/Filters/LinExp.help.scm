;; (LinExp in srclo srchi dstlo dsthi)

;; Map a linear range to an exponential range.

;; in    - input to convert            - kr, ar
;; srclo - lower limit of input range  - ir
;; srchi - upper limit of input range  - ir
;; dstlo - lower limit of output range - ir
;; dsthi - upper limit of output range - ir

(Mul (SinOsc ar (LinExp (MouseX kr 0 1 0 0.1) 0 1 440 660) 0)
     (LinExp (MouseY kr 0 1 0 0.1) 0 1 0.01 0.25))