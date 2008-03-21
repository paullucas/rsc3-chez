;; (rand-id rate id)
 
;; Choose which random number generator to use for this synth.  All
;; synths that use the same generator reproduce the same sequence of
;; numbers when the same seed is set again.

;; See also: rand-seed.

;; Graphs to generate noise in the context of a given RNG and to reset
;; a specified RNG.

(with-sc3
 (lambda (fd)
   (send-synth
    fd "r"
    (letc ((out 0) (id 1))
      (mrg2 (rand-id ir id)
	    (out out (add (mul (white-noise ar) 0.05) (dust2 ar 70))))))
   (send-synth
    fd "s"
    (letc ((seed 1910) (id 1))
      (mrg2 (rand-id kr id)
	    (rand-seed kr (impulse kr (mul-add (f-sin-osc kr 0.2 0) 10 11) 0) seed))))))

;; Start two noise synths on left and right channel with a different randgen id

(with-sc3
 (lambda (fd)
   (send fd (/s_new "r" 1001 1 1 "out" 0 "id" 1))
   (send fd (/s_new "r" 1002 1 1 "out" 1 "id" 2))))

;; Reset the seed of randgen 1 

(with-sc3 (lambda (fd) (send fd (/s_new "s" 1003 1 1 "id" 1))))

;; Change the target RNG with ID 2, ie. effect right channel.

(with-sc3 (lambda (fd) (send fd (/n_set 1003 "id" 2))))

;; free noise nodes.

(with-sc3
 (lambda (fd)
   (send fd (/n_free 1001))
   (send fd (/n_free 1002))
   (send fd (/n_free 1003))))
