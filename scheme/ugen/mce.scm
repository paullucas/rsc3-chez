;; mce.scm - (c) rohan drape, 2005

(defineH mcel u
  (cond ((mce? u) (mce-channels u))
	(else     (list u))))

(defineH mce-required? u
  (cond ((ugen? u) (not (null? (filter mce? (ugen-inputs u)))))
	(else      #f)))

(defineH mce-depth i
  (maximum (map mce-degree (filter mce? i))))

(defineH mce-extend n i
  (if (mce? i)
      (extend (mce-channels i) n)
      (make-list n i)))

(defineH mce-transform (ugen n r i o s id)
  (let* ((f (lambda (i) (make-ugen n r i o s id)))
	 (d (mce-depth i))
	 (i* (invert (map (mce-extend d) i))))
    (make-mce (map f i*))))

(defineH mce-force u
  (mcel (graph-traverse 
	 (lambda (u) 
	   (if (mce-required? u) 
	       (mce-transform u) 
	       u)) 
	 u)))
