#lang racket/base

(require racket/file racket/path)

(provide write-file)

(define (write-file path content)
  (make-directory* (path-only path))
  (display-to-file content path #:exists 'replace))

; (write-file "./some/dir/file.txt" "Hello, Racket!\n\n\n\n")
