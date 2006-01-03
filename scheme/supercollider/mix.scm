;; mix.scm - (c) rohan drape, 2003-2005

;; Mix the list of UGen records at `inputs'.  This is an idiom over
;; the binary math operator 'Add'.

(defineH mix (cons x xs)
  (if (null? xs) x (+u x (mix xs))))

;; Use the one argument procedure `contructor' to build a list of
;; `degree' places, and 'Mix' that list.

(define (mix/fill degree constructor)
  (mix (tabulate degree constructor)))
