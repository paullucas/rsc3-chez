;; (Phasor trig rate start end resetpos)

;; Triggered linear ramp between two levels.  Starts a linear ramp
;; when trig input crosses from non-positive to positive.

;; trig       - sets phase to resetPos (default: 0, equivalent to start)
;; rate       - rate value in 1 / frameDur (at 44.1 kHz sample rate: rate 
;;              1 is eqivalent to 44100/sec)
;; start, end - start and end points of ramp
;; resetPos   - determines where to jump to on recieving a trigger.  the
;;		value at that position can be calculated as follows:
;;		(end - start) * resetPos

;; phasor controls sine frequency: end frequency matches a second sine wave.

(let* ((rate (MouseX.kr 0.2 2 1))
       (trig (Impulse.ar rate))
       (sr (SampleRate.ir))
       (x (Phasor.ar trig (FDiv rate sr))))
  (SinOsc.ar (list (LinLin.kr x 0 1 600 1000) 1000) 0 0.2))



// two phasors control two sine frequencies: mouse y controls resetPos of the second
(
{ var trig, rate, x, sr;
	rate = MouseX.kr(1, 200, 1);
	trig = Impulse.ar(rate);
	sr = SampleRate.ir;
	x = Phasor.ar(trig, rate / sr, 0, 1, [0, MouseY.kr(0, 1)]);
	SinOsc.ar(x * 500 + 500, 0, 0.2)
}.play;
)


// use phasor to index into a sound file

// allocate a buffer with a sound file
s.sendMsg("/b_allocRead", 0, "sounds/a11wlk01.wav");

// simple playback (more examples: see BufRd)
{ BufRd.ar(1, 0, Phasor.ar(0, BufRateScale.kr(0), 0, BufFrames.kr(0))) }.play;


// two phasors control two sound file positions: mouse y controls resetPos of the second
(
{ var trig, rate, framesInBuffer;
	rate = MouseX.kr(0.1, 100, 1);
	trig = Impulse.ar(rate);
	framesInBuffer = BufFrames.kr(0);
	x = Phasor.ar(trig, BufRateScale.kr(0), 0, framesInBuffer, [0, MouseY.kr(0, framesInBuffer)]);
	BufRd.ar(1, 0, x);
}.play;
)



