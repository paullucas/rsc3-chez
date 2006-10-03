;; (PV_JensenAndersen buffer propsc prophfe prophfc propsf threshold waittime)

;; FFT feature detector for onset detection based on work described in

;; Jensen,K. & Andersen, T. H. (2003). Real-time Beat Estimation Using
;; Feature Extraction.

;; In Proceedings of the Computer Music Modeling and Retrieval
;; Symposium, Lecture Notes in Computer Science. Springer Verlag.

;;  First order derivatives of the features are taken. Threshold may
;;  need to be set low to pick up on changes.

;; buffer - FFT buffer to read from.

;; propsc - Proportion of spectral centroid feature.

;; prophfe - Proportion of high frequency energy feature.

;; prophfc - Proportion of high frequency content feature.

;; propsf - Proportion of spectral flux feature.

;; threshold - Threshold level for allowing a detection

;; waittime - If triggered, minimum wait until a further frame can
;;            cause another spot (useful to stop multiple detects on
;;            heavy signals)

;; Default values in sclang are: propsc=0.25, prophfe=0.25,
;; prophfc=0.25, propsf=0.25, threshold=1.0, waittime=0.04.

(->< s (/b_alloc 0 2048 1))

(let* ((source (audioin 1))
       (detect (PV_JensenAndersen (FFT 0 source)
				  0.25 0.25 0.25 0.25
				  (MouseX kr 0.01 1.0 1 0.1)
				  0.04)))
  (Out 0 (Mul (SinOsc ar (Mce 440 445) 0)
	      (Decay (Mul 0.1 detect) 0.1))))
