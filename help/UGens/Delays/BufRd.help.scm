;; (BufRd numChannels bufnum phase loop interpolation)

;; Plays the content of a buffer.

;; The number of channels must be a fixed integer. The architechture
;; of the SynthDef cannot change after it is compiled. NOTE: if you
;; supply a bufnum of a buffer that has a different numChannels then
;; you have specified to the BufRd, it will fail silently.

;; The interpolation type is an integer: 1 no interpolation, 2 linear
;; interpolation, 4 cubic interpolation.

(-><! s (/b_allocRead 0 (rsc-file "audio/metal.wav") 0 0))

(BufRd ar 1 0 (Mul (SinOsc ar 0.1 0) (BufFrames ir 0)) 0 2)

(let ((phase (Mul (LFNoise1 r0 ar (MouseX kr (Mce 5 10) 100 0 0.1))
		  (BufFrames ir 0))))
  (BufRd ar 1 0 phase 0 2))

(let ((phase (Add (LFTri ar 0.1 0)
		  (Mul (LFTri ar 0.23 0) (BufFrames ir 0)))))
  (BufRd ar 1 0 phase 0 2))

;; Use a phasor index into the file

(let ((phase (Phasor ar 0 (Mul (MouseX kr 0.5 2 0 0.1)
			       (BufRateScale kr 0)) 0 (BufFrames kr 0) 0)))
  (BufRd ar 1 0 phase 1 (MouseY kr 0 5 0 0.1)))

;; Write into the buffer with a BufWr and read it with a BufRd.

(begin
  (BufWr ar 0 (Phasor ar 0 (Mul (BufRateScale kr 0) (MouseX kr 0.5 2) 0 (BufFrames kr 0))) 1 (SinOsc ar (LFNoise1 kr 2 300 400) 0 0.1))
  (BufRd ar 1 0 (Phasor ar 0 (Mul (BufRateScale kr 0) (MouseY kr 0.5 2) 0 (BufFrames kr 0)))))
