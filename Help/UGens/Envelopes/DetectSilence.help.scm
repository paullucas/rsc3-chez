;; (DetectSilence in amp time doneAction)

;; If the signal at `in' falls below `amp' for `time' seconds then
;; `doneAction' is raised.

(let ((s (Mul (SinOsc ar 440 0) (MouseY kr 0 0.4 0 0.1))))
  (audition (Mrg (DetectSilence s 0.1 0.2 removeSynth)
		 (Out 0 s))))

(with-sc3 display-server-status)
