;; (TWChoose trig array weights normalize)

;; The output is selected randomly on recieving a trigger from an
;; array of inputs.  The weights of this choice are determined from
;; the weights array.  If normalize is set to 1 the weights are
;; continuously normalized, which means an extra calculation overhead.
;; When using fixed values the normalizeSum method can be used to
;; normalize the values.  TWChoose is a composite of TWindex and
;; Select

(let ((a (Mce (SinOsc ar 220 0)
	      (Saw ar 440)
	      (Pulse ar 110 0.1))))
  (Mul (TWChoose (Dust ar (MouseX kr 1 1000 1 0.1))
		 a
		 (Mce 0.6 0.05 0.05)
		 1)
       0.1))

;; Note: all the ugens are continously running. This may not be the
;; most efficient way if each input is cpu-expensive.
