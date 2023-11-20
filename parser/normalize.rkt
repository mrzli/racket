#lang racket/base

(require
  racket/function
  racket/list
  racket/string
  )

(provide normalize-productions)

(define (normalize-productions productions)
  (apply append (map normalize-production productions))) ; apply append flattens the list by one level

(define (normalize-production production)
  (define-values (lhs rhs) (apply values (split-production production)))
  (define process
    (compose1
     (curry map (curry list lhs)) ; join lhs with rhs
     (curry map split-production-tokens) ; split rhs into tokens
     expand-production-options ; split rhs for options
     ))

  (process rhs)
  )

(define (split-production production)
  (string-split production ":"))

(define (expand-production-options rhs)
  (string-split rhs "|"))

(define (split-production-tokens rhs)
  (map char->immutable-string (string->list rhs)))

(define (char->immutable-string c)
  (string->immutable-string (string c)))

(define (p x)
  (println x)
  x)

; (println (normalize-productions productions))
