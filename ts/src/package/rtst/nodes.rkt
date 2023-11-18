#lang racket/base

(require racket/contract)

(provide
 n-variable-statement
 n-variable-declaration-list
 n-variable-declaration
 n-identifier
 )

(struct n-source-file-struct (statements) #:transparent)
(define (n-source-file statements)
  (list 'source-file statements))
(provide
 n-source-file-struct
 (contract-out
  [struct n-source-file-struct
    ((statements (listof any/c)))])
 n-source-file
 )

(define (n-variable-statement export declaration-list)
  (list 'variable-statement export declaration-list))

(define (n-variable-declaration-list keyword declarations)
  (list 'variable-declaration-list keyword declarations))

(define (n-variable-declaration name [type #f] [initializer #f])
  (list 'variable-declaration name type initializer))

(define (n-identifier name)
  (list 'identifier name))

(define (n-array-binding-pattern elements)
  (list 'array-binding-pattern elements))

(define (n-binding-element name [spread #f] [property-name #f])
  (list 'binding-element name spread property-name))
