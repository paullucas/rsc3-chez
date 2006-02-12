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

(->< s (/d_recv
 (synthdef
  "RecordBuf-example"
  (letc ((in 0) (bufnum 0)
	 (offset 1) (recLevel 1) (preLevel 0)
	 (run 1) (loop 1) (trigger 1))
    (RecordBuf bufnum offset recLevel preLevel run loop trigger (In ar in 1))))))

(define b (buffer-alloc 44100 1 #t))

(define y (synth-new "RecordBuf-example" `(bufnum ,(buffer-id b) in 2)))

(-> "/s_trace" (synth-id y))

(synth-set y 'run 1)

(define z (synth-new "PlayBuf-example" `(bufnum ,(buffer-id b))))

(synth-set z 'loop 1)
(synth-set z 'gain 0.1)
(synth-set z 'trigger 1)

(synth-free y)

(synth-free z)

(buffer-free b)
