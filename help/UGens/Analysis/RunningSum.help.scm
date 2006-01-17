;; (RunningSum in numsamp)

;; A running sum over a user specified number of samples, useful for
;; running RMS power windowing.

;; in      - Input signal
;; numsamp - How many samples to take the running sum over 
;;           (initialisation rate)

(Mul (RunningSum (audioin (Mce 1 2)) 40)
     1/40)
