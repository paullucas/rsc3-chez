;; pitch.scm - (c) rohan drape, 2005-2007

(module pitch (lib "lang.ss" "r5rs")
(#%require (only "../collection/list.scm"
		 list-ref/wrap)
	   (only "log.scm"
		 log2))
(#%provide midicps 
	   cpsmidi
	   octcps
	   cpsoct
	   midiratio
	   ratiomidi
	   degree->key)

(define (midicps note)
  (* 440.0 (expt 2.0 (* (- note 69.0) 0.083333333333))))

(define (cpsmidi freq)
  (+ (* (log2 (* freq 0.0022727272727)) 12.0) 69.0))

(define (midiratio midi)
  (expt 2.0 (* midi 0.083333333333)))

(define (ratiomidi ratio)
  (* 12.0 (log2 ratio)))

(define (octcps note)
  (* 440.0 (expt 2.0 (- note 4.75))))

(define (cpsoct freq)
  (+ (log2 (* freq 0.0022727272727)) 4.75))

(define (degree->key degree scale steps)
  (+ (* steps (quotient degree (length scale)))
     (list-ref/wrap scale degree)))

)
