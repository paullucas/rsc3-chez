;; mix.scm - (c) rohan drape, 2003-2006

;; Mix the UGen at `inputs'.  This is an idiom over the binary math
;; operator 'Add'.

(define (mix u)
  (cond
   ((mce? u) (foldl1 Add (mce-channels u)))
   (else     u)))

;; Use the one argument procedure `contructor' to build a list of
;; `degree' places, and 'Mix' that list.

(define (mix/fill degree constructor)
  (mix (make-mce (tabulate degree constructor))))
