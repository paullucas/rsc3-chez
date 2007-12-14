;; (freq-shift input shift PHASE)

;; freq-shift implements single sideband amplitude modulation, also
;; known as frequency shifting, but not to be confused with pitch
;; shifting.  Frequency shifting moves all the components of a signal
;; by a fixed amount but does not preserve the original harmonic
;; relationships.

;; input - audio input
;; shift - amount of shift in cycles per second
;; phase - phase of the frequency shift (0 - 2pi) 

;; shifting a 100Hz tone by 1 Hz rising to 500Hz

(let ((i (SinOsc ar 100 0))
      (s (XLine kr 1 500 5 removeSynth)))
  (audition (Out 0 (Mul (freq-shift i s 0) 0.1))))

;; shifting a complex tone by 1 Hz rising to 500Hz

(let ((i (Klang ar 1 0 (klang-data (list 101 303 606 808) 1 1)))
      (s (XLine kr 1 500 5 removeSynth)))
  (audition (Out 0 (Mul (freq-shift i s 0) 0.1))))

;; modulating shift and phase

(let ((i (SinOsc ar 10 0))
      (s (Mul (LFNoise2 ar 0.3) 1500))
      (p (range (SinOsc ar 500 0) 0 (* 2 pi))))
  (audition (Out 0 (Mul (freq-shift i s p) 0.1))))

;; shifting bandpassed noise

(let ((i (BPF (WhiteNoise ar) 1000 0.001))
      (s (Mul (LFNoise0 ar 5.5) 1000)))
  (audition (Out 0 (Mul (freq-shift i s 0) 32))))
