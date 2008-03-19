;; (fold2 a b)

;; Bilateral folding.  folds a to +/- b.

(fold2 (fsin-osc ar 1000 0)
       (line kr 0 1 8 do-nothing))
