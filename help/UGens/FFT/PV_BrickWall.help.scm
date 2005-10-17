;; (PV_BrickWall buffer wipe)

;; `wipe' = a unit signal, from -1 to 0 the UGen acts as a low-pass
;; filter, from 0 to 1 it acts as a high pass filter.

(define b 0)
(-><! s (/b_alloc b 2048 1))

(IFFT.ar (PV_BrickWall.kr (FFT.kr b (WhiteNoise.ar 0.2))
			  (MouseX.kr -1 1)))
