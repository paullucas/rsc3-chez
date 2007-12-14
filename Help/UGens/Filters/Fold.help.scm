;; (Fold in lo hi)

;; Fold a signal outside given thresholds.

;; This differs from the BinaryOpUGen fold2 in that it allows one to
;; set both low and high thresholds.

;; in - signal to be foldped
;; lo - low threshold of foldping
;; hi - high threshold of foldping

(let ((o (Mul (SinOsc ar 440 0) 0.2))
      (l (Rand -0.175 -0.025))
      (r (Rand 0.025 0.175)))
  (audition (Out 0 (Fold o l r))))

;; lo and hi are i-rate only.

(let ((o (Mul (SinOsc ar 440 0) 0.2))
      (x (MouseX kr -0.175 -0.025 1 0.1))
      (y (MouseY kr 0.025 0.175 1 0.1)))
  (audition (Out 0 (Fold o x y))))
