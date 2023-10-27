#lang racket/base

(require rts/lexer brag/support racket/pretty)

(define (lex str)
  (apply-port-proc rts-lexer str))

(define (lex-concise str)
  (define sl-tokens (lex str))
  (define tokens (map (lambda (slt) (srcloc-token-token slt)) sl-tokens))
  (for/list ([t (in-list tokens)]
             #:unless (token-struct-skip? t))
    (token-struct-type t)))

;(pretty-print (lex "aa a\na//fdsa"))
(pretty-print (lex-concise "aa a\na//fdsa"))

; ((from/to "\"" "\"") (open-input-string "\"aaa\" bbb"))
