;; (SOS in a0 a1 a2 b1 b2)

;; Second order filter section (biquad).  A standard second order
;; filter section. Filter coefficients are given directly rather than
;; calculated for you.

;; Same as TwoPole

(let* ((theta (Line.kr (* 0.2 pi) pi 5))
       (rho (Line.kr 0.6 0.99 5))
       (b1 (Mul 2 rho (Cos theta)))
       (b2 (Neg (Squared rho))))
  (SOS.ar (LFSaw.ar 200 0.1) 1 0 0 b1 b2))
