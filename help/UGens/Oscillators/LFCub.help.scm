;; (LFCub rate freq iphase)  
 
;; A sine like shape made of two cubic pieces. Smoother than LFPar.

(Mul (LFCub ar (MulAdd (LFCub kr (MulAdd (LFCub kr 0.2 0) 8 10) 0) 400 800) 0) 0.1)
(Mul (LFCub ar (MulAdd (LFCub kr 0.2 0) 400 800) 0) 0.1)
(Mul (LFCub ar 800 0) 0.1)
(Mul (LFCub ar (XLine kr 100 8000 30 doNothing) 0) 0.1)

;; Compare:

(Mul (LFPar ar (MulAdd (LFPar kr (MulAdd (LFPar kr 0.2 0) 8 10) 0) 400 800) 0) 0.1)
(Mul (LFPar ar (MulAdd (LFPar kr 0.2 0) 400 800) 0) 0.1)
(Mul (LFPar ar 800 0) 0.1)
(Mul (LFPar ar (XLine kr 100 8000 30 doNothing) 0) 0.1)

;; Compare:

(Mul (SinOsc ar (MulAdd (SinOsc kr (MulAdd (SinOsc kr 0.2 0) 8 10) 0) 400 800) 0) 0.1)
(Mul (SinOsc ar (MulAdd (SinOsc kr 0.2 0) 400 800) 0) 0.1)
(Mul (SinOsc ar 800 0) 0.1)
(Mul (SinOsc ar (XLine kr 100 8000 30 doNothing) 0) 0.1)

;; Compare:

(Mul (LFTri ar (MulAdd (LFTri kr (MulAdd (LFTri kr 0.2 0) 8 10) 0) 400 800) 0) 0.1)
(Mul (LFTri ar (MulAdd (LFTri kr 0.2 0) 400 800) 0) 0.1)
(Mul (LFTri ar 800 0) 0.1)
(Mul (LFTri ar (XLine kr 100 8000 30 doNothing) 0) 0.1)
