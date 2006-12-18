;; (Sweep trig rate)

;; Triggered linear ramp.  Starts a linear raise by rate/sec from zero
;; when trig input crosses from non-positive to positive.
	
;; Using sweep to modulate sine frequency

(let ((trig (Impulse kr (MouseX kr 0.5 20 1 0.1) 0)))
  (Mul (SinOsc ar (Add (Sweep trig 700) 500) 0) 0.2))

;; Using sweep to index into a buffer

(->< s (/b_allocRead 0 "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

(let ((trig (Impulse ar (MouseX kr 0.5 20 1 0.1) 0)))
  (BufRd 1 ar 0 (Sweep trig (BufSampleRate ir 0)) 0 2))

;; Backwards, variable offset

(let* ((trig (Impulse ar (MouseX kr 0.5 10 1 0.1) 0))
       (rate (BufSampleRate ir 0))
       (pos  (Add (Sweep trig (Neg rate)) (Mul (BufFrames ir 0) (LFNoise0 kr 15)))))
  (BufRd 1 ar 0 pos 0 2))

;; Raising rate

(let* ((trig (Impulse ar (MouseX kr 0.5 10 1 0.1) 0))
       (rate (Add (Sweep trig 2) 0.5)))
  (BufRd 1 ar 0 (Sweep trig (Mul (BufSampleRate ir 0) rate)) 0 2))
