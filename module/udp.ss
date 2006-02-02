;; udp.ss - (c) rohan drape, 2004-2006

(module 
 udp mzscheme
 (require "structure.ss"
	  (only (lib "include.ss") include))
 (include "../scheme/udp/udp.scm")
 (provide (all-defined)))
