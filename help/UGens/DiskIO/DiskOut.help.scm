;; (DiskOut bufnum channels)

;; Note: There are constaints on the size of the buffer, it must be
;; greater than or equal to twice the size of the audio bus.  There
;; must be the same number of channels at the buffer and the DiskOut
;; ugen.

(let ((bus-size 1024)
      (bufferexpt 15))
  (= 0 (bitwise-and (expt 2 bufferexpt) 
		    (- (arithmetic-shift bus-size 1) 1))))

(->< s
 (/d_recv 
  (graphdef->u8v
   (synthdef
    "DiskOut-Help"
    (letc ((bufnum 0))
      (let ((z (Clip2.ar 
		(RLPF.ar (LFPulse.ar (SinOsc.kr 0.2 0 10 21) 
				     '(0 0.1) 0.1) 100 0.1) 0.4)))
	(DiskOut.ar bufnum z)))))))

(define b (bID!))

(->< s (/b_alloc b 32768 2))

(->< s (/b_write b 
		 "/tmp/TEST_DISK_OUT.aiff" 
		 "aiff"
		 "float"
		 32768
		 0
		 0))

(define n (nID!))

(-> s (/s_new "DiskOut-Help" n 1 1 "bufnum" b))

(->< s (/b_close b))

(->< s (/b_free b))

(synth-free y)

(system "sndfile-info /tmp/TEST_DISK_OUT.aiff")

(unlink "/tmp/TEST_DISK_OUT.aiff")
