;; (GrainSin nc tr dur freq pan envbuf)

;; Granular synthesis with sine tones

;; nc - the number of channels to output. If 1, mono is returned and
;;      pan is ignored.

;; tr - a kr or ar trigger to start a new grain. If ar, grains after
;;      the start of the synth are sample accurate.

;; The following args are polled at grain creation time

;; dur - size of the grain.

;; freq - the input to granulate

;; pan - a value from -1 to 1. Determines where to pan the output in
;;       the same manner as PanAz.

;; envbuf - the buffer number containing a singal to use for the grain
;;          envelope. -1 uses a built-in Hanning envelope.

(let* ((x (MouseX kr -0.5 0.5 0 0.1))
       (y (MouseY kr 0 400 0 0.1))
       (n (WhiteNoise kr))
       (f (Add 440 (Mul n y)))
       (t (Impulse kr 10 0)))
  (audition (Out 0 (Mul (GrainSin 2 t 0.1 f x -1) 0.1))))
