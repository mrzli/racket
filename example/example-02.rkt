#lang racket

;; Step 1: Design the Notation and Behavior
;; Imagine we have a language where we write `(add 1 2)` 
;; and want to transform it to `1 + 2` in Python.

;; Step 2: Write the Transformation Program
(define (transform-to-python code)
  (match code
    [(list 'add a b) (format "~a + ~a" a b)]
    [_ (error "Unsupported code format")]))

;; Step 3: Output the Transformed Code
(define (output-transformed code output-file)
  (define transformed (transform-to-python code))
  (with-output-to-file output-file
    (lambda () (display transformed))
    #:exists 'truncate))

;; Test
(output-transformed '(add 3 5) "output.py")
