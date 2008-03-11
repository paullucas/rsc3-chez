;; (Shaper bufnum in)

;; Wave shaper.  Performs waveshaping on the input signal by indexing
;; into the table.

;; bufnum - the number of a buffer filled in wavetable format
;;          containing the transfer function.
;; in     - the input signal.

(with-sc3
 (lambda (fd)
   (async fd (/b_alloc 10 512 1))
   (async fd (/b_gen* 10 "cheby" 0 (list 1 0 1 1 0 1)))))

(audition
 (let* ((a (Line kr 0 1 6 removeSynth))
	(s (Mul (SinOsc ar 300 0) a)))
   (Out 0 (Mul (Shaper 10 s) 0.5))))
