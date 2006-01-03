;; (RecordBuf bufnum offset reclevel prelevel run loop trigger inputs)

(synthdef-send
 (synthdef
  "RecordBuf-example"
  ((in 0) (bufnum 0) 
   (offset 1) (recLevel 1) (preLevel 0) 
   (run 1) (loop 1) (trigger 1))
  (RecordBuf ar bufnum offset recLevel preLevel run loop trigger (In ar in 1))))

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
