;; (Klank in freqScale freqOffset decayScale spec)

;; Klank is a bank of fixed frequency resonators which can be used to
;; simulate the resonant modes of an object. Each mode is given a ring
;; time, which is the time for the mode to decay by 60 dB.

;; The UGen assistant Klank.spec can help create the 'spec' entry.
;; Note that the SC3 language reorders the inputs, the RSC client does
;; not.

;; input - the excitation input to the resonant filter bank.

;; freqscale - a scale factor multiplied by all frequencies at
;;             initialization time.

;; freqoffset - an offset added to all frequencies at initialization
;;              time.

;; decayscale - a scale factor multiplied by all ring times at
;;              initialization time.

(Klank.ar (Impulse.ar 2 0 0.1) 1 0 1 
	  (Klank.spec '(800 1071 1153 1723) '(1 1 1 1) '(1 1 1 1)))

(Klank.ar (Dust.ar 8 0.1) 1 0 1 
	  (Klank.spec '(800 1071 1353 1723) '(1 1 1 1) '(1 1 1 1)))

(Klank.ar (PinkNoise.ar 0.007) 1 0 1 
	  (Klank.spec '(800 1071 1353 1723) '(1 1 1 1) '(1 1 1 1)))

(Klank.ar (PinkNoise.ar '(0.007 0.007)) 1 0 1 
	  (Klank.spec '(200 671 1153 1723) '(1 1 1 1) '(1 1 1 1)))

(Klank.ar (Decay.ar (Impulse.ar 4) 0.03 (ClipNoise.ar 0.01)) 1 0 1
	  (Klank.spec (random-list 12 800 4000) '(1) (random-list 12 0.1 2)))

(synthdef-send
 (synthdef
  "Klank-Help"
  ((out 0) (freq 440) 
   (harm '(1 2 3 4)) (amp '(0.05 0.05 0.05 0.05)) (ring '(1 1 1 1)))
  (Out.ar out (Klank.ar (ClipNoise.ar 0.03)
			freq 0 1 
			(Klank.spec harm amp ring)))))

(begin
  (-> "/s_new" "Klank-Help" -1 0 1 "freq" 300)
  (-> "/s_new" "Klank-Help" -1 0 1 "freq" 400)
  (-> "/s_new" "Klank-Help" -1 0 1 "freq" (+ 533 1/3))
  (-> "/s_new" "Klank-Help" -1 0 1 "freq" 711.11))

(-> "/g_freeAll" 1)

(=>* 0
    '(/s_new "Klank-Help" -1 1 1 freq 500)
    '(/n_setn -1 harm 4 1 3 5 7))
