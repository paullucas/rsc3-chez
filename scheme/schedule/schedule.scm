;; schedule.scm - (c) rohan drape & matthew flatt, 2000-2006

(define (utc)
  (/ (current-inexact-milliseconds) 1000.0))

;; ch = channel, th = thread, sq = queue

(define-structure schedule ch th sq)

(define (at Q t f)
  (async-channel-put (schedule-ch Q) (make-sqe t f)))

(define (schedule-clear Q)
  (async-channel-put (schedule-ch Q) #f))

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
  (make-thread*
   (lambda ()
     (let loop ((t +inf.0))
       (sync
	(handle-evt (alarm-evt (* 1000.0 t))
		    (lambda (_)
		      (begin
			(if (not (sq-empty? SQ))
			    (schedule-dispatch Q SQ t))
			(if (sq-empty? SQ)
			    (loop +inf.0)
			    (loop (sqe-k (sq-min SQ)))))))
	(handle-evt CH
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
			     (error "illegal value" v))))))))))

(define (make-schedule*)
  (let* ((CH (make-async-channel))
	 (SQ (make-sq* <=))
	 (Q  (make-schedule CH #f SQ)))
    (begin
     (set-schedule-th! Q (schedule-sync-thread CH SQ Q))
     Q)))

(define (schedule-terminate Q)
  (begin
   (schedule-clear Q)
   (thread-terminate! (schedule-th Q))))
