;; input.scm - (c) rohan drape, 2005-2006

(module input (lib "lang.ss" "r5rs")
(#%require (only (lib "1.ss" "srfi")
		 make-list
		 list-index)
	   (only (lib "23.ss" "srfi")
		  error)
	   (only (lib "26.ss" "srfi")
		  cut)
	   "../graphdef/input.scm"
	   "../graphdef/control.scm"
	   "../graphdef/proxy.scm"
	   "../graphdef/mce.scm"
	   "../graphdef/mrg.scm"
	   "../graphdef/ugen.scm")
(#%provide (all-defined))

;; In the context of graphdef serialization <ugen> inputs must be
;; re-written into an <input> form.

(define (calculate-index n nn)
  (let ((i (list-index (cut equal? <> n) nn)))
    (if (not i)
	(error "calculate-index: not located" n nn)
	i)))

(define (number->input n nn)
  (make-input -1 (calculate-index n nn)))

(define (control*->control c cc)
  (make-control (control*-name c) (calculate-index c cc)))

(define (control*->input c cc)
  (make-input 0 (calculate-index c cc)))

(define (ugen->input u uu)
  (make-input (calculate-index u uu) 0))

(define (proxy->input p uu)
  (make-input (calculate-index (proxy-ugen p) uu)
	      (proxy-port p)))

(define (input*->input i nn cc uu)
  (cond
   ((number? i)   (number->input i nn))
   ((control*? i) (control*->input i cc))
   ((ugen? i)     (ugen->input i uu))
   ((proxy? i)    (proxy->input i uu))
   ((mce? i)      (error "input*->input: mce?" i))
   ((mrg? i)      (error "input*->input: mrg?" i))
   (else          (error "input*->input: illegal input" i))))

)
