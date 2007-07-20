;; ntp.scm - (c) rohan drape, 2000-2007

(module ntp (lib "lang.ss" "r5rs")
(#%require (only "../collection/list.scm"
		 list-ref/wrap)
	   (only "../math/exact.scm"
		 round-exact)
	   (only "../mzscheme/r6rs.ss"
		 fxior
		 fxand
		 fxarithmetic-shift-left
		 fxarithmetic-shift-right)
	   (only (lib "19.ss" "srfi")
		 make-time
		 time-second
		 time-nanosecond
		 time-utc))
(#%provide ntp->utc.
	   utc->ntp)

;; NTP is the Network Time Protocol.  NTP time is represented by a 64
;; bit fixed point number. The first 32 bits specify the number of
;; seconds since midnight on January 1, 1900, and the last 32 bits
;; specify fractional parts of a second to a precision of about 200
;; picoseconds. This is the representation used by Internet NTP
;; timestamps.

;; The number of seconds from the start of 1900 to the start of 1970.
;; NTP is measured from the former, UTC from the latter.  There are 17
;; leap years in this period.

(define 2^32 (expt 2 32))
(define 2^32. (exact->inexact 2^32))

(define seconds-from-1900-to-1970 (+ (* 70 365 24 60 60) (* 17 24 60 60)))
(define (seconds-to-ntp i)        (round-exact (* i 2^32)))
(define (ntp-to-seconds i)        (/ i 2^32))
(define (ntp-to-seconds. i)       (/ i 2^32.))
(define (nanoseconds-to-ntp i)    (round-exact (* i (/ 2^32 (expt 10 9)))))
(define (ntp-to-nanoseconds i)    (* i (/ (expt 10 9) 2^32)))

;; Convert between time intervals in seconds and NTP intervals.

(define (time-interval->ntp-interval interval)
  (seconds-to-ntp interval))

(define (ntp-interval->time-interval ntp-interval)
  (ntp-to-seconds ntp-interval))

(define (ntp-interval->time-interval. ntp-interval)
  (ntp-to-seconds. ntp-interval))

;; Evaluate to an <integer> representing the NTP time of the UTC time
;; of the <real> number `n'.

(define (utc->ntp n)
  (seconds-to-ntp (+ n seconds-from-1900-to-1970)))

;; Evaluate to a <real> number representing the UTC time of the
;; <integer> NTP time `ntp'.

(define (ntp->utc ntp)
  (- (ntp-to-seconds ntp) seconds-from-1900-to-1970))

(define (ntp->utc. ntp)
  (- (ntp-to-seconds. ntp) seconds-from-1900-to-1970))

;; Evaluate to an integer representing the NTP time of the SRFI-19
;; time object `time', which must be in UTC format.

(define (utc-time->ntp time)
  (let ((seconds (time-second time))
	(nanoseconds (time-nanosecond time)))
    (fxior (fxarithmetic-shift-left (+ seconds seconds-from-1900-to-1970)
				    32)
	   (nanoseconds-to-ntp nanoseconds))))

;; Evaluate to an SRFI-19 time object representing UTC time of the NTP
;; time `ntp'.

(define (ntp->utc-time ntp)
  (let ((seconds (- (fxarithmetic-shift-right ntp 32) seconds-from-1900-to-1970))
	(nanoseconds (ntp-to-nanoseconds (fxand ntp #xFFFFFFFF))))
    (make-time time-utc nanoseconds seconds)))

)
