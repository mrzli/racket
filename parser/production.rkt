#lang racket/base

(require
  racket/contract
  )

(provide
 (contract-out
  [struct production ((lhs string?) (rhs prod-rhs/c))]
  [struct production-options ((lhs string?) (opt (listof prod-rhs/c)))]
  ))

(define prod-rhs/c (listof string?))

(struct production (lhs rhs) #:transparent)
(struct production-options (lhs opt) #:transparent)
