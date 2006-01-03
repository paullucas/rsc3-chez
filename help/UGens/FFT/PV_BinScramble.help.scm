;; (PV_BinScramble buffer wipe width trig)

;; Randomizes the order of the bins.  The trigger will select a new
;; random ordering.

;; buffer - fft buffer.

;; wipe - scrambles more bins as wipe moves from zero to one.

;; width - a value from zero to one, indicating the maximum randomized
;; distance of a bin from its original location in the spectrum.

;; trig - a trigger selects a new random ordering.

(define b 0)
(-><! s (/b_alloc b 2048 1))

(define c 1)
(-><! s (/b_allocRead c (rsc-file "audio/metal.wav") 0 0))

(let* ((in (PlayBuf ar 1 c (BufRateScale kr c) 'loop: 1))
       (c0 (FFT kr b in))
       (c1 (PV_BinScramble kr c0 
			      (MouseX kr 0.0 1.0) 
			      0.1
			      (GT kr (MouseY kr 0.0 1.0) 0.5)))
       (c2 (IFFT ar c1)))
  (Out ar 0 (Mul ar 0.5 (list c2 c2))))
