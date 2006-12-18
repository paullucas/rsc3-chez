;; (Line rate start end dur doneAction)

;; Generates a line from the start value to the end value.

;; start - starting value
;; end - ending value
;; dur - duration in seconds

;; Note: The SC3 UGen reorders the mul and add inputs to precede the
;; doneAction input.

(Mul (SinOsc ar (Line kr 200 17000 5 2) 0)
     0.1)
