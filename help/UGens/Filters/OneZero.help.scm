;;; (OneZero in coef)

;;; One zero filter

(OneZero.ar (WhiteNoise.ar 0.5) 0.5)

(OneZero.ar (WhiteNoise.ar 0.5) -0.5)

(OneZero.ar (WhiteNoise.ar 0.5) (Line.kr -0.5 0.5 10))
