;; (PlayBuf numChannels bufnum rate trigger startPos loop) 

;; Sample playback oscillator.  Plays back a memory resident sample.

(define b (buffer-alloc-read (resolve "audio/metal.wav")))

;; Play once only.

(let ((bufnum (buffer-id b)))
  (PlayBuf.ar 1 bufnum (BufRateScale.kr bufnum)))

;; Play in infinite loop.

(let ((bufnum (buffer-id b)))
  (PlayBuf.ar 1 bufnum (BufRateScale.kr bufnum) loop: 1))

;; Trigger playback at each pulse.

(let ((bufnum (buffer-id b))
      (trig (Impulse.kr 2)))
  (PlayBuf.ar 1 bufnum (BufRateScale.kr bufnum) trig 0 0))

;; Trigger playback at each pulse (diminishing intervals).

(let ((bufnum (buffer-id b))
      (trig (Impulse.kr (XLine.kr 0.1 100 30))))
  (PlayBuf.ar 1 bufnum (BufRateScale.kr bufnum) trig 0 0))

;; Loop playback, accelerating pitch.

(let ((bufnum (buffer-id b))
      (rate (XLine.kr 0.1 100 60)))
  (PlayBuf.ar 1 bufnum rate 1 0 1))

;; Sine wave control of playback rate, negative rate plays backwards.

(let ((bufnum (buffer-id b))
      (rate (FSinOsc.kr (XLine.kr 0.2 8 30) 0 3 0.6)))
  (PlayBuf.ar 1 bufnum (Mul (BufRateScale.kr bufnum) rate) 1 0 1))

;; Release buffer.

(buffer-free b #t)
