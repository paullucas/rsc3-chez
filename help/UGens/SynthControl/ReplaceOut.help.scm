;; (ReplaceOut bufferIndex inputs)

;; Send signal to a bus, overwrite existing signal.

(begin (Out ar 0 (SinOsc ar '(330 331) 0 0.1))
       (ReplaceOut ar 0 (SinOsc ar '(880 881) 0 0.1))
       (SinOsc ar '(120 121) 0 0.1))

;; Compare to:

(begin (Out ar 0 (SinOsc ar '(330 331) 0 0.1))
       (Out ar 0 (SinOsc ar '(880 881) 0 0.1))
       (SinOsc ar '(120 121) 0 0.1))
