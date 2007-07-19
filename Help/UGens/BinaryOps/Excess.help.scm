;; (Excess a b)

;; Clipping residual.  Returns the difference of the original signal
;; and its clipped form: (a - clip2(a,b)).

(Excess (FSinOsc ar 1000 0) (Line kr 0 1 8 doNothing))

(let ((a (FSinOsc ar 1000 0))
      (b (Line kr 0 1 8 doNothing)))
  (Sub a (Clip2 a b)))
