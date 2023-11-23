#lang racket/base

(require brag/support)
; (require racket/pretty)
(require (for-syntax racket/base racket/syntax))

(provide (except-out (all-from-out racket/base) #%module-begin))
(provide (rename-out [lexer-t-mb #%module-begin]))
(provide lexer-t-program)
(provide lex)

(define-syntax (lexer-t-mb stx)
  (syntax-case stx ()
    [(_ DATA)
     #'(#%module-begin (lexer-t-program DATA))]))

(define-syntax (lexer-t-program stx)
  (syntax-case stx ()
    [(_ (MODULE-ID LEXER ((INPUT (TOKEN ...)) ...)))
     (with-syntax ([M (format-id #'MODULE-ID "~a" #'MODULE-ID)]
                   [L (format-id #'LEXER "~a" #'LEXER)])
       #'(module+ test
           (require rackunit lexer-t/expander)
           (require (rename-in M (L lang-lexer)))

           (define (l str)
             (lex lang-lexer str))

           (check-equal? (l INPUT) '(TOKEN ...)) ...
           )
       )]
    ))

; runtime ---------

(define (lex lexer str)
  (define sl-tokens (apply-port-proc lexer str))
  (define tokens (map (lambda (slt) (srcloc-token-token slt)) sl-tokens))
  (for/list ([t (in-list tokens)]
             #:unless (token-struct-skip? t))
    (list (token-struct-type t) (token-struct-val t))))
