;; bouncing objects (jmcc) #2

(import (rhs) (rsc3) (rsc3 lang))

(define bouncing-objects
  (let* ((imp-frq (x-line kr (add 5 (rand -2 2)) 600 4 do-nothing))
         (imp-amp (x-line kr 0.09 0.000009 4 do-nothing))
         (imp (mul (impulse ar imp-frq 0) imp-amp))
         (exc (decay imp 0.001))
         (flt-frq (replicate-m 4 (rand 400 8400)))
         (flt-amp (replicate-m 4 (rand 0 1)))
         (flt-rtm (replicate-m 4 (rand 0.01 0.11)))
         (flt (klank exc 1 0 1 (klank-data flt-frq flt-amp flt-rtm)))
         (loc (pan2 flt (rand -1 1) 1))
         (e (env '(1 1 0) '(3 0.001) (replicate 2 "linear") -1 -1)))
    (mul loc (env-gen kr 1 1 0 1 remove-synth e))))

(with-sc3
 (spawn-u
  (list (lambda () (random 0.6 1.6)) +inf.0)
  bouncing-objects))