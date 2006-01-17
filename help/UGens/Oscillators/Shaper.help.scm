;; (Shaper bufnum in)

;;  Wave shaper.  Performs waveshaping on the input signal by indexing
;;  into the table.

;; bufnum - the number of a buffer filled in wavetable format
;;          containing the transfer function.
;; in     - the input signal.

(-><! s (/b_alloc 10 512 1))

(-><! s (/b_gen* 10 "cheby" 0 (list 1 0 1 1 0 1)))

(Mul (Shaper 10 (Mul (SinOsc ar 300 0) (Line kr 0 1 6 2)))
     0.5)
