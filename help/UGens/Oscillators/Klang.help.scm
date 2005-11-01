;; (Klang freqScale freqOffset spec)

;; Bank of fixed oscillators.  The UGen assistant Klang.spec can help
;; create the 'spec' entry.  Note that the SC3 language reorders the
;; inputs, the RSC client does not.

(Klang.ar 1 0 (Klang.spec '(440 550 660 770 880 990 1000) '(0.05 0.02)))
