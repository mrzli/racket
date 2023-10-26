#lang racket/base

(require (for-syntax racket/base))

(define-syntax (rts-mb stx)
  (syntax-case stx ()
    [(_ EXPR ...)
     #'(#%module-begin
        (displayln EXPR) ...)]))
(provide (rename-out [rts-mb #%module-begin]))

(provide (except-out (all-from-out racket/base) #%module-begin))

; (provide #%top-interaction #%datum #%app #%top)
