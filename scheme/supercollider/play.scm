;; play.scm - (c) rohan drape, 2003-2006

;; Play the graph rooted at the <ugen> `u' at the server `s'.

(define (play s u)
  (let ((g (if (graphdef? u)
	       u
	       (ugen->graphdef/out u))))
    (begin
      (->< s (/d_recv (graphdef->u8l g)))
      (->  s (/s_new (graphdef-name g) -1 1 1)))))
