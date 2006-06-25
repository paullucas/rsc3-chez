;; mce.scm - (c) rohan drape, 2005-2006

(define (mce-degree m)
  (length (mce-channels m)))

(define (mce-ref m n)
  (list-ref (mce-channels m) n))

(define (mce-reverse u)
  (make-mce (reverse (mce-channels u))))

(define (mce-required? u)
  (not (null? (filter mce? (ugen-inputs u)))))

(define (mce-extend n i)
  (if (mce? i)
      (extend (mce-channels i) n)
      (make-list n i)))

(define (mce-transform u)
  (ugen-transform
   u
   (lambda (n r i o s d)
     (let* ((f (lambda (i*) (make-ugen n r i* o s d)))
	    (m (maximum (map mce-degree (filter mce? i))))
	    (e (lambda (i) (mce-extend m i)))
	    (i* (invert (map e i))))
       (make-mce (map f i*))))))

(define (mced u)
  (if (mce-required? u)
      (mce-transform u)
      u))

(define (mce-l u)
  (if (mce? u)
      (mce-channels u)
      (list u)))
