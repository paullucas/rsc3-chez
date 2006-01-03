;; (LFCub freq iphase)  
 
;; A sine like shape made of two cubic pieces. Smoother than LFPar.

(LFCub ar (LFCub kr (LFCub kr 0.2 0 8 10) 0 400 800) 0 0.1)
(LFCub ar (LFCub kr 0.2 0 400 800) 0 0.1)
(LFCub ar 800 0 0.1)
(LFCub ar (XLine kr 100 8000 30) 0 0.1)

;; Compare:

(LFPar ar (LFPar kr (LFPar kr 0.2 0 8 10) 0 400 800) 0 0.1)
(LFPar ar (LFPar kr 0.2 0 400 800) 0 0.1)
(LFPar ar 800 0 0.1)
(LFPar ar (XLine kr 100 8000 30) 0 0.1)

(SinOsc ar (SinOsc kr (SinOsc kr 0.2 0 8 10) 0 400 800) 0 0.1)
(SinOsc ar (SinOsc kr 0.2 0 400 800) 0 0.1)
(SinOsc ar 800 0 0.1)
(SinOsc ar (XLine kr 100 8000 30) 0 0.1)

(LFTri ar (LFTri kr (LFTri kr 0.2 0 8 10) 0 400 800) 0 0.1)
(LFTri ar (LFTri kr 0.2 0 400 800) 0 0.1)
(LFTri ar 800 0 0.1)
(LFTri ar (XLine kr 100 8000 30) 0 0.1)
