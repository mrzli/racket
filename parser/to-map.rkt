#lang racket/base

(require
  racket/list
  "production.rkt"
  )

(provide to-map)

(define (to-map productions)
  (define grouped (group-by car productions))
  (define processed-grouped (map process-group grouped))
  (make-immutable-hash processed-grouped))

(define (process-group group)
  (cons (caar group) group))

; (define (group-to-production-options group)
;   (list (caar group) (map cadr group)))
