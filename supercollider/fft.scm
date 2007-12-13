(module fft scheme/base

(require "../collection/list.scm"
	 "../graphdef/mce.scm")

(provide packfft-data)

(define (packfft-data m p)
  (make-mce (cons (* 2 (length m)) (splice (map list m p)))))

)


