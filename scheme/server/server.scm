;; server.scm - (c) rohan drape, 2003-2005

(defineH ->! osc-send!)

(defineH <-! osc-recv!)

(defineH <-*! s t
  (recH loop r (list)
    (letH p (<-! s t)
      (if p (loop (cons p r)) (reverse r)))))

(defineH -><! s (list r m)
  (begin!
    (letH q (<-*! s 0.0)
      (if (null? q)
	  #f
	  (inform! "-><!: queued" q)))
    (->! s m)
    (letH p (<-! s 1.0)
      (condH
        (not p)                    (error! "-><: timed out")
        (not (string=? (car p) r)) (error! "-><: bad return packet" p r)
        else                       p))))

(defineH =>! s t m
  (->! s (list t m)))

(defineH server-free-all! s
  (begin! 
   (->! s (/g_freeAll 0))
   (->! s (/clearSched))
   (->! s (/g_new 1 0 0))))
