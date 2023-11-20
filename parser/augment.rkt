#lang racket/base

(provide augment-productions)

(define (augment-productions productions)
  (define start-production (car productions))
  (cons (list "X" (list (car start-production))) productions)
)