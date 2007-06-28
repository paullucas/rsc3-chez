;; operator.scm - (c) rohan drape, 2005-2007

(module operator (lib "lang.ss" "r5rs")
(#%require "../collection/list.scm"
	   "../math/common.scm"
	   "../math/gain.scm"
	   "../math/log.scm"
	   "../math/pitch.scm"
	   "../graphdef/id.scm"
	   "../random/range.scm"
	   "constructor.scm")
(#%provide (all-defined))

;; Operators may, when applied to numbers, yield numbers.

(define-syntax define-unary-operator
  (syntax-rules ()
    ((_ n s f)
     (define (n a)
       (if (and (number? a) f)
	   (f a)
	   (construct-ugen 'UnaryOpUGen #f (list a) #f 1 s (make-uid 0)))))))

(define-unary-operator Neg 0 -)
(define-unary-operator Not 1 #f)
(define-unary-operator IsNil 2 #f)
(define-unary-operator NotNil 3 #f)
(define-unary-operator BitNot 4 #f)
(define-unary-operator Abs 5 abs)
(define-unary-operator AsFloat 6 #f)
(define-unary-operator AsInt 7 #f)
(define-unary-operator Ceil 8 ceiling)
(define-unary-operator Floor 9 floor)
(define-unary-operator Frac 10 #f)
(define-unary-operator Sign 11 #f)
(define-unary-operator Squared 12 squared)
(define-unary-operator Cubed 13 cubed)
(define-unary-operator Sqrt 14 sqrt)
(define-unary-operator Exp 15 #f)
(define-unary-operator Recip 16 recip)
(define-unary-operator MIDICPS 17 midicps)
(define-unary-operator CPSMIDI 18 cpsmidi)
(define-unary-operator MIDIRatio 19 midiratio)
(define-unary-operator RatioMIDI 20 ratiomidi)
(define-unary-operator DbAmp 21 dbamp)
(define-unary-operator AmpDb 22 ampdb)
(define-unary-operator OctCPS 23 octcps)
(define-unary-operator CPSOct 24 cpsoct)
(define-unary-operator Log 25 log)
(define-unary-operator Log2 26 log2)
(define-unary-operator Log10 27 log10)
(define-unary-operator Sin 28 sin)
(define-unary-operator Cos 29 cos)
(define-unary-operator Tan 30 tan)
(define-unary-operator ArcSin 31 asin)
(define-unary-operator ArcCos 32 acos)
(define-unary-operator ArcTan 33 atan)
(define-unary-operator SinH 34 #f)
(define-unary-operator CosH 35 #f)
(define-unary-operator TanH 36 #f)
(define-unary-operator _Rand 37 _rand)
(define-unary-operator Rand2 38 rand2)
(define-unary-operator _LinRand 39 #f)
(define-unary-operator BiLinRand 40 #f)
(define-unary-operator Sum3Rand 41 #f)
(define-unary-operator Distort 42 #f)
(define-unary-operator SoftClip 43 #f)
(define-unary-operator Coin 44 #f)
(define-unary-operator DigitValue 45 #f)
(define-unary-operator Silence 46 #f)
(define-unary-operator Thru 47 #f)
(define-unary-operator RectWindow 48 #f)
(define-unary-operator HanWindow 49 #f)
(define-unary-operator WelchWindow 50 #f)
(define-unary-operator TriWindow 51 #f)
(define-unary-operator _Ramp 52 #f)
(define-unary-operator SCurve 53 #f)

(define-syntax define-binary-operator
  (syntax-rules ()
    ((_ n s f)
     (define (n a b)
       (if (and (number? a)
		(number? b)
		f)
	   (f a b)
	   (construct-ugen 'BinaryOpUGen #f (list a b) #f 1 s (make-uid 0)))))))

(define-binary-operator Add 0 +)
(define-binary-operator Sub 1 -)
(define-binary-operator Mul 2 *)
(define-binary-operator IDiv 3 #f)
(define-binary-operator FDiv 4 /)
(define-binary-operator Mod 5 #f)
(define-binary-operator EQ 6 #f)
(define-binary-operator NE 7 #f)
(define-binary-operator LT 8 #f)
(define-binary-operator GT 9 #f)
(define-binary-operator LE 10 #f)
(define-binary-operator GE 11 #f)
(define-binary-operator Min 12 min)
(define-binary-operator Max 13 max)
(define-binary-operator BitAnd 14 #f)
(define-binary-operator BitOr 15 #f)
(define-binary-operator BitXor 16 #f)
(define-binary-operator LCM 17 #f)
(define-binary-operator GCD 18 #f)
(define-binary-operator Round 19 #f)
(define-binary-operator RoundUp 20 #f)
(define-binary-operator Trunc 21 #f)
(define-binary-operator Atan2 22 #f)
(define-binary-operator Hypot 23 #f)
(define-binary-operator Hypotx 24 #f)
(define-binary-operator Pow 25 #f)
(define-binary-operator ShiftLeft 26 #f)
(define-binary-operator ShiftRight 27 #f)
(define-binary-operator UnsignedShift 28 #f)
(define-binary-operator Fill 29 #f)
(define-binary-operator Ring1 30 #f)
(define-binary-operator Ring2 31 #f)
(define-binary-operator Ring3 32 #f)
(define-binary-operator Ring4 33 #f)
(define-binary-operator DifSqr 34 #f)
(define-binary-operator SumSqr 35 #f)
(define-binary-operator SqrSum 36 #f)
(define-binary-operator SqrDif 37 #f)
(define-binary-operator AbsDif 38 #f)
(define-binary-operator Thresh 39 #f)
(define-binary-operator AMClip 40 #f)
(define-binary-operator ScaleNeg 41 #f)
(define-binary-operator Clip2 42 #f)
(define-binary-operator Excess 43 #f)
(define-binary-operator Fold2 44 #f)
(define-binary-operator Wrap2 45 #f)
(define-binary-operator FirstArg 46 #f)
(define-binary-operator RandRange 47 #f)
(define-binary-operator ExpRandRange 48 #f)

;; N-ary variants

(define (Mul* . l) (foldl Mul 1 l))
(define (Add* . l) (foldl Add 0 l))

)
