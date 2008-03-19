;; (dbufrd bufnum phase loop)

;; Buffer demand ugen.

;; bufnum	- buffer number to read from
;; phase	- index into the buffer (demand ugen or any other ugen)
;; loop		- loop when phase exceeds number of frames in buffer

;; Example

(with-sc3
 (lambda (fd)
   (async fd (b-alloc 10 24 1))
   (send fd (b-setn1 10 0 (replicate-m 24 (randomx 200 500))))))

(let* ((q (dseq 3 (make-mce (list 0 3 5 0 3 7 0 5 9))))
       (p (dseq dinf (mce2 q (dbrown 5 0 23 1))))
       (t (dust kr 10)))
  (audition (mul (sin-osc ar (demand t 0 (dbufrd 10 p 1)) 0) 0.1)))

;; Buffer as a time pattern.

(with-sc3
 (lambda (fd)
   (async fd (/b_alloc 11 24 1))
   (send  fd (/b_setn* 11 0 (choosel 24 (list 1 0.5 0.25))))))

(let* ((p (dseq dinf (Mce (dseq 3 (Mce 0 3 5 0 3 7 0 5 9)) (dbrown 5 0 23 1))))
       (d (mul (Dbufrd 11 (dseries dinf 0 1) 1) 0.5))
       (l (Dbufrd 10 p 1)))
  (audition (mul (sin-osc ar (duty kr d 0 do-nothing l) 0) 0.1)))

;; free buffers

(with-sc3
 (lambda (fd)
   (async fd (/b_free 10))
   (async fd (/b_free 11))))
