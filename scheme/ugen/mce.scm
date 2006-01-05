;; mce.scm - (c) rohan drape, 2005

(defineH mcel u
  (cond ((mce? u) (mce-values u))
	(else     (list u))))

(defineH req-mce? u
  (cond ((ugen? u) (not (null? (filter mce? (ugen-inputs u)))))
	(else      #f)))

(defineH mce-depth i
  (maximum (map mce-length (filter mce? i))))

(defineH mce-extend n i
  (if (mce? i)
      (extend (mce-values i) n)
      (make-list n i)))

(define (invert l)
  (let ((f (lambda (n) (map (lambda (e) (ref e n)) l))))
    (map f (iota (length (car l))))))

(defineH mce-transform (ugen n r i o s)
  (let* ((f (lambda (i) (make-ugen n r i o s)))
	 (d (mce-depth i))
	 (i* (invert (map (mce-extend d) i))))
    (make-mce (map f i*))))

(defineH traverseu f u
  (cond ((ugen? u) (f (make-ugen (ugen-name u)
				 (ugen-rate u)
				 (map (traverseu f) (ugen-inputs u))
				 (ugen-outputs u)
				 (ugen-special u))))
	((mce? u) (f (make-mce (map (traverseu f) (mce-values u)))))
	((proxy? u) (f (make-proxy (traverseu f (proxy-ugen u))
		       (proxy-port u))))
  (else u)))

(defineH force-mce u
  (mcel (traverseu (lambda (u) 
		     (if (req-mce? u) 
			 (mce-transform u) 
			 u)) 
		   u)))

