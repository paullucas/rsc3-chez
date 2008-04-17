(import (rnrs)
        (mk-r6rs))

(mk-r6rs '(rsc3)
	 '("/home/rohan/sw/rsc3/src/rsc3.scm"
	   "/home/rohan/sw/rsc3/src/time.ikarus.scm")
	 (string-append (list-ref (command-line) 1)
                        "/rsc3.ikarus.sls")
	 '((rnrs)
	   (rhs)
	   (sosc)
	   (prefix (ikarus) ikarus:)
	   (prefix (xitomatl srfi random) srfi:)
           (prefix (xitomatl srfi time) srfi:))
	 '()
	 '())

(exit)
