#lang brag

source-file                      : root-statement*

root-statement                   : base-statement

inner-statement                  : base-statement

base-statement                   : block

block                            : "{" "}"
