#lang racket/base

(require "lexer.rkt")

(provide make-tokenizer)

(define (make-tokenizer port [path #f])
  (port-count-lines! port)
  ;(lexer-file-path path)
  (define (next-token) (rts-lexer port))
  next-token)
