;; (LorenzL.ar freq s r b h xi yi zi)

;; freq - iteration frequency in Hertz
;; s, r, b - equation variables
;; h - integration time step
;; xi - initial value of x
;; yi - initial value of y
;; zi - initial value of z

;; Lorenz chaotic generator.  A strange attractor discovered by Edward
;; N. Lorenz while studying mathematical models of the atmosphere.
;; The system is composed of three ordinary differential equations:

;; x' = s(y - x)
;; y' = x(r - z) - y
;; z' = xy - bz

;; The time step amount h determines the rate at which the ODE is
;; evaluated.  Higher values will increase the rate, but cause more
;; instability.  A safe choice is the default amount of 0.05.

;; vary frequency
(LorenzL.ar (MouseX.kr 20 (SampleRate.ir)) 
	    10.0 28.0 2.667 0.05 
	    0.1 0.0 0.0 
	    0.3)

;; randomly modulate params
(LorenzL.ar (SampleRate.ir)
	    (LFNoise0.kr 1 2 10)
	    (LFNoise0.kr 1 20 38)
	    (LFNoise0.kr 1 1.5 2)
	    0.05 
	    0.1 0.0 0.0
	    0.2)

;; as a frequency control
(SinOsc.ar (MulAdd.ar (Lag.ar (LorenzL.ar (MouseX.kr 1 200)) 0.003) 
		      800 900) 
	   0.0 0.4)
