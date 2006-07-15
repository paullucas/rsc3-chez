;; collection.ss - (c) rohan drape, 2004-2006

(module
 collection (lib "lang.ss" "r5rs")
 (#%require (rename (lib "list.ss")
		    sort mergesort)
	    (only (lib "1.ss" "srfi")
		  list-tabulate
		  list-copy
		  list-index 
		  make-list
		  take
		  drop
		  iota 
		  zip
		  append-map
		  every
		  unfold
		  delete-duplicates
		  filter
		  fold-right
		  fold
		  unzip2
		  find)
	    (only (lib "23.ss" "srfi")
		  error)
	    (only (lib "26.ss" "srfi")
		  cut)
	    (only (lib "48.ss" "srfi")
		  format)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/collection/list.scm")
 (include "../scheme/collection/series.scm")
 (include "../scheme/collection/tree.scm")
 (#%provide sort
	    concat member?
	    splice interleave intersperse lace extend
	    foldl1
	    dx->d d->dx rotate invert maximum
	    cycles take-cycle
	    ref/wrap
	    mapw mapw*
	    flatten
	    mapt
	    geom
	    foldl))
