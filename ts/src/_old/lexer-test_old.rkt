#lang racket/base

(require
  rts/lexer
  parser-tools/lex
  racket/pretty)

(define (lex port)
  (port-count-lines! port)
  (define (next-t port tokens)
    (define token (rts-lexer port))
    (if (equal?	(position-token-token token) 'EOF)
        (reverse tokens)
        (next-t port (cons token tokens))))

  (define result (next-t port '()))
  result
  )

(define (lex-concise str)
  (define p-tokens (lex (open-input-string str)))
  (define tokens (map (lambda (slt) (position-token-token slt)) p-tokens))
  tokens
  )

;(pretty-print (lex "aa a\na//fdsa"))
(pretty-print (lex-concise "12 12e+11"))

; ((from/to "\"" "\"") (open-input-string "\"aaa\" bbb"))
