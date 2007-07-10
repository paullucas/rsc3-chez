;; schedule.scm - (c) rohan drape & matthew flatt, 2000-2007

(module schedule (lib "lang.ss" "r5rs")
(#%require (only (lib "34.ss" "srfi")
		 with-exception-handler)
	   (only (lib "23.ss" "srfi")
		 error)	    
	   (only "../../module/spawn.ss"
		 spawn
		 thread-terminate!
		 thread-sleep!)
	   (only "../../module/utc.ss"
		 utc)
	   (only "../../module/ch.ss"
		 make-ch
		 ch-put
		 ch-sync)
	   (only "../structure/structure.scm"
		 define-structure)
	   "routine.scm"
	   "sq.scm")
(#%provide make-schedule* 
	   at 
	   schedule-clear 
	   at/r)

;; ch = channel, th = thread, sq = queue

(define-structure schedule ch th sq)

(define (at Q t f)
  (ch-put (schedule-ch Q) (make-sqe t f)))

(define (at/r Q t r)
  (at Q t (lambda (_ f) (f (r)))))

(define (schedule-clear Q)
  (ch-put (schedule-ch Q) #f))

(define (schedule-dispatch Q SQ t)
  (let* ((e  (sq-min SQ))
	 (f  (sqe-v e))
	 (t* (sqe-k e)))
    (if (<= t* t)
	(begin
	  (sq-remove-min! SQ)
	  (with-exception-handler
	   (lambda (e) (begin (display "schedule-dispatch: error:")
			      (display e)
			      (newline)))
	   (lambda ()  (f t (lambda (i)
			      (if (number? i)
				  (at Q (+ t i) f))))))))))

(define (schedule-sync-thread CH SQ Q)
  (spawn
   (lambda ()
     (let loop ((t +inf.0))
       (ch-sync CH 
		(lambda (v)
		  (cond ((sqe? v)
			 (begin
			   (sq-insert! SQ v)
			   (loop (min (sqe-k v) t))))
			((eq? v #f)
			 (begin
			   (sq-clear! SQ)
			   (loop +inf.0)))
			(else
			 (error "illegal value" v))))
		t
		(lambda (_)
		  (begin
		    (if (not (sq-empty? SQ))
			(schedule-dispatch Q SQ t))
		    (if (sq-empty? SQ)
			(loop +inf.0)
			(loop (sqe-k (sq-min SQ)))))))))))

(define (make-schedule*)
  (let* ((CH (make-ch))
	 (SQ (make-sq* <=))
	 (Q  (make-schedule CH #f SQ)))
    (begin
      (set-schedule-th! Q (schedule-sync-thread CH SQ Q))
      Q)))

(define (schedule-terminate Q)
  (begin
    (schedule-clear Q)
    (thread-terminate! (schedule-th Q))))

)
