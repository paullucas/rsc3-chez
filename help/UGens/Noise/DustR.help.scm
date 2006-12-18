;; (DustR rate lo hi)

;; DustR generates triggers where the inter-offset times are generated
;; randomly in the specified range (seconds) with linear distribution.

(Dust ar 1)
(DustR ar 0 2)

(DustR ar 1 1)
(Mul (Impulse ar 1 0) (Abs (WhiteNoise ar)))

(Dust ar (/ 1 0.025))
(DustR ar 0 0.05)

;; Courtesy Julian Rohrhuber, sc-dev/2006-January/009747.html

(define (DustR* r lo hi)
  (let ((d (Dseq +inf.sc (Mce (Dwhite 1 lo hi)))))
    (TDuty r d 0 0 (Abs (WhiteNoise r)))))

(DustR* ar 0.001 (MouseX kr 0.001 1 1 0.1))

(DustR ar 0.001 (MouseX kr 0.001 1 1 0.1))

(Mul (Impulse ar (/ 1 0.001) 0) (Abs (WhiteNoise ar)))

(->< s (/status))
