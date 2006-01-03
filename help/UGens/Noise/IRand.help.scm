;; (IRand lo hi)

;; Generates a single random integer value in uniform distribution
;; from `lo' to `hi'.
 
(FSinOsc ar (IRand ir 200 1200) 0 (Line kr 0.2 0 0.1 'doneAction: 2))
