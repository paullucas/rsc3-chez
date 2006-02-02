;; udp.ss - (c) rohan drape, 2004-2006

(module 
 udp mzscheme
 (require "structure.ss"
	  (only (lib "include.ss") include))
 (include "../udp/udp.scm")
 (provide (all-defined)))
