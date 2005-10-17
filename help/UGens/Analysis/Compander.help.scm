;; (Compander in control thresh slopeBelow slopeAbove clampTime relaxtime)

;; General purpose dynamics processor.

(define (example-signal)
  (Decay2.ar (Impulse.ar 8 0 (LFSaw.kr 0.3 0 -0.3 0.3))
	     0.001 0.3 (Mix (Pulse.ar '(80 81) 0.3))))

(example-signal)

;; Gate

(let ((z (example-signal)))
  (Compander.ar z z (MouseX.kr 0.1 1) 10 1 0.01 0.01))

;; Compressor

(let ((z (example-signal)))
  (Compander.ar z z (MouseX.kr 0.1 1) 1 0.5 0.01 0.01))

;; Limiter

(let ((z (example-signal)))
  (Compander.ar z z (MouseX.kr 0.1 1) 1 0.1 0.01 0.01))

;; Sustainer

(let ((z (example-signal)))
  (Compander.ar z z (MouseX.kr 0.1 1) 0.1 1 0.01 0.01))
