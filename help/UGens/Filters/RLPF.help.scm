;; (RLPF in freq rq)

;; A resonant low pass filter.

(RLPF ar (Saw ar 200 0.1) (FSinOsc kr (XLine kr 0.7 300 20) 0 3600 4000) 0.2)


