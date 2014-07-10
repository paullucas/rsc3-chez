(import (rnrs)
        (mk-r6rs))

(mk-r6rs '(rsc3)
	 '("../src/rsc3.scm"
           "../src/external.scm"
	   "../src/sys.ikarus.scm")
	 (string-append (list-ref (command-line) 1)
                        "/rsc3.ikarus.sls")
	 '((rnrs)
	   (rhs)
	   (sosc)
	   (prefix (ikarus) ikarus:)
           (prefix (srfi :9 records) srfi:)
           (prefix (srfi :19 time) srfi:)
	   (prefix (srfi :27 random-bits) srfi:))
	 '()
	 '())

(mk-r6rs '(rsc3)
	 '("../src/rsc3.scm"
	   "../src/external.scm"
           "../src/sys.plt.scm")
	 (string-append (list-ref (command-line) 1)
                        "/rsc3.mzscheme.sls")
	 '((rnrs)
	   (rhs)
	   (sosc)
	   (prefix (scheme) plt:)
           (prefix (srfi :9 records) srfi:)
           (prefix (srfi :19 time) srfi:)
	   (prefix (srfi :27 random-bits) srfi:))
	 '()
	 '())

(exit)
