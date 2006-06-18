;; schedule.ss - (c) rohan drape, 2004-2006

(module
 schedule (lib "lang.ss" "r5rs")
 (#%require (only (lib "34.ss" "srfi")
		  with-exception-handler)
	    (only (lib "23.ss" "srfi")
		  error)	    
	    (only "spawn.ss"
		  spawn
		  thread-terminate!
		  thread-sleep!)
	    (only "utc.ss"
		  utc)
	    (only "ch.ss"
		  make-ch
		  ch-put
		  ch-sync)
	    (only "structure.ss"
		  define-structure)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/schedule/pq.scm")
 (include "../scheme/schedule/sq.scm")
 (include "../scheme/schedule/schedule.scm")
 (include "../scheme/schedule/routine.scm")
 (#%provide make-schedule*
	    at
	    schedule-clear
	    routine
	    at/r))
