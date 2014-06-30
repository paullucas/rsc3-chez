(define dust-r (mk-oscillator-id "DustR" (lo hi) 1))
(define exp-rand-n (mk-specialized-n-id "ExpRandN" (l r) ir))
(define i-rand-n (mk-specialized-n-id "IRandN" (l r) ir))
(define lin-rand-n (mk-specialized-n-id "LinRandN" (l r bias) ir))
(define rand-n (mk-specialized-n-id "RandN" (l r) ir))
(define r-delay-map (mk-filter-mce "RDelayMap" (buf in dyn spec-array) 1))
(define t-scramble (mk-oscillator-mce "TScramble" (tr i) 1))
