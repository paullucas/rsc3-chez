;; (Select which array)

;; The output is selected from an array of inputs.

(audition
 (let* ((a (Mce (SinOsc ar 440 0) (Saw ar 440) (Pulse ar 440 0.1)))
	(cycle 3/2)
	(w (MulAdd (LFSaw kr 1 0) cycle cycle)))
   (Out 0 (Mul (Select w a) 0.2))))

;; Note: all the ugens are continously running. This may not be the
;; most efficient way if each input is cpu-expensive.

;; Here used as a sequencer:

(audition
 (let* ((n 32)
	(compose (lambda (a b) (lambda (c) (a (b c)))))
	(a (make-mce (map (compose midicps floor-exact) (randl n 30 80))))
	(cycle (/ n 2))
	(w (MulAdd (LFSaw kr 1/2 0) cycle cycle)))
   (Out 0 (Mul (Saw ar (Select w a)) 0.2))))
