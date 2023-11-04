#lang racket/base

(require "token.rkt" "util/main.rkt")

(define (read-number-token port)
  (define-values (row col pos) (port-next-location port))

  (define c (read-char port))

  (void)
  )

(define (read-number port)
  (define ch (read-char port))

  ;(read-one port 0 0)

  (void)
  )

; (:: )