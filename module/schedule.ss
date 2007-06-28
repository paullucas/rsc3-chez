;; schedule.ss - (c) rohan drape, 2004-2007

(module
 schedule (lib "lang.ss" "r5rs")
 (#%require "../scheme/schedule/pq.scm"
	    "../scheme/schedule/sq.scm"
	    "../scheme/schedule/schedule.scm"
	    "../scheme/schedule/routine.scm")
 (#%provide make-schedule*
	    at
	    schedule-clear
	    routine
	    at/r))
