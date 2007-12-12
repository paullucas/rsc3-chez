;; (DiskOut bufnum channels)

;; Note: There are constraints on the size of the buffer, it must be
;; greater than or equal to twice the size of the audio bus.  There
;; must be the same number of channels at the buffer and the DiskOut
;; ugen.

(let ((bus-size 1024)
      (bufferexpt 15))
  (= 0 (bitwise-and (expt 2 bufferexpt)
		    (- (arithmetic-shift bus-size 1) 1))))

(let ((b 10)
      (n 100)
      (t 10)
      (g (letc ((bufnum 0))
	   (let ((z (Clip2
		     (RLPF (LFPulse ar (MulAdd (SinOsc kr 0.2 0) 10 21)
				    (Mce 0 0.1) 0.1) 100 0.1) 0.4)))
	     (Mrg (DiskOut bufnum z)
		  (Out 0 z))))))
  (with-sc3
   (lambda (fd)
     (->< fd (/d_recv (graphdef->u8l (synthdef "DiskOut-Help" g))))
     (->< fd (/b_alloc b 32768 2))
     (->< fd (/b_write b
		       "/tmp/test.aiff"
		       "aiff"
		       "float"
		       32768
		       0
		       1))
     (-> fd (/s_new "DiskOut-Help" n 1 1 "bufnum" b))
     (sleep t)
     (-> fd (/n_free n))
     (->< fd (/b_close b))
     (->< fd (/b_free b)))))

(system "sndfile-info /tmp/test.aiff")
(system "jack.play /tmp/test.aiff")
