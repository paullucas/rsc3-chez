;; mul-add.scm - (c) rohan drape, 2005

;; Determine if a multiply add stage is required.  That is if `value'
;; is not a lisp number or constant with a value of `identity', or a
;; list of such.

(define (mul-add? value identity)
  (if (list? value)
      (index (lambda (e) (mul-add? e identity)) value)
      (not (and (number? value) (= value identity)))))

;; If required create math ugens so that the value returned is equal
;; to '(u * mul) + add'.  `u' is either a <ugen> or <output-proxy>, or
;; a <list> of such.  `mul' and `add' are any values acceptable as a
;; <ugen> input.

(define mul-special-index 2)
(define add-special-index 0)

(define (mul-add u rate mul add)
  (let* ((mul? (mul-add? mul 1.0))
	 (add? (mul-add? add 0.0))
	 (m+a? (and mul? add?)))
    (cond (m+a? (make-ugen/mce 'MulAdd
			       rate 
			       (list u mul add) 
			       (list rate)
			       2))
	  (mul? (make-ugen/mce 'BinaryOpUGen
			       rate 
			       (list u mul) 
			       (list rate)
			       mul-special-index))
	  (add? (make-ugen/mce 'BinaryOpUGen
			       rate 
			       (list u add) 
			       (list rate)
			       add-special-index))
	  (else u))))
