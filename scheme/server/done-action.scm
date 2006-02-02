;; done-action.scm - (c) rohan drape, 2003-2006

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
