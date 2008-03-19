;; subsample-offset

;; Offset from synth start within one sample.

;; When a synth is created from a time stamped osc-bundle, it starts
;; calculation at the next possible block (normally 64 samples). Using
;; an offset-out ugen, one can delay the audio so that it matches
;; sample accurately.  For some synthesis methods, one needs subsample
;; accuracy. subsample-offset provides the information where, within
;; the current sample, the synth was scheduled. It can be used to
;; offset envelopes or resample the audio output.

;; See also offset-out.

;; Demonstrate cubic subsample interpolation.  An impulse train that
;; can be moved between samples.

(send-synth
 s "s"
 (letc ((out 0) (addOffset 0))
   (let* ((i (mul (impulse ar 2000 0) 0.3))
	  (d sample-dur)
	  (x 4)
	  (o (add (sub 1 subsample-offset) (mouse-x kr 0 addOffset 0 0.1)))
	  (r (delay-c i (mul d (add 1 x)) (Mul d (Add o x)))))
     (offset-out out r))))

;; Create two pulse trains one sample apart, move one relative to the
;; other.  When cursor is at the left, the impulses are adjacent, on
;; the right, they are exactly 1 sample apart.  View this with an
;; oscilloscope.

(let ((t (utc))
      (dt (/ 1 (server-sample-rate/actual s))))
  (wuth-sc3
   (lambda (fd)
     (send fd (bundle (+ t 0.2) (/s_new "s" -1 1 1 "addOffset" 3)))
     (send fd (bundle (+ t 0.2 dt) (/s_new "s" -1 1 1 "addOffset" 0))))))
