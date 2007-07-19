;; (Wrap2 a b)

;; Bilateral wrapping.  Wraps input wave to +/- b.

(Wrap2 (FSinOsc ar 1000 0) (Line kr 0 1.01 8 doNothing))
