#lang lexer-t

module-id: rts/lexer
lexer: rts-lexer

-----
let x1 = obj.prop;
-----
let let
x1 x1
= =
obj obj
. .
prop prop
; ;
-----
let x2 = obj?.prop;
-----
let let
x2 x2
= =
obj obj
?. ?.
prop prop
; ;
-----
let x3 = obj!;
-----
let let
x3 x3
= =
obj obj
! !
; ;
-----
let x4 = obj[1];
-----
let let
x4 x4
= =
obj obj
[ [
NUMBER 1
] ]
; ;
-----
call(...obj);
-----
call call
( (
... ...
obj obj
) )
; ;
-----
call?.<string>();
-----
call call
?. ?.
< <
string string
> >
( (
) )
; ;
-----
let x = async <T1, T2>(p1: string): void => {};
-----
let let
x x
= =
async async
< <
T1 T1
, ,
T2 T2
> >
( (
p1 p1
: :
string string
) )
: :
void void
=> =>
{ {
} }
; ;
-----
let x2 = ++x1;
-----
let let
x2 x2
= =
++ ++
x1 x1
; ;
-----
let x2 = x1--;
-----
let let
x2 x2
= =
x1 x1
-- --
; ;
-----
const [{ field1 }] = array;
-----
const const
[ [
{ {
field1 field1
} }
] ]
= =
array array
; ;
-----
let x = -1 + (2 - y) * 3 / 4 % 5 ** 6;
-----
let let
x x
= =
NUMBER -1
+ +
( (
NUMBER 2
- -
y y
) )
* *
NUMBER 3
/ /
NUMBER 4
% %
NUMBER 5
** **
NUMBER 6
; ;
