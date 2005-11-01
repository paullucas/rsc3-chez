;; (VOsc bufpos freq phase)

;; Variable wavetable oscillator.  A wavetable lookup oscillator which
;; can be swept smoothly across wavetables. All the wavetables must be
;; allocated to the same size. Fractional values of table will
;; interpolate between two adjacent tables.
 
;; This oscillator requires a buffer to be filled with a wavetable
;; format signal.  This preprocesses the Signal into a form which can
;; be used efficiently by the Oscillator.  The buffer size must be a
;; power of 2.
 
;; This can be acheived by creating a Buffer object and sending it one
;; of the "b_gen" messages ( sine1, sine2, sine3 ) with the wavetable
;; flag set to true.
 
;; This can also be acheived by creating a Signal object and sending
;; it the 'asWavetable' message, saving it to disk, and having the
;; server load it from there.
 
;; Note about wavetables: VOsc requires the b_gen sine1 wavetable flag
;; to be ON.
 
;; Allocate and fill tables 0 to 7.

(iter 8 (lambda (i)
	    ;; Allocate table 
	    (-> '/b_alloc i 1024)
	    ;; Generate list of harmonic amplitudes
	    (let* ((n (expt (+ i 1) 2))
		   (a (tabulate n (lambda (j) (square (/ (- n j) n))))))
	      ;; Fill table 
	      (apply -> '/b_gen  i 'sine1 7 a))))

;; Oscillator at buffers 0 through 7.

(VOsc.ar (MouseX.kr 0 7) '(120 121) 0 0.3)

;; Reallocate buffers while oscillator is running.

(iter 8 (lambda (i)
	    ;; Allocate table 
	    (-> '/b_alloc i 1024)
	    ;; Fill table 
	    (apply -> '/b_gen  i 'sine1 7 (random-list 12 0 1))))

