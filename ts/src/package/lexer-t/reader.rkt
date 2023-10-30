#lang racket/base

(require racket/port racket/string racket/list racket/hash)

(provide read-syntax)

(define (read-syntax path port)
  (define parsed (parse port))
  ; (println parsed)
  (define module-datum `(module lexer-t-mod lexer-t/expander ,parsed))
  (datum->syntax #f module-datum))

(define (parse port)
  (define by-separator
    (let* ([lines (port->lines port)]
           [by-separator-temp (split-by-separator-iter lines '(()))])
      (reverse (map reverse by-separator-temp))))

  (define main-data (first by-separator))
  (define test-cases-data (rest by-separator))
  (unless (even? (length test-cases-data))
    (error "Input/result pair mismatch"))
  (define parsed-data (get-parsed-data main-data test-cases-data))

  (list
   (hash-ref parsed-data 'module-id)
   (hash-ref parsed-data 'lexer)
   (hash-ref parsed-data 'cases)
   )

  ; (define cases
  ;   (let ([raw (hash-ref parsed-data 'cases)])
  ;     (map (lambda (c) (list 'lexer-t-case (first c) (quasiquote ,(second c)))) raw)
  ;     ))

  ; `(lexer-t-program
  ;   (require-for-test ,@(list (hash-ref parsed-data 'module-id) (hash-ref parsed-data 'lexer)))
  ;   (lexer-t-cases ,@cases))
  )

; split by "---"
(define (split-by-separator-iter lst acc)
  (cond
    [(empty? lst) acc]
    [(separator-line? (first lst))
     (split-by-separator-iter (rest lst) (cons '() acc))]
    [else
     (define new-first (cons (first lst) (first acc)))
     (split-by-separator-iter (rest lst) (cons new-first (rest acc)))]))

(define (get-parsed-data main-data test-cases-data)
  (define main-data-hash (get-main-data-hash main-data))
  (define test-cases-hash (hasheq 'cases (process-test-cases test-cases-data)))
  (hash-union main-data-hash test-cases-hash)
  )

(define (get-main-data-hash main-data-raw)
  (define filtered-main-data (filter non-blank-string? main-data-raw))
  (define main-data-components (flatten (map get-main-data-kw filtered-main-data)))
  (define h (apply hasheq main-data-components))
  (unless (hash-has-key? h 'module-id)
    (error "Main data should have a 'module-id' definition"))
  (unless (hash-has-key? h 'lexer)
    (error "Main data should have a 'lexer' definition"))
  h
  )

(define (get-main-data-kw item)
  (define components (map string-trim (string-split item ":")))
  (unless (= (length components) 2)
    (error "Main data item should have a key and a value"))
  (list (string->symbol (first components)) (second components))
  )

(define (process-test-cases test-cases-raw)
  (define grouped (split-list-by test-cases-raw 2))
  (define grouped-processed (map process-test-case grouped))
  grouped-processed
  )

(define (process-test-case item)
  (define input (first item))
  (define result (second item))
  (define final-input (string-trim (string-join input "\n")))
  (define final-result (map process-test-case-token-line (filter non-blank-string? result)))
  (list final-input final-result)
  )

(define (process-test-case-token-line line)
  (define parts (string-split line " "))
  (define name (first parts))
  (define value
    (let* ([value (string-join (rest parts))]
           [val-len (string-length value)]
           [is-quoted (and (> val-len 1) (string-prefix? value "\"") (string-suffix? value "\""))])
      (if is-quoted (substring value 1 (- val-len 1)) value)))
  (list (string->symbol name) value)
  )

(define (separator-line? line) (string-prefix? line "---"))

(define (non-blank-string? line) (non-empty-string? (string-trim line)))

(define (split-list-by lst n)
  (cond
    [(empty? lst) '()]
    [else
     (define first-part (take lst n))
     (define second-part (drop lst n))
     (cons first-part (split-list-by second-part n))]))
