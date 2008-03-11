;; rsc3.ss - (c) rohan drape, 2004-2007

(module rsc3 scheme/base
(require mzlib/include)
(require rsc3/mzscheme/r6rs)
(require rsc3/mzscheme/udp)
(provide (all-defined-out))
(include "common.scm")
(include "sosc.scm")
(include "graphdef.scm")
(include "ugen.scm")
(include "server.scm")
(include "supercollider.scm")
)
