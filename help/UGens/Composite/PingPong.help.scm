;; (PingPong.ar bufnum inputArray delayTime feedback rotate)

;; Stereo ping pong delay.  This is a language level UGen.

(define b (buffer-alloc (* 44100 2) 2 #t))

(let ((left (Decay2.ar (Impulse.ar 0.7 0.25) 0.01 0.25 
		       (SinOsc.ar (SinOsc.kr 3.7 0 200 500))))
      (right (Decay2.ar (Impulse.ar 0.5 0.25) 0.01 0.25
			(Resonz.ar (PinkNoise.ar 4) (SinOsc.kr 2.7 0 1000 2500) 0.2))))
  (PingPong.ar (buffer-id b) (list left right) 0.5 (MouseX.kr 0.1 0.9) 1))

(buffer-free b #t)
