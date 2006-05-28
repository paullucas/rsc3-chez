;; decode.scm - (c) rohan drape, 2002-2006

;; Since a pure decode/scan without shared u8vs is very
;; inefficient, implement read/scan-* forms.

;; Evaluates to the string encoded at the OSC byte stream `p'.

(define (decode/scan-string b)
  (u8v->string (u8v-copy* b 0 (u8v-index b 0))))

(define (read/scan-string p)
  (let loop ((b (read-u8v 4 p))
	     (r (list)))
    (if (eq? 0 (u8v-ref b 3))
	(decode/scan-string (u8v-concat (reverse (cons b r))))
	(loop (read-u8v 4 p) (cons b r)))))

;; Evaluates to the byte string encoded at the OSC byte stream `p'.

(define (read/scan-bytes p)
  (let* ((n (_i32 p))
	 (b (read-u8v n p)))
    (read-u8v (- 4 (modulo n 4)) p)
    b))

;; Evaluates to the object, described by the OSC type character
;; `type', encoded at the OSC byte stream `p'.

(define (read/scan-value type p)
  (cond ((eq? type #\i) (_i32 p))
	((eq? type #\t) (_u64 p))
	((eq? type #\h) (_i64 p))
	((eq? type #\f) (_f32 p))
	((eq? type #\d) (_f64 p))
	((eq? type #\s) (read/scan-string p))
	((eq? type #\b) (read/scan-bytes p))
	(else           (error "read/scan-value: bad type" type))))

;; Evaluate to the list of objects encoded at the OSC byte stream
;; `p', conforming to the types given in the OSC character type
;; list `types'.

(define (read/scan-arguments types p)
  (if (null? types)
      '()
      (cons (read/scan-value (car types) p)
	    (read/scan-arguments (cdr types) p))))

;; Evaluate to the scheme representation of the OSC message at the OSC
;; byte stream `p'.  The first object is the 'address' of the
;; message, any subsequent objects are arguments for that address.

(define (read/scan-message p)
  (let* ((address (read/scan-string p))
	 (type-descriptor (read/scan-string p)))
    (cons address
	  (read/scan-arguments (cdr (string->list type-descriptor))
			       p))))

;; Evaluate to a scheme representation of the OSC bundle encoded at
;; the OSC stream `p'.  The bundle ends at the end of the byte
;; stream.  The first object is the <real> UTC 'timetag' of the
;; bundle, any subsequent objects are either OSC messages or embedded
;; OSC bundles.

(define (read/scan-bundle p)
  (let ((bundletag (read/scan-string p))
	(timetag (ntp->utc. (_u64 p)))
	(parts (list)))
    (if (not (equal? bundletag "#bundle"))
	(error "read/scan-bundle: Illegal bundle tag" bundletag)
	(cons timetag
	      (let loop ((parts (list)))
		(if (eof-object? (peek-char p))
		    (reverse parts)
		    (begin
		      ;; We have no use for the message size...
		      (_i32 p)
		      (loop (cons (read/scan-packet p) parts)))))))))

;; Evaluate to the scheme representation of the OSC packet encoded at
;; the OSC byte stream `p'. An OSC packet is either an OSC message
;; or an OSC bundle.

(define (read/scan-packet p)
  (if (eq? (peek-char p) #\#)
      (read/scan-bundle p)
      (read/scan-message p)))

(define (u8v->osc b) 
  (let ((p (open-input-u8v b)))
    (read/scan-packet p)))


