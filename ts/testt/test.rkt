#lang racket/base

(require racket/pretty rtst)

(define result
  (n-source-file
   (list
    (n-variable-statement
     #t
     (n-variable-declaration-list
      'let
      (list
       (n-variable-declaration 'x1 'number 2)
       (n-variable-declaration 'y1 'number 3)
       )
      )
     )
     (n-variable-statement
     #f
     (n-variable-declaration-list
      'const
      (list
       (n-variable-declaration 'x2 'number 2)
       (n-variable-declaration 'y2 'number 3)
       )
      )
     )
    ))
  )

; (pretty-print result)


(define write (make-write-node-tree #:indent-size 2))

(display (write 0 result))
