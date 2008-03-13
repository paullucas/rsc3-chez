;; int
(define addToHead 0)
(define addToTail 1)
(define addBefore 2)
(define addAfter 3)
(define addReplace 4)

;; int
(define genNormalize 1)
(define genWavetable 2)
(define genClear 4)

;; int
(define doNothing 0)
(define pauseSynth 1)
(define removeSynth 2)

(define /quit
  (message "/quit" nil))

(define /notify
  (lambda (i)
    (message "/notify" (list i))))

(define /status
  (message "/status" nil))

(define /dumpOSC
  (lambda (i)
    (message "/dumpOSC" (list i))))

(define /sync
  (lambda (i)
    (message "/sync" (list i))))

(define /clearSched
  (message "/clearSched" nil))

(define /d_recv
  (lambda (b)
    (message "/d_recv" (list b))))

(define /d_load
  (lambda (s)
    (message "/d_load" (list s))))

(define /d_loadDir
  (lambda (s)
    (message "/d_loadDir" (list s))))

(define /d_free1
  (lambda (s)
    (message "/d_free" (list s))))

(define /n_free1
  (lambda (i)
    (message "/n_free" (list i))))

(define /n_run1
  (lambda (i j)
    (message "/n_run" (list i j))))

(define /n_set1
  (lambda (i s f)
    (message "/n_set" (list i s f))))

(define /n_setn1
  (lambda (i s fs)
    (message "/n_setn" (cons i (cons s (cons (length fs) fs))))))

(define /n_fill1
  (lambda (i s j f)
    (message "/n_fill" (list i s j f))))

(define /n_map1
  (lambda (i s j)
    (message "/n_map" (list i s j))))

(define /n_mapn1
  (lambda (i s j k)
    (message "/n_mapn" (list i s j k))))

(define /n_before
  (lambda (i j)
    (message "/n_before" (list i j))))

(define /n_query
  (lambda (i)
    (message "/n_query" (list i))))

(define /n_trace
  (lambda (i)
    (message "/n_trace" (list i))))

(define /s_new0
  (lambda (s i j k)
    (message "/s_new" (list s i j k))))

(define /s_new1
  (lambda (s i j k t f)
    (message "/s_new" (list s i j k t f))))

(define /s_new2
  (lambda (s i j k t1 f1 t2 f2)
    (message "/s_new" (list s i j k t1 f1 t2 f2))))

(define /s_new
  (lambda (s i j k cs)
    (message "/s_new" (append2 (list s i j k) cs))))

(define /s_get1
  (lambda (i j)
    (message "/s_get" (list i j))))

(define /s_getn1
  (lambda (i s j)
    (message "/s_getn" (list i s j))))

(define /s_noid
  (lambda (i)
    (message "/s_noid" (list i))))

(define /g_new1
  (lambda (i j k)
    (message "/g_new" (list i j k))))

(define /g_head1
  (lambda (i j)
    (message "/g_head" (list i j))))

(define /g_tail1
  (lambda (i j)
    (message "/g_tail" (list i j))))

(define /g_freeAll1
  (lambda (i)
    (message "/g_freeAll" (list i))))

(define /g_deepFree1
  (lambda (i)
    (message "/g_deepFree" (list i))))

(define /b_alloc
  (lambda (id frames channels)
    (message "/b_alloc" (list id frames channels))))

(define /b_allocRead
  (lambda (id path frame n)
    (message "/b_allocRead" (list id path frame n))))

(define /b_read
  (lambda (id path frame n bframe flag)
    (message "/b_read" (list id path frame n bframe flag))))

(define /b_write
  (lambda (id path header type frames start flag)
    (message "/b_write" (list id path header type frames start flag))))

(define /b_free
  (lambda (i)
    (message "/b_free" (list i))))

(define /b_zero
  (lambda (i)
    (message "/b_zero" (list i))))

(define /b_set1
  (lambda (i j f)
    (message "/b_set" (list i j f))))

(define /b_setn1
  (lambda (i j fs)
    (message "/b_setn" (cons i (cons j (cons (length fs) fs))))))

(define /b_fill1
  (lambda (i j k f)
    (message "/b_fill" (list i j k f))))

(define /b_close
  (lambda (i)
    (message "/b_close" (list i))))

(define /b_query1
  (lambda (i)
    (message "/b_query" (list i))))

(define /b_get1
  (lambda (i j)
    (message "/b_get" (list i j))))

(define /b_getn1
  (lambda (i j k)
    (message "/b_getn" (list i j k))))

(define /b_gen1
  (lambda (i s fs)
    (message "/b_gen" (cons i (cons s fs)))))

(define /c_set1
  (lambda (i f)
    (message "/c_set" (list i f))))

(define /c_setn1
  (lambda (i fs)
    (message "/c_setn" (cons i (cons (length fs) fs)))))

(define /c_fill1
  (lambda (i j f)
    (message "/c_fill" (list i j f))))

(define /c_get1
  (lambda (i)
    (message "/c_get" (list i))))

(define /c_getn1
  (lambda (i j)
    (message "/c_getn" (list i j))))



;; port -> float -> [osc]
(define recv*
  (lambda (fd t)
    (let loop ((r (list)))
      (let ((p (recv fd t)))
	(if p (loop (cons p r)) (reverse r))))))

(define timeout 
  (make-parameter 1.0))

;; port -> string -> osc
(define wait
  (lambda (fd s)
    (let ((p (recv fd (timeout))))
      (cond
       ((not p) (error "wait: timed out"))
       ((not (string=? (car p) s)) (error "wait: bad return packet" p s))
       (else p)))))

;; port -> osc -> ()
(define async
  (lambda (fd m)
    (send fd m)
    (wait fd "/done")))

;; port -> ()
(define reset
  (lambda (fd)
    (send fd (bundle -1 (list (/g_freeAll1 0)
			      /clearSched
			      (/g_new1 1 0 0))))))

;; (port -> any) -> any
(define with-sc3
  (lambda (f)
    (let* ((fd (open-udp* "127.0.0.1" 57110))
	   (r (f fd)))
      (udp*-close fd)
      r)))



;; [string]
(define status-fields
  (list "# UGens                     "
	"# Synths                    "
	"# Groups                    "
	"# Instruments               "
	"% CPU (Average)             "
	"% CPU (Peak)                "
	"Sample Rate (Nominal)       "
	"Sample Rate (Actual)        "))

;; osc -> [string]
(define status-format
  (lambda (r)
    (cons "***** SuperCollider Server Status *****"
	  (zip-with string-append
		    status-fields 
		    (map1 number->string (cddr r))))))

;; port -> [string]
(define server-status
  (lambda (fd)
    (send fd /status)
    (let ((r (wait fd "status.reply")))
      (status-format r))))

;; port -> ()
(define display-server-status
  (lambda (fd)
    (newline)
    (for-each display (intersperse "\n" (server-status fd)))
    (newline)))

;; port -> int -> number
(define server-status-field
  (lambda (fd n)
    (send fd /status)
    (let ((r (wait fd "status.reply")))
      (list-ref r n))))

;; port -> float
(define server-sample-rate/nominal
  (lambda (s)
    (server-status-field s 8)))

;; port -> float
(define server-sample-rate/actual
  (lambda (s)
    (server-status-field s 9)))
