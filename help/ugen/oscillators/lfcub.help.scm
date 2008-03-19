;; (lfcub rate freq iphase)  
 
;; A sine like shape made of two cubic pieces. Smoother than lfpar.

(mul (lfcub ar (mul-add (lfcub kr (mul-add (LFCub kr 0.2 0) 8 10) 0) 400 800) 0) 0.1)
(mul (lfcub ar (mul-add (lfcub kr 0.2 0) 400 800) 0) 0.1)
(mul (lfcub ar 800 0) 0.1)
(mul (lfcub ar (xline kr 100 8000 30 do-nothing) 0) 0.1)

;; Compare:

(mul (lfpar ar (mul-add (lfpar kr (mul-add (LFPar kr 0.2 0) 8 10) 0) 400 800) 0) 0.1)
(mul (lfpar ar (mul-add (lfpar kr 0.2 0) 400 800) 0) 0.1)
(mul (lfpar ar 800 0) 0.1)
(mul (lfpar ar (xline kr 100 8000 30 do-nothing) 0) 0.1)

;; Compare:

(mul (sin-osc ar (mul-add (sin-osc kr (mul-add (Sinosc kr 0.2 0) 8 10) 0) 400 800) 0) 0.1)
(mul (sin-osc ar (mul-add (sin-osc kr 0.2 0) 400 800) 0) 0.1)
(mul (sin-osc ar 800 0) 0.1)
(mul (sin-osc ar (xline kr 100 8000 30 do-nothing) 0) 0.1)

;; Compare:

(mul (lftri ar (mul-add (lftri kr (mul-add (LFTri kr 0.2 0) 8 10) 0) 400 800) 0) 0.1)
(mul (lftri ar (mul-add (lftri kr 0.2 0) 400 800) 0) 0.1)
(mul (lftri ar 800 0) 0.1)
(mul (lftri ar (xline kr 100 8000 30 do-nothing) 0) 0.1)
