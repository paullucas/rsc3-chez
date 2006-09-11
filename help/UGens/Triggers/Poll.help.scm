;; (Poll trig in trigid label)

;; Print the current output value of a UGen.

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

(define (Poll* trig in trigId label)
  (Poll trig in trigId (string->ugen label)))

(Poll* (Impulse kr 10 0)
       (Line kr 0 1 1 doNothing)
       0
       "Test")

;; Multichannel Expansion (Broken...)

(Poll* (Impulse kr (Mce 10 5) 0)
       (Line kr 0 (Mce 1 5) (Mce 1 2) doNothing)
       0
       "Test")

(->< s /status)
