;; (LagIn numChannels bus lag)

;; Set bus 10.

(with-sc3 (lambda (fd) (-> fd (/c_set 10 (rand 200 8000)))))

;; Smooth a control rate input signal.

(audition (Out 0 (Mul (SinOsc ar (LagIn 1 10 1) 0) 0.1)))
