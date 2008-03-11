
;; hscheme

;; all :: (a -> Bool) -> [a] -> Bool
(define all
  (lambda (f l)
    (if (null? l)
        #t
        (and (f (head l)) (all f (tail l))))))

;; and :: [Bool] -> Bool
(define all-true
  (lambda (l)
    (if (null? l)
        #t
        (and (head l) (all-true (tail l))))))

;; any :: (a -> Bool) -> [a] -> Bool
(define any
  (lambda (f l)
    (if (null? l)
        #f
        (or (f (head l)) (any f (tail l))))))

;; (++) :: [a] -> [a] -> [a]
(define append2
  (lambda (a b)
    (if (null? a)
        b
        (cons (head a) (append2 (tail a) b)))))

;; break :: (a -> Bool) -> [a] -> ([a],[a])
(define break
  (lambda (p l)
    (span (compose not p) l)))

;; compare :: (Ord a) => a -> a -> Ordering 
(define GT 'GT)
(define LT 'LT)
(define EQ 'EQ)
(define compare
  (lambda (x y)
    (cond ((> x y) GT)
          ((< x y) LT)
          (else EQ))))

;; (.) :: (b -> c) -> (a -> b) -> a -> c
;;(define compose
;;  (lambda (f g)
;;    (lambda (x)
;;      (f (g x)))))

;; concat :: [[a]] -> [a]
(define concat
  (lambda (l)
    (foldr append2 nil l)))

;; concatMap :: (a -> [b]) -> [a] -> [b]
(define concat-map
  (lambda (f l)
    (concat (map1 f l))))

;; const :: a -> b -> a
(define const
  (lambda (x)
    (lambda (_)
      x)))

;; curry :: ((a, b) -> c) -> a -> b -> c
(define curry
  (lambda (f)
    (lambda (x y)
      (f (tuple2 x y)))))

;; deleteBy :: (a -> a -> Bool) -> a -> [a] -> [a]
(define delete-by
  (lambda (f x l)
    (if (null? l)
        nil
        (if (f x (head l))
            (tail l)
            (cons (head l) (delete-by f x (tail l)))))))

;; delete :: (Eq a) => a -> [a] -> [a]
(define delete
  (lambda (x l)
    (delete-by equal? x l)))

;; drop :: Int -> [a] -> [a]
(define drop
  (lambda (n l)
    (cond ((<= n 0) l)
          ((null? l) nil)
          (else (drop (- n 1) (tail l))))))

;; dropWhile :: (a -> Bool) -> [a] -> [a]
(define drop-while
  (lambda (p l)
    (if (null? l)
        nil
        (if (p (head l))
            (drop-while p (tail l))
            l))))

;; elem :: (Eq a) => a -> [a] -> Bool
(define elem
  (lambda (x l)
    (any (lambda (y) (equal? x y)) l)))

;; elemIndex :: Eq a => a -> [a] -> Maybe Int
(define elem-index
  (lambda (x l)
    (find-index (lambda (y) (equal? x y)) l)))

;; elemIndices :: Eq a => a -> [a] -> [Int]
(define elem-indices
  (lambda (x l)
    (find-indices (lambda (y) (equal? x y)) l)))

;; enumFromThenTo :: a -> a -> a -> [a]
(define enum-from-then-to
  (lambda (i j k)
    (cond ((= i k) (list1 k))
          ((> i k) nil)
          (else (cons i (enum-from-then-to j (+ j (- j i)) k))))))

;; enumFromTo :: a -> a -> [a]
(define enum-from-to
  (lambda (i j)
    (enum-from-then-to i (succ i) j)))

;; even :: (Integral a) => a -> Bool
(define even
  (lambda (n)
    (even? n)))

;; find :: (a -> Bool) -> [a] -> Maybe a
(define find
  (lambda (f l)
    (if (null? l)
        #f
        (if (f (head l))
            (head l)
            (find f (tail l))))))


;; findIndex :: (a -> Bool) -> [a] -> Maybe Int
(define find-index
  (letrec ((g (lambda (f l n)
                (if (null? l)
                    #f
                    (if (f (head l))
                        n
                        (g f (tail l) (+ n 1)))))))
    (lambda (f l)
      (g f l 0))))

;; findIndices :: (a -> Bool) -> [a] -> [Int]
(define find-indices
  (letrec ((g (lambda (f l n)
                (if (null? l)
                    nil
                    (if (f (head l))
                        (cons n (g f (tail l) (+ n 1)))
                        (g f (tail l) (+ n 1)))))))
    (lambda (f l)
      (g f l 0))))

;; filter :: (a -> Bool) -> [a] -> [a]
;;(define filter
;;  (lambda (f l)
;;    (if (null? l)
;;        nil
;;        (let ((x (head l))
;;              (xs (tail l)))
;;          (if (f x)
;;              (cons x (filter f xs))
;;              (filter f xs))))))

;; flip :: (a -> b -> c) -> b -> a -> c
(define flip
  (lambda (f)
    (lambda (x y)
      (f y x))))

;; foldl :: (a -> b -> a) -> a -> [b] -> a
;;(define foldl
;;  (lambda (f z l)
;;    (if (null? l)
;;        z
;;        (foldl f (f z (head l)) (tail l)))))

;; foldl1 :: (a -> a -> a) -> [a] -> a
(define foldl1
  (lambda (f l)
    (foldl f (head l) (tail l))))

;; foldr :: (a -> b -> b) -> b -> [a] -> b
;;(define foldr
;;  (lambda (f z l)
;;    (if (null? l)
;;        z
;;        (f (head l) (foldr f z (tail l))))))

;; foldr1 :: (a -> a -> a) -> [a] -> a
(define foldr1
  (lambda (f l)
    (if (null? (tail l))
        (head l)
        (f (head l) (foldr1 f (tail l))))))

;; fst :: (a, b) -> a
(define fst
  (lambda (v)
    (vector-ref v 0)))

;; head :: [a] -> a
(define head car)

;; id :: a -> a
(define id
  (lambda (x)
    x))

;; init :: [a] -> [a]
(define init
  (lambda (l)
    (let ((x (head l))
          (xs (tail l)))
      (if (null? xs)
          nil
          (cons x (init xs))))))

;; insert :: Ord a => a -> [a] -> [a]
(define insert 
  (lambda (e l)
    (insert-by compare e l)))

;; insertBy :: (a -> a -> Ordering) -> a -> [a] -> [a]
(define insert-by
  (lambda (f x l)
    (if (null? l)
        (list1 x)
        (if (equal? (f x (head l)) GT)
            (cons (head l) (insert-by f x (tail l)))
            (cons x l)))))

;; intercalate :: [a] -> [[a]] -> [a]
(define intercalate
  (lambda (xs xss)
    (concat (intersperse xs xss))))

;; intersperse :: a -> [a] -> [a]
(define intersperse
  (lambda (x l)
    (cond ((null? l) nil)
          ((null? (tail l)) l)
          (else (cons (head l) (cons x (intersperse x (tail l))))))))

;; isInfixOf :: (Eq a) => [a] -> [a] -> Bool
(define is-infix-of
  (lambda (p q)
    (cond ((null? p) #t)
          ((null? q) #f)
          (else (or (is-prefix-of p q)
                    (is-infix-of p (tail q)))))))

;; isPrefixOf :: (Eq a) => [a] -> [a] -> Bool
(define is-prefix-of
  (lambda (p q)
    (cond ((null? p) #t)
          ((null? q) #f)
          (else (and (equal? (head p) (head q)) 
                     (is-prefix-of (tail p) (tail q)))))))

;; isSuffixOf :: (Eq a) => [a] -> [a] -> Bool
(define is-suffix-of
  (lambda (p q)
    (is-prefix-of (reverse p) (reverse q))))

;; last :: [a] -> a
(define last
  (lambda (l)
    (let ((xs (tail l)))
      (if (null? xs)
          (head l)
          (last xs)))))

;; length :: [a] -> Int
;; (define length
;;   (lambda (l)
;;     (if (null? l)
;;         0
;;         (+ 1 (length (tail l))))))

;; list1 :: a -> [a]
(define list1
  (lambda (x)
    (list x)))

;; list2 :: a -> a -> [a]
(define list2
  (lambda (x y)
    (list x y)))

;; list3 :: a -> a -> a -> [a]
(define list3
  (lambda (x y z)
    (list x y z)))

;; (!!) :: [a] -> Int -> a
;; (define list-ref
;;   (lambda (l n)
;;     (if (= n 0)
;;         (head l)
;;         (list-ref (tail l) (- n 1)))))

;; lookup :: (Eq a) => a -> [(a, b)] -> Maybe b
(define lookup
  (lambda (x l)
    (if (null? l)
        #f
        (if (equal? (fst (head l)) x)
            (snd (head l))
            (lookup x (tail l))))))

;; map :: (a -> b) -> [a] -> [b]
(define map1
  (lambda (f l)
    (if (null? l)
        nil
        (cons (f (head l)) (map1 f (tail l))))))

;; mapAccumL :: (acc -> x -> (acc, y)) -> acc -> [x] -> (acc, [y])
(define map-accum-l 
  (lambda (f s l)
    (if (null? l) 
        (tuple2 s nil)
        (let* ((x (head l))
               (xs (tail l))
               (s_y (f s x))
               (s_ (fst s_y))
               (y (snd s_y))
               (s__ys (map-accum-l f s_ xs))
               (s__ (fst s__ys))
               (ys (snd s__ys)))
          (tuple2 s__ (cons y ys))))))

;; (map-accum-l (lambda (x y) (tuple2 (* x 3) (* y 5))) 3 '(1 2 3 4 5))
;; => #(729 (5 10 15 20 25))

;; mapAccumR :: (acc -> x -> (acc, y)) -> acc -> [x] -> (acc, [y])
(define map-accum-r
  (lambda (f s l)
    (if (null? l) 
        (tuple2 s nil)
        (let* ((x (head l))
               (xs (tail l))
               (s_ys (map-accum-r f s xs))
               (s_ (fst s_ys))
               (ys (snd s_ys))
               (s__y (f s_ x))
               (s__ (fst s__y))
               (y (snd s__y)))
          (tuple2 s__ (cons y ys))))))

;; maximum :: (Ord a) => [a] -> a
(define maximum
  (lambda (l)
    (foldl1 max l)))

;; minimum :: (Ord a) => [a] -> a
(define minimum
  (lambda (l)
    (foldl1 min l)))

;; nub :: (Eq a) => [a] -> [a]
(define nub
  (lambda (l)
    (nub-by equal? l)))

;; nubBy :: (a -> a -> Bool) -> [a] -> [a]
(define nub-by
  (lambda (f l)
    (if (null? l)
        nil
        (let ((x (head l))
              (xs (tail l)))
          (cons x (nub-by f (filter (lambda (y) (not (f x y))) xs)))))))

;; nil :: [a]
(define nil
  (list))

;; notElem :: (Eq a) => a -> [a] -> Bool
(define not-elem
  (lambda (x l)
    (all (lambda (y) (not (equal? x y))) l)))

;; null :: [a] -> Bool
;;(define null null?)

;; odd :: (Integral a) => a -> Bool
(define odd
  odd?)

;; or :: [Bool] -> Bool
(define any-true
  (lambda (l)
    (if (null? l)
        #f
        (or (head l) (any-true (tail l))))))

;; otherwise :: Bool
(define otherwise
  #t)

;; partition :: (a -> Bool) -> [a] -> ([a],[a])
(define partition 
  (let ((select (lambda (p) 
                  (lambda (x tf)
                    (let ((t (fst tf))
                          (f (snd tf)))
                      (if (p x) 
                          (tuple2 (cons x t) f)
                          (tuple2 t (cons x f))))))))
    (lambda (p xs)
      (foldr (select p) (tuple2 nil nil) xs))))

;; pred :: a -> a
(define pred
  (lambda (x)
    (- x 1)))

;; product :: (Num a) => [a] -> a
(define product
  (lambda (l)
    (foldl * 1 l)))

;; replicate :: Int -> a -> [a]
(define replicate
  (lambda (n x)
    (if (= n 0)
        nil
        (cons x (replicate (- n 1) x)))))

;; reverse :: [a] -> [a]
;; (define reverse
;;   (lambda (l)
;;     (foldl (flip cons) nil l)))
        
;; scanl :: (a -> b -> a) -> a -> [b] -> [a]
(define scanl
  (lambda (f q l)
    (cons q (if (null? l)
                nil
                (scanl f (f q (head l)) (tail l))))))

;; scanl1 :: (a -> a -> a) -> [a] -> [a]
(define scanl1
  (lambda (f l)
    (if (null? l)
        nil
        (scanl f (head l) (tail l)))))

;; scanr :: (a -> b -> b) -> b -> [a] -> [b]
(define scanr
  (lambda (f q0 l)
    (if (null? l)
        (list1 q0)
        (let ((qs (scanr f q0 (tail l))))
          (cons (f (head l) (head qs)) qs)))))

;; scanr1 :: (a -> a -> a) -> [a] -> [a]
(define scanr1
  (lambda (f l)
    (if (null? l)
        nil
        (if (null? (tail l))
            l
            (let ((qs (scanr1 f (tail l))))
              (cons (f (head l) (head qs)) qs))))))

;; snd :: (a, b) -> b
(define snd
  (lambda (v)
    (vector-ref v 1)))

;; span :: (a -> Bool) -> [a] -> ([a],[a])
(define span
  (lambda (p l)
    (if (null? l)
        (tuple2 nil nil)
        (if (p (head l))
            (let ((r (span p (tail l))))
              (tuple2 (cons (head l) (fst r)) (snd r)))
            (tuple2 nil l)))))

;; splitAt :: Int -> [a] -> ([a],[a])
(define split-at
  (lambda (n l)
    (tuple2 (take n l) (drop n l))))

;; succ :: a -> a
(define succ
  (lambda (x)
    (+ x 1)))

;; sum :: (Num a) => [a] -> a
(define sum
  (lambda (l)
    (foldl + 0 l)))

;; tail :: [a] -> [a]
(define tail cdr)

;; take :: Int -> [a] -> [a]
(define take
  (lambda (n l)
    (cond ((<= n 0) nil)
          ((null? l) nil)
          (else (cons (head l) (take (- n 1) (tail l)))))))

;; takeWhile :: (a -> Bool) -> [a] -> [a]
(define take-while
  (lambda (p l)
    (if (null? l)
        nil
        (if (p (head l))
            (cons (head l) (take-while p (tail l)))
            nil))))

;; transpose :: [[a]] -> [[a]]
(define transpose
  (lambda (l)
    (let ((protect
           (lambda (f)
             (lambda (x)
               (if (null? x)
                   nil
                   (f x))))))
      (cond ((null? l) nil)
            ((null? (head l)) (transpose (tail l)))
            (else (let* ((e (head l))
                         (x (head e))
                         (xs (tail e))
                         (xss (tail l)))
                    (cons (cons x (filter (compose not null?) (map1 (protect head) xss)))
                          (transpose (cons xs (map (protect tail) xss))))))))))

;; tuple1 :: a -> (a)
(define tuple1
  (lambda (x)
    (vector x)))

;; tuple2 :: a -> b -> (a, b)
(define tuple2
  (lambda (x y)
    (vector x y)))

;; tuple3 :: a -> b -> c -> (a, b, c)
(define tuple3
  (lambda (x y z)
    (vector x y z)))

;; uncurry :: (a -> b -> c) -> (a, b) -> c
(define uncurry
  (lambda (f)
    (lambda (xy)
      (f (fst xy) (snd xy)))))

;; undefined :: a
(define undefined
  (lambda ()
    (head nil)))

;; unfoldr :: (b -> Maybe (a, b)) -> b -> [a]
(define unfoldr
  (lambda (f x)
    (let ((r (f x)))
      (if r
          (cons (fst r) (unfoldr f (snd r)))
          nil))))

;; (unfoldr (lambda (b) (if (= b 0) #f (tuple2 b (- b 1)))) 10)
;; => (10 9 8 7 6 5 4 3 2 1)

;; union :: (Eq a) => [a] -> [a] -> [a]
(define union
  (lambda (a b)
    (union-by equal? a b)))

;; unionBy :: (a -> a -> Bool) -> [a] -> [a] -> [a]
(define union-by
  (lambda (f xs ys)
    (let ((g (lambda (x y) (delete-by f y x))))
      (append2 xs (foldl g (nub-by f ys) xs)))))

;; zip :: [a] -> [b] -> [(a, b)]
(define zip
  (lambda (a b)
    (zip-with tuple2 a b)))

;; zip2 :: [a] -> [b] -> [c] -> [(a, b, c)]
(define zip3
  (lambda (a b c)
    (zip-with tuple3 a b c)))

;; zipWith :: (a -> b -> c) -> [a] -> [b] -> [c]
(define zip-with
  (lambda (f a b)
    (cond ((null? a) nil)
          ((null? b) nil)
          (else (cons (f (head a) (head b))
                      (zip-with f (tail a) (tail b)))))))

;; zipWith3 :: (a -> b -> c -> d) -> [a] -> [b] -> [c] -> [d]
(define zip-with3
  (lambda (f a b c)
    (cond ((null? a) nil)
          ((null? b) nil)
          ((null? c) nil)
          (else (cons (f (head a) (head b) (head c))
                      (zip-with3 f (tail a) (tail b) (tail c)))))))


;; structure

(define-syntax define-structure
   (syntax-rules ()
     ((_ name field ...)
      (define-struct name (field ...) #:mutable #:inspector (make-inspector)))))


;; list

;; list-ref variant where n is taken modulo the list length.

(define (list-ref/wrap l n)
  (list-ref l (modulo n (length l))))

;; length variant that returns 1 for non-list arguments.

(define (length* l)
  (if (list? l)
      (length l)
      1))

(define iota
  (lambda (n)
    (enum-from-to 0 (- n 1))))

;; iota variant that makes a list of `n' places, the first is `init',
;; each subsequent is the previous multiplied by `factor'.

(define (geom n init factor)
  (if (= n 0)
      (list)
      (cons init (geom (- n 1) (* init factor) factor))))

;; filter variant that return a sub-list of `l' containing only those
;; elements at indices for which the procedure `predicate' evaluates
;; to '#t'.

(define (filter-index predicate l)
  (map (lambda (index) (list-ref l index))
       (filter predicate (iota (length l)))))

;; [sclang] Elements at `l' are spliced into a list.  This is a
;; non-recursive flatten operation.

(define (splice l)
  (let ((f (lambda (a b)
	     (if (list? a)
		 (append a b)
		 (cons a b)))))
    (foldr f '() l)))

;; [sclang] Return a list of `n' places.  If `l' is a list with fewer
;; than `n' elements returns the circular expansion of `l', if `l' is
;; a list with more than `n' elements returns only first `n' elements
;; of `l', if `l'is a list of `n' elements returns `l'.  If `l' is not
;; a list returns a list of `n' elements each being `l'.

(define (extend l n)
  (if (and (list? l) (not (null? l)))
      (let ((z (length l)))
	(cond ((= z n) l)
	      ((> z n) (take n l))
	      (else (extend (append l l) n))))
      (replicate n l)))

;; Extend all lists at `l' to be equal in length to the longest list
;; at `l'.  If any element is not a list it is replaced with a list of
;; itself of that length.

(define (extend-all l)
  (let ((n (apply max (map length* l))))
    (map (lambda (e) (extend e n)) l)))

;; Return a rotation of `l' by `n' places.

(define (rotate l n)
  (let ((ll (length l)))
    (map (lambda (index) (list-ref l (modulo (+ n index) ll)))
	 (iota ll))))

;; UNSAFE...

(define (invert l)
  (let ((f (lambda (n) (map (lambda (e) (list-ref e n)) l))))
    (map f (iota (length (car l))))))

;; Return a <list> containing every `n'th element of the list `l' in
;; sequence.

(define (take-cycle l n)
  (filter-index (lambda (i) (= 0 (modulo i n))) l))

;; Return a <list> of <list>s, each containing a cycle generated by
;; 'take-cycle'.

(define (cycles l n)
  (map (lambda (i)
	 (take-cycle (drop i l) n))
       (iota n)))


;; series

;; Predicate to determine if `l' is a one element list.

(define (singleton? l)
  (and (list? l) (null? (cdr l))))

;; The sequence of intervals between the elements of the series `s'.

(define (d->dx s)
  (d->dx** s -))

;; Variant that considers the interval from the first to last element.

(define (d->dx* s)
  (d->dx (append s (list (car s)))))

;; Variant allowing function other than '-'.

(define (d->dx** s f)
  (unfoldr
   (lambda (b)
     (if (null? (tail b))
         #f
         (tuple2 (f (head (tail b)) (head b)) (tail b))))
   s))

;; A series, the first element being `n', and subsequent elements
;; summing the previous element with the interval from the interval
;; series `i'.

(define (dx->d n i)
  (if (null? i)
      (list n)
      (cons n (dx->d (+ (car i) n) (cdr i)))))


;; tree

;; A not entirely naive flatten - ie. does not use append.

(define (flatten* t r)
  (cond ((null? t) r)
	((list? t) (flatten* (car t) (flatten* (cdr t) r)))
	(else      (cons t r))))

(define (flatten t)
  (flatten* t '()))

;; Map f over the leaf nodes of t.

(define (mapt f t)
  (cond ((null? t) (list))
	((list? t) (map (lambda (e) (mapt f e)) t))
	(else      (f t))))


;; clip

;; Clip `n' between a and b.

(define (clip a b n) (if (< n a) a (if (> n b) b n)))
(define (clipu n)    (clip 0 1 n))

;; Clip real and imaginary components of z.

(define (clipz a b z)
  (make-rectangular (clip a b (real-part z))
		    (clip a b (imag-part z))))


;; common

(define (squared n)
  (* n n))

(define (cubed n)
  (* n n n))

(define (recip n)
  (/ 1 n))


;; constants

(define e (exp 1.0))
(define pi (* 4 (atan 1)))
(define two-pi (* 2 pi))
(define half-pi (/ pi 2))

;; SuperCollider names.

(define pi2    half-pi)
(define pi32   (* pi 1.5))
(define twopi  two-pi)
(define rtwopi (/ 1.0 two-pi))
(define log001 (log 0.001))
(define log01  (log 0.01))
(define log1   (log 0.1))
(define rlog2  (/ 1.0 (log 2.0)))
(define sqrt2  (sqrt 2.0))
(define rsqrt2 (/ 1.0 sqrt2))

;; +inf.0 does not write to UGen graph files...

(define inf 1073741824.0)


;; exact

;; Exact integer constructors and predicate.

(define (floor-exact n)    (inexact->exact (floor n)))
(define (ceiling-exact n)  (inexact->exact (ceiling n)))
(define (truncate-exact n) (inexact->exact (truncate n)))
(define (round-exact n)    (inexact->exact (round n)))

;;(define (exact-integer? x) (and (integer? x) (exact? x)))


;; gain

;; Convert a linear rms gain value to a decibel value and the inverse.
;; Zero decibels is unity gain.  These algorithms are from SC3.

(define (ampdb amp) (* (log10 amp) 20))
(define (dbamp db)  (expt 10 (* db 0.05)))

(define (powdb pow) (* (log10 pow) 10))
(define (dbpow db)  (expt 10 (* db 0.1)))


;; log

(define (log* n)         (if (zero? n) n (log n)))
(define (log2 x)         (/ (log (abs x)) (log 2)))
(define (log10 x)        (/ (log x) (log 10)))


;; pitch

(define (midicps note)
  (* 440.0 (expt 2.0 (* (- note 69.0) 0.083333333333))))

(define (cpsmidi freq)
  (+ (* (log2 (* freq 0.0022727272727)) 12.0) 69.0))

(define (midiratio midi)
  (expt 2.0 (* midi 0.083333333333)))

(define (ratiomidi ratio)
  (* 12.0 (log2 ratio)))

(define (octcps note)
  (* 440.0 (expt 2.0 (- note 4.75))))

(define (cpsoct freq)
  (+ (log2 (* freq 0.0022727272727)) 4.75))

(define (degree->key degree scale steps)
  (+ (* steps (quotient degree (length scale)))
     (list-ref/wrap scale degree)))


;; choose.scm - (c) rohan drape, 2005-2007

;; Return a randomly selected element of the <list> 'l'.

(define (choose l)
  (list-ref l (randi 0 (length l))))

;; Return a randomly selected element of the <list> 'l'.

(define (choosel n l)
  (map (lambda (_) (choose l)) (iota n)))

;; Weighted choose, w must sum to 1.

(define (windex w n)
  (find-index (lambda (e) (< n e)) (cdr (dx->d 0 w))))

(define (wchoose l w)
  (list-ref l (windex w (rand 0.0 1.0))))

;; Proportional choose, p will be normalized and then wchoosen.

(define (normalize-sum l)
  (let ((n (foldl1 + l)))
    (map (lambda (e) (/ e n)) l)))

(define (pchoose l p)
  (wchoose l (normalize-sum p)))

;; Evaluates to a random element from the proper list `l' as if it
;; were a list distributed with the proportions at `proportions'.
;; This is pchoose with reversed arguments...

(define (choose/proportions proportions l)
  (let* ((p-sum (cdr (dx->d 0 proportions)))
	 (n     (rand 0 (last p-sum))))
    (list-ref l (find-index (lambda (e) (< n e)) p-sum))))

;; Return a randomly selected element of the <string> 's'.

(define (string-choose v)
  (string-ref v (randi 0 (string-length v))))

;; Return a randomly selected element of the <vector> 'v'.

(define (vector-choose v)
  (vector-ref v (randi 0 (vector-length v))))


;; distribution.scm - (c) rohan drape, 2000-2007

;; Alias SRFI-27 name

;; (define random random-real)

;; Linearly distributed in [0,1) with a mean value of 0.2929.  The
;; density function is given by 'f(x) = 2 * (1 - x)'.

(define (random-linear) (min (random) (random)))

;; Linearly distributed in [0,1) with a mean value of 0.6969.  The
;; density function is given by 'f(x) = 2 * (x - 1)'.

(define (random-inverse-linear) (max (random) (random)))

;; Triangularly distributed in [0,1) with a mean value of 0.5.

(define (random-triangular) (* 0.5 (+ (random) (random))))

;; Exponentialy distributed with a mean value of '0.69315 / l'.  There
;; is no upper limit on the value however there is only a one in
;; one-thousand chance of generating a number greater than '6.9078 /
;; l'.  The density function is given by: 'f(x) = l ^ (-l * x)'.

(define (random-exponential l)
  (let ((u (random)))
    (if (zero? u)
	(random-exponential l)
	(/ (- (log u)) l))))

;; Clamped 'random-exponential' in [0,1).

(define (random-exponential*)
  (clip 0.0 1.0 (random-exponential 6.9078)))

;; Bilinear exponentialy distributed with a mean value of 0 and where
;; half of the results lie between '+- 1 / l'.  The density function
;; is given by: 'f(x) = 0.5 * l * (e ^ (-l * |x|))'.

(define (random-bilinear-exponential l)
  (let ((u (* 2 (random))))
    (if (zero? u)
	(random-bilinear-exponential l)
	(* (if (> u 1) -1 1) (log (if (> u 1) (- 2 u) u))))))

;; Guassian distributed with a mean value of `mu' and where 68.26% of
;; values will occur within the interval +-`sigma' and 99.75% within
;; the interval +-(3 * `sigma').  The density function is given by:
;; 'f(x) = (1 / SQRT (2 * pi * sigma)) EXP - ((x - u) ^ 2) / (s *
;; (sigma ^ 2))'.

(define (random-guassian sigma mu)
  (let* ((n 12)
	 (half-n (/ n 2))
	 (scale (/ 1 (sqrt (/ n 12)))))
    (let ((sum (apply + (map (lambda (ignored) (random)) (iota n)))))
      (+ (* sigma scale (- sum half-n)) mu))))

;; Clamped 'random-guassian' in [0,1).

(define (random-guassian*)
  (clip 0.0 1.0 (random-guassian (/ 1.0 6.0) 0.5)))

;; Cauchy-distributed with a mean value of 0.0 where half of the
;; results lie in the interval +-alpha, and 99.9% fall within
;; +-318.3alpha.  The density function is given by: 'f(x) = alpha /
;; (pi * (alpha ^ 2 + x ^ 2))'.

(define (random-cauchy alpha)
  (let ((u (random)))
    (if (= u 0.5)
	(random-cauchy alpha)
	(* alpha (tan (* u pi))))))

;; Beta-distributed in [0,1).

(define (random-beta a b)
  (let ((u1 (random)))
    (if (zero? u1)
	(random-beta a b)
	(let ((u2 (random)))
	  (if (zero? u2)
	      (random-beta a b)
	      (let* ((y1 (expt u1 (/ 1 a)))
		     (y2 (expt u2 (/ 1 b)))
		     (sum (+ y1 y2)))
		(if (> sum 1.0)
		    (random-beta a b)
		    (/ y1 sum))))))))

;; Weibull-distributed.

(define (random-weibull s t)
  (let ((u (random)))
    (if (or (zero? u)
	    (= u 1.0))
	(random-weibull s t)
	(let ((a (/ 1.0 (- 1.0 u))))
	  (* s (expt (log a) (/ 1.0 t)))))))

;; Poisson-distributed.

(define (random-poisson l)
  (let loop ((v (exp (- l)))
	     (u (random))
	     (n 0))
    (if (>= u v)
	(loop v (* u (random)) (+ n 1))
	n)))


;; range

;; Parameter to control distribution.

(define current-rand (make-parameter random))

;; Evaluates to a random number with range [a,b) with the distribution
;; determined by `r'.

(define (rand a b) (+ (* ((current-rand)) (- b a)) a))

;; Zero to `n' variant, named for SC3 operator, which is so named due
;; to conflict with SC3 UGen.

(define (_rand n)
  (rand 0 n))

;; -`n' to `n' variant, SC3 naming.

(define (rand2 n)
  (rand (- n) n))

;; List generating variant of rand.

(define (randl n l r)
  (map (lambda (i) (rand l r)) (iota n)))

;; Integer variant.

(define (randi a b) (floor-exact (rand a b)))

;; Complex variant.

(define (randc a b d e) (make-rectangular (rand a b) (rand d e)))

;; Exponential variant, very common in music work.

(define (randx minima maxima)
  (let ((ratio (/ maxima minima)))
    (* (expt ratio (rand 0.0 1.0)) minima)))

;; List generating variant of randx.

(define (randxl n l r)
  (map (lambda (i) (randx l r)) (iota n)))

;; Boolean variant.

(define (randb) (> 0.5 (rand 0.0 1.0)))

;; Evaluates to a number that lies within deviation from `center'
;; calculated by multiplying `perturbation' by `center'.

(define (randp center perturbation)
  (let ((deviation (* center perturbation)))
    (rand (- center deviation) (+ center deviation))))


;; shuffle

;; Return a random permutation of the <list> `l'.  This is not a
;; mutation operation.  For a critique of this method see
;; http://okmij.org/ftp/Haskell/perfect-shuffle.txt.

(define (shuffle l)
  (let ((q (map (lambda (e) (cons (rand 0 1) e)) l))
	(c (lambda (a b) (> (car a) (car b)))))
    (map cdr (list-sort q c))))

;; sclang name for shuffle.

(define scramble shuffle)
