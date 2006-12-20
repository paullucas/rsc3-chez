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

(->< s (/b_alloc 10 512 1))

(->< s (/b_gen 10 "sine1" (+ 1 2 4) 1 1/2 1/3 1/4 1/5))

(Mul (Osc ar 10 220 0) 0.1)

;; Modulate freq

(Mul (Osc ar 10 (XLine kr 2000 200 1 removeSynth) 0) 0.5)

;; Modulate freq

(let ((f (MulAdd (Osc ar b (XLine kr 1 1000 9 removeSynth) 0) 200 800)))
  (Mul (Osc ar 10 f 0) 0.25))

;; Modulate phase

(let ((p (Mul (Osc ar b (XLine kr 20 8000 10 removeSynth) 0) two-pi)))
  (Mul (Osc ar 10 800 p) 0.25))

;; Change the buffer while its playing

(Mul (Osc ar 10 220 0) 0.1)

(define t
  (spawn
   (lambda ()
     (let loop ()
       (->< s (/b_gen b "sine1" (+ 1 2 4) 1 (rand 0 1) 1/4))
       (sleep 0.1)
       (loop)))))

(thread-terminate! t)
