;; read.scm - (c) rohan drape, 2002-2006

;; Since a pure decode/scan without shared u8vs is very
;; inefficient, implement read/scan-* forms.

;; Evaluates to the string encoded at the OSC byte stream `port'.

(define (read/scan-string! port)
  (let loop ((b (read-u8v! 4 port))
	     (r (list)))
    (if (eq? 0 (u8v-ref b 3))
	(decode/scan-string (u8v-concat (reverse (cons b r))))
	(loop (read-u8v! 4 port) (cons b r)))))

;; Evaluates to the byte string encoded at the OSC byte stream `port'.

(define (read/scan-bytes! port)
  (let* ((n (u8v->i32 (read-u8v! 4 port)))
	 (b (read-u8v! n port)))
    (read-u8v! (- 4 (modulo n 4)) port)
    b))

;; Evaluates to the object, described by the OSC type character
;; `type', encoded at the OSC byte stream `port'.

(define (read/scan-value! type port)
  (cond ((eq? type #\i) (u8v->i32 (read-u8v! 4 port)))
	((eq? type #\t) (u8v->u64 (read-u8v! 8 port)))
	((eq? type #\h) (u8v->i64 (read-u8v! 8 port)))
	((eq? type #\f) (u8v->f32 (read-u8v! 4 port)))
	((eq? type #\d) (u8v->f64 (read-u8v! 8 port)))
	((eq? type #\s) (read/scan-string! port))
	((eq? type #\b) (read/scan-bytes! port))
	(else           (error "read/scan-value: bad type" type))))

;; Evaluate to the list of objects encoded at the OSC byte stream
;; `port', conforming to the types given in the OSC character type
;; list `types'.

(define (read/scan-arguments! types port)
  (if (null? types)
      '()
      (cons (read/scan-value! (car types) port)
	    (read/scan-arguments! (cdr types) port))))

;; Evaluate to the scheme representation of the OSC message at the OSC
;; byte stream `port'.  The first object is the 'address' of the
;; message, any subsequent objects are arguments for that address.

(define (read/scan-message! port)
  (let* ((address (read/scan-string! port))
	 (type-descriptor (read/scan-string! port)))
    (cons address
	  (read/scan-arguments! (cdr (string->list type-descriptor))
				    port))))

;; Evaluate to a scheme representation of the OSC bundle encoded at
;; the OSC stream `port'.  The bundle ends at the end of the byte
;; stream.  The first object is the <real> UTC 'timetag' of the
;; bundle, any subsequent objects are either OSC messages or embedded
;; OSC bundles.

(define (read/scan-bundle! port)
  (let ((bundletag (read/scan-string! port))
	(timetag (ntp->utc. (u8v->u64 (read-u8v! 8 port))))
	(parts (list)))
    (if (not (equal? bundletag "#bundle"))
	(error "read/scan-bundle!: Illegal bundle tag" bundletag)
	(cons timetag
	      (let loop ((parts (list)))
		(if (eof-object? (peek-char port))
		    (reverse parts)
		    (begin
		      ;; We have no use for the message size...
		      (u8v->i32 (read-u8v! 4 port))
		      (loop (cons (read/scan-packet! port) parts)))))))))

;; Evaluate to the scheme representation of the OSC packet encoded at
;; the OSC byte stream `port'. An OSC packet is either an OSC message
;; or an OSC bundle.

(define (read/scan-packet! port)
  (if (eq? (peek-char port) #\#)
      (read/scan-bundle! port)
      (read/scan-message! port)))

