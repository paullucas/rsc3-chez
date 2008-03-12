;; (PackFFT chain bufsize frombin tobin zeroothers magsphases)

;; Pack separate demand-rate FFT bin streams into an FFT chain buffer

;; Takes a length-prefixed array of magnitudes and phases, and packs
;; them into an FFT buffer ready for transforming back into
;; time-domain audio using IFFT.

;; Most people won't need to use this directly - instead, use
;; pvcollect, pvcalc, or pvcalc2.

;; The input data is magsphases, which should be a flat array
;; containing magnitude and phase of all bins in ascending order.
;; e.g. [mag0, phase0, mag1, phase1, mag2, phase2, ... magN, phaseN]
;; This input is typically demand-rate.

;; This is technically similar to Demand or Duty in that it calls
;; demand-rate UGens further up the graph to process the values,
;; eventually calling UnpackFFT. These two ends of the process must in
;; most cases see the same chain...! Otherwise behaviour is undefined
;; and, who knows, possibly unpleasant.

;; frombin and tobin allow you to fill the supplied data only into a
;; subset of the FFT bins (i.e. a single delimited frequency band),
;; set zeroothers to 1 to zero all the magnitudes outside this band
;; (otherwise they stay intact).

;; For usage examples, see UnpackFFT, but also pvcollect, pvcalc,
;; pvcalc2.

;; Here's an unusual example which uses PackFFT without using
;; UnpackFFT first - essentially creating our FFT data from scratch.

(with-sc3
 (lambda (fd)
   (send fd (/b_alloc 10 512 1))))

(let* ((n 100)
       (n* (enum-from-to 1 n))
       (m1 (map (lambda (_) (range (FSinOsc kr (ExpRand 0.1 1) 0) 0 1)) n*))
       (square (lambda (a) (* a a)))
       (m2 (map Mul m1 (map square (iota n 1.0 (- (/ 1.0 n))))))
       (i (map (lambda (_) (LFPulse kr (Pow 2 (IRand -3 5)) 0 0.3)) n*))
       (m3 (map Mul m2 i))
       (p (replicate n 0.0))
       (c1 (FFT* 10 (FSinOsc ar 440 0)))
       (c2 (PackFFT c1 512 0 (- n 1) 1 (packfft-data m3 p)))
       (s (IFFT* c2)))
  (audition (Out 0 (Mce s s))))
