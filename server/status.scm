;; status.scm - (c) rohan drape, 2006-2008

(module status scheme/base

(require (only-in "../collection/list.scm"
		  intersperse)
	 (only-in "command.scm"
		  /status)
	 "server.scm")

(provide (all-defined-out))

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

(define (server-status fd)
  (send fd /status)
  (let ((r (wait fd "status.reply")))
    (status-format r)))

(define (display-server-status s)
  (newline)
  (for-each display (intersperse (server-status s) "\n"))
  (newline))

;; Accessors

(define (server-status-field fd n)
  (send fd /status)
  (let ((r (wait fd "status.reply")))
    (list-ref r n)))

(define (server-sample-rate/nominal s)
  (server-status-field s 8))

(define (server-sample-rate/actual s)
  (server-status-field s 9))

)
