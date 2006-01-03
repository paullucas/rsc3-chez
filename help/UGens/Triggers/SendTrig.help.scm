;; (SendTrig in id value)

;; On receiving a trigger (0 to non-zero transition), send a trigger
;; message from the server back to the client.

;; input - the trigger 

;; id - an integer that will be passed with the trigger message.  This
;;   	is useful if you have more than one SendTrig in a SynthDef

;; value - a UGen or float that will be polled at the time of trigger,
;;         and its value passed with the trigger message
					
(osc-responder-register
 "/tr" 
 (lambda (packet)
   (inform "Packet arrived:" packet)))

(let ((s (Dust ar 0.1 0 0.9)))
  (SendTrig ar s)
  s)


