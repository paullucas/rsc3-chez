;; double -> void
(define pause-thread
  (lambda (n)
    (thread-sleep n)))

;; double -> void
(define pause-thread-until
  (lambda (t)
    (let ((c (utcr)))
      (pause-thread (- t c)))))

;; port -> ugen -> ()
(define play
  (lambda (fd u)
    (play-at fd u -1 add-to-tail 1)))

(define hear (lambda (u) (audition (out 0 u))))
