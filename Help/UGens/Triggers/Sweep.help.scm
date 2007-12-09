;; (Sweep trig rate)

;; Triggered linear ramp.  Starts a linear raise by rate/sec from zero
;; when trig input crosses from non-positive to positive.
	
;; Using sweep to modulate sine frequency

(let* ((t (Impulse kr (MouseX kr 0.5 20 1 0.1) 0))
       (f (Add (Sweep t 700) 500)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))

;; Using sweep to index into a buffer

(with-sc3
 (lambda (fd)
   (->< fd (/b_allocRead 0 "/home/rohan/audio/metal.wav" 0 0))))

(let* ((t (Impulse ar (MouseX kr 0.5 20 1 0.1) 0))
       (i (Sweep t (BufSampleRate ir 0))))
  (audition (Out 0 (BufRd 1 ar 0 i 0 2))))

;; Backwards, variable offset

(let* ((t (Impulse ar (MouseX kr 0.5 10 1 0.1) 0))
       (r (BufSampleRate ir 0))
       (i (Add (Sweep t (Neg r)) (Mul (BufFrames ir 0) (LFNoise0 kr 15)))))
  (audition (Out 0 (BufRd 1 ar 0 i 0 2))))

;; Raising rate

(let* ((t (Impulse ar (MouseX kr 0.5 10 1 0.1) 0))
       (r (Add (Sweep t 2) 0.5))
       (i (Sweep t (Mul (BufSampleRate ir 0) r))))
  (audition (Out 0 (BufRd 1 ar 0 i 0 2))))
