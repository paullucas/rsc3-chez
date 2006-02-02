;; collection.ss - (c) rohan drape, 2004-2006

(module 
 collection mzscheme
 (require (rename (lib "list.ss") sort mergesort)
	  (only (lib "1.ss" "srfi") 
		 list-tabulate list-copy list-index  make-list
		 take drop iota  zip append-map every
		 unfold delete-duplicates filter fold-right fold unzip2 find)
	   (only (lib "26.ss" "srfi") cut)
	   (only (lib "include.ss") include))
  (include "../scheme/collection/list.scm")
  (include "../scheme/collection/series.scm")
  (include "../scheme/collection/tree.scm")
  (provide sort (all-defined)))
