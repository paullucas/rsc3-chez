;; (PV_BinScramble buffer wipe width trig)

;; Randomizes the order of the bins.  The trigger will select a new
;; random ordering.

;; buffer - fft buffer.

;; wipe   - scrambles more bins as wipe moves from zero to one.

;; width  - a value from zero to one, indicating the maximum randomized
;;          distance of a bin from its original location in the spectrum.

;; trig   - a trigger selects a new random ordering.

(begin
  (->< s (/b_alloc 10 2048 1))
  (->< s (/b_allocRead 12 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0)))

(let* ((a (PlayBuf 1 12 (BufRateScale kr 12) 1 0 1))
       (f (FFT 10 a))
       (g (PV_BinScramble f
			  (MouseX kr 0.0 1.0 0 0.1)
			  (MouseY kr 0.0 1.0 0 0.1)
			  (Impulse kr 4 0)))
       (h (IFFT g)))
  (Out 0 (Mul 0.5 (Mce h h))))
