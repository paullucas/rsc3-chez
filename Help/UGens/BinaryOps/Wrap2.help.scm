;; (wrap2 a b)

;; Bilateral wrapping.  wraps input wave to +/- b.

(wrap2 (fsin-osc ar 1000 0) (line kr 0 1.01 8 do-nothing))
