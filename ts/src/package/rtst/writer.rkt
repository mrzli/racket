#lang racket/base

(require
  racket/list
  racket/function
  racket/string
  )

(provide
 nw-state
 nw-write
 nw-write-conditional
 nw-write-line
 nw-write-line-conditional
 nw-write-with-conditional-line
 nw-loop
 nw-loop-comma-separated
 indent-inc
 indent-dec
 get-result-string
 )

(define-struct nw-state (indent indent-size result) #:transparent)

(define (nw-write text)
  (lambda (state) (nw-write-into-last-line state text)
    ))

(define (nw-write-line text)
  (lambda (state)
    (result-add-new-line (nw-write-into-last-line state text))
    ))

(define (nw-write-conditional condition text)
  (if condition
      (nw-write text)
      identity)
  )

(define (nw-write-line-conditional condition text)
  (if condition
      (nw-write-line text)
      identity)
  )

(define (nw-write-with-conditional-line condition-line text)
  (if condition-line
      (nw-write-line text)
      (nw-write text))
  )

(define (nw-loop n-lst work)
  (cond
    [(empty? n-lst) identity]
    [else
     (define is-last (empty? (rest n-lst)))
     (compose1
      (nw-loop (rest n-lst) work)
      (work (first n-lst) is-last)
      )]
    )
  )

(define (nw-loop-comma-separated n-lst item-work multiline trailing-comma)
  (if multiline
      ; multiline
      (compose1
       (indent-dec)
       (nw-write-line #f)
       (nw-loop
        n-lst
        (lambda (n is-last)
          (define comma (or (not is-last) trailing-comma))
          (compose1
           (nw-write-line-conditional (not is-last) #f)
           (nw-write-conditional comma ",")
           (item-work n)
           )))
       (indent-inc)
       (nw-write-line #f)
       )
      ; single line
      (nw-loop
       n-lst
       (lambda (n is-last)
         (compose1
          (nw-write-conditional (not is-last) ", ")
          (item-work n)
          )))
      ))

(define (indent-inc)
  (lambda (state)
    (nw-state
     (+ (nw-state-indent state) 1)
     (nw-state-indent-size state)
     (nw-state-result state)
     )
    ))

(define (indent-dec)
  (lambda (state)
    (nw-state
     (- (nw-state-indent state) 1)
     (nw-state-indent-size state)
     (nw-state-result state)
     )
    ))

(define (get-result-string)
  (lambda (state)
    (define result (nw-state-result state))
    (define ordered (reverse (map reverse result)))
    (string-join (map (lambda (line) (string-join line "")) ordered) "\n")
    ))

; private

(define (nw-write-into-last-line state text)
  (define result (nw-state-result state))
  (define last-line (first result))
  (define new-last-line
    (cond
      [text
       (cond
         [(empty? last-line) (list text (get-indent state))]
         [else (cons text last-line)])]
      [else last-line]))
  (define new-result (cons new-last-line (rest result)))

  (result-update-last-line state new-result)
  )

(define (result-update-last-line state new-result)
  (nw-state
   (nw-state-indent state)
   (nw-state-indent-size state)
   new-result
   )
  )

(define (result-add-new-line state)
  (define result (nw-state-result state))
  (define new-result (cons empty result))
  (nw-state
   (nw-state-indent state)
   (nw-state-indent-size state)
   new-result
   )
  )

(define (get-indent state)
  (define indent (nw-state-indent state))
  (define indent-size (nw-state-indent-size state))
  (make-string (* indent indent-size) #\space))
