;; (PlayBuf numChannels rate bufnum rate trigger startPos loop) 

;; Sample playback oscillator.  Plays back a memory resident sample.

;; numChannels - number of channels that the buffer will be.  This
;;               must be a fixed integer. The architechture of the
;;               SynthDef cannot change after it is compiled.
;;               Warning: if you supply a bufnum of a buffer that has
;;               a different numChannels then you have specified to
;;               the PlayBuf, it will fail silently.

;; bufnum - the index of the buffer to use

;; rate - 1.0 is the server's sample rate, 2.0 is one octave up, 0.5
;;        is one octave down -1.0 is backwards normal rate
;;        etc. Interpolation is cubic.  Note: If the buffer's sample
;;        rate is different from the server's, you will need to
;;        multiply the desired playback rate by (file's rate /
;;        server's rate). The UGen BufRateScale.kr(bufnum) returns
;;        this factor. See examples below. BufRateScale should be used
;;        in virtually every case.

;; trigger - a trigger causes a jump to the startPos.  A trigger
;; occurs when a signal changes from <= 0 to > 0.

;; startPos - sample frame to start playback.

;; loop - 1 means true, 0 means false.  This is modulate-able.

(define b 10)

(->< s (/b_allocRead b "/home/rohan/sw/sw-01/audio/metal.wav" 0 0))

;; Play once only.

(PlayBuf 1 ar b (BufRateScale kr b) 1 0 0)

;; Play in infinite loop.

(PlayBuf 1 ar b (BufRateScale kr b) 1 0 1)

;; Trigger playback at each pulse.

(PlayBuf 1 ar b (BufRateScale kr b) (Impulse kr 2 0) 0 0)

;; Trigger playback at each pulse (diminishing intervals).

(let ((trig (Impulse kr (XLine kr 0.1 100 10 2) 0)))
  (PlayBuf 1 ar b (BufRateScale kr b) trig 0 0))

;; Loop playback, accelerating pitch.

(let ((rate (XLine kr 0.1 100 60 2)))
  (PlayBuf 1 ar b rate 1 0 1))

;; Sine wave control of playback rate, negative rate plays backwards.

(let ((rate (MulAdd (FSinOsc kr (XLine kr 0.2 8 30 2) 0) 3 0.6)))
  (PlayBuf 1 ar b (Mul (BufRateScale kr b) rate) 1 0 1))

;; Release buffer.

(->< s (/b_free b))
