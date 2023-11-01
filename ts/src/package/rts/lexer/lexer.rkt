#lang racket/base

(require brag/support)

(provide rts-lexer)

; basic
(define-lex-abbrev alpha-upper (:/ "A" "Z"))
(define-lex-abbrev alpha-lower (:/ "a" "z"))
(define-lex-abbrev alpha (:or alpha-upper alpha-lower))
(define-lex-abbrev digit (:/ "0" "9"))
(define-lex-abbrev alphanum (:or alpha digit))

; comment
(define-lex-abbrev line-comment (from/stop-before "//" "\n"))
(define-lex-abbrev block-comment (from/to "/*" "*/"))

; identifier
(define-lex-abbrev identifier-start-char (:or alpha "_" "$"))
(define-lex-abbrev identifier-char (:or alphanum "_" "$"))
(define-lex-abbrev identifier (:: identifier-start-char (:* identifier-char)))

; number
(define-lex-abbrev number-sign (:or "+" "-"))
(define-lex-abbrev non-zero-digit (:/ "1" "9"))

(define-lex-abbrev hex-alpha-lower (:/ "a" "f"))
(define-lex-abbrev hex-alpha-upper (:/ "A" "F"))
(define-lex-abbrev hex-alpha (:or hex-alpha-lower hex-alpha-upper))
(define-lex-abbrev hex-digit (:or digit hex-alpha))

(define-lex-abbrev octal-digit (:/ "0" "7"))

(define-lex-abbrev binary-digit (:/ "0" "1"))

(define-lex-abbrev decimal_segment (:: (:? "_") (:+ digit)))
(define-lex-abbrev decimal-whole-part (:or "0" (:: non-zero-digit (:* decimal_segment))))
(define-lex-abbrev decimal-fractional-part (:: digit (:* decimal_segment)))
(define-lex-abbrev decimal-exponent-part
  (:: (:or "e" "E") (:? number-sign) decimal-whole-part))

(define-lex-abbrev hex-number (:: (:? number-sign) "0x" (:+ hex-digit)))
(define-lex-abbrev octal-number (:: (:? number-sign) "0o" (:+ octal-digit)))
(define-lex-abbrev binary-number (:: (:? number-sign) "0b" (:+ binary-digit)))

(define-lex-abbrev decimal-number
  (:: (:? number-sign) decimal-whole-part (:? (:: "." decimal-fractional-part)) (:? decimal-exponent-part)))

(define-lex-abbrev number (:or hex-number octal-number binary-number decimal-number))

; string
(define-lex-abbrev backslash "\\")
(define-lex-abbrev double-quote "\"")
(define-lex-abbrev single-quote "'")
(define-lex-abbrev backslash-escaped-chars
  (:: backslash (:or backslash double-quote single-quote "n" "r" "t" "b" "f" "v")))
(define-lex-abbrev hex-escape (:: backslash "x" hex-digit hex-digit))
(define-lex-abbrev unicode-escape (:: backslash "u" (:= 4 hex-digit)))
(define-lex-abbrev unicode-escape-code-point (:: backslash "u" "{" (:** 1 6 hex-digit) "}"))
(define-lex-abbrev escaped-chars
  (:or backslash-escaped-chars hex-escape unicode-escape unicode-escape-code-point))
(define-lex-abbrev dq-string-char
  (:or escaped-chars (:~ backslash double-quote)))
(define-lex-abbrev sq-string-char
  (:or escaped-chars (:~ backslash single-quote)))
(define-lex-abbrev dq-string
  (:: double-quote (:* dq-string-char) double-quote))
(define-lex-abbrev sq-string
  (:: single-quote (:* sq-string-char) single-quote))
(define-lex-abbrev string (:or dq-string sq-string))

; punctuator
(define-lex-abbrev open-parens "(")
(define-lex-abbrev close-parens ")")
(define-lex-abbrev open-bracket "[")
(define-lex-abbrev close-bracket "]")
(define-lex-abbrev open-brace "{")
(define-lex-abbrev close-brace "}")
(define-lex-abbrev assignment-operator
  (:or "=" "+=" "-=" "**=" "*=" "/=" "%=" "<<=" ">>=" ">>>=" "&=" "^=" "|=" "&&=" "||=" "??="))
(define-lex-abbrev equality-operator (:or "==" "!=" "===" "!=="))
(define-lex-abbrev comparison-operator (:or "<" ">" "<=" ">="))
(define-lex-abbrev arithmetic-operator (:or "+" "-" "*" "/" "%" "**"))
(define-lex-abbrev bitwise-operator (:or "&" "|" "^" "~" "<<" ">>" ">>>"))
(define-lex-abbrev logical-operator (:or "&&" "||" "!"))
(define-lex-abbrev unary-operator (:or "++" "--"))
(define-lex-abbrev nullish-operator (:or "??" "?."))
(define-lex-abbrev other-punctuator (:or "." "," ":" ";" "?" "..." "=>"))
(define-lex-abbrev punctuator
  (:or open-parens close-parens open-bracket close-bracket open-brace close-brace
       assignment-operator equality-operator comparison-operator arithmetic-operator
       bitwise-operator logical-operator unary-operator nullish-operator other-punctuator))

(define rts-lexer
  (lexer-srcloc
   [whitespace (token lexeme #:skip? #t)]
   [line-comment (token lexeme #:skip? #t)]
   [block-comment (token lexeme #:skip? #t)]
   [identifier (token 'IDENTIFIER lexeme)]
   [number (token 'NUMBER lexeme)]
   [string (token 'STRING lexeme)]
   [punctuator (token 'PUNCTUATOR lexeme)]
   ))
