#lang racket/base

(require racket/pretty brag/support)
(require (for-syntax racket/base))

(provide (except-out (all-from-out racket/base) #%module-begin))
(provide (rename-out [lexer-t-mb #%module-begin]))
(provide lex)

(define-syntax (lexer-t-mb stx)
  (syntax-case stx ()
    [(_ EXPR ...)
     #'(#%module-begin
        ; (require rackunit lexer-t/expander)
        ; (require (rename-in <package-name> (<orig-lexer-name> lang-lexer)))

        ; (pretty-print lang-lexer)

        (pretty-print 'EXPR) ...)]))

; (define-syntax (require-lexer stx)
;   (syntax-case stx ()
;     [(_ PACKAGE-NAME ORIG-LEXER-NAME)
;      #'(require <package-name> (rename-in <package-name> (<orig-lexer-name> lang-lexer)))]))

(define (lex lexer str)
  (define sl-tokens (apply-port-proc lexer str))
  (define tokens (map (lambda (slt) (srcloc-token-token slt)) sl-tokens))
  (for/list ([t (in-list tokens)]
             #:unless (token-struct-skip? t))
    (list (token-struct-type t) (token-struct-val t))))
