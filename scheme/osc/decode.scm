;; decode.scm - (c) rohan drape, 2002-2006

;; Evaluates to the <string> encoded at the OSC <u8v> `b'.  This
;; deletes the zero padding at the end of the string.

(define (decode/scan-string b)
  (u8v->string (u8v-copy* b 0 (u8v-index b 0))))

;; Evaluates to the <u8v> encoded at the OSC <u8v> `b'.

(define (decode/scan-bytes b)
  (u8v-copy* b 4 (+ 4 (u8v->i32 (u8v-copy* b 0 4)))))

;; Evaluates to the value described by the OSC type character `type'
;; encoded at the OSC <u8v> `b'.

(define (decode/scan-value type b)
  (case type
    ((#\i) (u8v->i32 b))
    ((#\h) (u8v->i64 b))
    ((#\t) (u8v->u64 b))
    ((#\f) (u8v->f32 b))
    ((#\d) (u8v->f64 b))
    ((#\s) (decode/scan-string b))
    ((#\b) (decode/scan-bytes b))
    (else  (error "decode/scan-value: illegal type" type))))

;; Since a pure decode without shared u8vs is very inefficient,
;; defer to read-* forms.

(define (decode-message b)
  (read/scan-message (open-input-u8v b)))

(define (decode-bundle b)
  (read/scan-bundle (open-input-u8v b)))

;; Evaluate to the scheme representation of the OSC packet encoded at
;; the OSC <u8v> `b' starting at the integer offset `start'.  An
;; OSC packet is either an OSC message or an OSC bundle.

(define (decode-packet b)
  (if (= (u8v-ref b 0) (char->integer #\#))
      (decode-bundle b)
      (decode-message b)))

(define (u8v->osc b) (decode-packet b))

