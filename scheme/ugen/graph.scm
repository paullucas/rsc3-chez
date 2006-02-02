;; graph.scm - (c) rohan drape, 2003-2006

;; Return the <list> of all elements of the UGen graph rooted at `u'.
;; Nodes are values of type <ugen>|<proxy>|<control*>|<number>.

(define (graph-nodes u)
  (cond
   ((ugen? u)       (cons u (splice (map graph-nodes (ugen-inputs u)))))
   ((proxy? u)      (cons u (graph-nodes (proxy-ugen u))))
   ((control*? u)   (list u))
   ((number? u)     (list u))
   ((mce? u)        (concat (map graph-nodes (mce-channels u))))
   ((mrg? u)        (concat (map graph-nodes (mrg-roots u))))
   (else            (error! "graph-nodes: illegal value" u))))

;; Depth first traversal

(define (graph-traverse f u)
  (let ((f* (lambda (u) (graph-traverse f u))))
    (cond
     ((ugen? u)  (f (make-ugen (ugen-name u)
			       (ugen-rate u)
			       (map f* (ugen-inputs u))
			       (ugen-outputs u)
			       (ugen-special u)
			       (ugen-id u))))
     ((proxy? u) (f (make-proxy (graph-traverse f (proxy-ugen u))
				(proxy-port u))))
     ((mce? u)   (f (make-mce (map f* (mce-channels u)))))
     ((mrg? u)   (f (make-mrg (map f* (mrg-roots u)))))
     (else       u))))

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
   (reverse (filter ugen? (graph-nodes u)))
   equal?))

(define (ugen-close u nn cc uu)
  (if (not (ugen-validate u))
      (error! "ugen-close: ugen invalid" u)
      (make-ugen (ugen-name u)
		 (ugen-rate u)
		 (map (lambda (i)
			(input*->input i nn cc uu))
		      (ugen-inputs u))
		 (ugen-outputs u)
		 (ugen-special u)
		 (ugen-id u))))

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
