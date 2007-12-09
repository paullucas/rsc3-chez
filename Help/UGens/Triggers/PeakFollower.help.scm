;; (PeakFollower in decay)

;; Track peak signal amplitude.  Outputs the peak amplitude of the
;; signal received at the input.  If level is below maximum, the level
;; decreases by the factor given in decay.

;; in    - input signal.
;; decay - decay factor.

;; Internally, the absolute value of the signal is used, to prevent
;; underreporting the peak value if there is a negative DC offset. To
;; obtain the minimum and maximum values of the signal as is, use the
;; RunningMin and RunningMax UGens.


;; No decay

(let* ((s (Mul (Dust ar 20) (Line kr 0 1 4 doNothing)))
       (f (MulAdd (PeakFollower s 1.0) 1500 200)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))

;; A little decay

(let* ((s (Mul (Dust ar 20) (Line kr 0 1 4 doNothing)))
       (f (MulAdd (PeakFollower s 0.999) 1500 200)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))

;; Mouse x controls decay

(let* ((x (MouseX kr 0.99 1.0001 1 0.1))
       (s (Mul (Dust ar 20) (Line kr 0 1 4 doNothing)))
       (f (MulAdd (PeakFollower s (Min x 1.0)) 1500 200)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))

;; Follow a sine lfo

(let* ((x (MouseX kr 0.99 1.0001 1 0.1))
       (s (SinOsc kr 0.2 0))
       (f (MulAdd (PeakFollower s (Min x 1.0)) 200 500)))
  (audition (Out 0 (Mul (SinOsc ar f 0) 0.2))))
