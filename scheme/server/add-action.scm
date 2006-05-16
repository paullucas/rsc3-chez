;; add-action.scm - (c) rohan drape, 2006

;; The addAction values are interpreted as follows:

;; 0 - add the new node to the the head of the group specified by the
;; add target ID.

;; 1 - add the new node to the the tail of the group specified by the
;; add target ID.

;; 2 - add the new node just before the node specified by the add
;; target ID.

;; 3 - add the new node just after the node specified by the add
;; target ID.

;; 4 - the new node replaces the node specified by the add target
;; ID. The target node is freed.

(define addToHead  0)
(define addToTail  1)
(define addBefore  2)
(define addAfter   3)
(define addReplace 4)
