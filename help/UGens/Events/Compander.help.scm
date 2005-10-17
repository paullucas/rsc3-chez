;;; (Compander input control thresh slopeBelow slopeAbove clampTime relaxTime)

;;; Compressor, expander, limiter, gate, ducker.  General purpose
;;; dynamics processor.


;; Example signal to process.

(Decay2.ar (Impulse.ar 8 (LFSaw.kr 0.3 -0.3 0.3))
	   0.001 0.3 (Mix (Pulse.ar '(80 81) 0.3)))

;; Noise gate

(let ((z (Decay2.ar (Impulse.ar 8 (LFSaw.kr 0.3 -0.3 0.3))
		    0.001 0.3 (Mix (Pulse.ar '(80 81) 0.3)))))
  (Compander.ar z z (MouseX.kr 0.1 1) 10 1 0.01 0.01))

;; Compressor

(let ((z (Decay2.ar (Impulse.ar 8 (LFSaw.kr 0.3 -0.3 0.3))
		    0.001 0.3 (Mix (Pulse.ar '(80 81) 0.3)))))
  (Compander.ar z z (MouseX.kr 0.1 1) 1 0.5 0.01 0.01))

;; Limiter

(let ((z (Decay2.ar (Impulse.ar 8 (LFSaw.kr 0.3 -0.3 0.3))
		    0.001 0.3 (Mix (Pulse.ar '(80 81) 0.3)))))
  (Compander.ar z z (MouseX.kr 0.1 1) 1 0.1 0.01 0.01))

;; Sustainer

(let ((z (Decay2.ar (Impulse.ar 8 (LFSaw.kr 0.3 -0.3 0.3))
		    0.001 0.3 (Mix (Pulse.ar '(80 81) 0.3)))))
  (Compander.ar z z (MouseX.kr 0.1 1) 0.1 1 0.01 0.01))
