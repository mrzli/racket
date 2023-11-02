#lang brag

source-file                      : root-statement*

root-statement                   : base-statement

inner-statement                  : base-statement

base-statement                   : block
                                 | variable-statement

block                            : "{" inner-statement* "}"

variable-statement               : ["export"] variable-declaration-list ";"
variable-declaration-list        : ("let" | "const") variable-declaration ("," variable-declaration)*
variable-declaration             : ""