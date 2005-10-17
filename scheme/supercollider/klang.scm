;; klang.scm - (c) rohan drape, 2003-2005

;; Generate a 'spec' list for a Klang UGen.  `freqs' is a list that
;; determines the number of partials, `amps' and `phases' are possibly
;; abbreviated lists subject to expansion by 'extend' to the length of
;; `freqs'.

(define (Klang.spec freqs amps phases)
  (let ((n (length freqs)))
    (interleave freqs (extend amps n) (extend phases n))))

;; Variant to generate a 'spec' list for a Klank UGen.

(define Klank.spec Klang.spec)
