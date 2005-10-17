;;; (Gendy1 ampdist durdist adparam ddparam minfreq maxfreq ampscale durscale initCPs knum)

;; An implementation of the dynamic stochastic synthesis generator
;; conceived by Iannis Xenakis and described in Formalized Music
;; (1992, Stuyvesant, NY: Pendragon Press) chapter 9 (pp 246-254) and
;; chapters 13 and 14 (pp 289-322). The BASIC program in the book was
;; written by Marie-Helene Serra so I think it helpful to credit her
;; too.

;; ampdist - Choice of probability distribution for the next
;;           perturbation of the amplitude of a control point.

;; The distributions are (adapted from the GENDYN program in
;; Formalized Music):

;;   0- LINEAR
;;   1- CAUCHY
;;   2- LOGIST
;;   3- HYPERBCOS
;;   4- ARCSINE
;;   5- EXPON
;;   6- SINUS

;; Where the sinus (Xenakis' name) is in this implementation taken as
;; sampling from a third party oscillator. See example below.

;; durdist - Choice of distribution for the perturbation of the
;;           current inter control point duration.

;; adparam - A parameter for the shape of the amplitude probability
;;           distribution, requires values in the range 0.0001 to 1
;;           (there are safety checks in the code so don't worry too
;;           much if you want to modulate.)

;; ddparam - A parameter for the shape of the duration probability
;;           distribution, requires values in the range 0.0001 to 1

;; minfreq - Minimum allowed frequency of oscillation for the Gendy1
;;           oscillator, so gives the largest period the duration is
;;           allowed to take on.

;; maxfreq - Maximum allowed frequency of oscillation for the Gendy1
;;           oscillator, so gives the smallest period the duration is
;;           allowed to take on.

;; ampscale - Normally 0.0 to 1.0, multiplier for the distribution's
;;            delta value for amplitude. An ampscale of 1.0 allows the
;;            full range of -1 to 1 for a change of amplitude.

;; durscale - Normally 0.0 to 1.0, multiplier for the distribution's
;;            delta value for duration. An ampscale of 1.0 allows the
;;            full range of -1 to 1 for a change of duration.

;; initCPs - Initialise the number of control points in the
;;           memory. Xenakis specifies 12. There would be this number
;;           of control points per cycle of the oscillator, though the
;;           oscillator's period will constantly change due to the
;;           duration distribution.

;; knum - Current number of utilised control points, allows
;;        modulation.


;; Defaults	

(Pan2.ar (Gendy1.ar))

;; Wandering bass

(Pan2.ar (Gendy1.ar 1 1 1.0 1.0 30 100 0.3 0.05 5))

(Pan2.ar (RLPF.ar (Gendy1.ar 2 3 minfreq: 20 maxfreq: (MouseX.kr 100 1000) durscale: 0.0 initCPs: 40 knum: 40) 500 0.3 0.2) 0.0)

(let ((mx (MouseX.kr 220 440))
   (my (MouseY.kr 0.0 1.0)))
 (Pan2.ar (Gendy1.ar 2 3 1 1 minfreq: mx maxfreq: (Mul 8 mx) ampscale: my durscale: my initCPs: 7 knum: 7 mul: 0.3) 0.0))

;; Noise

(Pan2.ar (Gendy1.ar initCPs: 1 knum: 1))

(Pan2.ar (Gendy1.ar initCPs: 2 knum: 2))

;; Used as an LFO

(let ((adparam (SinOsc.kr 0.1 0 0.49 0.51))
      (ddparam (SinOsc.kr 0.13 0 0.49 0.51))
      (ampscale (SinOsc.kr 0.17 0 0.49 0.51))
      (durscale (SinOsc.kr 0.19 0 0.49 0.51)))
  (Pan2.ar 
   (SinOsc.ar 
    (Gendy1.kr 2 4 adparam ddparam 3.4 3.5 ampscale durscale 10 10 50 350) 0 0.3) 0.0))

;; Wasp

(Pan2.ar (Gendy1.ar 0 0 (SinOsc.kr 0.1 0 0.1 0.9) 1.0 50 1000 1 0.005 12 12 0.2) 0.0)

;; Modulate distributions. Change of pitch as distributions change
;; the duration structure and spectrum

(Pan2.ar (Gendy1.ar (MouseX.kr 0 7) (MouseY.kr 0 7) mul: 0.2) 0.0)

;; Modulate number of CPs.

(Pan2.ar (Gendy1.ar knum: (MouseX.kr 1 13) mul: 0.2) 0.0)

;; Self modulation.

(Pan2.ar (Gendy1.ar maxfreq: (Gendy1.kr 5 4 0.3 0.7 0.1 (MouseY.kr 0.1 10) 1.0 1.0 5 5 500 600) 
		  knum: (MouseX.kr 1 13) mul: 0.2) 0.0)

;; Use SINUS to track any oscillator and take CP positions from it use
;; adparam and ddparam as the inputs to sample.

(Pan2.ar (Gendy1.ar 6 6 (LFPulse.kr 100 0 0.4 1.0) (SinOsc.kr 30 0 0.5) mul: 0.2) 0.0)

;; Near the corners are interesting.

(Pan2.ar (Gendy1.ar 6 6 (LFPulse.kr (MouseX.kr 0 200) 0 0.4 1.0) (SinOsc.kr (MouseY.kr 0 200) 0 0.5) mul: 0.2) 0.0)

;; Texture

(Mix.fill 
 10 
 (lambda ()
   (let ((freq (random 130.0 160.3))
	 (adparam (SinOsc.kr 0.1 0 0.49 0.51))
	 (ddparam (SinOsc.kr 0.13 0 0.49 0.51))
	 (ampscale (SinOsc.kr 0.17 0 0.49 0.51))
	 (durscale (SinOsc.kr 0.19 0 0.49 0.51)))
     (Pan2.ar (SinOsc.ar (Gendy1.ar (random 6) (random 6) adparam ddparam freq freq ampscale durscale 12 12 200 400) 0 0.1) 
	      (random -1 1)))))

;; Try durscale 10.0 and 0.0 too.

(Pan2.ar
 (CombN.ar
  (Resonz.ar
   (Gendy1.ar 2 3 minfreq: 1 maxfreq: (MouseX.kr 10 700) durscale: 0.1 initCPs: 10 knum: 10)
   (MouseY.kr 50 1000) 0.1)
  0.1 0.1 5 0.6)
 0.0)

;; Overkill

(define (overkill n)
  (define (exprand a b) (random* random-exponential-normal a b))
  (Mix.fill 
   n 
   (lambda ()
     (let* ((freq (random 50 560.3))
	    (numcps (random 2 20))
	    (knum (SinOsc.kr (exprand 0.02 0.2) 0 (FDiv numcps 2) (FDiv numcps 2))))
       (Pan2.ar (Gendy1.ar (random 6) (random 6) (random 1) (random 1) freq freq (random 1) (random 1) numcps knum 
			   (FDiv 0.5 (Sqrt n))) 
		(random -1 1))))))

(overkill 10)

;; Another traffic moment

(Resonz.ar (overkill 10) (MouseX.kr 100 2000) (MouseY.kr 0.01 1.0))
