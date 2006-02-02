;; graphdef.ss - (c) rohan drape, 2004-2006

(module 
 graphdef mzscheme
 (require "structure.ss"
	  "u8v.ss"
	  "collection.ss"
	  (only (lib "1.ss" "srfi") make-list every)
	  (only (lib "include.ss") include))
 (include "../scheme/graphdef/control.scm")
 (include "../scheme/graphdef/graphdef.scm")
 (include "../scheme/graphdef/id.scm")
 (include "../scheme/graphdef/input.scm")
 (include "../scheme/graphdef/letc.scm")
 (include "../scheme/graphdef/mce.scm")
 (include "../scheme/graphdef/mrg.scm")
 (include "../scheme/graphdef/output.scm")
 (include "../scheme/graphdef/proxy.scm")
 (include "../scheme/graphdef/rate.scm")
 (include "../scheme/graphdef/ugen.scm")
 (provide (all-defined)))
