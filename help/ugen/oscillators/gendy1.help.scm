;; (gendy1 rate ampdist durdist adparam ddparam minfreq maxfreq 
;;         ampscale durscale initCPs knum)

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

;; minfreq - Minimum allowed frequency of oscillation for the gendy1
;;           oscillator, so gives the largest period the duration is
;;           allowed to take on.

;; maxfreq - Maximum allowed frequency of oscillation for the gendy1
;;           oscillator, so gives the smallest period the duration is
;;           allowed to take on.

;; ampscale - Normally 0.0 to 1.0, multiplier for the distribution's
;;            delta value for amplitude. An ampscale of 1.0 allows the
;;            full range of -1 to 1 for a change of amplitude.

;; durscale - Normally 0.0 to 1.0, multiplier for the distribution's
;;            delta value for duration. An ampscale of 1.0 allows the
;;            full range of -1 to 1 for a change of duration.

;; initCPs - initialise the number of control points in the
;;           memory. Xenakis specifies 12. There would be this number
;;           of control points per cycle of the oscillator, though the
;;           oscillator's period will constantly change due to the
;;           duration distribution.

;; knum - Current number of utilised control points, allows
;;        modulation.


;; sclang defaults: ampdist=1, durdist=1, adparam=1.0, ddparam=1.0,
;; minfreq=440, maxfreq=660, ampscale= 0.5, durscale=0.5, initCPs= 12,
;; knum=12.

(pan2 (gendy1 ar 1 1 1 1 440 660 0.5 0.5 12 12) 0 0.15)

;; Wandering bass

(pan2 (gendy1 ar 1 1 1.0 1.0 30 100 0.3 0.05 5 5) 0 0.15)

;; Play me	

(let* ((x (mouse-x kr 100 1000 1 0.1))
       (g (gendy1 ar 2 3 1 1 20 x 0.5 0.0 40 40)))
  (pan2 (mul (rlpf g 500 0.3) 0.2) 0.0 0.25))

;; Scream!

(let ((x (mouse-x kr 220 440 1 0.1))
      (y (mouse-y kr 0.0 1.0 0 0.1)))
 (pan2 (gendy1 ar 2 3 1 1 x (mul 8 x) y y 7 7) 0.0 0.3))

;; 1 CP = random noise

(pan2 (gendy1 ar 1 1 1 1 440 660 0.5 0.5 1 1) 0 0.15)

;; 2 CPs = an oscillator

(pan2 (gendy1 ar 1 1 1 1 440 660 0.5 0.5 2 2) 0 0.15)

;; Used as an LFO

(let* ((ad (mul-add (sin-osc kr 0.1 0) 0.49 0.51))
       (dd (mul-add (sin-osc kr 0.13 0) 0.49 0.51))
       (as (mul-add (sin-osc kr 0.17 0) 0.49 0.51))
       (ds (mul-add (sin-osc kr 0.19 0) 0.49 0.51))
       (g  (gendy1 kr 2 4 ad dd 3.4 3.5 as ds 10 10)))
  (pan2 (sin-osc ar (mul-add g 50 350) 0) 0.0 0.3))

;; Wasp

(let ((ad (mul-add (sin-osc kr 0.1 0) 0.1 0.9)))
  (pan2 (gendy1 ar 0 0 ad 1.0 50 1000 1 0.005 12 12) 0.0 0.2))

;; Modulate distributions. Change of pitch as distributions change
;; the duration structure and spectrum

(let* ((x (mouse-x kr 0 7 0 0.1))
       (y (mouse-y kr 0 7 0 0.1))
       (g (gendy1 ar x y 1 1 440 660 0.5 0.5 12 12)))
  (pan2 g 0 0.2))

;; Modulate number of CPs.

(let* ((x (mouse-x kr 1 13 0 0.1))
       (g (gendy1 ar 1 1 1 1 440 660 0.5 0.5 12 x)))
  (pan2 g 0 0.2))

;; Self modulation.

(let* ((x  (mouse-x kr 1 13 0 0.1))
       (y  (mouse-y kr 0.1 10 0 0.1))
       (g0 (gendy1 kr 5 4 0.3 0.7 0.1 y 1.0 1.0 5 5))
       (g1 (gendy1 ar 1 1 1 1 440 (mul-add g0 500 600) 0.5 0.5 12 x)))
  (pan2 g1 0.0 0.2))

;; Use SINUS to track any oscillator and take CP positions from it use
;; adparam and ddparam as the inputs to sample.

(let* ((p (lf-pulse kr 100 0 0.4))
       (s (mul (sin-osc kr 30 0) 0.5))
       (g (gendy1 ar 6 6 p s 440 660 0.5 0.5 12 12)))
  (pan2 g 0.0 0.2))

;; Near the corners are interesting.

(let* ((x (mouse-x kr 0 200 0 0.1))
       (y (mouse-y kr 0 200 0 0.1))
       (p (lf-pulse kr x 0 0.4))
       (s (mul (sin-osc kr y 0) 0.5))
       (g (gendy1 ar 6 6 p s 440 660 0.5 0.5 12 12)))
  (pan2 g 0.0 0.2))

;; Texture

(mix-fill 
 10 
 (lambda (_)
   (let* ((f (rand 130.0 160.3))
	  (ad (mul-add (sin-osc kr 0.1 0) 0.49 0.51))
	  (dd (mul-add (sin-osc kr 0.13 0) 0.49 0.51))
	  (as (mul-add (sin-osc kr 0.17 0) 0.49 0.51))
	  (ds (mul-add (sin-osc kr 0.19 0) 0.49 0.51))
	  (g  (gendy1 ar (rand 0 6) (rand 0 6) ad dd f f as ds 12 12)))
     (pan2 (sin-osc ar (mul-add g 200 400) 0)
	   (rand -1 1)
	   0.1))))

;; Try durscale 10.0 and 0.0 too.

(let* ((x (mouse-x kr 10 700 0 0.1))
       (y (mouse-y kr 50 1000 0 0.1))
       (g (gendy1 ar 2 3 1 1 1 x 0.5 0.1 10 10)))
  (pan2 (comb-n (resonz g y 0.1) 0.1 0.1 5) 0.0 0.6))

;; Overkill

(define (overkill i)
  (mix-fill 
   i
   (lambda (_)
     (let* ((f (rand 50 560.3))
	    (n (rand 2 20))
	    (k (mul-add (sin-osc kr (exp-rand 0.02 0.2) 0) (fdiv n 2) (fdiv n 2)))
	    (g (gendy1 ar 
		       (rand 0 6) (rand 0 6) (rand 0 1) (rand 0 1) f f 
		       (rand 0 1) (rand 0 1) n k)))
       (pan2 g (rand -1 1) (fdiv 0.5 (sqrt i)))))))

(overkill 10)

;; Another traffic moment

(let ((x (mouse-x kr 100 2000 0 0.1))
      (y (mouse-y kr 0.01 1.0 0 0.1)))
  (resonz (overkill 10) x y))
