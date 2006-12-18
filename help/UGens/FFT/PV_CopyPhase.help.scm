;; (PV_CopyPhase bufferA bufferB)

;; Combines magnitudes of first input and phases of the second input.

(begin
  (->< s (/b_alloc 10 2048 1))
  (->< s (/b_alloc 11 2048 1))
  (->< s (/b_allocRead 12 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0)))

(let* ((a (Mul (WhiteNoise ar) 0.2))
       (b (Mul (SinOsc ar 100 0) 0.2))
       (f (FFT 10 a))
       (g (FFT 11 b))
       (h (PV_CopyPhase f g)))
  (Out 0 (Mul (IFFT h) 0.5)))

(let* ((a (Mul (WhiteNoise ar) 0.2))
       (b (PlayBuf 1 ar 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT 10 a))
       (g (FFT 11 b))
       (h (PV_CopyPhase f g)))
  (Out 0 (Mul (IFFT h) 0.5)))
