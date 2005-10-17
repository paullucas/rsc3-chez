;; name.scm - (c) rohan drape, 2005

;; A UGen user-name is usually just the UGen name with a rate suffix,
;; but for Binary and Unary OpUGens it is the name of the operation
;; without any rate suffix, which is determined by the special index.

(define (user-name name special)
  (cond
   ((eq? name 'BinaryOpUGen) (binaryop-name special))
   ((eq? name 'UnaryOpUGen)  (unaryop-name special))
   (else                     name)))

(defineH user-name/rate (ugen name rate _ _ special)
  (symbol-++ (user-name name special)
	     (ref '(.ir .kr .ar .dr) rate)))
