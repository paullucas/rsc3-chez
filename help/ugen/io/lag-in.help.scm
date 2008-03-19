;; (lagin numChannels bus lag)

;; Set bus 10.

(with-sc3 
 (lambda (fd) 
   (send fd (/c_set 10 (rand 200 8000)))))

;; Smooth a control rate input signal.

(audition (out 0 (mul (sin-osc ar (lagin 1 10 1) 0) 0.1)))
