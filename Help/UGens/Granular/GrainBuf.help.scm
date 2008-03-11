;; (GrainBuf nc tr dur sndbuf rate pos interp pan envbuf)

;; Granular synthesis with sound stored in a buffer

;; nc - the number of channels to output. If 1, mono is returned and
;;      pan is ignored.

;; tr - a kr or ar trigger to start a new grain. If ar, grains after
;;      the start of the synth are sample accurate.

;; The following args are polled at grain creation time

;; dur - size of the grain.

;; sndbuf - the buffer holding an audio signal

;; rate - the playback rate of the sampled sound

;; pos - the playback position for the grain to start with (0 is
;;       beginning, 1 is end of file)

;; interp - the interpolation method used for pitchshifting grains.
;;          1 = no interpolation. 2 = linear. 4 = cubic interpolation
;;          (more computationally intensive).

;; pan - a value from -1 to 1. Determines where to pan the output in
;;       the same manner as PanAz.

;; envb - the buffer number containing a singal to use for the
;;        grain envelope. -1 uses a built-in Hanning envelope.

(with-sc3
 (lambda (fd)
   (async fd (/b_allocRead 10 "/home/rohan/audio/metal.wav" 0 0))
   (let ((g (letc ((gate 1)
		   (amp 1)
		   (sndbuf 0)
		   (envbuf -1))
	      (let* ((x (MouseX kr -1 1 0 0.1))
		     (y (MouseY kr 10 45 0 0.1))
		     (i (Impulse kr y 0))
		     (r (range (LFNoise1 kr 500) 0.5 2))
		     (p (range (LFNoise2 kr 0.1) 0 1)))
		(Out 0 (GrainBuf 2 i 0.1 sndbuf r p 2 x envbuf))))))
     (async fd (/d_recv (graphdef->u8l (synthdef "g" g))))
     (send fd (/s_new "g" -1 addToTail 1 "sndbuf" 10 "envbuf" -1)))))
