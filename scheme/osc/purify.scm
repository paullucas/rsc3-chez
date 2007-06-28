;; purify.scm - (c) rohan drape, 2005-2007

(module purify (lib "lang.ss" "r5rs")
(#%require (only "../u8/u8l.scm"
		 u8l?)
	   (only (lib "23.ss" "srfi")
		 error))
(#%provide (all-defined))

;; Evaluates to a type-correct form of the OSC data `e'.  This
;; procedure does not verify that `e' is syntactically correct.
;; Boolean values are rewritten as integers, zero for '#f' and one for
;; '#t'.  Symbols are rewritten as the strings given by
;; 'symbol->string'.  An error is raised if `e' cannot be rewritten.
;; Note that R5RS does not require symbols to be case sensitive
;; although most interpreters will have an option to set this.

(define (purify e)
  (cond ((or (number? e) (string? e) (u8l? e)) e)
	((list? e) (map purify e))
	((symbol? e) (symbol->string e))
	((boolean? e) (if e 1 0))
	(else (error "purify: illegal input" e))))

)
