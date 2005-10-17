;;; (Normalizer in level dur) 

;;; Flattens dynamics.

(let ((z (Decay2.ar (Impulse.ar 8 (LFSaw.kr 0.25  -0.6  0.7))
		    0.001  0.3 (FSinOsc.ar 500))))
  (list z (Normalizer.ar z 0.4 0.01)))
