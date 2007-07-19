;; (PV_BinWipe bufferA bufferB wipe)

;; Combine low and high bins from two inputs

;; Copies low bins from one input and the high bins of the other.

;; bufferA - fft buffer A.
;; bufferB - fft buffer B.
;; wipe - can range between -1 and +1.

;; if wipe == 0 then the output is the same as inA.
;; if  wipe > 0 then it begins replacing with bins from inB from the bottom up.
;; if  wipe < 0 then it begins replacing with bins from inB from the top down.

(begin
  (->< s (/b_alloc 10 2048 1))
  (->< s (/b_alloc 11 2048 1))
  (->< s (/b_allocRead 12 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0)))

(let* ((a (Mul (WhiteNoise ar) 0.2))
       (b (Mul (SinOsc ar 100 0) 0.2))
       (f (FFT 10 a))
       (g (FFT 11 b))
       (h (PV_BinWipe f g (MouseX kr -1 1 0 0.1))))
  (Out 0 (Mul (IFFT h) 0.5)))

(let* ((a (Mul (WhiteNoise ar) 0.2))
       (b (PlayBuf 1 12 (BufRateScale kr 12) 0 0 1))
       (f (FFT 10 a))
       (g (FFT 11 b))
       (h (PV_BinWipe f g (MouseX kr -1 1 0 0.1))))
  (Out 0 (Mul (IFFT h) 0.5)))
