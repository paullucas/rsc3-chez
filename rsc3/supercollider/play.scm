;; play.scm - (c) rohan drape, 2003-2007

(module play (lib "lang.ss" "r5rs")
(#%require (only "../server/command.scm"
		 /d_recv
		 /s_new)
	   (only "../server/server.scm"
		 ->
		 -><)
	   (only "../graphdef/graphdef.scm"
		 graphdef?
		 graphdef->u8l
		 graphdef-name)
	   (only "synthdef.scm"
		 ugen->graphdef/out))
(#%provide (all-defined))

;; Play the graph rooted at the <ugen> `u' at the server `s'.

(define (play s u)
  (let ((g (if (graphdef? u)
	       u
	       (ugen->graphdef/out u))))
    (->< s (/d_recv (graphdef->u8l g)))
    (->  s (/s_new (graphdef-name g) -1 1 1))))

)
