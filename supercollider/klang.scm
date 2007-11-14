;; klang.scm - (c) rohan drape, 2003-2007

(module klang scheme/base

(require "../collection/list.scm"
	 "../graphdef/mce.scm")

(provide klang-data klank-data)

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

;; Variant to generate a 'spec' list for a Klank UGen, the last
;; argument is `ring-time', not `phases'.

(define klank-data klang-data)

)
