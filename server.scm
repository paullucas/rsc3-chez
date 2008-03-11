
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

(define with-reply 
  (lambda (_ m)
    m))

(define /quit
  (with-reply
   "/done"
   (message "/quit")))

(define (/notify code)
  (with-reply
   "/done"
   (message "/notify" code)))

(define /status
  (with-reply
   "status.reply"
   (message "/status")))

(define (/dumpOSC code)
  (message "/dumpOSC" code))

(define (/sync id)
  (with-reply
   "/synced"
   (message "/sync" id)))

(define /clearSched
  (message "/clearSched"))

(define (/d_recv data)
  (with-reply
   "/done"
   (message "/d_recv" data)))

(define (/d_load path)
  (with-reply
   "/done"
   (message "/d_load" path)))

(define (/d_loadDir path)
  (with-reply
   "/done"
   (message "/d_loadDir" path)))

(define (/d_free name)
  (message "/d_free" name))

(define (/n_free id)
  (message "/n_free" id))

(define (/n_run id flag)
  (message "/n_run" id flag))

(define (/n_set id index value)
  (message "/n_set" id index value))

(define (/n_setn id index n . values)
  (apply message "/n_setn" id index n values))

(define (/n_fill id index n value)
  (message "/n_fill" id index n value))

(define (/n_map id index bus)
  (message "/n_map" id index bus))

(define (/n_mapn id index bus n)
  (message "/n_mapn" id index bus n))

(define (/n_before a b)
  (message "/n_before" a b))

(define (/n_query id)
  (with-reply 
   "n_info"
   (message "/n_query" id)))

(define (/n_trace id)
  (message "/n_trace" id))

(define (/s_new name id action target . initialize)
  (apply message "/s_new" name id action target initialize))

(define (/s_get id index)
  (with-reply
   "n_set"
   (message "/s_get" id index)))

(define (/s_getn id index n)
  (with-reply
   "n_setn"
   (message "/s_getn" id index n)))

(define (/s_noid id)
  (message "/s_noid" id))

(define (/g_new id action target)
  (message "/g_new" id action target))

(define (/g_head group node)
  (message "/g_head" group node))

(define (/g_tail group node)
  (message "/g_tail" group node))

(define (/g_freeAll id)
  (message "/g_freeAll" id))

(define (/g_deepFree id)
  (message "/g_deepFree" id))

(define (/b_alloc id frames channels)
  (with-reply
   "/done"
   (message "/b_alloc" id frames channels)))

(define (/b_allocRead id path frame n)
  (with-reply
   "/done"
   (message "/b_allocRead" id path frame n)))

(define (/b_read id path frame n bframe flag)
  (with-reply
   "/done"
   (message "/b_read" id path frame n bframe flag)))

(define (/b_write id path header type frames start flag)
  (with-reply
   "/done"
   (message "/b_write" id path header type frames start flag)))

(define (/b_free id)
  (with-reply
   "/done"
   (message "/b_free" id)))

(define (/b_zero id)
  (with-reply
   "/done"
   (message "/b_zero" id)))

(define (/b_set id index value)
  (message "/b_set" id index value))

(define (/b_setn id index n . values)
  (apply message "/b_setn" id index n values))

(define (/b_setn* id n l)
  (apply /b_setn id n (length l) l))

(define (/b_fill id index n value)
  (message "/b_fill" id index n value))

(define (/b_close id)
  (with-reply
   "/done"
   (message "/b_close" id)))

(define (/b_query id)
  (with-reply
   "/b_info"
   (message "/b_query" id)))

(define (/b_get id index)
  (with-reply
   "/b_set"
   (message "/b_get" id index)))

(define (/b_getn id index n)
  (with-reply
   "/b_setn"
   (message "/b_getn" id index n)))

(define (/b_gen id cmd . values)
  (with-reply
   "/done"
   (apply message "/b_gen" id cmd values)))

(define (/b_gen* id cmd . l)
  (apply /b_gen id cmd (splice l)))

(define (/c_set id value)
  (message "/c_set" id value))

(define (/c_setn id n . values)
  (apply message "/c_setn" id n values))

(define (/c_setn* n l)
  (apply /c_setn n (length l) l))

(define (/c_fill id n value)
  (message "/c_fill" id n value))

(define (/c_get id)
  (with-reply
   "/c_set"
   (message "/c_get" id)))

(define (/c_getn id n)
  (with-reply
   "/c_setn"
   (message "/c_getn" id n)))


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
		   (/g_freeAll 0)
		   /clearSched
		   (/g_new 1 0 0))))

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
