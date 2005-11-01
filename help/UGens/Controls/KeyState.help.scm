;; (KeyState keynum minval maxval lag)

;; Report the status of a particular key.  A key is either pressed,
;; or not pressed.

;; The keycode 38 is the A key on my keyboard.  Under X the xev(1)
;; command is useful in determining your keyboard layout.

(SinOsc.ar 800 0 (KeyState.kr 38 0 0.1 0.5))

;; There is a lookup assistant, you may need to tune it for your
;; particular keyboard, see the source documentation for details.

(SinOsc.ar 803 0 (KeyState.kr (KeyStateInteger #\a) 0 0.1 0.5))

;; The whole keyboard sings, this can get pretty annoying after a while...

(let ((keys "1234567890qwertyuiopasdfghjklzxcvbnm"))
  (Mix.fill 
   (string-length keys)
   (lambda (n)
     (SinOsc.ar (random 330 770) 
		0 
		(KeyState.kr (KeyStateInteger (string-ref keys n)) 0 0.1 0.5)))))
