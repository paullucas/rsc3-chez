;; (FreeVerb in mix room damp)
;; (FreeVerb2 in1 in2 mix room damp)

;; A simple reverb.

;; in, in1, in2 - input signal.
;; mix - dry/wet balance. range 0..1
;; room - room size. rage 0..1
;; damp - Reverb HF damp. range 0..1

(let* ((i (Impulse ar 1 0))
       (c (LFCub ar 1200 0))
       (s (Mul* (Decay i 0.25) c 0.1))
       (x (MouseX kr 0 1 0 0.1))
       (y (MouseY kr 0 1 0 0.1))
       (r (FreeVerb s y x 0.5)))
  (audition (Out 0 r)))

(let* ((i (audioin (Mce 0 1)))
       (c (lambda (u n) (mce-channel u n)))
       (x (MouseX kr 0 1 0 0.1))
       (y (MouseY kr 0 1 0 0.1))
       (r (FreeVerb2 (c i 0) (c i 1) y x 0.5)))
  (draw* (Out 0 r)))
