;; (VarSaw rate freq iphasewidth)

;; Variable duty saw

;; freq - frequency in Hertz
;; iphase - initial phase offset in cycles ( 0..1 )
;; width - duty cycle from zero to one.

(let ((f (MulAdd (LFPulse kr (Mce 3 3.03) 0 0.3) 200 200))
      (w (range (LFTri kr 1 0) 0 1)))
  (audition (Out 0 (Mul (VarSaw ar f 0 w) 0.1))))
