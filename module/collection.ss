;; collection.ss - (c) rohan drape, 2004-2007

(module
 collection (lib "lang.ss" "r5rs")
 (#%require (rename (lib "list.ss") sort mergesort)
	    "../scheme/collection/list.scm"
	    "../scheme/collection/mapw.scm"
	    "../scheme/collection/series.scm"
	    "../scheme/collection/tree.scm")
 (#%provide sort
    	    list-ref/wrap length*
	    geom filter-index drop*
	    foldr concat foldl foldl1 maximum
	    splice interleave intersperse lace extend extend-all rotate invert cycles take-cycle
	    dx->d d->dx d->dx** 
	    mapw mapw*
	    flatten mapt))
