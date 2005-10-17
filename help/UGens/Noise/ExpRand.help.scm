;; (ExpRand lo hi)
 
;; Generates a single random float value in an exponential
;; distributions from `lo' to `hi'.
 
(FSinOsc.ar (ExpRand.ir 100.0 8000.0)
	    0
	    (Line.kr 0.5 0 0.01 'doneAction: 2))
