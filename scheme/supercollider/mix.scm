;; mix.scm - (c) rohan drape, 2003-2005

;; Mix the list of UGen records at `inputs'.  This is an idiom over
;; the binary math operator 'Add'.

(defineH Mix (cons x xs)
  (if (null? xs) x (+.gr x (Mix xs))))

;; Use the zero or one argument procedure `contructor' to build a list
;; of `degree' places, and 'Mix' that list.

(define (Mix.fill degree constructor)
  (Mix (tabulate degree constructor)))
