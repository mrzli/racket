#lang racket/base

(require racket/set)

(provide
 char-in-range?
 char-in-list?
 char-in-set?
 char-eq?
 char-digit?
 char-alpha-upper?
 char-alpha-lower?
 char-alpha?
 char-alphanum?
 char-hex-digit?
 char-octal-digit?
 char-binary-digit?
 )

(define (char-in-range? c lo hi)
  (let ([c (char->integer c)]
        [lo (char->integer lo)]
        [hi (char->integer hi)])
    (<= lo c hi)))

(define (char-eq? c1 c2)
  (eq? c1 c2))

(define (char-in-list? c lst)
  (define s (list->seteq lst))
  (char-in-set? c s))

(define (char-in-set? c s)
  (set-member? s c))

(define (char-digit? c)
  (char-in-range? c #\0 #\9))

(define (char-alpha-upper? c)
  (char-in-range? c #\A #\Z))

(define (char-alpha-lower? c)
  (char-in-range? c #\a #\z))

(define (char-alpha? c)
  (or (char-alpha-upper? c)
      (char-alpha-lower? c)))

(define (char-alphanum? c)
  (or (char-alpha? c)
      (char-digit? c)))

(define (char-hex-alpha-upper? c)
  (char-in-range? c #\A #\F))

(define (char-hex-alpha-lower? c)
  (char-in-range? c #\a #\f))

(define (char-hex-alpha? c)
  (or (char-hex-alpha-upper? c)
      (char-hex-alpha-lower? c)))

(define (char-hex-digit? c)
  (or (char-digit? c)
      (char-hex-alpha? c)))

(define (char-octal-digit? c)
  (char-in-range? c #\0 #\7))

(define (char-binary-digit? c)
  (char-in-range? c #\0 #\1))
