#lang racket/base

(require racket/list racket/file)

(provide execute)

(define (execute project-dir)
  (define generated-project-dir (build-path project-dir "generated"))
  (delete-directory/files generated-project-dir #:must-exist? #f)

  (define generator-project-dir (build-path project-dir "generator/project"))
  (define rkt-files (list-rkt-files generator-project-dir))
  (for ([rkt-file-path rkt-files])
    (let ([execute (dynamic-require (build-path generator-project-dir rkt-file-path) 'execute)])
      (execute project-dir rkt-file-path))))

(define (list-rkt-files dir)
  (reverse (list-rkt-files-internal dir (string->path ".") (get-entries dir) '())))

(define (list-rkt-files-internal root-path relative-path entries result)
  (cond
    [(empty? entries) result]
    [else
     (define entry-name (first entries))
     (define other-entries (rest entries))
     (define relative-entry-path (build-path relative-path entry-name))
     (define curr-path (simplify-path (build-path root-path relative-entry-path)))
     (cond
       [(rkt-file? curr-path)
        (list-rkt-files-internal root-path
                                 relative-path
                                 other-entries
                                 (cons relative-entry-path result))]
       [(directory-exists? curr-path)
        (list-rkt-files-internal root-path
                                 relative-entry-path
                                 (get-entries curr-path)
                                 result)]
       [else
        (list-rkt-files-internal root-path
                                 relative-path
                                 other-entries
                                 result)])]))

(define (rkt-file? path)
  (and (file-exists? path) (regexp-match? #rx".rkt$" (path->string path))))

(define (get-entries dir)
  (directory-list dir #:build? #f))

