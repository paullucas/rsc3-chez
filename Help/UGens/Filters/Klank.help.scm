;; (Klank in freqScale freqOffset decayScale spec)

;; Klank is a bank of fixed frequency resonators which can be used to
;; simulate the resonant modes of an object. Each mode is given a ring
;; time, which is the time for the mode to decay by 60 dB.

;; The UGen assistant klank-data can help create the 'spec' entry.
;; Note that the SC3 language reorders the inputs, the RSC client does
;; not.

;; input - the excitation input to the resonant filter bank.

;; freqscale - a scale factor multiplied by all frequencies at
;;             initialization time.

;; freqoffset - an offset added to all frequencies at initialization
;;              time.

;; decayscale - a scale factor multiplied by all ring times at
;;              initialization time.

(let ((i (Mul (Impulse ar 2 0) 0.1))
      (d (klank-data '(800 1071 1153 1723) 
		     (replicate 5 1) 
		     (replicate 5 1))))
  (audition (Out 0 (Klank i 1 0 1 d))))

(let ((i (Mul (Dust ar 8) 0.1))
      (d (klank-data '(800 1071 1353 1723) 
		     (replicate 4 1) 
		     (replicate 4 1))))
  (audition (Out 0 (Klank i 1 0 1 d))))

(let ((i (Mul (PinkNoise ar) 0.007))
      (d (klank-data '(800 1071 1353 1723) 
		     (replicate 4 1) 
		     (replicate 4 1))))
  (audition (Out 0 (Klank i 1 0 1 d))))

(let ((i (Mul (PinkNoise ar) (mce2 0.007 0.007)))
      (d (klank-data '(200 671 1153 1723)
		     (replicate 4 1) 
		     (replicate 4 1))))
  (audition (Out 0 (Klank i 1 0 1 d))))

(let ((i (Mul (Decay (Impulse ar 4 0) 0.03) (Mul (ClipNoise ar) 0.01)))
      (d (klank-data (randl 12 800 4000) 
		     (replicate 12 1) 
		     (randl 12 0.1 2))))
  (audition (Out 0 (Klank i 1 0 1 d))))
