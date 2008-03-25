;; rm-octaver (andrea valle, miller puckette)

(let* ((default-pitch 
	 (lambda (i)
	   (pitch i 440 60 4000 100 16 1 0.01 0.5 1)))
       (i (audio-in 1))
       (p (default-pitch i))
       (f (mce-ref p 0)))
  (audition (out 0 (mul-add (sin-osc ar (mul f 0.5) 0) i i))))
