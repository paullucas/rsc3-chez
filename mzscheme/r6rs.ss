;; r6rs.ss - (c) rohan drape, 2006-2007

;; r6rs names...

(module r6rs mzscheme
(require (prefix srfi: (lib "1.ss" "srfi")))
(require (prefix srfi: (lib "23.ss" "srfi")))
(require (prefix list: (lib "list.ss")))
(provide (all-defined-except r6rs:error)
	 (rename r6rs:error error))

(define fxior bitwise-ior)
(define fxxor bitwise-xor)
(define fxand bitwise-and)
(define fxarithmetic-shift-left arithmetic-shift)
(define (fxarithmetic-shift-right i n) (arithmetic-shift i (- n)))

(define get-u8 read-byte)
(define put-u8 write-byte)
(define lookahead-u8 peek-byte)

(define open-bytevector-input-port open-input-bytes)
(define open-bytevector-output-port open-output-bytes)
(define bytevector? bytes?)
(define make-bytevector make-bytes)
(define bytevector-length bytes-length)
(define (endianness s) (eq? s 'big))
(define bytevector-ieee-single-ref floating-point-bytes->real)
(define bytevector-ieee-double-ref floating-point-bytes->real)
(define (bytevector-ieee-single-set! v k x e) (real->floating-point-bytes x 4 e v))
(define (bytevector-ieee-double-set! v k x e) (real->floating-point-bytes x 8 e v))
(define bytevector->u8-list bytes->list)
(define u8-list->bytevector list->bytes)

(define (call-with-bytevector-output-port f)
  (let ((p (open-output-bytes)))
    (f p)
    (get-output-bytes p)))

(define find srfi:find)
(define filter srfi:filter)
(define partition srfi:partition)
(define remp srfi:remove)
(define fold-left srfi:fold)
(define fold-right srfi:fold-right)

(define list-sort list:mergesort)

(define (r6rs:error who msg . i)
  (srfi:error "error: ~a, ~a, ~a" who msg i))

)
