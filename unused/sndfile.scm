;; sndfile

(define au-magic #x2e736e64)

(define au-unspecified 0)
(define au-mulaw8 1)
(define au-linear8 2)
(define au-linear16 3)
(define au-linear24 4)
(define au-linear32 5)
(define au-float 6)
(define au-double 7)

(define au-size-of
(lambda (e)
  (cond ((= e au-unspecified) (error 'au-size-of "unspecified encoding"))
	((= e au-mulaw8) 1)
	((= e au-linear8) 1)
	((= e au-linear16) 2)
	((= e au-linear24) 3)
	((= e au-linear32) 4)
	((= e au-float) 4)
	((= e au-double) 8)
	(else (error "au-size-of: illegal encoding"))))

(define au-mk-hdr
(lambda (nf enc sr nc)
  (let ((nb (* nf nc (au-size-of enc))))
    (concat-map i32->u8l (list au-magic 28 nb enc sr nc 0))))

(define au-f32 (list au-float f32->u8l))
(define au-f64 (list au-double f64->u8l))

(define write-snd-file
(lambda (e sr nc fn d)
  (let ((enc (car e))
	(encdr (cadr e))
	(nf (/ (length d) nc)))
    (with-output-to-file fn
      (lambda ()
	(for-each put-u8 (au-mk-hdr nf enc sr nc))
	(for-each put-u8 (concat-map encdr d))))))
