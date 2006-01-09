;; pitch.scm - (c) rohan drape, 2005

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
     (ref/wrap scale degree)))

