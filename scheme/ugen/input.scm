;; input.scm - (c) rohan drape, 2005

(define (input*? i)
  (or (number? i)
      (control*? i)
      (ugen? i)
      (proxy? i)))

;; In the context of graphdef serialization <ugen> inputs must be
;; re-written into an <input> form.

(define (number-index n nn)
  (index (cut equal? <> n) nn))

(define (number->input n nn)
  (make-input -1 (number-index n nn)))

(define (control*-index c cc)
  (index (cut equal? <> c) cc))

(define (control*->control c cc)
  (make-control (control*-name c) (control*-index c cc)))

(define (control*->input c cc)
  (make-input 0 (control*-index c cc)))

(define (ugen-index u uu)
  (index (cut equal? <> u) uu))

(define (ugen->input u uu)
  (make-input (ugen-index u uu) 0))

(define (proxy->input p uu)
  (make-input (ugen-index (proxy-ugen p) uu)
	      (proxy-port p)))

(define (input*->input i nn cc uu)
  (cond
   ((number? i)   (number->input i nn))
   ((control*? i) (control*->input i cc))
   ((ugen? i)     (ugen->input i uu))
   ((proxy? i)    (proxy->input i uu))
   (else          (error! "rewrite-input: illegal input" i))))
