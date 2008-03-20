;; three-cpsw (rd)

(let* ((t (dust kr (mce2 12 18)))
       (f0 (trand 1 64 t))
       (f1 (lfnoise0 kr f0))
       (a  (trand 0.0 0.5 t))
       (dt (trand 0.975 1.025 t))
       (dh (trand 0.750 0.7505 t))
       (f (mul-add f1 (mce2 9000 12000) 9500))
       (o (add3 (saw ar f) (saw ar (mul f dh)) (saw ar (mul f dt)))))
  (audition (out 0 (clip2 (mul o a) 0.75))))