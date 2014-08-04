(import (rnrs)
        (mk-r6rs))

(define rsc3-src
  '("../src/command.scm"
    "../src/composite.scm"
    "../src/enum.scm"
    "../src/env.scm"
    "../src/external.scm"
    "../src/list.scm"
    "../src/rsc3.scm"
    "../src/ugen.scm"))

(mk-r6rs '(rsc3)
	 (cons "../src/sys.ikarus.scm" rsc3-src)
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
	 (cons "../src/sys.plt.scm" rsc3-src)
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
