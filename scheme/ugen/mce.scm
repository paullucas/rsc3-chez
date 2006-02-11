;; mce.scm - (c) rohan drape, 2005-2006

(define (mce-degree m)
  (length (mce-channels m)))

(define (mce-ref m n)
  (ref (mce-channels m) n))

(define (mce-reverse u)
  (make-mce (reverse (mce-channels u))))

(define (mce-required? u)
  (not (null? (filter mce? (ugen-inputs u)))))

(define (mce-extend n i)
  (if (mce? i)
      (extend (mce-channels i) n)
      (make-list n i)))

(define (mce-transform u)
  (let ((n (ugen-name u))
	(r (ugen-rate u))
	(i (ugen-inputs u))
	(o (ugen-outputs u))
	(s (ugen-special u))
	(d (ugen-id u)))
    (let* ((f (lambda (i*) (make-ugen n r i* o s d)))
	   (m (maximum (map mce-degree (filter mce? i))))
	   (e (lambda (i) (mce-extend m i)))
	   (i* (invert (map e i))))
      (make-mce (map f i*)))))

(define (mced u)
  (if (mce-required? u)
      (mce-transform u)
      u))

(define (mce-l u)
  (if (mce? u)
      (mce-channels u)
      (list u)))
