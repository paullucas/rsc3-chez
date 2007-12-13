;; (PV_MagFreeze buffer freeze)

;; Freeze magnitudes.  Freezes magnitudes at current levels when
;; freeze > 0.

;; buffer - fft buffer.
;; freeze - if > 0 then magnitudes are frozen at current levels.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))
   (->< fd (/b_allocRead 12 "/home/rohan/audio/metal.wav" 0 0))))

(let ((dup (lambda (a) (Mce a a)))
      (s (SinOsc ar (MulAdd (LFNoise1 kr 5.2) 250 400) 0))
      (f (SinOsc kr 0.2 0)))
  (audition (Out 0 (dup (Mul 0.25 (IFFT* (PV_MagFreeze (FFT* 10 s) f)))))))

(let ((dup (lambda (a) (Mce a a)))
      (s (PlayBuf 1 12 (BufRateScale kr 12) 1 0 1))
      (f (GT (MouseY kr 0 1 0 0.1) 0.5)))
  (audition (Out 0 (dup (Mul 0.25 (IFFT* (PV_MagFreeze (FFT* 10 s) f)))))))
