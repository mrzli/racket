#lang racket/base

(require
  "writer.rkt"
  racket/list
  racket/string
  racket/function
  )

(provide make-write-node-tree)

(define (make-write-node-tree #:indent-size [indent-size 2])
  (lambda (indent n) (write-node-tree indent indent-size n)))

(define (write-node-tree indent indent-size n)
  (define state (nw-state indent indent-size '(())))
  (define transformation
    (compose1
     (get-result-string)
     (write-node-any n)
     ))
  (transformation state)
  )

(define (write-node-any n)
  (define type (first n))
  (case type
    ['source-file (write-node-source-file n)]
    ['variable-statement (write-node-variable-statement n)]
    ['variable-declaration-list (write-node-variable-declaration-list n)]
    ['variable-declaration (write-node-variable-declaration n)]
    [else (raise (format "unknown node type: ~a" type))]
    )
  )

(define (write-node-source-file n)
  (define statements (list-ref n 1))
  (define work
    (lambda (item is-last)
      (compose1
       (nw-write-with-conditional-line (not is-last) #f)
       (write-node-any item)
       )))
  (nw-loop statements work)
  )

(define (write-node-variable-statement n)
  (define export (list-ref n 1))
  (define declaration-list (list-ref n 2))

  (compose1
   (nw-write ";")
   (write-node-variable-declaration-list declaration-list)
   (if export (nw-write "export ") identity)
   ))

(define (write-node-variable-declaration-list n)
  (define keyword (list-ref n 1))
  (define declarations (list-ref n 2))

  (compose1
   (nw-loop-comma-separated declarations write-node-variable-declaration #f #f)
   (nw-write (format "~a " keyword))
   ))

(define (write-node-variable-declaration n)
  (define name (list-ref n 1))
  (define type (list-ref n 2))
  (define initializer (list-ref n 3))

  (compose1
   (if initializer
       (compose1
        (nw-write (format "~a" initializer))
        (nw-write " = "))
       identity)
   (if type
       (compose1
        (nw-write (format "~a" type))
        (nw-write ": "))
       identity)
   (nw-write (format "~a" name))
   )
  )
