#lang racket/base

(require rts/lexer brag/support)

(module+ test
  (require rackunit))

(define (lex str)
  (apply-port-proc rts-lexer str))

(define (lex-concise str)
  (define sl-tokens (lex str))
  (define tokens (map (lambda (slt) (srcloc-token-token slt)) sl-tokens))
  (for/list ([t (in-list tokens)]
             #:unless (token-struct-skip? t))
    (list (token-struct-type t) (token-struct-val t))))

(module+ test
  (check-equal? (lex-concise "ident1 ident2") '((IDENT "ident1") (IDENT "ident2")))
  ;(check-equal? 1 2)
  )
