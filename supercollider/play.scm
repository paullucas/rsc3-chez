;; play.scm - (c) rohan drape, 2003-2007

(module play scheme/base

(require (only-in "../server/command.scm"
		  /d_recv
		  /s_new)
	 (only-in "../server/server.scm"
		  ->
		  -><
		  with-sc3)
	 (only-in "../graphdef/graphdef.scm"
		  graphdef?
		  graphdef->u8l
		  graphdef-name)
	 (only-in "synthdef.scm"
		  ugen->graphdef/out))

(provide play
	 audition)

;; Play the graph rooted at the <ugen> `u' at the server `s'.

(define (play s u)
  (let ((g (if (graphdef? u)
	       u
	       (ugen->graphdef/out u))))
    (->< s (/d_recv (graphdef->u8l g)))
    (->  s (/s_new (graphdef-name g) -1 1 1))))

(define (audition u)
  (with-sc3 
    (lambda (fd)
      (play fd u))))


)
