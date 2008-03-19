;; (buf-wr rate bufnum phase loop inputs)

;; Buffer writing oscillator.  Write to a buffer at an index. See also
;; buf-rd.

;; bufnum - the index of the buffer to use
;; phase  - modulateable index into the buffer (has to be audio rate).
;; loop   - 1 means true, 0 means false.  this is modulateable.
;; input  - input ugens (channelArray)

(let ((a (letc ((r 1))
	   (let* ((r* (mul (buf-rate-scale kr 0) r))
		  (p (phasor ar 0 r* 0 (buf-frames kr 0) 0))
		  (f (mul-add (lfnoise1 kr 2) 300 400))
		  (i (mul (sin-osc ar f 0) 0.1)))
	     (mrg2 (buf-wr 0 p 1 i)
		   (out 0 0.0)))))
      (b (letc ((r 1))
	   (let* ((r* (mul (buf-rate-scale kr 0) r))
		  (p (phasor ar 0 r* 0 (buf-frames kr 0) 0)))
	     (out 0 (buf-rd 1 ar 0 p 1 2))))))
  (with-sc3 
   (lambda (fd)
     (async fd (b-alloc 0 (* 44100 2) 1))
     (send-synth fd "a" a)
     (send-synth fd "b" b)
     (send fd (s-new0 "a" 1001 1 0))
     (send fd (s-new0 "b" 1002 1 0)))))

(define (do-send m)
  (with-sc3 (lambda (fd) (send fd m))))

(do-send (n-set1 1002 "r" 5))

(do-send (n-set1 1001 "r" (random 0 2)))

(do-send (n-set1 1002 "r" 2))
