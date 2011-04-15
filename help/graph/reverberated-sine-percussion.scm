;; reverberated sine percussion (jmcc)

(let* ((d 10)
       (c 7)
       (a 4)
       (s (mix-fill
	   d
	   (lambda (_)
	     (resonz (mul (dust ar (/ 2 d)) 50)
		     (+ 200 (random 0 3000))
		     0.003))))
       (z (delay-n s 0.048 0.48))
       (y (mix (comb-l z
		       0.1
		       (mul-add (lf-noise1 kr (clone c (rand 0 0.1)))
				0.04
				0.05)
		       15)))
       (rallpass
	(lambda (i)
	  (allpass-n i 0.050 (clone 3 (rand 0 0.05)) 1)))
       (chain-of
	(lambda (n f)
	  (foldl1 compose (replicate n f))))
       (x ((chain-of a rallpass) y)))
  (audition (out 0 (add s (mul 0.2 x)))))
