;; (PV_BinScramble buffer wipe width trig)

;; Randomizes the order of the bins.  The trigger will select a new
;; random ordering.

;; buffer - fft buffer.

;; wipe - scrambles more bins as wipe moves from zero to one.

;; width - a value from zero to one, indicating the maximum randomized
;; distance of a bin from its original location in the spectrum.

;; trig - a trigger selects a new random ordering.

(define b 0)
(->< s (/b_alloc b 2048 1))

(define c 1)
(->< s (/b_allocRead c (rsc-file "audio/metal.wav") 0 0))

(let* ((in (PlayBuf ar 1 c (BufRateScale kr c) 1 0 1))
       (c0 (FFT b in))
       (c1 (PV_BinScramble c0 
			   (MouseX kr 0.0 1.0 0 0.1) 
			   0.1
			   (GT (MouseY kr 0.0 1.0 0 0.1) 0.5)))
       (c2 (IFFT c1)))
  (Out 0 (Mul 0.5 (Mce c2 c2))))
