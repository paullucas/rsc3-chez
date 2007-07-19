;; (Convolution2 in bufnum trigger framesize)

;; Strict convolution with fixed kernel which can be updated using a
;; trigger signal.

;; in        - processing target

;; bufnum    - buffer index for the fixed kernel, may be modulated in
;;             combination with the trigger

;; trigger   - update the kernel on a change from <=0 to >0

;; framesize - size of FFT frame, must be a power of two. Convolution
;;             uses twice this number internally, maximum value you
;;             can give this argument is 2^16=65536. Note that it gets
;;             progressively more expensive to run for higher powers!
;;             512, 1024, 2048, 4096 standard.

;; Allocate three buffers

(for-each
 (lambda (b) 
   (->< s (/b_alloc b 2048 1)))
 (list 10 11 12))

(require (lib "1.ss" "srfi"))

(begin
 (for-each (lambda (n) (-> s (/b_set 10 (+ (* 400 n) 100) 1)))          (iota 3))
 (for-each (lambda (n) (-> s (/b_set 11 (+ (* 20  n) 10)  (rand 0 1)))) (iota 50))
 (for-each (lambda (n) (-> s (/b_set 12 (+ (* 40  n) 20)  1)))          (iota 20)))

(send-synth
 s "c"
 (letc ((k 0) (t 0))
   (let ((i (Impulse ar 1 0)))
     (Out 0 (Mul (Convolution2 i k t 2048) 0.5)))))

(-> s (/s_new "c" 1001 1 1 "k" 10))

(-> s (/n_set 1001 "k" 11))
(-> s (/n_set 1001 "t" 0))
(-> s (/n_set 1001 "t" 1))

(-> s (/n_set 1001 "k" 12))
(-> s (/n_set 1001 "t" 0))
(-> s (/n_set 1001 "t" 1))

(->< s (/b_zero 12))
(for-each (lambda (n) (-> s (/b_set 12 (+ (* 20  n) 10)  1))) (iota 40))
(-> s (/n_set 1001 "t" 0))
(-> s (/n_set 1001 "t" 1))

;; With soundfile.

(->< s (/b_allocRead 10 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

(let ((i (audioin (Mce 1))))
  (Out 0 (Mul (Convolution2 i 10 0 512) 0.5)))
