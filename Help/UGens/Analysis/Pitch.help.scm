;; (Pitch in initFreq minFreq maxFreq execFreq maxBinsPerOctave
;;        median ampThreshold peakThreshold downSample)

;; Autocorrelation pitch follower

;; This is a better pitch follower than ZeroCrossing, but more costly
;; of CPU. For most purposes the default settings can be used and only
;; in needs to be supplied. Pitch returns two values (via an Array of
;; OutputProxys, see the OutputProxy help file), a freq which is the
;; pitch estimate and hasFreq, which tells whether a pitch was
;; found. Some vowels are still problematic, for instance a wide open
;; mouth sound somewhere between a low pitched short 'a' sound as in
;; 'sat', and long 'i' sound as in 'fire', contains enough overtone
;; energy to confuse the algorithm.

;; sclang default argument values are: in = 0.0, initFreq = 440.0,
;; minFreq = 60.0, maxFreq = 4000.0, execFreq = 100.0,
;; maxBinsPerOctave = 16, median = 1, ampThreshold = 0.01,
;; peakThreshold = 0.5, downSample = 1.

(define (Pitch* in median ampThreshold)
  (Pitch in 444.0 60.0 4000.0 100.0 16 median ampThreshold 0.5 1))

(let* ((in (Mul (SinOsc ar (MouseX kr 220 660 0 0.1) 0) 
		(MouseY kr 0.05 0.25 0 0.1)))
       (amp (Amplitude kr in 0.05 0.05))
       (freq+ (Pitch* in 7 0.02)))
  (Mce in (Mul (SinOsc ar (FDiv (car (mce-channels freq+)) 2) 0)
	       amp)))

(let* ((in (audioin 1))
       (amp (Amplitude kr in 0.05 0.05))
       (freq+ (Pitch* in 7 0.02)))
  (Mce in (Mul (SinOsc ar (car (mce-channels freq+)) 0)
	       amp)))
