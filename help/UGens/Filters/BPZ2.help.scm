;; (BPZ2 in) 

;; Two zero fixed midpass.  This filter cuts out 0 Hz and the Nyquist
;; frequency.

(BPZ2 (Mul (WhiteNoise ar) 0.25))

