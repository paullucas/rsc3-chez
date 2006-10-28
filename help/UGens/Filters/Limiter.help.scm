;; (Limiter input level lookAheadTime)
 
;; Peak limiter.  Limits the input amplitude to the given
;; level. Limiter will not overshoot like Compander will, but it needs
;; to look ahead in the audio. Thus there is a delay equal to twice
;; the lookAheadTime.  Limiter, unlike Compander, is completely
;; transparent for an in range signal.

(Limiter (Mul (Decay2 (Impulse ar 8 (Mul (LFSaw kr 0.25 -0.6) 0.7))
		      0.001 
		      0.3)
	      (FSinOsc ar 500 0))
	 0.4 
	 0.01)
