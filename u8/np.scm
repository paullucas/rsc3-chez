;; np.scm - (c) rohan drape, 2005-2007

(module np (lib "lang.ss" "r5rs")
(#%require "../mzscheme/r6rs.ss"
	   (only "../collection/tree.scm"
		 flatten
		 mapt)
	   (only "../structure/structure.scm"
		 define-structure)
	   "u8l.scm")
(#%provide u8 
	   u16
	   i16
	   u32
	   i32
	   u64
	   i64
	   f32
	   f64
	   read-u16
	   read-i16
	   read-u32
	   read-i32
	   read-u64
	   read-i64
	   read-f32
	   read-f64
	   pstr
	   cstr
	   bstr
	   read-pstr
	   read-cstr
	   np->u8l
	   npt->u8l)

;; Network protocol.

(define-structure np tag value)

;; Tags :: symbol

(define U8   'u8)
(define U16  'u16)
(define U32  'u32)
(define U64  'u64)
(define I16  'i16)
(define I32  'i32)
(define I64  'i64)
(define F32  'f32)
(define F64  'f64)
(define PSTR 'pstr)
(define CSTR 'cstr)
(define BSTR 'bstr)

;; Constructors :: ?value? -> np

(define (u8   n) (make-np U8   n))
(define (u16  n) (make-np U16  n))
(define (u32  n) (make-np U32  n))
(define (u64  n) (make-np U64  n))
(define (i16  n) (make-np I16  n))
(define (i32  n) (make-np I32  n))
(define (i64  n) (make-np I64  n))
(define (f32  n) (make-np F32  n))
(define (f64  n) (make-np F64  n))
(define (pstr s) (make-np PSTR s))
(define (cstr s) (make-np CSTR s))
(define (bstr s) (make-np BSTR s))

;; np->u8l :: np -> [u8]

(define (np->u8l e)
  (let ((t (np-tag e))
	(v (np-value e)))
    (case t
      ((u8)   (u8->u8l   v))
      ((u16)  (u16->u8l  v))
      ((u32)  (u32->u8l  v))
      ((u64)  (u64->u8l  v))
      ((i16)  (i16->u8l  v))
      ((i32)  (i32->u8l  v))
      ((i64)  (i64->u8l  v))
      ((f32)  (f32->u8l  v))
      ((f64)  (f64->u8l  v))
      ((pstr) (pstr->u8l v))
      ((cstr) (cstr->u8l v))
      ((bstr) v)
      (else   (error 'np->u8l "illegal value" t v)))))

;; u8l->np :: tag -> [u8] -> np

(define (u8l->np tag l)
  (case tag
      ((u8)   (u8l->u8   l))
      ((u16)  (u8l->u16  l))
      ((u32)  (u8l->u32  l))
      ((u64)  (u8l->u64  l))
      ((i16)  (u8l->i16  l))
      ((i32)  (u8l->i32  l))
      ((i64)  (u8l->i64  l))
      ((f32)  (u8l->f32  l))
      ((f64)  (u8l->f64  l))
      ((pstr) (u8l->pstr l))
      ((cstr) (u8l->cstr l))
      (else   (error 'u8l->np "illegal tag" tag l))))

;; read-np :: tag -> IO ?value?

(define (read-np tag)
  (case tag
    ((u8)   (get-u8))
    ((u16)  (u8l->u16 (read-u8l 2)))
    ((u32)  (u8l->u32 (read-u8l 4)))
    ((u64)  (u8l->u64 (read-u8l 6)))
    ((i16)  (u8l->i16 (read-u8l 2)))
    ((i32)  (u8l->i32 (read-u8l 4)))
    ((i64)  (u8l->i64 (read-u8l 8)))
    ((f32)  (u8l->f32 (read-u8l 4)))
    ((f64)  (u8l->f64 (read-u8l 8)))
    ((pstr) (read-pstr))
    ((cstr) (read-cstr))
    (else   (error 'read-np "illegal tag" tag))))

;; write-np :: np -> IO ()

(define (write-np np)
  (map put-u8 (np->u8l np)))

;; npt->u8l :: [npt] -> [int]

(define (npt->u8l t)
  (flatten (mapt np->u8l t)))

)
