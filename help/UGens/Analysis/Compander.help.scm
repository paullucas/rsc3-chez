;; (Compander input control thresh slopeBelow slopeAbove clampTime relaxTime)

;; Compressor, expander, limiter, gate, ducker.  General purpose
;; dynamics processor.

;; Example signal to process.

(define z
  (Mul (Decay2 (Mul (Impulse ar 8 0) (Mul (LFSaw kr 0.3 0) 0.3)) 0.001 0.3)
       (mix (Pulse ar (Mce 80 81) 0.3))))

;; Noise gate

(Compander z z (MouseX kr 0.1 1 0 0.1) 10 1 0.01 0.01)

;; Compressor

(Compander z z (MouseX kr 0.1 1 0 0.1) 1 0.5 0.01 0.01)

;; Limiter

(Compander z z (MouseX kr 0.1 1 0 0.1) 1 0.1 0.01 0.01)

;; Sustainer

(Compander z z (MouseX kr 0.1 1 0 0.1) 0.1 1 0.01 0.01)
