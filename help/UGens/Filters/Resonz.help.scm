;;; (Resonz in freq bwr)

;;; Resonant filter.

;;; A two pole resonant filter with zeroes at z = +/- 1. Based on
;;; K. Steiglitz, "A Note on Constant-Gain Digital Resonators,"
;;; Computer Music Journal, vol 18, no. 4, pp. 8-10, Winter 1994.  The
;;; reciprocal of Q is used rather than Q because it saves a divide
;;; operation inside the unit generator.

;; in - input signal to be processed
;; freq - resonant frequency in Hertz
;; rq - bandwidth ratio (reciprocal of Q). rq = bandwidth / centerFreq

(Resonz.ar (WhiteNoise.ar 0.5) 2000 0.1)

;; Modulate frequency

(Resonz.ar (WhiteNoise.ar 0.5) (XLine.kr 1000 8000 10) 0.05)

;; Modulate bandwidth

(Resonz.ar (WhiteNoise.ar 0.5) 2000 (XLine.kr 1 0.001 8))

;; Modulate bandwidth opposite direction

(Resonz.ar (WhiteNoise.ar 0.5) 2000 (XLine.kr 0.001 1 8))

;; Random resonator at a random location, run as often as you like...

(let ((freq (random (map (lambda (z) (* z 120)) (iota 16 1))))
      (bw 1/4)
      (gain 8))
  (Pan2.ar (Resonz.ar (WhiteNoise.ar) freq (/ bw freq) gain)
	   (Rand.ir -1 1)))
