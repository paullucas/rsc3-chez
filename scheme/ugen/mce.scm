;; mce.scm - (c) rohan drape, 2005-2006

(defineH mce-degree m
  (length (mce-channels m)))

(defineH mce-ref m n
  (ref (mce-channels m) n))

(defineH mce-required? u
  (not (null? (filter mce? (ugen-inputs u)))))

(defineH mce-extend n i
  (if (mce? i)
      (extend (mce-channels i) n)
      (make-list n i)))

(defineH mce-transform (ugen n r i o s id)
  (let* ((f (lambda (i) (make-ugen n r i o s id)))
	 (d (maximum (map mce-degree (filter mce? i))))
	 (i* (invert (map (mce-extend d) i))))
    (make-mce (map f i*))))

(defineH mced u
  (if (mce-required? u)
      (mce-transform u)
      u))
