;; (Stepper trig reset min max step resetval)

;; Stepper pulse counter.  Each trigger increments a counter which is
;; output as a signal. The counter wraps between min and max.

(-><! s (/b_alloc 10 128 1))

(let ((a (list 97.999 195.998 523.251 466.164 195.998
	       233.082 87.307 391.995 87.307 261.626
	       195.998 77.782 233.082 195.998 97.999
	       155.563)))
  (->! s (/b_setn* 10 0 a)))

(let* ((rate (MouseX kr 1 5 1 0.1))
       (clock (Impulse kr rate 0))
       (env (Decay2 clock 0.002 2.5))
       (index (Stepper clock 0 0 15 1 0))
       (freq (BufRd kr 1 10 index 1 1))
       (ffreq (Add (if #t
		       (Lag2 freq 0.1)
		       (Mul (MouseY kr 80 1600 1 0.1) (Add (Mul env 4) 2)))
		   (Mce 0 0.3)))
       (lfo (SinOsc kr 0.2 (Mce 0 half-pi 0.0024 0.0025))))
  (seq (out (mix (LFPulse ar (Mul freq (Mce 1 3/2 2)) 0 0.3)))
       (Mul (RLPF out ffreq 0.3) env)
       (Mul (RLPF out ffreq 0.3) env)
       (Mul out 0.02)
       ;; Echo
       (MulAdd (CombL out 1 (FDiv 0.66 rate) 2) 0.8 out)
       ;; Reverb
       (let ((rev out))
	 (for-each (lambda (_)
		     (set! rev (AllpassN rev
					 0.05
					 (make-mce (randl! 2 0 0.05))
					 (rand! 1.5 2.0))))
		   (iota 5))
	 (Add out (Mul rev 0.3)))
       (LeakDC out 0.1)
       ;; Flanger
       (Add (DelayL out 0.1 lfo) out)
       ;; Slight bass emphasis
       (OnePole out 0.9)))

;; Pattern randomizer....

(let ((p (map (lambda (e)
		(midicps (+ 36 (degree->key e (list 0 3 5 7 10) 12))))
	      (map floor-exact (randl! 16 0 15)))))
  (->! s (/b_setn* 10 0 p)))
