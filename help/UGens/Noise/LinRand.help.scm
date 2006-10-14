;; (LinRand lo hi minmax)
 
;; Generates a single random float value in linear distribution from
;; lo to hi, skewed towards lo if minmax < 0, otherwise skewed towards
;; hi.

(Mul (FSinOsc ar (LinRand 200 10000 (Mce -1 1)) 0)
     (Line kr 0.4 0 0.01 removeSynth))
