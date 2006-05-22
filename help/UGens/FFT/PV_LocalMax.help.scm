;; (PV_LocalMax buffer threshold)

;; Pass bins which are a local maximum

;; Passes only bins whose magnitude is above a threshold and above
;; their nearest neighbors.

;; buffer - fft buffer.
;; threshold - magnitude threshold.

(begin
  (->< s (/b_alloc 10 2048 1))
  (->< s (/b_allocRead 12 (rsc-file "audio/metal.wav") 0 0)))

(let* ((a (PlayBuf ar 1 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT 10 a))
       (h (PV_LocalMax f (MouseX kr 0 100 0 0.1))))
  (Out 0 (Mul (IFFT h) 0.5)))
