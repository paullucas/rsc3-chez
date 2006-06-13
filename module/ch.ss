;; ch.ss - (c) rohan drape, 2006

(module
 ch mzscheme
 (require (only (lib "async-channel.ss")
		async-channel-put
		make-async-channel))

 ;; ch = asynchronous channel. f = function to receive value.  t = utc
 ;; clock time in seconds to timeout. tf = function to receive timeout.
 (define make-ch make-async-channel)
 (define ch-put  async-channel-put)
 (define (ch-sync ch f t tf)
   (sync
    (handle-evt (alarm-evt (* 1000.0 t)) tf)
    (handle-evt ch f)))

 (provide make-ch
	  ch-sync
	  ch-put))
