;; (KeyState rate keynum minval maxval lag)

;; Report the status of a particular key.  A key is either pressed,
;; or not pressed.

;; The keycode 38 is the A key on my keyboard.  Under X the xev(1)
;; command is useful in determining your keyboard layout.

(Mul (SinOsc ar 800 0)
     (KeyState kr 38 0 0.1 0.5))
