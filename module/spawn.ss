;; spawn.ss - (c) rohan drape, 2006

(module
 spawn mzscheme
 (require (only (lib "async-channel.ss")
		async-channel-put
		make-async-channel))

 ;; spawn is the composition of SRFI-18 make-thread & thread-start!
 (define spawn thread)
 (define thread-terminate! kill-thread)
 (define thread-sleep! sleep)

 ;; utc is an accurate clock time source
 (define (utc) (/ (current-inexact-milliseconds) 1000.0))

 ;; ch = asynchronous channel. f = function to receive value.  t = utc
 ;; clock time in seconds to timeout. tf = function to receive timeout.
 (define make-ch make-async-channel)
 (define ch-put  async-channel-put)
 (define (ch-sync ch f t tf)
   (sync
    (handle-evt (alarm-evt (* 1000.0 t)) tf)
    (handle-evt ch f)))

 (provide spawn
	  thread-terminate!
	  thread-sleep!
	  utc
	  make-ch
	  ch-sync
	  ch-put))
