;; command.scm - (c) rohan drape, 2005-2007

(module command (lib "lang.ss" "r5rs")
(#%require (only "../collection/list.scm"
		 splice)
	   (only "../osc/verify.scm"
		 message))
(#%provide (all-defined))

(define with-reply list)

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
  (with-reply "n_info"
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

)
