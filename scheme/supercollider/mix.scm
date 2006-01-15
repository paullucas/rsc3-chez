;; mix.scm - (c) rohan drape, 2003-2005

;; Mix the UGen at `inputs'.  This is an idiom over the binary math
;; operator 'Add'.

(defineH mix u
  (cond
   ((mce? u) (foldl1 Add (mce-channels u)))
   (else     u)))

;; Use the one argument procedure `contructor' to build a list of
;; `degree' places, and 'Mix' that list.

(defineH mix/fill degree constructor
  (mix (tabulate degree constructor)))
