;; seqr (rd)

(let* ((nfreq
        (lambda (n l r)
          (map midi-cps (map floor (replicate-m n (random l r))))))
       (seqr
        (lambda (f e)
          (let ((n (/ (length e) 2)))
            (select (mul-add (lf-saw kr f 0) n n) (make-mce e)))))
       (n (i-random 6 18))
       (f (/ (i-random 9 18) n)))
  (audition
   (out 0 (mul (blip ar 
                     (mce2 (seqr f (nfreq n 72 96))
                           (seqr f (nfreq n 72 84)))
                     (mce2 (seqr f (replicate-m n (random 1 3)))
                           (seqr f (replicate-m n (random 3 6)))))
               (mce2 (seqr f (replicate-m n (random 0.05 0.10)))
                     (seqr f (replicate-m n (random 0.05 0.15))))))))
