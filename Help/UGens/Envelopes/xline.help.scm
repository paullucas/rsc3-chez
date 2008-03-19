;; (xline rate start end dur doneAction)

;; Exponential line generator.  Generates an exponential curve from
;; the start value to the end value. Both the start and end values
;; must be non-zero and have the same sign.

;; start      - starting value
;; end        - ending value
;; dur        - duration in seconds
;; doneAction - a doneAction to be evaluated when the xline is
;;              completed. See env-gen for details.

(let ((f (xline kr 200 17000 10 remove-synth)))
  (audition (out 0 (mul (sin-osc ar f 0) 0.1))))
