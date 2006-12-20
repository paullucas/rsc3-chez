;; status.scm - (c) rohan drape, 2006

(define status-fields 
  (list "# UGens                     "
	"# Synths                    "
	"# Groups                    "
	"# Instruments               "
	"% CPU (Average)             "
	"% CPU (Peak)                "
	"Sample Rate (Nominal)       "
	"Sample Rate (Actual)        "))

(define (status-info r)
  (map number->string (cddr r)))

(define (status-format r)
  (cons "***** SuperCollider Server Status *****"
	(map string-append status-fields (status-info r))))

;; Collect server status information.

(define (server-status s)
  (let ((r (->< s /status)))
    (status-format r)))

(define (display-server-status s)
  (newline)
  (for-each display (intersperse (server-status s) "\n"))
  (newline))

;; Accessors

(define (server-status-field s n)
  (let ((r (->< s /status)))
    (list-ref r n)))

(define (server-sample-rate/nominal s)
  (server-status-field s 8))

(define (server-sample-rate/actual s)
  (server-status-field s 9))
