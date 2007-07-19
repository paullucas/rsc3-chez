;; (WrapIndex bufnum in)

;; Index into a table with a signal.

;; The input signal value is truncated to an integer value and used as
;; an index into the table.  Out of range index values are wrapped
;; cyclically to the valid range.

;; bufnum - index of the buffer
;; in     - the input signal.

(->< s (/b_alloc 0 6 1))

(-> s (/b_setn* 0 0 (list 200 300 400 500 600 800)))

(let ((f (WrapIndex 0 (MouseX kr 0 18 0 0.1))))
  (Mul (SinOsc ar f 0) 0.5))
