;;; (InFeedback bus numChannels)

;;; Read signal from a bus without erasing it.

;;; The output (Out) ugens overwrite data on the bus, giving this bus
;;; a new timestamp so that any input (In) ugen can check if the data
;;; was written within the current cycle. The next cycle this data is
;;; still there, but in case of audio one normally doesn't want an in
;;; ugen to read it again, as it might cause feedback.
 
;;; This is the reason why In.ar checks the timestamp and ignores
;;; everything that was not written within this cycle. This means that
;;; nodes can only read data from a bus that was written by a
;;; preceeding node when using the In.ar ugen which overwrites the old
;;; data. This is good for audio, but for control data it is more
;;; convenient to be able to read a bus from any place in the node
;;; order.
 
;;; This is why In.kr behaves differently and reads also data with a
;;; timestamp that is one cycle old. Now in some cases we want to be
;;; able to read audio from a bus independant of the current node
;;; order, which is the use of InFeedback.  The delay introduced by
;;; this is at a maximum one block size, which equals about 0.0014 sec
;;; at the default block size and sample rate.
 
;; Audio feedback modulation.
 
(SinOsc.ar (Add (Mul (InFeedback.ar 0 1) 1300) 300) 0 0.4)

;; Evaluate these in either order and hear both tones.

(InFeedback.ar 10 1)

(begin (Out.ar 10 (SinOsc.ar 440 0 0.1))
       (SinOsc.ar 60 0 0.1))

;; Doubters consult this.

(In.ar 10 1)
