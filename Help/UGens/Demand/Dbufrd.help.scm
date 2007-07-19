;; (Dbufrd bufnum phase loop)

;; Buffer demand ugen.

;; bufnum	- buffer number to read from
;; phase	- index into the buffer (demand ugen or any other ugen)
;; loop		- loop when phase exceeds number of frames in buffer

;; Example

(begin (->< s (/b_alloc 10 24 1))
       (->  s (/b_setn* 10 0 (randxl 24 200 500))))

(let ((p (Dseq +inf.sc (Mce (Dseq 3 (Mce 0 3 5 0 3 7 0 5 9)) (Dbrown 5 0 23 1))))
      (t (Dust kr 10)))
  (Mul (SinOsc ar (Demand t 0 (Dbufrd 10 p 1)) 0) 0.1))

;; Buffer as a time pattern.

(begin (->< s (/b_alloc 11 24 1))
       (->  s (/b_setn* 11 0 (choosel 24 (list 1 0.5 0.25)))))

(let* ((p (Dseq +inf.sc (Mce (Dseq 3 (Mce 0 3 5 0 3 7 0 5 9)) (Dbrown 5 0 23 1))))
       (d (Mul (Dbufrd 11 (Dseries +inf.sc 0 1) 1) 0.5))
       (l (Dbufrd 10 p 1)))
  (Mul (SinOsc ar (Duty kr d 0 doNothing l) 0) 0.1))

;; Free buffers

(begin (->< s (/b_free 10))
       (->< s (/b_free 11)))
