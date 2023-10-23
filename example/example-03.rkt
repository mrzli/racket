#lang racket

(define val (read (open-input-string (format "~a" "(foo bar)"))))

(displayln val)
(displayln (list? val))


