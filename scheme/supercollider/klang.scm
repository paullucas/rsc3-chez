;; klang.scm - (c) rohan drape, 2003-2006

;; Generate a 'spec' list for a Klang UGen.  `freqs' is a list that
;; determines the number of partials, `amps' and `phases' are possibly
;; abbreviated lists subject to expansion by 'extend' to the length of
;; `freqs'.

(define (klang-data freqs amps phases)
  (let ((n (length freqs)))
    (make-mce
     (interleave freqs
		 (extend amps n)
		 (extend phases n)))))

;; Variant to generate a 'spec' list for a Klank UGen.

(define klank-data klang-data)
