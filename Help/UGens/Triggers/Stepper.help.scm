;; (Stepper trig reset min max step resetval)

;; Stepper pulse counter.  Each trigger increments a counter which is
;; output as a signal. The counter wraps between min and max.

(with-sc3 
 (lambda (fd)
   (let ((a (list 97.999 195.998 523.251 466.164 195.998
		  233.082 87.307 391.995 87.307 261.626
		  195.998 77.782 233.082 195.998 97.999
		  155.563)))
     (async fd (/b_alloc 10 128 1))
     (send fd (/b_setn1 10 0 a)))))

;; Function composition...

(define (seq s l)
  (if (null? l)
      s
      (seq ((car l) s) (cdr l))))

(let* ((rate (MouseX kr 1 5 1 0.1))
       (clock (Impulse kr rate 0))
       (env (Decay2 clock 0.002 2.5))
       (index (Stepper clock 0 0 15 1 0))
       (freq (BufRd 1 kr 10 index 1 1))
       (ffreq (Add (if #t
		       (Lag2 freq 0.1)
		       (Mul (MouseY kr 80 1600 1 0.1) (Add (Mul env 4) 2)))
		   (Mce 0 0.3)))
       (lfo (SinOsc kr 0.2 (Mce 0 (/ pi 2) 0.0024 0.0025)))
       (rvb (lambda (s) (AllpassN s
				  0.05
				  (clone 2 (Rand 0 0.05))
				  (Rand 1.5 2.0))))
       (proc (list 
	      (lambda (s) (Mul (RLPF s ffreq 0.3) env))
	      (lambda (s) (Mul (RLPF s ffreq 0.3) env))
	      (lambda (s) (Mul s 0.2))
	      ;; Echo
	      (lambda (s) (MulAdd (CombL s 1 (FDiv 0.66 rate) 2) 0.8 s))
	      ;; Reverb
	      (lambda (s) (Add s (Mul (seq s (replicate 5 rvb)) 0.3)))
	      (lambda (s) (LeakDC s 0.1))
	      ;; Flanger
	      (lambda (s) (Add (DelayL s 0.1 lfo) s))
	      ;; Slight bass emphasis
	      (lambda (s) (OnePole s 0.9))))
       (init (mix (LFPulse ar (Mul freq (Mce 1 3/2 2)) 0 0.3))))
  (audition (Out 0 (seq init proc))))

;; Pattern randomizer....

(with-sc3
 (lambda (fd)
   (let ((p (map (lambda (e)
		   (midicps (+ 36 (degree->key e (list 0 3 5 7 10) 12))))
		 (map floor-exact (randl 16 0 15)))))
     (send fd (/b_setn1 10 0 p)))))

;; A shorter variant, using some simple syntax...

(define-syntax seq*
  (syntax-rules ()
    ((_ i s f ...)
     (seq i (list (lambda (s) f) ...)))))

(let* ((rate (MouseX kr 1 5 1 0.1))
       (clock (Impulse kr rate 0))
       (env (Decay2 clock 0.002 2.5))
       (index (Stepper clock 0 0 15 1 0))
       (freq (BufRd 1 kr 10 index 1 1))
       (ffreq (Add (Lag2 freq 0.1) (Mce 0 0.3)))
       (lfo (SinOsc kr 0.2 (Mce 0 (/ pi 2) 0.0024 0.0025)))
       (rvb (lambda (s) (AllpassN s
				  0.05
				  (clone 2 (Rand 0 0.05))
				  (Rand 1.5 2.0))))
       (init (mix (LFPulse ar (Mul freq (Mce 1 3/2 2)) 0 0.3)))
       (proc (seq* init
		   s
		   (Mul (RLPF s ffreq 0.3) env)
		   (Mul (RLPF s ffreq 0.3) env)
		   (Mul s 0.2)
		   (MulAdd (CombL s 1 (FDiv 0.66 rate) 2) 0.8 s)
		   (Add s (Mul (seq s (replicate 5 rvb)) 0.3))
		   (LeakDC s 0.1)
		   (Add (DelayL s 0.1 lfo) s)
		   (OnePole s 0.9))))
  (audition (Out 0 proc)))
