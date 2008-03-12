;; (pvcollect chain numframes func frombin tobin zeroothers)

;; Process each bin of an FFT chain separately.

;; pvcollect applies function func to each bin of an FFT chain. func
;; should be a function that takes magnitude, phase, index as inputs
;; and returns a resulting [magnitude, phase].

;; The "index" is the integer bin number, starting at 0 for DC. You
;; can optionally ignore the phase and only return a single
;; (magnitude) value, in which case the phase is assumed to be left
;; unchanged.

;; frombin, tobin, and zeroothers are optional arguments which limit
;; the processing to a specified integer range of FFT bins. If
;; zeroothers is set to 1 then bins outside of the range being
;; processed are silenced.

;; Note that this procedure can be relatively CPU-heavy, depending on
;; how you use it.

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

(define spectral-delay
  (lambda (m p _)
    (let ((v (range (LFPar kr 0.5 0) 0.1 1)))
      (list (Add m (DelayN m 1 v)) p))))

(define (bpf-sweep nf)
  (lambda (m p i)
    (let ((e (Abs (Sub i (range (LFPar kr 0.1 0) 2 (/ nf 20))))))
      (list (Mul (LT e 10) m) p))))

(with-sc3
 (lambda (fd)
   (async fd (/b_alloc 10 1024 1))
   (async fd (/b_allocRead 11 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((nf 1024)
       (i (PlayBuf 1 11 (BufRateScale kr 11) 1 0 1))
       (c1 (FFT* 10 i))
       (c2 (pvcollect c1 nf spectral-delay 0 250 0)))
  (audition (Out 0 (Mul 0.1 (IFFT* c2)))))
