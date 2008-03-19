;; (lin-pan2 in pos level)

;; Two channel linear pan.  See pan2.

(audition (out 0 (lin-pan2 (pink-noise ar) (fsin-osc kr 2 0) 0.1)))

(audition (out 0 (lin-pan2 (fsin-osc ar 800 0.1) (fsin-osc kr 3 0) 0.1)))
