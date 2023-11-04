#lang racket/base

(require
  rts/lexer
  racket/pretty)

(define (lex str)
  (define port (open-input-string str))
  (port-count-lines! port)
  (rts-lexer port)
  )

; (define (lex-concise str)
;   (define p-tokens (lex (open-input-string str)))
;   (define tokens (map (lambda (slt) (position-token-token slt)) p-tokens))
;   tokens
;   )

(pretty-print (lex "12 12e+11\n222"))
