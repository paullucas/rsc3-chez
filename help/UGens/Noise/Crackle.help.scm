;; (Crackle chaosParam) 

;; A noise generator based on a chaotic function.  The parameter of
;; the chaotic function has useful values from just below 1.0 to just
;; above 2.0. Towards 2.0 the sound crackles.

;; The equation implemented is: y0 = fabs(y1 * param - y2 - 0.05f)

(Crackle ar 1.95 0.5)

;; Modulate chaos parameter

(Crackle ar (Line kr 1.0 2.0 3) 0.5)
