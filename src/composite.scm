(define add3 sum3)
(define add4 sum4)

(define buf-rd-c
  (lambda (nc r b p l)
    (buf-rd nc r b p l 4)))

(define buf-rd-l
  (lambda (nc r b p l)
    (buf-rd nc r b p l 2)))

(define buf-rd-n
  (lambda (nc r b p l)
    (buf-rd nc r b p l 1)))

;; ugen -> ugen -> ugen
(define dcons
  (lambda (x xs)
    (let ((i (dseq 1 (mce2 0 1)))
	  (a (dseq 1 (mce2 x xs))))
      (dswitch i a))))

;; ugen -> ugen -> ugen -> ugen
(define freq-shift
  (lambda (i f p)
    (let ((o (sin-osc ar f (mce2 (add p (* 0.5 pi)) p)))
	  (h (hilbert i)))
      (mix (mul h o)))))

(define fft*
  (lambda (buf in)
    (fft buf in 0.5 0 1 0)))

(define ifft*
  (lambda (buf)
    (ifft buf 0 0)))

(define lin-lin
  (lambda (in srclo srchi dstlo dsthi)
    (let* ((scale (fdiv (sub dsthi dstlo) (sub srchi srclo)))
           (offset (sub dstlo (mul scale srclo))))
      (mul-add in scale offset))))

(define mce2 (lambda (a b) (make-mce (list a b))))
(define mce3 (lambda (a b c) (make-mce (list a b c))))
(define mce4 (lambda (a b c d) (make-mce (list a b c d))))
(define mce5 (lambda (a b c d e) (make-mce (list5 a b c d e))))

;; mce -> int -> ugen
(define mce-channel
  (lambda (u n)
    (list-ref (mce-channels u) n)))

;; int -> (int -> ugen) -> mce
(define mce-fill
  (lambda (n f)
    (make-mce (map f (enum-from-to 0 (- n 1))))))

;; ugen|mce -> ugen
(define mix
  (lambda (u)
    (foldl add 0 (mce-channels u))))

;; int -> (int -> ugen) -> ugen
(define mix-fill
  (lambda (n f)
    (mix (mce-fill n f))))

;; Rate -> UGen -> UGen -> Warp -> UGen -> UGen
(define mouse-r
  (lambda (rt l r ty tm)
    (let ((f (if (= ty 0) lin-lin lin-exp)))
      (lag (f (lf-noise1 rt 1) -1 1 l r) tm))))

(define mouse-x* mouse-r)
(define mouse-y* mouse-r)

(define mouse-button*
  (lambda (rt l r tm)
    (let ((o (lf-clip-noise rt 1)))
      (lag (lin-lin o -1 1 l r) tm))))

(define mrg2 make-mrg)
(define mrg3 (lambda (a b c) (make-mrg a (make-mrg b c))))
(define mrg4 (lambda (a b c d) (make-mrg a (make-mrg b (make-mrg c d)))))

;; [ugen] -> mrg
(define mrg-n
  (lambda (xs)
    (if (null? xs)
	(error "mrg-n" "nil input list" xs)
	(if (null? (tail xs))
	    (head xs)
	    (mrg2 (head xs) (mrg-n (tail xs)))))))

(define mul3 (lambda (a b c) (mul (mul a b) c)))
(define mul4 (lambda (a b c d) (mul (mul (mul a b) c) d)))

;; rate -> ugen -> ugen -> ugen -> ugen -> ugen
(define pm-osc
  (lambda (r cf mf pm mp)
    (sin-osc r cf (mul (sin-osc r mf mp) pm))))

(define t-choose
  (lambda (trig array)
    (select (ti-rand 0 (length (mce-channels array)) trig) array)))

(define tw-choose
  (lambda (trig array weights normalize)
    (select (tw-index trig normalize weights) array)))
