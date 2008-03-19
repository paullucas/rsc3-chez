(import (rhs r6rs rhs))
(load "/home/rohan/sw/rhs/util/util.scm")

(mk-r6rs '(rsc3 ikarus rsc3)
	 '("/home/rohan/sw/rsc3/src/rsc3.scm")
	 "/home/rohan/sw/rsc3/ikarus/rsc3.scm"
	 '((rnrs)
	   (rhs r6rs rhs)
	   (sosc r6rs sosc)
	   (sosc ikarus transport)
	   (only (ikarus) parameterize tcp-connect)
	   (xitomatl srfi random))
	 '()
	 '())
