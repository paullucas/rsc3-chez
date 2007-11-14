;; constructor.scm - (c) rohan drape, 2005-2007

(module constructor scheme/base

(require (only-in srfi/1
		  make-list)
	 "../graphdef/output.scm"
	 "../graphdef/rate.scm"
	 "../graphdef/rate-of.scm"
	 "../graphdef/ugen.scm"
	 "mce.scm"
	 "proxied.scm")

(provide (all-defined-out))

;; name = <string> | <symbol>
;; rate? = <rate> | #f
;; inputs = <list> of <input*>
;; mce? = <input*> | #f
;; outputs = <integer>
;; special = <integer>

;; It is significant whether MCE or Proxing occurs first, the ordering
;; here follows that in sclang.

(define (construct-ugen name rate? inputs mce? outputs special id)
  (let* ((inputs* (if mce?
		      (append inputs (mce-l mce?))
		      inputs))
	 (rate (if rate?
		   rate?
		   (rate-select (map rate-of inputs*))))
	 (u (make-ugen
	     (if (symbol? name)
		 (symbol->string name)
		 name)
	     rate
	     inputs*
	     (make-outputs outputs rate)
	     special
	     id)))
    (proxied (mced u))))

)
