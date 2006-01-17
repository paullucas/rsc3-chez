;; (DustR lo hi)

;; DustR generates triggers where the inter-offset times are generated
;; randomly in the specified range (seconds) with linear distribution.

(Dust r0 ar 1)
(DustR r0 ar 0 2)

(DustR r0 ar 1 1)
(Mul (WhiteNoise r0 ar) (Impulse ar 1 0))

(Dust r0 ar (/ 1 0.025))
(DustR r0 ar 0 0.05)
