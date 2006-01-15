;; constructor.scm - (c) rohan drape, 2005-2006

;; name = <string>
;; rate? = <rate> | #f
;; inputs = <list> of <input*>
;; mce? = <input*> | #f
;; outputs = <integer>
;; special = <integer>

;; It is significant whether MCE or Proxing occurs first, the ordering
;; here follows that in sclang.

(define (construct-ugen name rate? inputs mce? outputs special id)
  (let* ((inputs* (if mce?
		      (++ inputs (mce-channels mce?))
		      inputs))
	 (rate (if rate?
		   rate?
		   (rate-select (map rate-of inputs*))))
	 (u (make-ugen
	     (symbol->string name)
	     rate
	     inputs*
	     (make-outputs outputs rate)
	     special
	     id)))
    (proxied (mced u))))
