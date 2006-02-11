;; (LocalIn numChannels)

;; Define and read from buses local to a SynthDef

;; numChannels - the number of channels of local buses.  The default
;;                is 1.

;; LocalIn defines buses that are local to the SynthDef. These are
;; like the global buses, but are more convenient if you want to
;; implement a self contained effect that uses a feedback processing
;; loop.  There can only be one audio rate and one control rate
;; LocalIn per SynthDef.  The audio can be written to the bus using
;; LocalOut.

(let* ((a0 (Mul (Decay (Impulse ar 0.3 0) 0.1) (Mul (WhiteNoise R0 ar) 0.2)))
       (a1 (Add (LocalIn ar 2) (Mce a0 0)))
       (a2 (DelayN a1 0.2 0.2)))
  (Mrg (LocalOut (Mul (mce-reverse a2) 0.8)) 
       (Out 0 a2)))
