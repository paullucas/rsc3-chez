;; (Osc rate bufnum freq phase)

;; Linear interpolating wavetable lookup oscillator with frequency and
;; phase modulation inputs.

;; This oscillator requires a buffer to be filled with a wavetable
;; format signal.  This preprocesses the Signal into a form which can
;; be used efficiently by the Oscillator.  The buffer size must be a
;; power of 2.

;; This can be acheived by creating a Buffer object and sending it one
;; of the "b_gen" messages ( sine1, sine2, sine3 ) with the wavetable
;; flag set to true.

;; Note about wavetables: OscN requires the b_gen sine1 wavetable flag
;; to be OFF.  Osc requires the b_gen sine1 wavetable flag to be ON.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 10 512 1))
   (->< fd (/b_gen 10 "sine1" (+ 1 2 4) 1 1/2 1/3 1/4 1/5))))

(audition (Out 0 (Mul (Osc ar 10 220 0) 0.1)))

;; Modulate freq

(let ((f (XLine kr 2000 200 1 removeSynth)))
  (audition (Out 0 (Mul (Osc ar 10 f 0) 0.5))))

;; Modulate freq

(let* ((f1 (XLine kr 1 1000 9 removeSynth))
       (f2 (MulAdd (Osc ar 10 f1 0) 200 800)))
  (audition (Out 0 (Mul (Osc ar 10 f2 0) 0.25))))

;; Modulate phase

(let* ((f (XLine kr 20 8000 10 removeSynth))
       (p (Mul (Osc ar 10 f 0) two-pi)))
  (audition (Out 0 (Mul (Osc ar 10 800 p) 0.25))))

;; Change the buffer while its playing

(audition (Out 0 (Mul (Osc ar 10 220 0) 0.1)))

(with-sc3
 (lambda (fd)
   (->< fd (/b_gen 10 "sine1" (+ 1 2 4) 1 (rand 0 1) 1/4))))
