;; (Klang rate freqScale freqOffset spec)

;; Bank of fixed oscillators.  The UGen assistant Klang.spec can help
;; create the 'spec' entry.  Note that the SC3 language reorders the
;; inputs, the rsc3 client does not.

(let ((d (klang-data '(440 550 660 770 880 990 1000) 
		     '(0.05 0.02 0.07 0.04 0.05 0.02 0.03) 
		     (replicate 7 0))))
  (audition (Out 0 (Klang ar 1 0 d))))
