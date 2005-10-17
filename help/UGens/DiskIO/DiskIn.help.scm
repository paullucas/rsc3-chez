;; (DiskIn numChannels bufnum)

;; Continously play a soundfile from disk. This requires a buffer to
;; be preloaded with one buffer size of sound.  The buffer size must
;; be a multiple of twice the synth block size. The default block size
;; is 128. See server-options for setting block size.

;; Note that DiskIn reads the number of outputs to create from what
;; looks like an input, but IT IS NOT AN INPUT, and cannot be set
;; using a control.

(define path (resolve "audio/metal.wav"))

(define b (buffer-cue-sound-file path 0 1))

(DiskIn.ar c (buffer-id b))

(buffer-free b #t)
