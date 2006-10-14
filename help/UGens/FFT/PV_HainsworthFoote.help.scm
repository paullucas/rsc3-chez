;; (PV_HainsworthFoote buffer proph propf threshold waittime)

;; FFT onset detector based on work described in

;;   Hainsworth, S. (2003) Techniques for the Automated Analysis of
;;   Musical Audio. PhD, University of Cambridge engineering dept. See
;;   especially p128. The Hainsworth metric is a modification of the
;;   Kullback Liebler distance.

;; The onset detector has general ability to spot spectral change, so
;; may have some ability to track chord changes aside from obvious
;; transient jolts, but there's no guarantee it won't be confused by
;; frequency modulation artifacts.

;; Hainsworth metric on it's own gives good results but Foote might be
;; useful in some situations: experimental.

;; buffer - FFT buffer to read from

;; proph - What strength of detection signal from Hainsworth metric to use.

;; propf - What strength of detection signal from Foote metric to
;;         use. The Foote metric is normalised to [0.0,1.0]

;; threshold - Threshold hold level for allowing a detection

;; waittime - If triggered, minimum wait until a further frame can
;;            cause another spot (useful to stop multiple detects on
;;            heavy signals)

;; Default values in sclang are: proph=0.0, propf=0.0, threshold=1.0,
;; waittime=0.04.

;; --

;; Just Hainsworth metric with low threshold

(->< s (/b_alloc 0 2048 1))

(let* ((source (audioin 1))
       (detect (PV_HainsworthFoote (FFT 0 source) 
				   1.0 
				   0.0
				   (MouseX kr 0.01 1.0 1 0.1)
				   0.04)))
  (Out 0 (Mul* (SinOsc ar (Mce 440 445) 0)
	       (Decay (Mul 0.1 detect) 0.1)
	       0.1)))

;; Just Hainsworth metric, spot note transitions.

(let* ((src (Mul (LFSaw ar (MulAdd (LFNoise0 kr 1) 90 400) 0) 0.5))
       (dtc (PV_HainsworthFoote (FFT 0 src)
				1.0
				0.0
				0.9
				0.5))
       (cmp (Mul (SinOsc ar 440 0)
		 (Decay (Mul 0.1 dtc) 0.1))))
  (Out 0 (Add (Pan2 src -1 0.1)
	      (Pan2 cmp 1 0.1))))

;; Just Foote metric.  Foote never triggers with threshold over 1.0,
;; threshold under mouse control.

(let* ((src (audioin 1))
       (dtc (PV_HainsworthFoote (FFT 0 src)
				0.0
				1.0
				(MouseX kr 0.0 1.1 0 0.1)
				0.02))
       (cmp (Mul (SinOsc ar 440 0)
		 (Decay (Mul 0.1 dtc) 0.1))))
  (Out 0 (Add (Pan2 src -1 0.1)
	      (Pan2 cmp 1 0.1))))
