#lang racket/base

(require "nodes.rkt" "writer.rkt" "write-node.rkt")

(provide (all-from-out "nodes.rkt" "writer.rkt" "write-node.rkt"))

(provide example)

(define (example val)
  (println (+ val 3)))
