;; mix.scm - (c) rohan drape, 2003-2005

;; Mix the list of UGen records at `inputs'.  This is an idiom over
;; the binary math operator 'Add'.

(defineH mix u
  (foldl1 Add (mce-force u)))

;; Use the one argument procedure `contructor' to build a list of
;; `degree' places, and 'Mix' that list.

(defineH mix/fill degree constructor
  (foldl1 Add (tabulate degree constructor)))
