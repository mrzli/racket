#lang racket/base

(require
  "augment.rkt"
  "normalize.rkt"
  "to-map.rkt"
  )

(define productions '("S:AA" "A:aA|b"))

(define process
  (compose1
   to-map
   augment-productions
   normalize-productions
   ))

(define result (process productions))
(println result)

(define temp (hash-ref result "A"))

(println temp)