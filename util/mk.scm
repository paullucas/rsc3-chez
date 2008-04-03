(import (rnrs)
        (rhs util util))

(mk-r6rs '(rsc3 r6rs rsc3)
	 '("/home/rohan/sw/rsc3/src/rsc3.scm"
	   "/home/rohan/sw/rsc3/src/time.ikarus.scm")
	 "/home/rohan/sw/rsc3/r6rs/rsc3.ikarus.sls"
	 '((rnrs)
	   (rhs r6rs rhs)
	   (sosc r6rs sosc)
	   (sosc r6rs transport)
	   (prefix (ikarus) ikarus:)
	   (prefix (xitomatl srfi random) srfi:)
           (prefix (xitomatl srfi time) srfi:))
	 '()
	 '())

(exit)
