;; binaryop.scm - (c) rohan drape, 2003-2005

;; A <list> that maps symbolic binary operator names to integer
;; indexes.  The names and ordering are (and *must* remain) those used
;; as enumeration constants in the scsynth source.

(define binaryop-names '(Add Sub Mul IDiv FDiv Mod EQ NE LT GT LE
GE Min Max BitAnd BitOr BitXor LCM GCD Round RoundUp Trunc Atan2
Hypot Hypotx Pow ShiftLeft ShiftRight UnsignedShift Fill Ring1
Ring2 Ring3 Ring4 DifSqr SumSqr SqrSum SqrDif AbsDif Thresh
AMClip ScaleNeg Clip2 Excess Fold2 Wrap2 FirstArg RandRange
ExpRandRange))

;; Evaluates to the 'SpecialIndex' for the symbolic binary operator
;; `name', or to '#f' if `name' is not a binary operator.  

(define (binaryop-index name) 
  (index (cut eq? <> name) binaryop-names))

;; Evaluate to the name of the binary operation defined by `index'.

(define (binaryop-name index) 
  (ref binaryop-names index))
