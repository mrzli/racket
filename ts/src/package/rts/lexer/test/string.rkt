#lang lexer-t

module-id: rts/lexer
lexer: rts-lexer

-----
""
"a" "b"
"abc"
"some value"
"with a double quote \""
"with escapes \\ \" \' \n \t \r \b \f \v"
"with hex escape \xff"
"with unicode 1 escape \uFFFF"
"with unicode 2 escape \u{123AF}"
-----
STRING """"
STRING ""a""
STRING ""b""
STRING ""abc""
STRING ""some value""
STRING ""with a double quote \"""
STRING ""with escapes \\ \" \' \n \t \r \b \f \v""
STRING ""with hex escape \xff""
STRING ""with unicode 1 escape \uFFFF""
STRING ""with unicode 2 escape \u{123AF}""
-----
''
'a' 'b'
'abc \''
-----
STRING "''"
STRING "'a'"
STRING "'b'"
STRING "'abc \''"
