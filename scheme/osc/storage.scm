;; storage.scm - (c) rohan drape, 2005-2006

;; Returns the number of bytes needed to store the <string> `s'.

(define (string-storage-size s)
  (let ((n (string-length s)))
    (+ n (- 4 (modulo n 4)))))

;; Return the storage size of the argument `type'.  For string and
;; u8v arguments the data must be accessed to determine this
;; value.

(define (value-storage-size t v o)
  (case t
    ((#\i #\f)     4)
    ((#\t #\h #\d) 8)
    ((#\s)         (let ((n (u8v-index v 0 o))) (+ n (- 4 (modulo n 4)))))
    ((#\b)         (+ (u8v->i32 (u8v-copy* v o (+ o 4))) 4))
    (else          (error "value-storage-size" t v o))))
