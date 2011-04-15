;; record scratcher (josh parmenter)

(let* ((dup (lambda (a) (mce2 a a)))
       (fn "/home/rohan/audio/metal.wav")
       (b 0)
       (x (mouse-x kr -10 10 linear 0.2))
       (dx (sub x (delay-n x 0.1 0.1)))
       (bdx (add (mouse-button kr 1 0 0.3) dx))
       (bdxr (mul bdx (buf-rate-scale kr b)))
       (scr (play-buf 1 b bdxr 0 0 loop)))
  (with-sc3
   (lambda (fd)
     (async fd (b-alloc-read b fn 0 0))
     (play fd (out 0 (dup scr))))))
