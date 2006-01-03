;; (LinLin in srclo srchi dstlo dsthi)

;; Map a linear range to another linear range.

;; in    - input to convert.
;; srclo - lower limit of input range.
;; srchi - upper limit of input range.
;; dstlo - lower limit of output range.
;; dsthi - upper limit of output range.

(SinOsc ar (LinLin kr (MouseX kr 0 1) 0 1 440 660) 
	   0 
	   (LinLin kr (MouseY kr 0 1) 0 1 0.05 0.25))
