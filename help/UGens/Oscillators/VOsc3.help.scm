;;; (VOsc3 bufpos freq1 freq2 freq3)

;;; Three variable wavetable oscillators.
 
;;; A wavetable lookup oscillator which can be swept smoothly across
;;; wavetables. All the wavetables must be allocated to the same
;;; size. Fractional values of table will interpolate between two
;;; adjacent tables. This unit generator contains three oscillators at
;;; different frequencies, mixed together.
 
;;; This oscillator requires a buffer to be filled with a wavetable
;;; format signal.  This preprocesses the Signal into a form which can
;;; be used efficiently by the Oscillator.  The buffer size must be a
;;; power of 2.
 
;;;; This can be acheived by creating a Buffer object and sending it
;;;; one of the "b_gen" messages ( sine1, sine2, sine3 ) with the
;;;; wavetable flag set to true.
 
;;; Note about wavetables: VOsc3 requires the b_gen sine1 wavetable
;;; flag to be ON.
 
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

(VOsc3.ar (MouseX.kr 0 7) '(240 241) '(240.27 241.1) '(240.43 239.71) 0.3)

;; Reallocate buffers while oscillator is running.

(iter 8 (lambda (i)
	    ;; Allocate table 
	    (-> '/b_alloc i 1024)
	    ;; Fill table 
	    (apply -> '/b_gen  i 'sine1 7 (random-list 16 0 1))))
