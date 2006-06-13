;; spawn.ss - (c) rohan drape, 2006

(module
 spawn mzscheme

 ;; spawn is the composition of SRFI-18 make-thread & thread-start!
 (define spawn thread)

 ;; SRFI-18 aliases
 (define thread-terminate! kill-thread)
 (define thread-sleep! sleep)

 (provide spawn
	  thread-terminate!
	  thread-sleep!))
