#lang racket/base

(require brag/support)

(provide rts-lexer)

; (define rts-lexer
;   (lexer-srcloc
;    ["a" (token 'A lexeme)]
;    [whitespace (token lexeme #:skip? #t)]
;    [(from/stop-before "//" "\n") (token lexeme #:skip? #t)]
;    [(from/to "/*" "*/") (token lexeme #:skip? #t)]
;    ))

; (define string-lexer
;   (lexer-srcloc
;    [(from/to "\"" "\"") (token 'STRING lexeme)]
;    ))

(define (rts-lexer port)
  (define (next-token port)
    (cond
      [(string-match? port "aaa")]
      
      


(define (string-match? port str)
  (define chars (string->list str))
  (for ([ch (in-string str)])
    (define next (peek port))
    (unless (char=? ch next)
      (return #f)))
  #t)

