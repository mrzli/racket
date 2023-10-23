#lang racket/base

(require "../../../../src/util/util.rkt")

(provide execute)

(define (execute project-dir rkt-file-path)
  (displayln project-dir)
  (displayln rkt-file-path)
  (define generated-file-path (path-replace-extension rkt-file-path ""))
  (define target-dir (build-path project-dir "generated" generated-file-path))
  (write-file target-dir generated-file-path))
