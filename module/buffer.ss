;; buffer.ss - (c) rohan drape, 2004-2006

(module
 buffer mzscheme
 (require "collection.ss"
	  "server.ss"
	  (only (lib "include.ss") include))
 (include "../scheme/buffer/signal.scm")
 (provide (all-defined)))
