;; u8v.ss - (c) rohan drape, 2004-2006

(module
 u8v mzscheme
 (require (only "structure.ss"
		define-structure)
	  (only "collection.ss"
		flatten)
	  (only (lib "include.ss")
		include)
	  (only (lib "1.ss" "srfi")
		fold-right))
 (include "../scheme/u8v/u8v.scm")
 (provide make-u8v u8v u8v? u8v-ref u8v-length u8v-copy* u8v-copy!
	  u8v-index
	  string->u8v pstring->u8v
	  u8v->string u8v->pstring
	  i8->u8v i16->u8v i32->u8v i64->u8v u64->u8v f32->u8v f64->u8v
	  u8v->i8 u8v->i16 u8v->i32 u8v->i64 u8v->u64 u8v->f32 u8v->f64
	  u8v->integer u8v->real
	  integer->u8v real->u8v
	  u8t->u8v
	  u8v-++ u8v-append u8v-concat
	  open-input-u8v
	  read-u8v write-u8v file->u8v
	  u8 i8 u16 i16 u32 i32 u64 i64 f32 f64
	  _u8 _i8 _u16 _i16 _u32 _i32 _u64 _i64 _f32 _f64
	  str pstr u8v*
	  _pstr
	  u8w mk-u8v))
