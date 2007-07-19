;; (RecordBuf bufnum offset reclevel prelevel run loop trigger inputs)

;; Records input into a Buffer.

;; If recLevel is 1.0 and preLevel is 0.0 then the new input
;; overwrites the old data.  If they are both 1.0 then the new data is
;; added to the existing data. (Any other settings are also valid.)

;; bufnum     - the index of the buffer to use
;; offset     - an offset into the buffer in samples, default 0
;; recLevel   - value to multiply by input before mixing with
;;              existing data. Default is 1.0.
;; preLevel   - value to multiply to existing data in buffer before
;;              mixing with input. Default is 0.0.
;; run        - If zero, then recording stops, otherwise recording
;;              proceeds. Default is 1.
;; loop       - If zero then don't loop, otherwise do.  This is
;;              modulate-able. Default is 1.
;; trigger    - a trigger causes a jump to the start of the Buffer.
;;              A trigger occurs when a signal changes from <=0 to >0.
;; inputArray - an Array of input channels

(send-synth 
 s "recorder"
 (letc ((in 0) (bufnum 0)
	(offset 1) (recLevel 1) (preLevel 0)
	(run 1) (loop 1) (trigger 1))
   (RecordBuf bufnum offset recLevel preLevel run loop trigger (In 2 ar in))))

(define b 10)

(->< s (/b_alloc b 44100 2))

(define y 1001)

(-> s (/s_new "recorder" y addToTail 1 "bufnum" b "in" 8))

(-> s (/n_trace y))

(send-synth 
 s "player"
 (letc ((bufnum 0) (rate 1) (trigger 1) (startPos 0) (loop 1) (gain 1))
   (Mul (PlayBuf 2 bufnum rate trigger startPos loop) gain)))

(define z 1002)

(-> s (/s_new "player" z addToTail 1 "bufnum" b))

(-> s (/n_set y "run" 1))

(-> s (/n_set z "loop" 1))
(-> s (/n_set z "gain" 2))
(-> s (/n_set z "trigger" 1))

(-> s (/n_free y))
(-> s (/n_free z))

(->< s (/b_free b))
