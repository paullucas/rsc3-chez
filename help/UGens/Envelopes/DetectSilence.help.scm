;;; (DetectSilence in amp time doneAction)

;;; If the signal at `in' falls below `amp' for `time' seconds then
;;; `doneAction' is raised.

(let ((s (SinOsc.ar 440 0 (MouseY.kr 0 0.4))))
  (DetectSilence.ar s 0.1 doneAction: 2)
  s)

