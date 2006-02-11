;; (DustR lo hi)

;; DustR generates triggers where the inter-offset times are generated
;; randomly in the specified range (seconds) with linear distribution.

(Dust R0 ar 1)
(DustR R0 ar 0 2)

(DustR R0 ar 1 1)
(Mul (Impulse ar 1 0) (Abs (WhiteNoise R0 ar)))

(Dust R0 ar (/ 1 0.025))
(DustR R0 ar 0 0.05)

;; Courtesy Julian Rohrhuber, sc-dev/2006-January/009747.html

(define (DustR* g r lo hi)
  (let ((d (Dseq inf (Mce (Dwhite g 1 lo hi)))))
    (TDuty r d 0 0 (Abs (WhiteNoise g r)))))

(DustR* R0 ar 0.001 (MouseX kr 0.001 1 1 0.1))

(DustR R0 ar 0.001 (MouseX kr 0.001 1 1 0.1))

(Mul (Impulse ar (/ 1 0.001) 0) (Abs (WhiteNoise R0 ar)))

(-><! s (/status))
