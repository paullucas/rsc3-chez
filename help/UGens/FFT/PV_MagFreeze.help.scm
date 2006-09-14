;; (PV_MagFreeze buffer freeze)

;; Freezes magnitudes at current levels when freeze > 0.

;; buffer = fft buffer.  freeze = if freeze > 0 then magnitudes are
;; frozen at current levels.

(define b 0)

(->< s (/b_alloc b 2048 1))

(define (Dup a) (Mce a a))

(Dup
 (Mul 
  0.25 
  (IFFT 
   (PV_MagFreeze
    (FFT b (SinOsc ar (MulAdd (LFNoise1 kr 5.2) 250 400) 0))
    (SinOsc kr 0.2 0)))))

(define c 1)

(->< s (/b_allocRead c "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

(Dup 
 (Mul 
  0.5
  (IFFT 
   (PV_MagFreeze 
    (FFT b (PlayBuf ar 1 c (BufRateScale kr c) 1 0 1)) 
    (GT (MouseY kr 0 1 0 0.1) 0.5)))))
