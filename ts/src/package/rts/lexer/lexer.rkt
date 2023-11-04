#lang racket/base

(require "token.rkt" "util/main.rkt")

(provide rts-lexer token)

(define (rts-lexer port [path #f])
  (define c (peek-char port))
  (cond
    [(char-digit? c) (println c)]
    )

  (token 'IDENTIFIER)
  )


