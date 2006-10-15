;; (PV_Copy bufferA bufferB)

;; Copies the spectral frame in bufferA to bufferB at that point in
;; the chain of PV UGens. This allows for parallel processing of
;; spectral data without the need for multiple FFT UGens, and to copy
;; out data at that point in the chain for other purposes. bufferA and
;; bufferB must be the same size.

;; bufferA - source buffer.
;; bufferB - destination buffer.

(->< s (/b_alloc 0 2048 1))

(->< s (/b_alloc 1 2048 1))

;; -- proof of concept, silence

(let* ((in (LFClipNoise ar 100))
       (c0 (FFT 0 in))
       (c1 (PV_Copy c0 1)))
  (Sub (IFFT c0) (IFFT c1)))
