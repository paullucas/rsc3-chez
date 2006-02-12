;; (Select which array)

;; The output is selected from an array of inputs.

(let ((a (Mce (SinOsc ar 440 0) (Saw ar 440) (Pulse ar 440 0.1)))
      (cycle 3/2))
  (Mul (Select (MulAdd (LFSaw kr 1 0) cycle cycle) a) 0.2))

;; Note: all the ugens are continously running. This may not be the
;; most efficient way if each input is cpu-expensive.

;; Here used as a sequencer:

(define (compose a b)
  (lambda (c) (a (b c))))

(let* ((n 32)
       (a (make-mce (map (compose floor-exact midicps) (randl n 30 80))))
       (cycle (/ n 2)))
  (Mul (Saw ar (Select (MulAdd (LFSaw kr 1/2 0) cycle cycle) a))
       0.2))
