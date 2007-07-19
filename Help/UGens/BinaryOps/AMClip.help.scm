;; (AMClip a b)

;; 0 when b <= 0, a*b when b > 0

(AMClip (WhiteNoise ar) (Mul (FSinOsc kr 1 0) 0.2))
