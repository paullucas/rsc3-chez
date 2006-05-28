;; schedule.ss - (c) rohan drape, 2004-2006

(module
 schedule (lib "lang.ss" "r5rs")
 (#%require (only (lib "34.ss" "srfi")
		  with-exception-handler)
	    (only (lib "23.ss" "srfi")
		  error)	    
	    (only (lib "include.ss") 
		  include)
	    (only "structure.ss"
		  define-structure)
	    (only "spawn.ss"
		  spawn
		  thread-terminate!
		  thread-sleep!
		  utc
		  make-ch
		  ch-put
		  ch-sync))
 (include "../scheme/schedule/pq.scm")
 (include "../scheme/schedule/sq.scm")
 (include "../scheme/schedule/schedule.scm")
 (#%provide make-schedule*
	    at
	    schedule-clear
	    spawn
	    utc))
