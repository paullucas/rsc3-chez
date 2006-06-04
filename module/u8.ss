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
	    (only "structure.ss"
		  define-structure)
	    (only "collection.ss"
		  flatten
		  mapt)
	    (only (lib "include.ss")
		  include))
 (include "../scheme/u8/u8l.scm")
 (include "../scheme/u8/np.scm")
 (#%provide read-u8 peek-u8 write-u8
	    u8 u16 i16 u32 i32 u64 i64 f32 f64
	    read-u16 read-i16 read-u32 read-i32 read-u64 read-i64 read-f32 read-f64
	    pstr cstr bstr
	    read-pstr read-cstr read-bstr 
	    read-u8l
	    i32->u8l
	    npt->u8l
	    with-input-u8l
	    u8l?))
 
