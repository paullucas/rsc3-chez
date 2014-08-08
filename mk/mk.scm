(import (rnrs)
        (mk-r6rs))

(define rsc3-src
  '("../src/command.scm"
    "../src/constant.scm"
    "../src/core.scm"
    "../src/derived.scm"
    "../src/envelope.scm"
    "../src/external.scm"
    "../src/list.scm"
    "../src/sc3.scm"
    "../src/ugen.scm"))

(define rsc3-dep
  '((rnrs)
    (rhs)
    (sosc)
    (prefix (srfi :9 records) srfi:)
    (prefix (srfi :19 time) srfi:)
    (prefix (srfi :27 random-bits) srfi:)))

(mk-r6rs '(rsc3)
	 (cons "../src/sys.ikarus.scm" rsc3-src)
	 (string-append (list-ref (command-line) 1) "/rsc3.ikarus.sls")
	 (cons '(prefix (ikarus) ikarus:) rsc3-dep)
	 '()
	 '())

(mk-r6rs '(rsc3)
	 (cons "../src/sys.guile.scm" rsc3-src)
	 (string-append (list-ref (command-line) 1) "/rsc3.guile.sls")
	 rsc3-dep
	 '()
	 '())

(mk-r6rs '(rsc3)
	 (cons "../src/sys.plt.scm" rsc3-src)
	 (string-append (list-ref (command-line) 1) "/rsc3.mzscheme.sls")
	 (cons '(prefix (scheme) plt:) rsc3-dep)
	 '()
	 '())

(exit)
