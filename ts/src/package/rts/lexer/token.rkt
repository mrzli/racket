#lang racket/base

(require racket/contract)

(provide
 (contract-out
  [struct token-struct
    ([type symbol?]
     [val any/c]
     [pos (or/c exact-nonnegative-integer? #f)]
     [row (or/c exact-positive-integer? #f)]
     [col (or/c exact-nonnegative-integer? #f)]
     [span (or/c exact-nonnegative-integer? #f)]
     [skip? boolean?]
     )]
  [token
   (->*
    (symbol?)
    (any/c
     #:pos (or/c exact-nonnegative-integer? #f)
     #:row (or/c exact-positive-integer? #f)
     #:col (or/c exact-nonnegative-integer? #f)
     #:span (or/c exact-nonnegative-integer? #f)
     #:skip boolean?)
    token-struct?
    )])
 )

(struct token-struct (type val pos row col span skip?) #:transparent)

(define
  (token
   type
   [val #f]
   #:pos [pos #f]
   #:row [row #f]
   #:col [col #f]
   #:span [span #f]
   #:skip [skip? #f])
  (token-struct type val pos row col span skip?))
