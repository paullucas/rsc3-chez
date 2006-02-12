;; (SendTrig in id value)

;; On receiving a trigger (0 to non-zero transition), send a trigger
;; message from the server back to the all registered clients.
;; Clients register by sending a /notify message to the server.

;; input - the trigger

;; id - an integer that will be passed with the trigger message.  This
;;   	is useful if you have more than one SendTrig in a SynthDef

;; value - a UGen or float that will be polled at the time of trigger,
;;         and its value passed with the trigger message

(let ((s (LFNoise0 R0 kr 10)))
  (Mrg (SendTrig s 0 s)
       (Out 0 (Mul (SinOsc ar (MulAdd s 200 500) 0) 0.1))))

(->< s (/notify 1))

(<-* s 0.1)

(->< s (/notify 0))
