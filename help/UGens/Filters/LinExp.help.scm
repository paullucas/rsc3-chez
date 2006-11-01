;; (LinExp in srclo srchi dstlo dsthi)

;; Map a linear range to an exponential range.

;; in    - input to convert.
;; srclo - lower limit of input range.
;; srchi - upper limit of input range.
;; dstlo - lower limit of output range.
;; dsthi - upper limit of output range.

(Mul (SinOsc ar (LinExp (MouseX kr 0 1 0 0.1) 0 1 440 660) 0)
     (LinExp (MouseY kr 0 1 0 0.1) 0 1 0.01 0.25))
