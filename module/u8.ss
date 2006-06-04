;; u8.ss - (c) rohan drape, 2004-2006

(module
 u8 (lib "lang.ss" "r5rs")
 (#%require "bytes.ss"
	    (only (lib "1.ss" "srfi")
		  fold-right
		  iota
		  take
		  list-index
		  every)
	    (only (lib "23.ss" "srfi")
		  error)
	    (only (lib "43.ss" "srfi")
		  vector-every)
	    (only "structure.ss"
		  define-structure)
	    (only "collection.ss"
		  flatten
		  mapt)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/u8/u8.scm")
 (include "../scheme/u8/u8l.scm")
 (include "../scheme/u8/u8v.scm")
 (include "../scheme/u8/np.scm")
 (#%provide ;; byte
	    read-u8 peek-u8 write-u8
	
	    ;; u8
	    u8? u8->i8 i8->u8
	
	    ;; u8l
	    u8l?
	    i8->u8l i16->u8l i32->u8l i64->u8l u8->u8l u16->u8l u32->u8l u64->u8l f32->u8l f64->u8l
	    u8l->i8 u8l->i16 u8l->i32 u8l->i64 u8l->u8 u8l->u16 u8l->u32 u8l->u64 u8l->f32 u8l->f64
	    str->u8l
	    u8l->str
	    with-input-u8l
	    read-u8l
	    file->u8l

	    ;; u8v
	    u8v?
	    i8->u8v i16->u8v i32->u8v i64->u8v u8->u8v u16->u8v u32->u8v u64->u8v f32->u8v f64->u8v
	    u8v->i8 u8v->i16 u8v->i32 u8v->i64 u8v->u8 u8v->u16 u8v->u32 u8v->u64 u8v->f32 u8v->f64
	    u8v->str
	    str->u8v
	    file->u8v

	    ;; np
	    u8 u16 i16 u32 i32 u64 i64 f32 f64
	    read-u16 read-i16 read-u32 read-i32 read-u64 read-i64 read-f32 read-f64
	    pstr cstr bstr
	    read-pstr read-cstr read-bstr
	    npt->u8l
	    ))

