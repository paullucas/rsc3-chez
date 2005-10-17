;; (PV_MagFreeze buffer freeze)

;; Freezes magnitudes at current levels when freeze > 0.

;; buffer = fft buffer.  freeze = if freeze > 0 then magnitudes are
;; frozen at current levels.

(define b 0)
(-><! s (/b_alloc b 2048 1))

(define (dup a) (list a a))

(dup
 (Mul.ar 
  0.25 
  (IFFT.ar 
   (PV_MagFreeze.kr
    (FFT.kr b (SinOsc.ar (LFNoise1.kr 5.2 250 400)))
    (SinOsc.kr 0.2)))))

(define c 1)
(-><! s (/b_allocRead c (rsc-file "audio/metal.wav") 0 0))

(dup 
 (Mul.ar 
  0.5
  (IFFT.ar 
   (PV_MagFreeze.kr 
    (FFT.kr b (PlayBuf.ar 1 c (BufRateScale.kr c) 'loop: 1)) 
    (GT.kr (MouseY.kr 0.0 1.0) 0.5)))))
