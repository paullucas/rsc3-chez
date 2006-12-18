;; (Convolution in kernel framesize)

;; Strict convolution of two continuously changing inputs. Also see
;; [Convolution2] for a cheaper CPU cost alternative for the case of a
;; fixed kernel which can be changed with a trigger message.

;; in        - processing target
;; kernel    - processing kernel.
;; framesize - size of FFT frame, must be a power of two

(let ((input (audioin (Mce 1 2)))
      (kernel (WhiteNoise ar)))
  (Mul (Convolution input kernel 2048) 0.1))

(require (only (lib "1.ss" "srfi") iota))

(let ((a 2048)
      (b 0))
  (->< s (/b_alloc b a 1))
  (-> s (/b_set b 0 1.0))
  (for-each (lambda (n) 
	      (-> s (/b_set b (randi 0 a) (rand 0.0 1.0))))
	    (iota 100))
  (Mul (Convolution 
	(audioin (Mce 1 2)) 
	(PlayBuf 1 ar b (BufRateScale kr b) 1 0 1)
	(* 2 a))
       0.2))
