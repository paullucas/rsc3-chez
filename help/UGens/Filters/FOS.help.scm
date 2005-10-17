;;; (FOS in a0 a1 b1)

;;; First order filter section.

;; Same as OnePole.

(let ((x (LFTri.ar 0.4 0 0.99)))
  (FOS.ar (LFSaw.ar 200 0 0.2) (Sub 1 (Abs x)) 0 x))

;; Same as OneZero

(let ((x (LFTri.ar 0.4 0 0.99)))
  (FOS.ar (LFSaw.ar 200 0 0.2) (Sub 1 (Abs x)) x 0))
