;; play.scm - (c) rohan drape, 2003-2005

;; Play the graph rooted at the <ugen> `u' at the server `s'.

(define (play! s u)
  (let ((g (ugen->graphdef/out u)))
    (-><! s (/d_recv (graphdef->u8v g)))
    (->!  s (/s_new (graphdef-name g) -1 1 1))))
