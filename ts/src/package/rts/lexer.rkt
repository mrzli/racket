#lang racket/base

(require brag/support)

(define rts-lexer
  (lexer-srcloc
   ["a" (token 'A lexeme)]
   [whitespace (token lexeme #:skip? #t)]
   [(from/stop-before "//" "\n") (token lexeme #:skip? #t)]
   [(from/to "/*" "*/") (token lexeme #:skip? #t)]
   ))

(provide rts-lexer)