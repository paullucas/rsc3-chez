;; (PlayBuf numChannels bufnum rate trigger startPos loop) 

;; Sample playback oscillator.  Plays back a memory resident sample.

(define b 10)

(-><! s (/b_allocRead b (rsc-file "audio/metal.wav") 0 0))

;; Play once only.

(PlayBuf ar 1 b (BufRateScale kr b) 1 0 0)

;; Play in infinite loop.

(PlayBuf ar 1 b (BufRateScale kr b) 1 0 1)

;; Trigger playback at each pulse.

(PlayBuf ar 1 b (BufRateScale kr b) (Impulse kr 2 0) 0 0)

;; Trigger playback at each pulse (diminishing intervals).

(let ((trig (Impulse kr (XLine kr 0.1 100 10 2) 0)))
  (PlayBuf ar 1 b (BufRateScale kr b) trig 0 0))

;; Loop playback, accelerating pitch.

(let ((rate (XLine kr 0.1 100 60 2)))
  (PlayBuf ar 1 b rate 1 0 1))

;; Sine wave control of playback rate, negative rate plays backwards.

(let ((rate (MulAdd (FSinOsc kr (XLine kr 0.2 8 30 2) 0) 3 0.6)))
  (PlayBuf ar 1 b (Mul (BufRateScale kr b) rate) 1 0 1))

;; Release buffer.

(-><! s (/b_free b))
