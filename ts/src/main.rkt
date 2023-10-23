#lang racket/base

(define project-dir (vector-ref (current-command-line-arguments) 0))
(define root-module-path (build-path project-dir "generator/root.rkt"))

(let ([execute (dynamic-require root-module-path 'execute)])
  (execute project-dir))
