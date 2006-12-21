;; (DemandEnvGen rate levels times shapes curves gate reset
;;               levelScale levelOffset timeScale doneAction)

;; levels - a demand ugen or any other ugen

;; times  - a demand ugen or any other ugen if one of these ends, 
;;          the doneAction is evaluated

;; shapes - a demand ugen or any other ugen, the number given is 
;;          the shape number according to Env

;; curves - a demand ugen or any other ugen, if shape is 5, this 
;;          is the curve factor some curves/shapes don't work if 
;;          the duration is too short. have to see how to improve 
;;          this. also some depend on the levels obviously, like 
;;          exponential cannot cross zero.
	
;; gate   - if gate is x >= 1, the ugen runs, if gate is 0 > x > 1, 
;;          the ugen is released at the next level (doneAction), if 
;;          gate is x < 0, the ugen is sampled end held

;; reset  - if reset crosses from nonpositive to positive, the ugen 
;;          is reset at the next level, if it is > 1, it is reset 
;;          immediately.

;; Frequency envelope with random times.

(let* ((l (Dseq +inf.sc (Mce 204 400 201 502 300 200)))
       (t (Drand +inf.sc (Mce 1.01 0.2 0.1 2.0)))
       (y (MouseY kr 0.01 3 1 0.1))
       (f (DemandEnvGen ar l (Mul t y) 7 0 1 1 1 0 1 doNothing)))
  (Mul (SinOsc ar (Mul f (Mce 1 1.01)) 0) 0.1))

;; Frequency modulation

(let* ((x (MouseX kr -0.01 -4 0 0.1))
       (y (MouseY kr 1 3000 1 0.1))
       (s (randxl 32 200 1000))
       (l (lambda () (Dseq +inf.sc (make-mce (shuffle s)))))
       (t (Mul SampleDur y))
       (f (DemandEnvGen ar (Mce (l) (l)) t 5 x 1 1 1 0 1 doNothing)))
  (Mul (SinOsc ar f 0) 0.1))

;;  Gate. Mouse x on right side of screen toggles gate.

(let* ((x (MouseX kr 0 1 0 0.1))
       (l (Round (Dwhite +inf.sc 300 1000) 100))
       (f (DemandEnvGen kr l 0.1 5 0.3 (GT x 0.5) 1 1 0 1 doNothing)))
  (Mul (SinOsc ar (Mul f (Mce 1 1.21)) 0) 0.1))
