;; (Poll trig in trigid label)

;; Print/query the current output value of a UGen.

;; trig - a non-positive to positive transition telling Poll to return
;;        a value

;; in - the signal you want to poll

;; trigid - if greater then 0, a '/tr' message is sent back to the
;;          client (similar to SendTrig)

;; label - a string or symbol to be printed with the polled value

;; Poll returns its in signal (and is therefore transparent).
;; WARNING: Printing values from the Server in intensive for the
;; CPU. Poll should be used for debugging purposes.

(define (string->ugen s)
  (make-mce 
   (cons (string-length s)
	 (map char->integer (string->list s)))))

(let ((t (Impulse kr 2 0))
      (i (Line kr 0 1 5 removeSynth)))
  (audition (Poll t i 0 (string->ugen "Test"))))

(with-sc3
 (lambda (fd)
   (letrec ((print (lambda (e) (display e) (newline)))
	    (showing (lambda (f) (lambda () (let ((v (f))) (print v) v))))
	    (repeat (lambda (f) (if (f) (repeat f) #f))))
     (->< fd (/notify 1))
     (repeat (showing (lambda () (<- fd 1.0))))
     (->< fd (/notify 0)))))

;; Multichannel Expansion (Broken...)

(define (Poll* trig in trigId label)
  (Poll trig in trigId (string->ugen label)))

(Poll* (Impulse kr (Mce 10 5) 0)
       (Line kr 0 (Mce 1 5) (Mce 1 2) doNothing)
       0
       "Test")

(->< s /status)
