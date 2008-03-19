;; (mul a b)

;; multiplication, written '*' in sclang.

(mul (sin-osc ar 440 0) 0.5)

;; mul* is a variable argument variant.  

;; Creates a beating effect (subaudio rate).

(mul* (fsin-osc kr 10 0) 
      (pink-noise ar)
      0.5)

;; Ring modulation.

(mul* (sin-osc ar (xline kr 100 1001 10 do-nothing) 0)
      (Syncsaw ar 100 200)
      0.25)
