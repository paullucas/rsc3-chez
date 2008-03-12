(module r6rs scheme/base

(require (prefix-in srfi: (lib "1.ss" "srfi")))
(require (prefix-in srfi: (lib "23.ss" "srfi")))
(require (prefix-in list: (lib "list.ss")))

(provide fxior fxxor fxand fxarithmetic-shift-left fxarithmetic-shift-right
	 get-u8 put-u8 lookahead-u8
	 open-bytevector-input-port
	 open-bytevector-output-port
	 bytevector?
	 make-bytevector
	 bytevector-length
	 endianness
	 bytevector-ieee-single-ref
	 bytevector-ieee-double-ref
	 bytevector-ieee-single-set!
	 bytevector-ieee-double-set!
	 bytevector->u8-list
	 u8-list->bytevector
	 make-bytevector
	 call-with-bytevector-output-port
	 list-sort
	 ;; (rename-out (r6rs:error error)))
	 )

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
(define partition srfi:partition)
(define remp srfi:remove)
(define fold-left srfi:fold)
(define fold-right srfi:fold-right)

;; (define filter srfi:filter)

(define list-sort list:mergesort)

(define (r6rs:error who msg . i)
  (srfi:error "error: ~a, ~a, ~a" who msg i))

)
