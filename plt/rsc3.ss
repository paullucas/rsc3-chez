(module rsc3 rhs/plt/empty
(provide (all-defined-out))
(require mzlib/include)
(require rnrs/base-6
	 rnrs/bytevectors-6
	 rnrs/lists-6
	 rnrs/records/syntactic-6
	 rnrs/io/simple-6
	 (except-in rnrs/io/ports-6
		    current-output-port
		    current-input-port
		    current-error-port))
(require rhs/r6rs/rhs)
(require sosc/plt/sosc)
(require srfi/27)
(include "../src/rsc3.scm")
)
