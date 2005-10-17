;; (Stepper trig reset min max step resetval)

;; Stepper pulse counter.  Each trigger increments a counter which is
;; output as a signal. The counter wraps between min and max.

(-> "/b_alloc" 10 128)

(let ((a (list 97.999 195.998 523.251 466.164 195.998 
	       233.082 87.307 391.995 87.307 261.626 
	       195.998 77.782 233.082 195.998 97.999 
	       155.563)))
  (apply -> "/b_setn" 10 0 (length a) a))

(let* ((rate (MouseX.kr 1 5 1))
       (clock (Impulse.kr rate)) 
       (env (Decay2.kr clock 0.002 2.5))
       (index (Stepper.kr clock 0 0 15 1 0))
       (freq (BufRd.kr 1 10 index 1 1))
       (ffreq (Add (if #t 
		       (Lag2.kr freq) 
		       (Mul (MouseY.kr 80 1600 1) (Add (Mul env 4) 2)))
		   (list 0 0.3)))
       (lfo (SinOsc.kr 0.2 (list 0 half-pi 0.0024 0.0025))))
  (seq (out (Mix (LFPulse.ar (Mul freq '(1 3/2 2)) 0 0.3)))
       (RLPF.ar out ffreq 0.3 env)
       (RLPF.ar out ffreq 0.3 env)
       (Mul out 0.02)
       ;; Echo
       (CombL.ar out 1 (FDiv 0.66 rate) 2 0.8 out)
       ;; Reverb
       (let ((rev out))
	 (do-times 5 (set! rev (AllpassN.ar rev 
					    0.05 
					    (random-list 2 0.05) 
					    (random 1.5 2.0))))
	 (Add out (Mul rev 0.3)))
       (LeakDC.ar out)
       ;; Flanger
       (DelayL.ar out 0.1 lfo 1 out)
       ;; Slight bass emphasis
       (OnePole.ar out 0.9)))

;; Pattern randomizer....

(define m '(0 3 5 7 10))

(define-procedure (degreeToKey scaleDegree scale (stepsPerOctave 12))
  (+ (* stepsPerOctave (quotient scaleDegree (length scale)))
     (at scale scaleDegree)))

(apply -> 
       "/b_setn" 10 0 16 
       (map (lambda (e) 
	      (midi-note->frequency (+ 36 (degreeToKey e m))))
	    (randomI-list 16 0 15)))
