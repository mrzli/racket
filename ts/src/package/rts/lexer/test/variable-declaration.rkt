#lang lexer-t

module-id: rts/lexer
lexer: rts-lexer

-----
let x1 = 1;
-----
let let
x1 x1
= =
NUMBER 1
; ;
-----
let x2: number = 1;
-----
let let
x2 x2
: :
number number
= =
NUMBER 1
; ;
-----
const x3 = 1;
-----
const const
x3 x3
= =
NUMBER 1
; ;
-----
const x4 = 1, x5 = 2;
-----
const const
x4 x4
= =
NUMBER 1
, ,
x5 x5
= =
NUMBER 2
; ;
