#lang br/quicklang

(define (read-syntax path port)
  (define src-lines (port->lines port))
  (define src-datums (format-datums '~a src-lines))
  ; (displayln src-datums)
  (define module-datum `(module stacker-mod "stacker.rkt"
                          (handle-args ,@src-datums)))
  (datum->syntax #f module-datum))

(provide read-syntax)

(define-macro (stacker-module-begin HANDLE-ARGS-EXPR)
  #'(#%module-begin
     (display (first HANDLE-ARGS-EXPR))))

; (define-syntax (stacker-module-begin stx)
;   (syntax-case stx ()
;     [(_ HANDLE-EXPR ...)
;      #'(#%module-begin
;         HANDLE-EXPR ...
;         (display (first stack)))]))

(provide (rename-out [stacker-module-begin #%module-begin]))

(define (handle-args . args)
  (for/fold ([stack-acc empty])
            ([arg (in-list args)])
            ;#:unless (void? arg))
    (cond
      [(void? arg) stack-acc]
      [(number? arg) (cons arg stack-acc)]
      [(or (equal? + arg) (equal? * arg))
       (define op-result (arg (first stack-acc) (second stack-acc)))
       (cons op-result (drop stack-acc 2))])))

(provide handle-args)

(provide + *)
