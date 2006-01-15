;; constructor.scm - (c) rohan drape, 2005-2006

;; name = <string>
;; rate? = <rate> | #f
;; inputs = <list> of <input*>
;; mce? = <input*> | #f
;; outputs = <integer>
;; special = <integer>

(define (construct-ugen name rate? inputs mce? outputs special id)
  (let* ((inputs* (if mce?
		      (++ inputs (mce-force mce?))
		      inputs))
	 (rate (if rate?
		   rate?
		   (rate-select (map rate-of inputs*)))))
    (make-ugen/proxies
     (symbol->string name)
     rate
     inputs*
     (make-outputs outputs rate)
     special
     id)))
