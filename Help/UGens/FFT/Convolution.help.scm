;; (Convolution in kernel framesize)

;; Strict convolution of two continuously changing inputs. Also see
;; [Convolution2] for a cheaper CPU cost alternative for the case of a
;; fixed kernel which can be changed with a trigger message.

;; in        - processing target
;; kernel    - processing kernel.
;; framesize - size of FFT frame, must be a power of two

(audition
 (let ((input (audioin (Mce 1 2)))
       (kernel (WhiteNoise ar)))
   (Mul (Convolution input kernel 2048) 0.1)))

(require srfi/1)

(let ((a 2048)
      (b 0))
  (with-sc3
   (lambda (fd)
     (->< fd (/b_alloc b a 1))
     (-> fd (/b_set b 0 1.0))
     (for-each (lambda (n) 
		 (-> fd (/b_set b (randi 0 a) (rand 0.0 1.0))))
	       (iota 100))))
  (audition (Mul (Convolution 
		  (audioin (Mce 1 2)) 
		  (PlayBuf 1 b (BufRateScale kr b) 1 0 1)
		  (* 2 a))
		 0.2)))
