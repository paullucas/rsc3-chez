;; graph.scm - (c) rohan drape, 2003-2005

;; Return the <list> of all elements of the UGen graph rooted at `u'.
;; Nodes are values of type <ugen>|<output-proxy>|<control*>|<number>.

(define (graph-nodes u)
  (cond 
   ((ugen? u)         (cons u (splice (map graph-nodes (ugen-inputs u)))))
   ((output-proxy? u) (cons u (graph-nodes (output-proxy-ugen u))))
   ((control*? u)     (list u))
   ((number? u)       (list u))
   (else              (error! "graph-nodes: illegal value" u))))

;; Filters over nodes.

(define (graph-constants u)
  (delete-duplicates 
   (filter number? (graph-nodes u))
   equal?))

(define (graph-controls* u)
  (delete-duplicates
   (filter control*? (graph-nodes u))
   equal?))

;; Ordering is *essential* - the antecedents of `u' are depth first,
;; `u' is the last element.

(define (graph-ugens u)
  (delete-duplicates
   (reverse (cons u (filter ugen? (graph-nodes u))))
   equal?))

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

(define (output-proxy->input p uu)
  (make-input (ugen-index (output-proxy-ugen p) uu)
	      (output-proxy-port p)))

(define (rewrite-input i nn cc uu)
  (cond 
   ((number? i)       (number->input i nn))
   ((control*? i)     (control*->input i cc))
   ((ugen? i)         (ugen->input i uu))
   ((output-proxy? i) (output-proxy->input i uu))
   (else              (error! "rewrite-input: illegal input" i))))

(define (ugen-close u nn cc uu)
  (make-ugen (ugen-name u)
	     (ugen-rate u)
	     (map (lambda (i)
		    (rewrite-input i nn cc uu))
		  (ugen-inputs u))
	     (ugen-outputs u)
	     (ugen-special u)))

(define (graph->graphdef name u)
  (let* ((nn  (graph-constants u))
	 (cc  (graph-controls* u))
	 (uu  (graph-ugens u))
	 (uu* (if (null? cc) uu (cons (implicit-ugen cc) uu))))
    (make-graphdef 
     name
     nn
     (map control*-default cc)
     (map (lambda (c) (control*->control c cc)) cc)
     (map (lambda (u) (ugen-close u nn cc uu*)) uu*))))
