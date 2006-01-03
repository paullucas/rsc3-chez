;; (MouseButton minval maxval lag)

;; Report the status of the first pointer button.  The button is
;; either pressed, or not pressed.

(SinOsc ar 800 0 (MouseButton kr 0 0.1 0.1))
