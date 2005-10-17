;; (PV_MagSmear buffer bins)

;; Average magnitudes across bins.

;; Average a bin's magnitude with its neighbors. 

;; buffer - fft buffer.

;; bins   - number of bins to average on each side of bin. 
;;          As this number rises, so will CPU usage.

(define b 0)
(-><! s (/b_alloc b 2048 1))

(define (dup a) (list a a))

(let* ((in (LFSaw.ar 500 0 (Decay2.ar (Impulse.ar 2 0 0.2) 0.01 2)))
       (c0 (FFT.kr b in))
       (c1 (PV_MagSmear.kr c0 (MouseX.kr 0 100))))
  (Mul.ar 0.5 (dup (IFFT.ar c1))))

(define c 1)
(-><! s (/b_allocRead c (rsc-file "audio/metal.wav") 0 0))

(Mul.ar 
 0.5 
 (dup 
  (IFFT.ar 
   (PV_MagSmear.kr (FFT.kr b (PlayBuf.ar 1 c (BufRateScale.kr c) 'loop: 1)) 
		   (MouseX.kr 0 100)))))

