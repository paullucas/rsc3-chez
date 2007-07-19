;; (FFT buffer in)		

;; Fast fourier transform.  The fast fourier transform analyzes the
;; frequency content of a signal.  FFT uses a local buffer for holding
;; the buffered audio.  The inverse transform, IFFT, reconstructs an
;; audio signal.
 
;; Note that the UGens the SC3 language provides do not use rate
;; extensions, since only a single rate is valid for each UGen class.
;; The FFT and PV_ UGens must run at control rate, the IFFT UGen at
;; audio rate.

(->< s (/b_alloc 10 2048 1))

(IFFT (FFT 10 (Mul (WhiteNoise ar) 0.05)))

(IFFT 
 (FFT 
  10
  (SinOsc ar (MulAdd (SinOsc kr (Squared (MulAdd (SinOsc kr 0.08 0) 6 6.2)) 0) 100 800) 0)))
