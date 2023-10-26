#lang racket/base

(require racket/port)
; (require "tokenizer.rkt" "parser.rkt")

(define (read-syntax path port)
  (define src-lines (port->lines port))
  (define module-datum `(module rts-mod rts/expander (list ,@src-lines)))
  (datum->syntax #f module-datum))
(provide read-syntax)
