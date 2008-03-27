(import (rhs r6rs rhs))
(load "/home/rohan/sw/rhs/util/util.scm")

(mk-r6rs '(rsc3 r6rs rsc3)
	 '("/home/rohan/sw/rsc3/src/rsc3.scm"
	   "/home/rohan/sw/rsc3/src/time.ikarus.scm")
	 "/home/rohan/sw/rsc3/r6rs/rsc3.ikarus.sls"
	 '((rnrs)
	   (rhs r6rs rhs)
	   (sosc r6rs sosc)
	   (sosc r6rs transport)
	   (prefix (only (ikarus) 
                         nanosleep) 
                   ikarus:)
	   (prefix (only (xitomatl srfi random) 
                         random-real 
                         random-integer) 
                   srfi:))
	 '()
	 '())
