;; klang.scm - (c) rohan drape, 2003-2007

(module klang scheme/base

(require "../collection/list.scm"
	 "../graphdef/mce.scm"
	 "../graphdef/rate.scm"
	 "../math/constants.scm"
	 "../ugen/filter.scm"
	 "../ugen/operator.scm"
	 "../ugen/oscillator.scm"
	 "mix.scm")

(provide (all-defined-out))

;; Generate a 'spec' list for a Klang UGen.  `freqs' is a list that
;; determines the number of partials, `amps' and `phases' are possibly
;; abbreviated lists subject to expansion by 'extend' to the length of
;; `freqs'.

(define (klang-data freqs amps phases)
  (let ((n (length freqs)))
    (make-mce
     (interleave freqs
		 (extend amps n)
		 (extend phases n)))))

;; Variant to generate a 'spec' list for a Klank UGen, the last
;; argument is `ring-time', not `phases'.

(define klank-data klang-data)

(define (dyn-klank i fs fo ds s)
  (letrec ((gen (lambda (l)
		  (if (null? l)
		      0
		      (let ((f (car l))
			    (a (cadr l))
			    (d (caddr l)))
			(Add (Mul (Ringz i (MulAdd f fs fo) (Mul d ds)) a)
			     (gen (cdddr l))))))))
    (gen (mce-channels s))))

;; Frequency shifter, in terms of Hilbert UGen.

(define (freq-shift i f p)
  (let ((o (SinOsc ar f (Mce (Add p (* 0.5 pi)) p)))
	(h (Hilbert i)))
    (mix (Mul h o))))

)
