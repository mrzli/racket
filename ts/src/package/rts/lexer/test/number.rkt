#lang lexer-t

module-id: rts/lexer
lexer: rts-lexer

-----
1
2.0
0.11
0.11e-1
0.11E+1
+2
-2
0xFF
0o77
0b11
-----
NUMBER 1
NUMBER 2.0
NUMBER 0.11
NUMBER 0.11e-1
NUMBER 0.11E+1
NUMBER +2
NUMBER -2
NUMBER 0xFF
NUMBER 0o77
NUMBER 0b11
