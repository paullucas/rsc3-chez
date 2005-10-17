;; unaryop.scm - (c) rohan drape, 2003-2005

;; A list that maps symbolic unary operation names to integer indexes.

(define unaryop-names '(Neg Not IsNil NotNil BitNot Abs AsFloat
AsInt Ceil Floor Frac Sign Squared Cubed Sqrt Exp Recip MIDICPS
CPSMIDI MIDIRatio RatioMIDI DbAmp AmpDb OctCPS CPSOct Log Log2
Log10 Sin Cos Tan ArcSin ArcCos ArcTan SinH CosH TanH _Rand Rand2
_LinRand BiLinRand Sum3Rand Distort SoftClip Coin DigitValue
Silence Thru RectWindow HanWindow WelchWindow TriWindow _Ramp
SCurve))

;; Evaluates to the 'SpecialIndex' for the symbolic unary operator
;; `name', or to '#f' if `name' is not a binary operator.  The names
;; are those used as enueration constants in the SC3 source.

(define (unaryop-index name) 
  (index (cut eq? <> name) unaryop-names))

;; Evaluate to the symbolic name of the binary operation defined by
;; `index'.

(define (unaryop-name index) (ref unaryop-names index))
