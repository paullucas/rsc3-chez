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

(define atHeadOf    0)
(define atTailOf    1)
(define beforeNode  2)
(define afterNode   3)
(define replaceNode 4)
