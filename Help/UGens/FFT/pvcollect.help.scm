(require srfi/1)

(define no-op
  (lambda (m p _)
    (list m p)))

(define rand-phase
  (lambda (m p _)
    (list m (Rand 0 3.14))))

(define noise-phase
  (lambda (m p _)
    (list m (range (LFNoise0 kr 3) 0 3.14))))

(define combf
  (lambda (m p i)
    (list (if (= (modulo i 7) 0) m 0) p)))

(define noise-mag
  (lambda (m p _)
    (list (Mul (GT (LFNoise0 kr 10) 0) m) p)))

(define (spectral-delay v)
  (lambda (m p _)
    (list (Add m (DelayN m 1 v)) p)))

(define (bpf-sweep nf)
  (lambda (m p i)
    (let ((e (Abs (Sub i (range (LFPar kr 0.1 0) 2 (/ nf 20))))))
      (list (Mul (LT e 10) m) p))))

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 1024 1))
   (->< fd (/b_allocRead 11 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((f bpf-sweep)
       (nf 1024)
       (i (PlayBuf 1 11 (BufRateScale kr 11) 1 0 1))
       (c1 (FFT* 10 i))
       (v (range (LFPar kr 0.5 0) 0.1 1))
       (c2 (pvcollect c1 nf (spectral-delay v) 0 250 0)))
  (audition (Out 0 (Mul 0.1 (IFFT* c2)))))
