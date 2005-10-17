;; patterns.scm - (c) rohan drape, 2005

;; Aliases to stream operations.

(define-syntax Pcons 
  (syntax-rules () 
    ((_ a b) (stream-cons a b))))

(define-syntax Pdef
  (syntax-rules () 
    ((_ a ...) (define-stream a ...))))

(define Pcar  stream-car)
(define Pcdr  stream-cdr)
(define Pnil  stream-null)
(define Pnil? stream-null?)
(define Pmap  stream-map)
(define Pls   stream->list)
(define P     as-stream)

(define-syntax Pnext!
  (syntax-rules ()
    ((_ p) (let ((n (Pcar p))) 
	     (begin! (set! p (Pcdr p)) 
		     n)))))

;; Math based patterns.

(define Piota stream-iota)
(define P+    stream-+)
(define P-    stream--)
(define P*    stream-*)
(define P/    stream-/)

(define-stream (Pgeom start grow length)
  (if (= length 0)
      Pnil
      (Pcons start (Pgeom (* start grow) grow (- length 1)))))

;; List based patterns.  This is the order given in the SuperCollider
;; streams help file.

(define-stream (Pseq l r o)
  (if (<= r 0)
      Pnil
      (stream-++ (list->stream (rotate l o))
		 (Pseq l (- r 1) o))))

(define-stream (Pser l r o)
  (Pfin r (Pseq l r o)))

(define-stream (Prand l r)
  (if (<= r 0)
      Pnil
      (Pcons (choose! l) (Prand l (- r 1)))))

(define-stream (Pshuf l r)
  (if (<= r 0)
      Pnil
      (stream-++ (list->stream (shuffle! l))
		 (Pshuf l (- r 1)))))

(define-stream (Place l r)
  (if (<= r 0)
      Pnil
      (stream-++ (list->stream (apply lace l))
		 (Place l (- r 1)))))

(define (Ptuple l r)
  (Pcons (map Pcar l) (Ptuple (map Pcdr l) r)))

;; Filter patterns.

(define-stream (Pswitch l w)
  (let* ((index (Pcar w))
	 (next (ref l index)))
    (if (stream? next)
	(stream-++ next (Pswitch l (Pcdr w)))
	(Pcons next (Pswitch l (Pcdr w))))))

(define-stream (Pn p n)
  (if (= n 0)
      Pnil
      (stream-++ p (Pn p (- n 1)))))

(define-stream (Pstutter n p)
  (stream-++ (list->stream (make-list n (Pcar p)))
	     (Pstutter n (Pcdr p))))

(define-stream (Pfin n p)
  (if (= n 0)
      Pnil
      (Pcons (Pcar p) (Pfin (- n 1) (Pcdr p)))))

(define Pcollect Pmap)

(define-stream (Preject p s)
  (let ((n (Pcar s))
	(t (Preject p (Pcdr s))))
    (if (p n) 
	t
	(Pcons n t))))

(define-stream (Pselect p s)
  (Preject (lambda (e) (not (p e))) s))

(define-stream (Pbindl l)
  (Pcons (plist->table (map Pcar l))
	 (Pbindl (map Pcdr l))))

(define-stream (Pbind . v)
  (Pbindl (map P v)))
