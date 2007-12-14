;; (MoogFF in freq gain reset)

;; Moog VCF implementation, designed by Federico Fontana. A digital
;; implementation of the Moog VCF (filter).

;; in - the input signal
;; freq - the cutoff frequency
;; gain - the filter resonance gain, between zero and 4
;; reset - when greater than zero, this will reset the 
;;         state of the digital filters at the beginning 
;;         of a computational block.

;; The design of this filter is described in the conference paper
;; Fontana, F. (2007) Preserving the Digital Structure of the Moog
;; VCF. In Proc. ICMC07, Copenhagen, 25-31 August 2007

(let ((n (Mul (WhiteNoise ar) 0.1))
      (y (MouseY kr 100 10000 1 0.1))
      (x (MouseX kr 0 4 0 0.1)))
  (audition (Out 0 (MoogFF n y x 0))))

(let ((p (Pulse ar (Mce 40 121) (Mce 0.3 0.7)))
      (f (range (SinOsc kr (range (LFNoise0 kr 0.43) 0.001 2.2) 0) 30 4200))
      (y (MouseY kr 1 4 0 0.1)))
  (audition (Out 0 (MoogFF p f (Mul 0.83 y) 0))))
