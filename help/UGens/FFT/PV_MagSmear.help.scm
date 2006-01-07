;; (PV_MagSmear buffer bins)

;; Average a bin's magnitude with its neighbors. 

;; buffer - fft buffer.

;; bins   - number of bins to average on each side of bin. 
;;          As this number rises, so will CPU usage.

(define b 0)

(-><! s (/b_alloc b 2048 1))

(define (Dup a) (Mce a a))

(let* ((in (Mul (LFSaw ar 500 0) (Decay2 (Mul (Impulse ar 2 0) 0.2) 0.01 2)))
       (c0 (FFT b in))
       (c1 (PV_MagSmear c0 (MouseX kr 0 100 0 0.1))))
  (Mul 0.5 (Dup (IFFT c1))))

(define c 1)

(-><! s (/b_allocRead c (rsc-file "audio/metal.wav") 0 0))

(Mul 
 0.5 
 (Dup 
  (IFFT 
   (PV_MagSmear (FFT b (PlayBuf ar 1 c (BufRateScale kr c) 1 0 1))
		(MouseX kr 0 100 0 0.1)))))

