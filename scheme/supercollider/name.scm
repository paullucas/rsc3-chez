;; name.scm - (c) rohan drape, 2003-2005

(define unary-operator-names '(Neg Not IsNil NotNil BitNot Abs AsFloat
AsInt Ceil Floor Frac Sign Squared Cubed Sqrt Exp Recip MIDICPS
CPSMIDI MIDIRatio RatioMIDI DbAmp AmpDb OctCPS CPSOct Log Log2 Log10
Sin Cos Tan ArcSin ArcCos ArcTan SinH CosH TanH _Rand Rand2 _LinRand
BiLinRand Sum3Rand Distort SoftClip Coin DigitValue Silence Thru
RectWindow HanWindow WelchWindow TriWindow _Ramp SCurve))

(define (unary-operator-name special) 
  (ref unary-operator-names special))

(define binary-operator-names '(Add Sub Mul IDiv FDiv Mod EQ NE LT GT
LE GE Min Max BitAnd BitOr BitXor LCM GCD Round RoundUp Trunc Atan2
Hypot Hypotx Pow ShiftLeft ShiftRight UnsignedShift Fill Ring1 Ring2
Ring3 Ring4 DifSqr SumSqr SqrSum SqrDif AbsDif Thresh AMClip ScaleNeg
Clip2 Excess Fold2 Wrap2 FirstArg RandRange ExpRandRange))

(define (binary-operator-name special)
  (ref binary-operator-names special))

(define (ugen-name/operator name special)
  (cond
   ((string=? name "BinaryOpUGen") (binary-operator-name special))
   ((string=? name "UnaryOpUGen")  (unary-operator-name special))
   (else                           name)))
