(module fft scheme/base

(require (only-in srfi/1 iota)
	 "../collection/list.scm"
	 "../graphdef/mce.scm"
	 "../ugen/specialized.scm")

(provide packfft-data packfft-data*
	 unpack-fft
	 pvcollect)

;; [m] -> [p] -> [#, m, p...]
(define (packfft-data m p)
  (make-mce (cons (* 2 (length m)) (splice (map list m p)))))

;; [[m, p]] -> [#, m, p...]
(define (packfft-data* mp)
  (make-mce (cons (* 2 (length mp)) (splice mp))))

(define (from-to f t)
  (iota (+ 1 (- t f)) f))

(define (unpack-fft c nf from to mp?)
  (map (lambda (i) 
	 (Unpack1FFT c nf i mp?))
       (from-to from to)))

(define (pvcollect c nf f from to z?)
  (let* ((m (unpack-fft c nf from to 0))
	 (p (unpack-fft c nf from to 1))
	 (i (from-to from to))
	 (e (map f m p i)))
    (PackFFT c nf from to z? (packfft-data* e))))

)


