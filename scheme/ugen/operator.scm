;; operator.scm - (c) rohan drape, 2005-2006

(define-syntax define-unary-operator
  (syntax-rules ()
    ((_ n s)
     (define (n a)
       (construct-ugen 'UnaryOpUGen #f (list a) #f 1 s (make-uid 0))))))

(define-unary-operator Neg 0)
(define-unary-operator Not 1)
(define-unary-operator IsNil 2)
(define-unary-operator NotNil 3)
(define-unary-operator BitNot 4)
(define-unary-operator Abs 5)
(define-unary-operator AsFloat 6)
(define-unary-operator AsInt 7)
(define-unary-operator Ceil 8)
(define-unary-operator Floor 9)
(define-unary-operator Frac 10)
(define-unary-operator Sign 11)
(define-unary-operator Squared 12)
(define-unary-operator Cubed 13)
(define-unary-operator Sqrt 14)
(define-unary-operator Exp 15)
(define-unary-operator Recip 16)
(define-unary-operator MIDICPS 17)
(define-unary-operator CPSMIDI 18)
(define-unary-operator MIDIRatio 19)
(define-unary-operator RatioMIDI 20)
(define-unary-operator DbAmp 21)
(define-unary-operator AmpDb 22)
(define-unary-operator OctCPS 23)
(define-unary-operator CPSOct 24)
(define-unary-operator Log 25)
(define-unary-operator Log2 26)
(define-unary-operator Log10 27)
(define-unary-operator Sin 28)
(define-unary-operator Cos 29)
(define-unary-operator Tan 30)
(define-unary-operator ArcSin 31)
(define-unary-operator ArcCos 32)
(define-unary-operator ArcTan 33)
(define-unary-operator SinH 34)
(define-unary-operator CosH 35)
(define-unary-operator TanH 36)
(define-unary-operator _Rand 37)
(define-unary-operator Rand2 38)
(define-unary-operator _LinRand 39)
(define-unary-operator BiLinRand 40)
(define-unary-operator Sum3Rand 41)
(define-unary-operator Distort 42)
(define-unary-operator SoftClip 43)
(define-unary-operator Coin 44)
(define-unary-operator DigitValue 45)
(define-unary-operator Silence 46)
(define-unary-operator Thru 47)
(define-unary-operator RectWindow 48)
(define-unary-operator HanWindow 49)
(define-unary-operator WelchWindow 50)
(define-unary-operator TriWindow 51)
(define-unary-operator _Ramp 52)
(define-unary-operator SCurve 53)

(define-syntax define-binary-operator
  (syntax-rules ()
    ((_ n s)
     (define (n a b)
       (construct-ugen 'BinaryOpUGen #f (list a b) #f 1 s (make-uid 0))))))

(define-binary-operator Add 0)
(define-binary-operator Sub 1)
(define-binary-operator Mul 2)
(define-binary-operator IDiv 3)
(define-binary-operator FDiv 4)
(define-binary-operator Mod 5)
(define-binary-operator EQ 6)
(define-binary-operator NE 7)
(define-binary-operator LT 8)
(define-binary-operator GT 9)
(define-binary-operator LE 10)
(define-binary-operator GE 11)
(define-binary-operator Min 12)
(define-binary-operator Max 13)
(define-binary-operator BitAnd 14)
(define-binary-operator BitOr 15)
(define-binary-operator BitXor 16)
(define-binary-operator LCM 17)
(define-binary-operator GCD 18)
(define-binary-operator Round 19)
(define-binary-operator RoundUp 20)
(define-binary-operator Trunc 21)
(define-binary-operator Atan2 22)
(define-binary-operator Hypot 23)
(define-binary-operator Hypotx 24)
(define-binary-operator Pow 25)
(define-binary-operator ShiftLeft 26)
(define-binary-operator ShiftRight 27)
(define-binary-operator UnsignedShift 28)
(define-binary-operator Fill 29)
(define-binary-operator Ring1 30)
(define-binary-operator Ring2 31)
(define-binary-operator Ring3 32)
(define-binary-operator Ring4 33)
(define-binary-operator DifSqr 34)
(define-binary-operator SumSqr 35)
(define-binary-operator SqrSum 36)
(define-binary-operator SqrDif 37)
(define-binary-operator AbsDif 38)
(define-binary-operator Thresh 39)
(define-binary-operator AMClip 40)
(define-binary-operator ScaleNeg 41)
(define-binary-operator Clip2 42)
(define-binary-operator Excess 43)
(define-binary-operator Fold2 44)
(define-binary-operator Wrap2 45)
(define-binary-operator FirstArg 46)
(define-binary-operator RandRange 47)
(define-binary-operator ExpRandRange 48)
