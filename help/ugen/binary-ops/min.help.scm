;; (min a b)

;; Minimum.

(audition
 (out 0 (let ((z (fsin-osc ar 500 0)))
	  (u:min z (fsin-osc ar 0.1 0)))))
