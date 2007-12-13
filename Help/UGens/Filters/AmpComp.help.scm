;; (AmpComp freq root exp)

;; Basic psychoacoustic amplitude compensation.

;; Implements the (optimized) formula: compensationFactor = (root /
;; freq) ** exp.  Higher frequencies are normally perceived as louder,
;; which AmpComp compensates.

;; See also AmpCompA

;; freq - input frequency value. For freq == root, the output is 1.0.

;; root - root freq relative to which the curve is calculated (usually
;;        lowest freq) default value: C (60.midicps)

;; exp - exponent. how steep the curve decreases for increasing freq
;;       (see plots below). default value 0.3333

;; Note that for frequencies very much smaller than root the
;; amplitudes can become very high.  In this case limit the freq with
;; freq.max(minval), or use AmpCompA.

;; compare a sine without compensation with one that uses amplitude
;; compensation

(let* ((x (MouseX kr 300 15000 1 0.1))
       (y (MouseY kr 0 1 0 0.1))
       (o (Mul (SinOsc ar x 0) 0.1))
       (c (AmpComp x 300 0.333))) 
  (audition (Out 0 (Mce (Mul o y) (Mul* o (Sub 1 y) c)))))

;; different sounds cause quite different loudness perception, and the
;; desired musical behavior can vary, so the exponent can be tuned:

(let* ((x (MouseX kr 300 15000 1 0.1))
       (o (Mul (Pulse ar x 0.5) 0.1))
       (c (AmpComp x 300 1.3)))
  (audition (Out 0 (Mul o c))))

;; amplitude compensation in frequency modulation

(let* ((x (MouseX kr 300 15000 1 0.1))
       (y (MouseY kr 3 200 1 0.1))
       (m (Mul x (MulAdd (SinOsc ar y 0) 0.5 1)))
       (a (AmpComp m 300 0.333))
       (c (Mul* (SinOsc ar m 0) 0.1 a)))
  (audition (Out 0 c)))
