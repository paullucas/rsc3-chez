;; (pv-rect-comb buffer numTeeth phase width)

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 2048 1))))

(let* ((dup (lambda (a) (Mce a a)))
       (x (mouse-x kr 0 0.5 0 0.1))
       (y (mouse-y kr 0 0.5 0 0.1))
       (n (dup (mul (white-noise ar) 0.3)))
       (c (pv-rect-comb (fft* 10 n) 8 x y)))
  (audition (out 0 (Ifft* c))))

(let* ((dup (lambda (a) (Mce a a)))
       (p (mul-add (lftri kr 0.097 0) 0.4 0.5))
       (w (mul-add (lftri kr 0.24 0) -0.5 0.5))
       (n (dup (mul (white-noise ar) 0.3)))
       (c (pv-rect-comb (fft* 10 n) 8 p w)))
  (audition (out 0 (Ifft* c))))
