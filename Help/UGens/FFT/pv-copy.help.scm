;; (pv-copy bufferA bufferB)

;; Copies the spectral frame in bufferA to bufferB at that point in
;; the chain of PV UGens. This allows for parallel processing of
;; spectral data without the need for multiple fft UGens, and to copy
;; out data at that point in the chain for other purposes. bufferA and
;; bufferB must be the same size.

;; bufferA - source buffer.
;; bufferB - destination buffer.

(with-sc3
 (lambda (fd)
   (->< fd (/b_alloc 0 2048 1))
   (->< fd (/b_alloc 1 2048 1))))

;; Proof of concept, silence

(let* ((in (LFclipNoise ar 100))
       (c0 (fft* 0 in))
       (c1 (pv-copy c0 1)))
  (audition (out 0 (sub (Ifft* c0) (ifft* c1)))))
