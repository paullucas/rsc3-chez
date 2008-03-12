
;; add-action

;; The addAction values are interpreted as follows:
;; 0 - add the new node to the the head of the group specified by the
;;     add target ID.
;; 1 - add the new node to the the tail of the group specified by the
;;     add target ID.
;; 2 - add the new node just before the node specified by the add
;;     target ID.
;; 3 - add the new node just after the node specified by the add
;;     target ID.
;; 4 - the new node replaces the node specified by the add target
;;     ID. The target node is freed.

(define addToHead  0)
(define addToTail  1)
(define addBefore  2)
(define addAfter   3)
(define addReplace 4)


;; command

(define /quit
  (message "/quit" nil))

(define (/notify i)
  (message "/notify" (list i)))

(define /status
  (message "/status" nil))

(define (/dumpOSC i)
  (message "/dumpOSC" (list i)))

(define (/sync i)
  (message "/sync" (list i)))

(define /clearSched
  (message "/clearSched" nil))

(define (/d_recv b)
  (message "/d_recv" (list b)))

(define (/d_load s)
  (message "/d_load" (list s)))

(define (/d_loadDir s)
  (message "/d_loadDir" (list s)))

(define (/d_free1 s)
  (message "/d_free" (list s)))

(define (/n_free1 i)
  (message "/n_free" (list i)))

(define (/n_run1 i j)
  (message "/n_run" (list i j)))

(define (/n_set1 i s f)
  (message "/n_set" (list i s f)))

(define (/n_setn1 i s fs)
  (message "/n_setn" (cons i (cons s (cons (length fs) fs)))))

(define (/n_fill1 i s j f)
  (message "/n_fill" (list i s j f)))

(define (/n_map1 i s j)
  (message "/n_map" (list i s j)))

(define (/n_mapn1 i s j k)
  (message "/n_mapn" (list i s j k)))

(define (/n_before i j)
  (message "/n_before" (list i j)))

(define (/n_query i)
  (message "/n_query" (list i)))

(define (/n_trace i)
  (message "/n_trace" (list i)))

(define (/s_new0 s i j k)
  (message "/s_new" (list s i j k)))

(define (/s_new1 s i j k t f)
  (message "/s_new" (list s i j k t f)))

(define (/s_new2 s i j k t1 f1 t2 f2)
  (message "/s_new" (list s i j k t1 f1 t2 f2)))

(define (/s_new s i j k cs)
  (message "/s_new" (append2 (list s i j k) cs)))

(define (/s_get1 i j)
  (message "/s_get" (list i j)))

(define (/s_getn1 i s j)
  (message "/s_getn" (list i s j)))

(define (/s_noid i)
  (message "/s_noid" (list i)))

(define (/g_new1 i j k)
  (message "/g_new" (list i j k)))

(define (/g_head1 i j)
  (message "/g_head" (list i j)))

(define (/g_tail1 i j)
  (message "/g_tail" (list i j)))

(define (/g_freeAll1 i)
  (message "/g_freeAll" (list i)))

(define (/g_deepFree1 i)
  (message "/g_deepFree" (list i)))

(define (/b_alloc id frames channels)
  (message "/b_alloc" (list id frames channels)))

(define (/b_allocRead id path frame n)
  (message "/b_allocRead" (list id path frame n)))

(define (/b_read id path frame n bframe flag)
  (message "/b_read" (list id path frame n bframe flag)))

(define (/b_write id path header type frames start flag)
  (message "/b_write" (list id path header type frames start flag)))

(define (/b_free i)
  (message "/b_free" (list i)))

(define (/b_zero i)
  (message "/b_zero" (list i)))

(define (/b_set1 i j f)
  (message "/b_set" (list i j f)))

(define (/b_setn1 i j fs)
  (message "/b_setn" (cons i (cons j fs))))

(define (/b_fill1 i j k f)
  (message "/b_fill" (list i j k f)))

