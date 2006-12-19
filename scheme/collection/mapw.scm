;; mapw.scm - (c) rohan drape, 2000-2006

;; [R5RS+] Windowed map.  Apply 'f' to 'n' element windows with 'm'
;; separation at `l' having 'z' elements.

(define (mapwz n m f l z)
  (cond ((or (> n z) (> m z))
	 (error "mapwz: short list" n m f l z))
	((= n z)
	 (list (apply f l)))
	(else
	 (cons (apply f (take l n))
	       (mapwz n m f (drop l m) (- z m))))))

(define (mapw n m f l)
  (mapwz n m f l (length l)))

;; Variant that extends the list to (length l) + n - 1 places.

(define (mapw* n m f l)
  (mapw n m f (extend l (+ n -1 (length l)))))
