;; score.scm - (c) rohan drape, 2004-2006

;; A score is a list of OSC bundles.  The timestamps are given in
;; seconds where zero is the start of the score.  An OSC file is a
;; binary file format understood by the SC3 synthesis server, and
;; consists of a sequence of length prefixed OSC bundles.

;; Generate the byte vector for the score `data'.

(define (score->u8v data)
  (u8v-concat (map (lambda (bundle)
		     (let ((bundle* (osc->u8v bundle)))
		       (u8v-++ (i32->u8v (u8v-length bundle*)) bundle*)))
		   data)))

;; Parse the z element u8v b.

(define (u8v->score b z)
  (if (= z 0)
      '()
      (let ((n (u8v->i32 (u8v-copy* b 0 4))))
	(cons (u8v->osc (u8v-copy* b 4 (+ 4 n)))
	      (u8v->score (u8v-copy* b (+ 4 n) z) (- z (+ n 4)))))))
