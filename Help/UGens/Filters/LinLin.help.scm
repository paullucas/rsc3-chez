;; (LinLin in srclo srchi dstlo dsthi)

;; Map a linear range to another linear range.

;; in    - input to convert            - kr, ar
;; srclo - lower limit of input range  - ir
;; srchi - upper limit of input range  - ir
;; dstlo - lower limit of output range - ir
;; dsthi - upper limit of output range - ir

(audition
 (Out 0 (Mul (SinOsc ar (LinLin (MouseX kr 0 1 0 0.1) 0 1 440 660) 0)
	     (LinLin (MouseY kr 0 1 0 0.1) 0 1 0.01 0.25))))
