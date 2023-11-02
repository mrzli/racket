#lang racket/base

(require brag/support rts/parser rts/tokenizer)

(define str #<<HERE
{}
HERE
  )

(parse-to-datum (apply-tokenizer make-tokenizer str))
