- each file should have an 'output' variable, with a value of some string, and that will be written to the a file inside examples/my-project/result



- you can implement reader/expander like this
  - ts code will produce a syntax tree
  - the node in each tree will be expanded to something like
    (n 'binary-expression (n 'numeric-literal 2) '+ (n 'numeric-literal 3))
  - racket code inside the node will be left as is, and will be expected to return the same thing as an 'n' expression, meaning a node for the final syntax tree to be used for generating the output
    - racket code can generate a list of nodes
      - have this be a separate function, like n-list, or just an 'n' with a special flag, such as 'quasi-list, or 'fragment or 'container, or whatever, provided it cannot be confused with an actual typescript node
    - racket code can switch back to typescript mode, this needs to be handled by the reader



- maybe have a separate DSL for making lexer tests, it will be tedious without it