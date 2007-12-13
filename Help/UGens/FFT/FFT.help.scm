;; (FFT buffer in hop wintype active)
;; (FFT* b i) => (FFT b i 0.5 0 1)

;; Fast fourier transform.  The fast fourier transform analyzes the
;; frequency content of a signal.  FFT uses a local buffer for holding
;; the buffered audio.  The inverse transform, IFFT, reconstructs an
;; audio signal.
 
;; Note that the UGens the SC3 language provides do not use rate
;; extensions, since only a single rate is valid for each UGen class.
;; The FFT and PV_ UGens must run at control rate, the IFFT UGen at
;; audio rate.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))))

(let* ((s (Mul (WhiteNoise ar) 0.05))
       (c (FFT* 10 s)))
  (audition (Out 0 (IFFT* c))))

(let* ((f1 (Squared (MulAdd (SinOsc kr 0.08 0) 6 6.2)))
       (f2 (MulAdd (SinOsc kr f1 0) 100 800))
       (s (SinOsc ar f2 0)))
  (audition (Out 0 (IFFT* (FFT* 10 s)))))
