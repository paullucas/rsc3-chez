;; server.ss - (c) rohan drape, 2004-2007

(module
 server (lib "lang.ss" "r5rs")

 (define-syntax require/provide
   (syntax-rules ()
     ((_ m) (begin (#%require m) (#%provide (all-from m))))))

 (require/provide "../scheme/server/command.scm")
 (require/provide "../scheme/server/add-action.scm")
 (require/provide "../scheme/server/done-action.scm")
 (require/provide "../scheme/server/gen.scm")
 (require/provide "../scheme/server/server.scm")
 (require/provide "../scheme/server/status.scm"))
