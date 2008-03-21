;; (blip rate freq numharm)
 
;; Band Limited impulse generator. All harmonics have equal
;; amplitude.

;; This is the equivalent of 'buzz' in MusicN languages. WARNING:
;; This waveform in its raw form could be damaging to your ears at
;; high amplitudes or for long periods.
 
;; Implementation notes: It is improved from other implementations in
;; that it will crossfade in a control period when the number of
;; harmonics changes, so that there are no audible pops. It also
;; eliminates the divide in the formula by using a 1/sin table (with
;; special precautions taken for 1/0).  The lookup tables are
;; linearly interpolated for better quality.
 
;; The number of harmonics may be lowered internally if it would
;; cause aliasing.

(audition (out 0 (mul (blip ar 440 200) 0.15)))

;; Modulate frequency

(let ((f (x-line kr 20000 200 6 remove-synth)))
  (audition (out 0 (mul (blip ar f 100) 0.2))))

;; Modulate number of harmonics.

(let ((h (line kr 1 100 20 remove-synth)))
  (audition (out 0 (mul (blip ar 200 h) 0.2))))