(define (/b_close i)
  (message "/b_close" (list i)))

(define (/b_query1 i)
  (message "/b_query" (list i)))

(define (/b_get1 i j)
  (message "/b_get" (list i j)))

(define (/b_getn1 i j k)
  (message "/b_getn" (list i j k)))

(define (/b_gen1 i s fs)
  (message "/b_gen" (cons i (cons s fs))))

(define (/c_set1 i f)
  (message "/c_set" (list i f)))

(define (/c_setn1 i fs)
  (message "/c_setn" (cons i fs)))

(define (/c_fill1 i j f)
  (message "/c_fill" (list i j f)))

(define (/c_get1 i)
  (message "/c_get" (list i)))

(define (/c_getn1 i j)
  (message "/c_getn" (list i j)))


;; done-action

;; The doneAction values are interpreted as follows:
;;  0 - do nothing when the envelope has ended
;;  1 - pause the synth, it is still resident
;;  2 - remove the synth and deallocate it
;;  3 - remove and deallocate both this synth and the preceeding node
;;  4 - remove and deallocate both this synth and the following node
;;  5 - remove and deallocate this synth and if the preceeding node is a
;;      group then do g_freeAll on it, else n_free it
;;  6 - remove and deallocate this synth and if the following node is a
;;      group then do g_freeAll on it, else n_free it
;;  7 - remove and deallocate this synth and all preceeding nodes in this
;;      group
;;  8 - remove and deallocate this synth and all following nodes in this
;;      group
;;  9 - remove and deallocate this synth and pause the preceeding node
;; 10 - remove and deallocate this synth and pause the following node
;; 11 - remove and deallocate this synth and if the preceeding node is a
;;      group then do g_deepFree on it, else n_free it
;; 12 - remove and deallocate this synth and if the following node is a
;;      group then do g_deepFree on it, else n_free it

(define doNothing   0)
(define pauseSynth  1)
(define removeSynth 2)


;; gen

(define genNormalize 1)
(define genWavetable 2)
(define genClear     4)


;; server

(define send osc-send)

(define recv osc-recv)

(define (recv* fd t)
  (let loop ((r (list)))
    (let ((p (recv fd t)))
      (if p (loop (cons p r)) (reverse r)))))

(define timeout (make-parameter 1.0))

(define (wait fd m)
  (let ((p (recv fd (timeout))))
    (cond
     ((not p) (error "wait: timed out"))
     ((not (string=? (car p) m)) (error "wait: bad return packet" p m))
     (else p))))

(define (async fd m)
  (send fd m)
  (wait fd "/done"))

(define (reset fd)
  (send fd (bundle -1
		   (/g_freeAll1 0)
		   /clearSched
		   (/g_new1 1 0 0))))

(define (with-sc3 f)
  (let* ((fd (open-udp* "127.0.0.1" 57110))
	 (r (f fd)))
    (udp*-close fd)
    r))


;; status.scm

(define status-fields
  (list "# UGens                     "
	"# Synths                    "
	"# Groups                    "
	"# Instruments               "
	"% CPU (Average)             "
	"% CPU (Peak)                "
	"Sample Rate (Nominal)       "
	"Sample Rate (Actual)        "))

(define (status-info r)
  (map number->string (cddr r)))

(define (status-format r)
  (cons "***** SuperCollider Server Status *****"
	(map string-append status-fields (status-info r))))

;; Collect server status information.

(define (server-status fd)
  (send fd /status)
  (let ((r (wait fd "status.reply")))
    (status-format r)))

(define (display-server-status s)
  (newline)
  (for-each display (intersperse "\n" (server-status s)))
  (newline))

;; Accessors

(define (server-status-field fd n)
  (send fd /status)
  (let ((r (wait fd "status.reply")))
    (list-ref r n)))

(define (server-sample-rate/nominal s)
  (server-status-field s 8))

(define (server-sample-rate/actual s)
  (server-status-field s 9))
