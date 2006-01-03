;; (Select which array)

;; The output is selected from an array of inputs.

(let ((a (list (SinOsc ar) (Saw ar) (Pulse ar)))
      (cycle 3/2))
  (Mul (Select ar (LFSaw kr 1 0 cycle cycle) a) 0.2))

;; Note: all the ugens are continously running. This may not be the
;; most efficient way if each input is cpu-expensive.

;; Here used as a sequencer:

(let* ((n 32)
       (a (map (compose midi-note->frequency floor-exact)
	       (random-list n 30 80)))
       (cycle (/ n 2)))
  (Saw ar (Select kr (LFSaw kr 1/2 0 cycle cycle) a) 0.2))
