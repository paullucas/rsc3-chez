;; (PV_BrickWall buffer wipe)

;; `wipe' = a unit signal, from -1 to 0 the UGen acts as a low-pass
;; filter, from 0 to 1 it acts as a high pass filter.

(->< s (/b_alloc 10 2048 1))

(IFFT (PV_BrickWall (FFT 10 (Mul (WhiteNoise ar) 0.2))
		    (MouseX kr -1 1 0 0.1)))
