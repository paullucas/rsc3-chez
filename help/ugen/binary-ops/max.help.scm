;; (max a b)

;; Maximum.

(audition
   (out 0 (let ((z (fsin-osc ar 500 0)))
	    (u:max z (fsin-osc ar 0.1 0)))))
