#lang racket/base

(provide
 n-source-file
 n-variable-statement
 n-variable-declaration-list
 n-variable-declaration
 )

(define (n-source-file statements)
  (list 'source-file statements))

(define (n-variable-statement export declaration-list)
  (list 'variable-statement export declaration-list))

(define (n-variable-declaration-list keyword declarations)
  (list 'variable-declaration-list keyword declarations))

(define (n-variable-declaration name [type #f] [initializer #f])
  (list 'variable-declaration name type initializer))
