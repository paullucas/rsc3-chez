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

(let* ((in (SinOsc ar (MouseX kr 220 660) 0 (MouseY kr 0.05 0.25)))
       (amp (Amplitude kr in 0.05 0.05))
       (freq+ (Pitch kr in 'ampThreshold: 0.02 'median: 7)))
  (list in (SinOsc ar (FDiv (car freq+) 2) 0 amp)))

(let* ((in (AudioIn ar 1))
       (amp (Amplitude kr in 0.05 0.05))
       (freq+ (Pitch kr in 'ampThreshold: 0.02 'median: 7)))
  (list in (SinOsc ar (car freq+) 0 amp)))
