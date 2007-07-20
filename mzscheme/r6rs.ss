;; r6rs.ss - (c) rohan drape, 2006-2007

;; r6rs names...

(module r6rs mzscheme
(provide (all-defined))

(define fxior bitwise-ior)
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

)
